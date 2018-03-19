Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs4NWjLhyVQLdZThJUbKsomoeoDcHLO1D2yhKIfettBqvvslZNzxpCBOaF/g7TkprkDEk72
ARC-Seal: i=1; a=rsa-sha256; t=1521483431; cv=none;
        d=google.com; s=arc-20160816;
        b=Ai/xdglwKklOBeYPWWbaBaIs45fLK4BUy8gt06xkZ9PWn8e6KS8Oyy5ihOkoHAxgdA
         9xKc7F2C+WFknU6fjGfS5j2tuoX/hAnLT1ZWRx0X9fxdH8D0KwG2eOrSITU7HjJsqsDu
         W9CPc+KtbhtEhUP4WGX1Eg267qCcGuFW1wsWAgNjAYrY8ZU2H/MVlebWqV4WGQ6M6lDm
         wJlKx33SolVEy9kDeXPxA0FbLrGN+9ffIjMgmdeLvGC2qWHUpXK66035IK4tbukPQBt+
         63jfIhGCA6wIOr1b2GQKqIX/HGwkgCp1SXHwkCoNP4ZfNWgUi1OulSpRJMjsRjFPjmwC
         wPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sXcV1SxBDmsp4OSHhQBRIArNmByV77pkosOC2gTJFeE=;
        b=JiOu7Z1a6VKNnVH0P3B/k9hbHob9Ey1hcF1gUfiCyeb1YDSwivXjNGJ+GIsCnoAy+O
         vb3RL4yLTksZy3T6oFQ670G/HzKefUO9+nf6BdvaancE0sGj94ySpBtpMoB0Mk1o7VpR
         WmZ0X3LPPjxi1pmwmXuSMRuEKa4E+3CVolybGtLzaf1rCQgKWkZd5QBpujZYfltW5KJw
         JDRtCQM/Mo2Sdyga+iR00jxEw6jy8tW38ggyprIhV/4W6Z8nl7Wuc81HcwOfFX2lio2U
         79SHtBmWb2++EGP0bf9Np9/A217PfayuQZcO+rMnP1wbdUlFNW7tKn7Fy3z+bGLC0QRV
         uhkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.4 122/134] lock_parent() needs to recheck if dentry got __dentry_killed under it
Date: Mon, 19 Mar 2018 19:06:45 +0100
Message-Id: <20180319171906.890740695@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390651194659537?=
X-GMAIL-MSGID: =?utf-8?q?1595391010367509485?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -634,11 +634,16 @@ again:
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
 
