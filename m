Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225P5saz453hO+PAIRZU1u+hzvO3DSnlVw67OeXz3+xBkav6hVHZ06th7vdgIVGYf9C1Tl4v
ARC-Seal: i=1; a=rsa-sha256; t=1518708348; cv=none;
        d=google.com; s=arc-20160816;
        b=zpN8rSylFU5MqfHDDN3TpLPi/hYlcjhzdQey9fA7G0dWPVxKzMn+qsrey4hsUbMqts
         KMPDHqvox+cNx3yGNNyQXv89nzPi4s+RIO6ArkNevZDHyGTPJf8fK67eEKvsiAyxcepc
         rDDCmzrApj0+oauPfS8YwLeIUZXR71yEQ5kEZhC1sLbfpJg3mjM72LB0MLXJ2u7Mm+/J
         zO7Rtnm/z7v/mrhsgdaMOFk3wjw0DJ9St4k+iCXND16cGomoOThty++UMzKMVWRn/bcg
         oHZAKHTWjAgv+8eocKN+JcZCxG+l0CBKllyXV8oSfj0BbMaHCW28EFRYhBkoyFSrPXTO
         czwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VY9WsuM0mocvvkWaSnqN6xNvFWF4JJzXUicFn/Jh0MU=;
        b=MaS8jAYOAXNaMW4OZErwWAzeHBGDU+cl61DFRsD9jURYljb/F7nDN7sTZutB0zjq8q
         qmjwC/D+tITB92O4sG846pAgY34VaQhRyAYeui+OIvEgFbzyP+lS6tVQrv9W8mOzOj4j
         l0eZoJmJtr8tjhwTYRhWz6VrMOMxPYrZ6r4D8RjqYCHaQETFH7GNehHUT7X6Q+beIm0g
         vJv/4C6cAg60h2CILMloGn1HECnB5PJk+3La+mcfsAncbsduioAq0NVoFK3lbmrk5Jif
         6kOXz/MUbX7J/bzwnvHfXToq2CfVmmpTya4Xmkl7jr9STc607ClOkUyz4NtuRxA7FLDd
         c7Iw==
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
Subject: [PATCH 4.9 11/88] dccp: CVE-2017-8824: use-after-free in DCCP code
Date: Thu, 15 Feb 2018 16:16:38 +0100
Message-Id: <20180215151224.221514352@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480715990046369?=
X-GMAIL-MSGID: =?utf-8?q?1592481125321655654?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
