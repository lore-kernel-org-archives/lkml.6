Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvszXxogBZU1pcEBOAirqdTjbw2sVr0Q7VOMxe9GU3Ci3pRg6rNYgdHLNt8GZbVqi9dayO4
ARC-Seal: i=1; a=rsa-sha256; t=1521483088; cv=none;
        d=google.com; s=arc-20160816;
        b=RINY2rlt97Sg2/LA8aDoma1u+3Tt2ugcoX3EKOaqZNmuDZVe5O8ce7NnG7e22Mt65m
         gKaeIm4VO7CSYB7XC1jvaWFl6Aa+uHMyGkau3IbyytfH4NSzwcO9/AUBymaDTM5TPmJ5
         pDQnwjS15fxLsZVMIe5ED1yIHFvkk8+m5PMCJpDUmU495QbxMeL5rEeQD1nBNxyt66cS
         4OUDsuujuURW9eQGLWFLYXN5lzd2v2ZIOb1GSaHzFCl+jYquErcQOWCQHU9frVuw8xgO
         W6gz2mOxxv0izVJYUVo+5ACVbSeR2whZrK6vg8PRGrMCe99bIIFU/JHJ+YAVRyyTU0Da
         Pmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=q8nLbeRMewMe3nHP8KmW80K9vrI8bvGptX/xb4VBgpM=;
        b=xVDi7KyHolsTDNiMXoG+FXq/eEUAPCZNs7UlbZzsCdPU0tRELqMnR6O3AHsqRj4gK8
         PF/W9t4IV8Tiye+qxB0ZaFxAfRO5N4hqhWRSNj5KYvobimRAUILcVKeHxUU5U8ahecwe
         aLkPF9Mv41nQagGA8WIeIfRvzWalVMkQm/Wt5MeGIiNCJBALdXNZA8YsdG3w/iqDR29M
         XSd4tVIAo3KszysgEMoxOmdFrnxjuFEE6pm+06EHm6uNtF3bbiKDfCI30uv3GrCqn+Eu
         Xgk9TwDekjjmn6ZODiIBmjnm8JyFcbKUfmFw9q0yKg9BwdrT1UOuPEWHCNZPILXEBz/0
         F12w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 3.18 63/68] lock_parent() needs to recheck if dentry got __dentry_killed under it
Date: Mon, 19 Mar 2018 19:06:41 +0100
Message-Id: <20180319171836.748239518@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390651194659537?=
X-GMAIL-MSGID: =?utf-8?q?1595390651194659537?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -581,11 +581,16 @@ again:
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
 
