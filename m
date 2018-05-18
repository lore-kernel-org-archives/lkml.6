Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrlrja0GkAEgH8Sp2j7SG2dT3J1+mAN0FFR2YrbeOGfo82Y1Ul2Fahr0i+PB/WFtrrjSl/j
ARC-Seal: i=1; a=rsa-sha256; t=1526631649; cv=none;
        d=google.com; s=arc-20160816;
        b=Bt1mOX7/t10hTZJNwLmxxrCEQKSvcy802EzOP2WEXkikTmtaVCat2Xz8HhabsGjPxX
         gtSTa7pCt4UHNdXiOv+KFY6JZ3gGHvkryDXtneISYe/M3AdTvruoEhDI7VVIsadun624
         NU02735x1sJfEQtMEPpbAYw9MXdWDWLp4bi+UDr/NaO7UMarNadePIGsSFTccGLpKTia
         gifY8IhXAsCDNzn0ZHOkOt3JdpvrvJFSYm2Iv7IhYY3G9uEPSWxVSzTSfQL85E0yU3BW
         +bg4iqjrDzrv9jNs5OhfeYbT7gs3CMCm13H9yJ9u+z36j1iRxK9A22Z5fhW1DL/01oCh
         sKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=fwVciR1R0Zj/wBfNm/2RvOPecBf2as9InYYVgL+QOsY=;
        b=jenPHg4ZtUeQXmdHuyvuFbYV9vyXGj+a2yalI9TlAad0BgJjO8OZXAAKJpknVF1T7X
         cW9eH4JMmZDsXjR981X3QgSrC8UroJSgAzwW7LtWtzBjmVPeGY1dqns/LbOKqBql5Cg2
         dYokqhVdjxaa78bs6O1aqf3RnS0rHguYavjTGREqfOtmm0ptksoNQavKEETG2ZQw2d2N
         xp9Gt2Nsz7qz60SGZqcQdZ+mlgJlk0FWHjMM99bV38uBDT56zfqWgDpypNvZ4Fxb2Gpv
         w0E40iGIUrW2csL84S94mTn25XQsrTemziL0pMk8wnzpJ9Lx24bm4Suki3pT22MlvDQP
         d6SQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=nZg6I6Xq;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=nZg6I6Xq;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	ethanwu <ethanwu@synology.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 42/45] btrfs: Take trans lock before access running trans in check_delayed_ref
Date: Fri, 18 May 2018 10:15:59 +0200
Message-Id: <20180518081532.519546814@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789307961962886?=
X-GMAIL-MSGID: =?utf-8?q?1600789307961962886?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ethanwu <ethanwu@synology.com>

commit 998ac6d21cfd6efd58f5edf420bae8839dda9f2a upstream.

In preivous patch:
Btrfs: kill trans in run_delalloc_nocow and btrfs_cross_ref_exist
We avoid starting btrfs transaction and get this information from
fs_info->running_transaction directly.

When accessing running_transaction in check_delayed_ref, there's a
chance that current transaction will be freed by commit transaction
after the NULL pointer check of running_transaction is passed.

After looking all the other places using fs_info->running_transaction,
they are either protected by trans_lock or holding the transactions.

Fix this by using trans_lock and increasing the use_count.

Fixes: e4c3b2dcd144 ("Btrfs: kill trans in run_delalloc_nocow and btrfs_cross_ref_exist")
CC: stable@vger.kernel.org # 4.14+
Signed-off-by: ethanwu <ethanwu@synology.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent-tree.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3171,7 +3171,11 @@ static noinline int check_delayed_ref(st
 	struct btrfs_transaction *cur_trans;
 	int ret = 0;
 
+	spin_lock(&root->fs_info->trans_lock);
 	cur_trans = root->fs_info->running_transaction;
+	if (cur_trans)
+		refcount_inc(&cur_trans->use_count);
+	spin_unlock(&root->fs_info->trans_lock);
 	if (!cur_trans)
 		return 0;
 
@@ -3180,6 +3184,7 @@ static noinline int check_delayed_ref(st
 	head = btrfs_find_delayed_ref_head(delayed_refs, bytenr);
 	if (!head) {
 		spin_unlock(&delayed_refs->lock);
+		btrfs_put_transaction(cur_trans);
 		return 0;
 	}
 
@@ -3196,6 +3201,7 @@ static noinline int check_delayed_ref(st
 		mutex_lock(&head->mutex);
 		mutex_unlock(&head->mutex);
 		btrfs_put_delayed_ref(&head->node);
+		btrfs_put_transaction(cur_trans);
 		return -EAGAIN;
 	}
 	spin_unlock(&delayed_refs->lock);
@@ -3223,6 +3229,7 @@ static noinline int check_delayed_ref(st
 	}
 	spin_unlock(&head->lock);
 	mutex_unlock(&head->mutex);
+	btrfs_put_transaction(cur_trans);
 	return ret;
 }
 
