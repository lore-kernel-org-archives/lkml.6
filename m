Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsE9tkR3cPOyzxWPLrVSEVPESEYG9vJZAM9+qSDm/7Z+D/Ir/19cZZwzjnMqtJh3RjW+jJx
ARC-Seal: i=1; a=rsa-sha256; t=1521484249; cv=none;
        d=google.com; s=arc-20160816;
        b=QM6engiVB/U/KOO+HlT3PNeI+VVbkr8c/mL5xIaQBr4LLyLvH/x/4TBcDP2ieAFYen
         KBQEMuDDgS9ybDCEm4FgY/UUSTY4BKHpXVMgDDb0ovOSHKoFPrFDB9fBmTXmjteAJQvn
         FwyhjxPzCwDOpROgfOzJUpA9uOHv3tWWSSywgu2m05xkEMB1n8Cvk4upIKXHoiSMhRC6
         tL2lDD0GPi2jDs6dGDe0QI28+QkrFtE5DPFkrhcnvOuD/8TL2HnZkN2MjQqlAq3IbgGo
         udPywoHJqlWeMrW4R6TOOdXhYQpGKPlw+oa9xNEr6m9vUufX458MPNY3ZV94T/awx0j+
         EI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YT5+8kgjGuKUW2Ev+0yFFgmIHyvR362RKl5fggnN33w=;
        b=hehwi93gnQtLKUEhAzDA1QnqpJwoJAe81tXv1pXJXNSNf72LT0+VS1Xk/xXXQ3ECNJ
         ua1ht/6QwMf+/AyKuM3wdtzonJ+l7e/EsTr2f3N6ON2wh6Ivuwqa49C0hguIDyMnS6yc
         OI7zzEcrgoB861GIUJouXOpwHjXKj/qGZ3bCJ0i/KNX9dEBb9CK/bl5cm9fyPRPkb1vF
         c8ZTiI5ggIX2cxAWlWLKx8Vvcqc/udawPtkGse6xTtvnkaRepc7QqRZnwxIabSWUZRCV
         gDEFp1urlzvqdufvvH7owJpZ65WF2PziP6XaLONY3nwJyOoIZq4gGKTS//Q/xQb/qwO1
         XYHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.14 25/41] lock_parent() needs to recheck if dentry got __dentry_killed under it
Date: Mon, 19 Mar 2018 19:08:25 +0100
Message-Id: <20180319180733.882419104@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390651194659537?=
X-GMAIL-MSGID: =?utf-8?q?1595391868361493470?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 3b821409632ab778d46e807516b457dfa72736ed upstream.

In case when dentry passed to lock_parent() is protected from freeing only
by the fact that it's on a shrink list and trylock of parent fails, we
could get hit by __dentry_kill() (and subsequent dentry_kill(parent))
between unlocking dentry and locking presumed parent.  We need to recheck
that dentry is alive once we lock both it and parent *and* postpone
rcu_read_unlock() until after that point.  Otherwise we could return
a pointer to struct dentry that already is rcu-scheduled for freeing, with
->d_lock held on it; caller's subsequent attempt to unlock it can end
up with memory corruption.

Cc: stable@vger.kernel.org # 3.12+, counting backports
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dcache.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -644,11 +644,16 @@ again:
 		spin_unlock(&parent->d_lock);
 		goto again;
 	}
-	rcu_read_unlock();
-	if (parent != dentry)
+	if (parent != dentry) {
 		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
-	else
+		if (unlikely(dentry->d_lockref.count < 0)) {
+			spin_unlock(&parent->d_lock);
+			parent = NULL;
+		}
+	} else {
 		parent = NULL;
+	}
+	rcu_read_unlock();
 	return parent;
 }
 
