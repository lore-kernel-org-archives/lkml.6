Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt6r+tZll9rT7fP85ozIWQpYrK0gNiY4bTpcxGiseQ8F1T50SyJ5qhp5wi1BVUwp1l4CsP4
ARC-Seal: i=1; a=rsa-sha256; t=1519676592; cv=none;
        d=google.com; s=arc-20160816;
        b=ea653Se8GQjbJgKJCEAhaBnoi5QiWz/ldXx+FJ0M+prTd3A13q4oVvpo+Lv5xo/T9u
         qyCvKGt+lkErJdO5DpO1xJSUa2N+f1ChdbKe2n1eLJSS3fIWxF6Dt8TwV3eRFrerb0pf
         V4htQ2HedJCPjjXgNi6ryJFY33F89T7TRbxeCAt4gH/ByZnPC8rtuymauPVFd03yocT8
         /PaJGsu1zhphW2kVzUOhzqt9UK/0grPSmiiMBjR7BEodIVuYljW+59JHj/HwYO3csndI
         H5D4ONnXC2Ww3doNQAI3BhbPHJy3ceY/LE5FM9jiPWG8akMfpUQ0jCrdX1uA17c2w0rm
         1GAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5XNCKyeT80Stvo9Kv65mkI/jL0TBSA8kJ+Q17jPhSJk=;
        b=Ig+SQddGrgn4qWtNb/POF74gn+58bNhBz7mxyqwKNysxcWm38pIeOYfoZRES+wFd+2
         o/dd2jGkLdhzt36CkWEPv7kIErH2dNBM909yyDMb0hAaz9pbSsqaBMZ+4yXNNmlwQJcB
         7K6BsIz5JOIcw7musMCX15sVi5g1LUkBAZla13RMR4t+N1i8LxavAJjXgbXve6iZomyi
         c6uE+MY3eh33ysdTBFgWJ5JM2ZzoO9tf5jGxGTdLTOwkHjDy+fcKT80LlHsHq4ZnNjVY
         vTS3ghfcLrsKLjRhMSZivi0fTfVA5++aCKzcTkVMV1CQ34beIFnAbD4lH3T+BbUSu3jd
         OgTg==
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
Subject: [PATCH 4.14 01/54] netfilter: drop outermost socket lock in getsockopt()
Date: Mon, 26 Feb 2018 21:21:38 +0100
Message-Id: <20180226202144.443053148@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495940069905483?=
X-GMAIL-MSGID: =?utf-8?q?1593496402407432867?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1355,10 +1355,7 @@ int ipv6_getsockopt(struct sock *sk, int
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
@@ -1397,10 +1394,7 @@ int compat_ipv6_getsockopt(struct sock *
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
