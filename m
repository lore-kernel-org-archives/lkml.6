Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227XWbkl/LtL1Zzh9gemV6Vj0IsEGgFekAJiHjKrDRXprGG4KI5ZYzLiYH199Yi7J1xxoe+A
ARC-Seal: i=1; a=rsa-sha256; t=1518707957; cv=none;
        d=google.com; s=arc-20160816;
        b=OT6oCFOd4pbKd0RiFEbzXR3xGk0FbzH9pz5W+kOF0C6CqqhRD8C9X2E1OJfhZML7JK
         coa2lFBPS0EJemvPAA0ehyRHpuB75Rgu4pSmNfdXiIBd2l7B6Xa0KSfEWFKnacCpMC/L
         x0yfirJMDehVypCbCCyo19HZ+6/2lDxmL9LPirbTzAyVgA+eJAUKx533ErXleThYU07C
         HyznZ+C5vkag5aTdWYPaj3dIrbZFSkadn+25ViP1g02UMEacEOhKPvXOCr6lrtDdiCgJ
         bSvKMYD30FidWd8ExKE5ZkEVytKnVSqo02LtwSkylXAAyo6oGLKMoU+J7GX4v+neO41G
         vCpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hgP5WBufaNdlYo+fooi/EAMAOazvgJAkD/h3HHvx0ZU=;
        b=U5Lz3Nqmra3YnboMiigddl8vlcEmx6ooYTr31WJup4aA+tTnP3b18luWEDkMbpgMG0
         NTouYz3bpEXpwuerZYLeVPRbKwBUQiwOso8+dvSD5Hx24ovK2TmaaRjQyU4OdwFTEQq1
         PmRk+EAIey+mRTHZRqR8QWiDtAiq6AWN9cHPhotz5TcemD2XU5pNM3b0wQgsNCSZjDKJ
         WwkkY3n7oQCDD/nAQ0naEVJLFtcoAszssd6ghY8P1La/X898gVENeI0bmMnHSS7Kumn8
         Vjv1SAxiQztLPFH2rJ82dnMGo3KCa/WDROnLIGDykDLj3Rt1Xmsl8I9/ZPa6YQi8Otbh
         uNCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mohamed Ghannam <simo.ghannam@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 24/45] dccp: CVE-2017-8824: use-after-free in DCCP code
Date: Thu, 15 Feb 2018 16:17:15 +0100
Message-Id: <20180215144121.062158102@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480715990046369?=
X-GMAIL-MSGID: =?utf-8?q?1592480715990046369?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohamed Ghannam <simo.ghannam@gmail.com>

commit 69c64866ce072dea1d1e59a0d61e0f66c0dffb76 upstream.

Whenever the sock object is in DCCP_CLOSED state,
dccp_disconnect() must free dccps_hc_tx_ccid and
dccps_hc_rx_ccid and set to NULL.

Signed-off-by: Mohamed Ghannam <simo.ghannam@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/dccp/proto.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -259,6 +259,7 @@ int dccp_disconnect(struct sock *sk, int
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct inet_sock *inet = inet_sk(sk);
+	struct dccp_sock *dp = dccp_sk(sk);
 	int err = 0;
 	const int old_state = sk->sk_state;
 
@@ -278,6 +279,10 @@ int dccp_disconnect(struct sock *sk, int
 		sk->sk_err = ECONNRESET;
 
 	dccp_clear_xmit_timers(sk);
+	ccid_hc_rx_delete(dp->dccps_hc_rx_ccid, sk);
+	ccid_hc_tx_delete(dp->dccps_hc_tx_ccid, sk);
+	dp->dccps_hc_rx_ccid = NULL;
+	dp->dccps_hc_tx_ccid = NULL;
 
 	__skb_queue_purge(&sk->sk_receive_queue);
 	__skb_queue_purge(&sk->sk_write_queue);
