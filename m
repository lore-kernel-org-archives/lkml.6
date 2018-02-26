Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuOGx/Q7JvQydMBMNS7fytqRm9t8vZKGvHSCf2Qv1yO2QL6WlQXFpqkpGO/Wn1iHJMqAuV/
ARC-Seal: i=1; a=rsa-sha256; t=1519676191; cv=none;
        d=google.com; s=arc-20160816;
        b=gAXgeJENZGfCbZW/1Y7u1ZkwNMDUe7vcjDZMuE55nC4uvE4vXmSb4OTi2kArn6ySn/
         GTCkIbgYjpMS+MS1z4kH0l5d/ShaPsN9cR4++52v6VkEG4xj/FBAsxX2iMwcgeSDzuiP
         lLPtchzRbM2Le2yGzSrQwZ7NoSQ4lA3d8cY1pAa3UHycwMxnwiUUbB+PlSVBApQ9KZk7
         yvhZXS1MB79+wL6Ix4vClxPRkBrUyKOC9llZwZGcaAKiEV4Vulqs7mQMAFAGT4xjlmaV
         MHkV0cAHzviS3Blnnwl+bBFA6ZQx9XLl3Xi1TqUoaVBhUZUNScDEPLuQXHXGkYB1EzS8
         Npog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IeL4pWsLGG2BDcj+u4ymfXMssTFpCwM3cna4VZYOefo=;
        b=QJGt9mLG/WHSMEWfXk9hTVKpG8ejgj/KyKv8YLpLN9x0zyaCA2c/2Fi3own1hdepLt
         POX7DSOjwv8k+IHWoH4vJe6BYoGPDi9Z2LDSys779T3rqf1X4FHbBdx+5af9ZVXBEfRG
         9U+K7XRH8UW/j8I/OSL2Z+wZvTBG41eXHeb9YWAqg4nBSXAdK0RFqWZsHCFTyoa48BKH
         aLsgPm3rUVooJqq1HZweA8O9ukLwYjBnCRct1Hj1VZoa4t5SmGnJXHUe9DEc15f5CdIc
         69NMSKMgDZe89FIwLk07ITdu/iiT5H00hrsqXJtAJN0xvYdi6WBIDfLRi3l0HWGKfyGG
         PxYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	syzbot+ddde1c7b7ff7442d7f2d@syzkaller.appspotmail.com,
	Florian Westphal <fw@strlen.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Krzysztof Piotr Oledzki <ole@ans.pl>
Subject: [PATCH 4.4 01/22] netfilter: drop outermost socket lock in getsockopt()
Date: Mon, 26 Feb 2018 21:16:01 +0100
Message-Id: <20180226201558.768932489@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
References: <20180226201558.681421374@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495940069905483?=
X-GMAIL-MSGID: =?utf-8?q?1593495982061197299?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit 01ea306f2ac2baff98d472da719193e738759d93 upstream.

The Syzbot reported a possible deadlock in the netfilter area caused by
rtnl lock, xt lock and socket lock being acquired with a different order
on different code paths, leading to the following backtrace:
Reviewed-by: Xin Long <lucien.xin@gmail.com>

======================================================
WARNING: possible circular locking dependency detected
4.15.0+ #301 Not tainted
------------------------------------------------------
syzkaller233489/4179 is trying to acquire lock:
  (rtnl_mutex){+.+.}, at: [<0000000048e996fd>] rtnl_lock+0x17/0x20
net/core/rtnetlink.c:74

but task is already holding lock:
  (&xt[i].mutex){+.+.}, at: [<00000000328553a2>]
xt_find_table_lock+0x3e/0x3e0 net/netfilter/x_tables.c:1041

which lock already depends on the new lock.
===

Since commit 3f34cfae1230 ("netfilter: on sockopt() acquire sock lock
only in the required scope"), we already acquire the socket lock in
the innermost scope, where needed. In such commit I forgot to remove
the outer-most socket lock from the getsockopt() path, this commit
addresses the issues dropping it now.

v1 -> v2: fix bad subj, added relavant 'fixes' tag

Fixes: 22265a5c3c10 ("netfilter: xt_TEE: resolve oif using netdevice notifiers")
Fixes: 202f59afd441 ("netfilter: ipt_CLUSTERIP: do not hold dev")
Fixes: 3f34cfae1230 ("netfilter: on sockopt() acquire sock lock only in the required scope")
Reported-by: syzbot+ddde1c7b7ff7442d7f2d@syzkaller.appspotmail.com
Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Tested-by: Krzysztof Piotr Oledzki <ole@ans.pl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/ip_sockglue.c   |    7 +------
 net/ipv6/ipv6_sockglue.c |   10 ++--------
 2 files changed, 3 insertions(+), 14 deletions(-)

--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1527,10 +1527,7 @@ int ip_getsockopt(struct sock *sk, int l
 		if (get_user(len, optlen))
 			return -EFAULT;
 
-		lock_sock(sk);
-		err = nf_getsockopt(sk, PF_INET, optname, optval,
-				&len);
-		release_sock(sk);
+		err = nf_getsockopt(sk, PF_INET, optname, optval, &len);
 		if (err >= 0)
 			err = put_user(len, optlen);
 		return err;
@@ -1562,9 +1559,7 @@ int compat_ip_getsockopt(struct sock *sk
 		if (get_user(len, optlen))
 			return -EFAULT;
 
-		lock_sock(sk);
 		err = compat_nf_getsockopt(sk, PF_INET, optname, optval, &len);
-		release_sock(sk);
 		if (err >= 0)
 			err = put_user(len, optlen);
 		return err;
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -1340,10 +1340,7 @@ int ipv6_getsockopt(struct sock *sk, int
 		if (get_user(len, optlen))
 			return -EFAULT;
 
-		lock_sock(sk);
-		err = nf_getsockopt(sk, PF_INET6, optname, optval,
-				&len);
-		release_sock(sk);
+		err = nf_getsockopt(sk, PF_INET6, optname, optval, &len);
 		if (err >= 0)
 			err = put_user(len, optlen);
 	}
@@ -1382,10 +1379,7 @@ int compat_ipv6_getsockopt(struct sock *
 		if (get_user(len, optlen))
 			return -EFAULT;
 
-		lock_sock(sk);
-		err = compat_nf_getsockopt(sk, PF_INET6,
-					   optname, optval, &len);
-		release_sock(sk);
+		err = compat_nf_getsockopt(sk, PF_INET6, optname, optval, &len);
 		if (err >= 0)
 			err = put_user(len, optlen);
 	}
