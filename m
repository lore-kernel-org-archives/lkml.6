Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuwmJqW07Ab+ucgVkx2HsGiN6aI8lmaGchOgKdmAldhBgg2R6XdsFtT6nJWsCw43xLU2naG
ARC-Seal: i=1; a=rsa-sha256; t=1519676765; cv=none;
        d=google.com; s=arc-20160816;
        b=CJEABGeQ34mpzNM/cRa4sQY2tlTeWqlRJ2SGzwM1+MCcBro8lUWmN3a1m/xhwkyCoK
         qPVI6OBG4sHb5CVRDWq8b63uh4jvP4VjniC2CRXbKY/7lPvDKAYedFxXsVyNlKRkXVp5
         zXOxws4jz0P3IllGVV88tFXtBkRuDAOoPW06X3ZRKSMqSudcStmlgmuppuDQx5BWPiCW
         Egpl5lVsmzUfiO6kbGp/XwbBZtuWvwptIkqxOGupVPSbnc76cLsKqDfcRXKWHG/wfRSa
         8pKoK4sXKloBt81X+GWPI5WHyc+rnfbnNA53hHOeKGCNFEpEWnSXrZjEhHtHAJz4TMrT
         tcQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NCg12nAUEKT+YolnLil0OVHpUV7yKnHBm/VdSqxMgmM=;
        b=09/iCFGHA7D2WaQzKxgk5z9pWmDFcQQ9ezaGOQsLdnkWCNspqYffd5RdkJyVZLkuw7
         NQ9cdeTIG8AsBTW55PlTX8ycXSyo1b91i62i1m9cK1vxPzvZSLTi7j2lPN5+NFYqO4om
         ceBQ/+7eCe1gFrwGyRznTxbIwSSfC0keA/6u9ICqUdnJriY4X0xcVZiT+edjZCplePgs
         GbnzifYrEhPuukn0BEHjl1PvJJ4lg+ej4fW72Lxwh2xnIDgNjuLXBPgMyF4DGqGBMWTH
         KI8OJ5kkuZ1WppsInophEf2wm9VtUZ1yo0058unf7zH2cv0jPpVUTktzPo7OQHmY+xop
         10gA==
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
Subject: [PATCH 4.15 01/64] netfilter: drop outermost socket lock in getsockopt()
Date: Mon, 26 Feb 2018 21:21:38 +0100
Message-Id: <20180226202153.512855240@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495940069905483?=
X-GMAIL-MSGID: =?utf-8?q?1593496584091631582?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1563,10 +1563,7 @@ int ip_getsockopt(struct sock *sk, int l
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
@@ -1598,9 +1595,7 @@ int compat_ip_getsockopt(struct sock *sk
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
@@ -1367,10 +1367,7 @@ int ipv6_getsockopt(struct sock *sk, int
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
@@ -1409,10 +1406,7 @@ int compat_ipv6_getsockopt(struct sock *
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
