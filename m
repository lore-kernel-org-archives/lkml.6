Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224fUiQlHnUr6YwGNRvk/nZiNuoAsW7LRggO1dsMPkjt4uftX7qUKYpWnmmK2+6ICcgw4TBm
ARC-Seal: i=1; a=rsa-sha256; t=1519412267; cv=none;
        d=google.com; s=arc-20160816;
        b=Wzl27CRC+FsziCPQZs5M2lgcxW67vco2i1SplinJ0VTTIguAm/sm0hr7Ja1FN/OjlT
         q7CyDfOGHY594vqsxbknavCg+u+6WFUDMCKZLfWycCQl/Z8gvrmWloIwJ0cgGvrKZWJF
         RB2Uw8Tz58m1Rub0KeJN1nRvfiejS5w6sg+V0mClUTJyJK2rA9zVCeaR5DqinjX+yLde
         U2D7jdiqX2wCMNd6tTwszs0Z2QRPXBSuaSlGhImmWFH9qtI/c1LrYrYDNGXywhTfPK+d
         QNoht13KMyL295XK9sYm9vLRihV64xi5/13b878VpzRs2ZeW8Sw/gnvd+l5/CcoTii71
         C7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gpfUk9fMmYZAYB3MDFJPk4eMYe3tlI8dVpHLfGbtHH0=;
        b=ob01MEXICqjt83Fpa+IpQzMaDTOjJazRgI/qoDFro2OShjR9icaBlu91JxjqVah7Pd
         X//iXCgvcpliExUZQOsaTHGQkA4H2MEloulOIIPTRDTVWhm8jkqIka+N29G4M3H+umnh
         gpBZmO6NJw3YFaE2H5X7H48cldYtaS9mxgQaNePY75CQCqxspLrna7DPiDbOCtLgnyb0
         BngUvRa6X6nA0lUAFqUTxe3VSp2W3yEwvZf3jwbNLADDeHpSRmMQigBxN4/eYt71+TKh
         cEhr/rE8EfU/jvZ3qdfMugiPScvfGHmCN1K8kwhDK8vxAInF8Bl8L7WKxwMdNpm7j8ui
         NsKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 22/45] net_sched: gen_estimator: fix lockdep splat
Date: Fri, 23 Feb 2018 19:29:01 +0100
Message-Id: <20180223170718.773911623@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218817299293467?=
X-GMAIL-MSGID: =?utf-8?q?1593219237294966791?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 40ca54e3a686f13117f3de0c443f8026dadf7c44 upstream.

syzbot reported a lockdep splat in gen_new_estimator() /
est_fetch_counters() when attempting to lock est->stats_lock.

Since est_fetch_counters() is called from BH context from timer
interrupt, we need to block BH as well when calling it from process
context.

Most qdiscs use per cpu counters and are immune to the problem,
but net/sched/act_api.c and net/netfilter/xt_RATEEST.c are using
a spinlock to protect their data. They both call gen_new_estimator()
while object is created and not yet alive, so this bug could
not trigger a deadlock, only a lockdep splat.

Fixes: 1c0d32fde5bd ("net_sched: gen_estimator: complete rewrite of rate estimators")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/gen_estimator.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/core/gen_estimator.c
+++ b/net/core/gen_estimator.c
@@ -159,7 +159,11 @@ int gen_new_estimator(struct gnet_stats_
 	est->intvl_log = intvl_log;
 	est->cpu_bstats = cpu_bstats;
 
+	if (stats_lock)
+		local_bh_disable();
 	est_fetch_counters(est, &b);
+	if (stats_lock)
+		local_bh_enable();
 	est->last_bytes = b.bytes;
 	est->last_packets = b.packets;
 	old = rcu_dereference_protected(*rate_est, 1);
