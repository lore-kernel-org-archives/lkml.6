Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx496YX+/jIFiDk29Y8IylBC0L4HtsXmF6w/35DTsLRKIHzJgModJ7kHUZDZlaURFHbeWO05V
ARC-Seal: i=1; a=rsa-sha256; t=1523472684; cv=none;
        d=google.com; s=arc-20160816;
        b=zkjCSorNSnZz1KphH6tgDWgrAddSUoTPFs9gueACaUdIaBhZdnlC49eW14LOR4/tXN
         pCZC/EgWD16S8Ur2vvNMAjVP23all/K9E1tUSrkDw7u4uOMirkgcTmhc2BlCxKBnA3V3
         SRvkBRfbCbgJRMdVBsrmer4zV+QUHz1/PWLT0nMxQO7UsJbYUH9iaL1l0Tk3sL+ZYvSK
         btoCs1vuDEzchkwQiDqMDXo4d2sTT7l7QEgL1YEcD4zEnXG2FKDKQbbgzP66ZcySmzfG
         w5ZyCBRfxQwAO9jgbr68vqKP4BWMTUL56fyxmCxC3AX1QnAlPboAuHg6OIYZHPd5vsZU
         TqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ucenmK5n7HFyxYnbLsDqWxCIuo6oqcEr9EGBhW5DbRo=;
        b=bI+Y0WJLh5/fXnNHDLH09qRtuJt3RMSSkaWhP+VeApPqwVfxQSS53Myz8Gxw64nyND
         zgtjuuRfxebK6Tdm/h82Hsk+UU/uvVUG3vnDm0enBLUgaCvYwqYRppcS5fg2xSCI4a23
         pH8YBWCFtKy+wJKwjsz50uCjn3Zlr3atvm/P9FrBEP7gkZa2IsSXwkENVxK7XbFhrlZq
         JJzfCmfNM3k4b9/r6u0vPIe5onhoCW1siKuPgN+yTSjvR6NI1NCAyJbftD99itTzlXSw
         f1wYqi+dcXm4uys3Nml0hRw9RvVz7CHHIujtTrW7JXqQl/hcavWym+7xFwJkDMuTr61Z
         XU8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yuval Mintz <Yuval.Mintz@cavium.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 139/190] bnx2x: Allow vfs to disable txvlan offload
Date: Wed, 11 Apr 2018 20:36:25 +0200
Message-Id: <20180411183600.735153811@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476272462961684?=
X-GMAIL-MSGID: =?utf-8?q?1597476893470699783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Mintz, Yuval" <Yuval.Mintz@cavium.com>


[ Upstream commit 92f85f05caa51d844af6ea14ffbc7a786446a644 ]

VF clients are configured as enforced, meaning firmware is validating
the correctness of their ethertype/vid during transmission.
Once txvlan is disabled, VF would start getting SKBs for transmission
here vlan is on the payload - but it'll pass the packet's ethertype
instead of the vid, leading to firmware declaring it as malicious.

Signed-off-by: Yuval Mintz <Yuval.Mintz@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -3943,15 +3943,26 @@ netdev_tx_t bnx2x_start_xmit(struct sk_b
 		/* when transmitting in a vf, start bd must hold the ethertype
 		 * for fw to enforce it
 		 */
+		u16 vlan_tci = 0;
 #ifndef BNX2X_STOP_ON_ERROR
-		if (IS_VF(bp))
+		if (IS_VF(bp)) {
 #endif
-			tx_start_bd->vlan_or_ethertype =
-				cpu_to_le16(ntohs(eth->h_proto));
+			/* Still need to consider inband vlan for enforced */
+			if (__vlan_get_tag(skb, &vlan_tci)) {
+				tx_start_bd->vlan_or_ethertype =
+					cpu_to_le16(ntohs(eth->h_proto));
+			} else {
+				tx_start_bd->bd_flags.as_bitfield |=
+					(X_ETH_INBAND_VLAN <<
+					 ETH_TX_BD_FLAGS_VLAN_MODE_SHIFT);
+				tx_start_bd->vlan_or_ethertype =
+					cpu_to_le16(vlan_tci);
+			}
 #ifndef BNX2X_STOP_ON_ERROR
-		else
+		} else {
 			/* used by FW for packet accounting */
 			tx_start_bd->vlan_or_ethertype = cpu_to_le16(pkt_prod);
+		}
 #endif
 	}
 
