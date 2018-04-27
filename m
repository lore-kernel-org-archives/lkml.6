Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZplPo6+roL9Or7k7ZLFXhqUS+fMkKcKMgtHBf19iIuMfV2QPVFK5n+H+E9gyjPPmnmUVpET
ARC-Seal: i=1; a=rsa-sha256; t=1524837607; cv=none;
        d=google.com; s=arc-20160816;
        b=tBaJtdaWTGWQhpeYy2N1MfqI8bkcAQS/l0ARGGFfpu+z2KvhDTg4/emfWHX5etGgJt
         kwv0C2QS8iSsCixkVCn6WYTeCDXYvFVKrTzL+vJin60ZGtPKsplfc1oEOJTtgPW9zM9C
         EjeQSFR6r7BhUEmHDm9/bQpIL5y0eUiNChnQ0e3zGP1t8GtCI8ikYtU9aAHUh8zgw69v
         ZatPZjFNj3As9OY4s689atQegvTVarjMCEKSPl7gTx5uZ6AuYeTDtwtF7ztCnHfolHiC
         cu6bieuJfrYSQHAJeIlzFsov8Bam6YYxbm6iDxqNvcU4QMSVX+y/uG6IvbsrJLwSEKji
         SYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=qbtCsdXMhmaA98+rWntm9bE2NTZTpa2noGqfpTonPR8=;
        b=WX4c1sVXWcp7qRz0M0sMsdSFFv5Vc5S2brRL1VtuSuzOxdeG8v1kx6Ch9INy9KOJl4
         rP4dpzqF+HXlUqmAEjKW+Vy+3d2eWc+cBndxLEtzipLDv8+3eNFhf/iwVxWzohaMq5Tc
         K3CkORTh/qx0Gqmvhlh0pFsztuo/sJuAF0HG+kcWYDAG7Cm1ZaTBPhPhcP0gn4Gk3tal
         xl+nOSlUljMe4JhE66SNUjVc8SGsJz5ekhBlCl2/jdvw2cTDxoDgLFAcTX1v911FLUZ6
         L9MEUxasjK7guW1VvSqPx70Ag14bC/s+ZZCV1MX33HZcAbSn72J0FoFkcJn3zWER9Hvn
         69Hw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A732221890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+f922284c18ea23a8e457@syzkaller.appspotmail.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 21/24] llc: delete timers synchronously in llc_sk_free()
Date: Fri, 27 Apr 2018 15:57:56 +0200
Message-Id: <20180427135632.452918098@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
References: <20180427135631.584839868@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908119412368139?=
X-GMAIL-MSGID: =?utf-8?q?1598908119412368139?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>


[ Upstream commit b905ef9ab90115d001c1658259af4b1c65088779 ]

The connection timers of an llc sock could be still flying
after we delete them in llc_sk_free(), and even possibly
after we free the sock. We could just wait synchronously
here in case of troubles.

Note, I leave other call paths as they are, since they may
not have to wait, at least we can change them to synchronously
when needed.

Also, move the code to net/llc/llc_conn.c, which is apparently
a better place.

Reported-by: <syzbot+f922284c18ea23a8e457@syzkaller.appspotmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/llc_conn.h |    1 +
 net/llc/llc_c_ac.c     |    9 +--------
 net/llc/llc_conn.c     |   22 +++++++++++++++++++++-
 3 files changed, 23 insertions(+), 9 deletions(-)

--- a/include/net/llc_conn.h
+++ b/include/net/llc_conn.h
@@ -97,6 +97,7 @@ static __inline__ char llc_backlog_type(
 
 struct sock *llc_sk_alloc(struct net *net, int family, gfp_t priority,
 			  struct proto *prot);
+void llc_sk_stop_all_timers(struct sock *sk, bool sync);
 void llc_sk_free(struct sock *sk);
 
 void llc_sk_reset(struct sock *sk);
--- a/net/llc/llc_c_ac.c
+++ b/net/llc/llc_c_ac.c
@@ -1096,14 +1096,7 @@ int llc_conn_ac_inc_tx_win_size(struct s
 
 int llc_conn_ac_stop_all_timers(struct sock *sk, struct sk_buff *skb)
 {
-	struct llc_sock *llc = llc_sk(sk);
-
-	del_timer(&llc->pf_cycle_timer.timer);
-	del_timer(&llc->ack_timer.timer);
-	del_timer(&llc->rej_sent_timer.timer);
-	del_timer(&llc->busy_state_timer.timer);
-	llc->ack_must_be_send = 0;
-	llc->ack_pf = 0;
+	llc_sk_stop_all_timers(sk, false);
 	return 0;
 }
 
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -951,6 +951,26 @@ out:
 	return sk;
 }
 
+void llc_sk_stop_all_timers(struct sock *sk, bool sync)
+{
+	struct llc_sock *llc = llc_sk(sk);
+
+	if (sync) {
+		del_timer_sync(&llc->pf_cycle_timer.timer);
+		del_timer_sync(&llc->ack_timer.timer);
+		del_timer_sync(&llc->rej_sent_timer.timer);
+		del_timer_sync(&llc->busy_state_timer.timer);
+	} else {
+		del_timer(&llc->pf_cycle_timer.timer);
+		del_timer(&llc->ack_timer.timer);
+		del_timer(&llc->rej_sent_timer.timer);
+		del_timer(&llc->busy_state_timer.timer);
+	}
+
+	llc->ack_must_be_send = 0;
+	llc->ack_pf = 0;
+}
+
 /**
  *	llc_sk_free - Frees a LLC socket
  *	@sk - socket to free
@@ -963,7 +983,7 @@ void llc_sk_free(struct sock *sk)
 
 	llc->state = LLC_CONN_OUT_OF_SVC;
 	/* Stop all (possibly) running timers */
-	llc_conn_ac_stop_all_timers(sk, NULL);
+	llc_sk_stop_all_timers(sk, true);
 #ifdef DEBUG_LLC_CONN_ALLOC
 	printk(KERN_INFO "%s: unackq=%d, txq=%d\n", __func__,
 		skb_queue_len(&llc->pdu_unack_q),
