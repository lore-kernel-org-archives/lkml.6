Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49JApTVeLFaFQvbpT36RvflSMDmAmW+p585IRqU7o67ayOz8oCNQE4D71tkQzeolC15kFiC
ARC-Seal: i=1; a=rsa-sha256; t=1523473406; cv=none;
        d=google.com; s=arc-20160816;
        b=s0a/qmBPLj0EMtnVsfbxTcgE7n+JFIG15W8k5Itm7J2kmuxnoRLtyJdlBJW+91X6IR
         maTF5+NUYgloM3UBuiYccsMuz9ANLsLlddMLpYC6TbelhZwG1Jpk2W1hFgYDw/No+wwQ
         lR8kGhzvkJEb51YbCXFOym1yjyKUtaMnYu9SakxxCeH9FaeTV8qlXSqPEMENrVg6DL3y
         gnbPelmkFSP1O4k/g1gliKzb4ePJidh5mAPMgncITwfHPWjC07L08BDSBje2LV8xc9Q4
         1UJkhxUb62gT0rxPpS23/BPwKqD9zRxPdWj70Mk8dc/MIB+f6vsKtspddMMBXI+ApHcG
         OTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WuB14CMdmm/viccYM5Kt3ToUzNTHe5wotkqFiyZ1pUE=;
        b=huMakZsaOtEvPq05eJev46r6FWOSgT11yPOLweThoP03kE5KZMSMP0Z6OqnLIw+Y2N
         hm1zN16gTsnDok0eNQkJSCtX9eSxtF2SdgaiMeGlgjDi3iknN89ZoMDJol4AcvpQo563
         jlEE6hR1qj/McjfTWC0H+HGB2AwGOPMalK6snW+SdP0MeiXSGIPMovcI5VAE9KL94rsA
         foI+ine9QOkgbsiJ60jhUgJBZcJm37SM7FDBguyikN/bj9UDELbp+jLL0iPKxYCgHzOb
         kh1k+m/KSIc94HYe31c6xQv+409dUJ7C4Mr8phlVjY777VrscGS9UqGzTR/7ligP5b5A
         70JA==
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
Subject: [PATCH 4.9 236/310] bnx2x: Allow vfs to disable txvlan offload
Date: Wed, 11 Apr 2018 20:36:15 +0200
Message-Id: <20180411183632.654191027@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476272462961684?=
X-GMAIL-MSGID: =?utf-8?q?1597477651188344008?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3887,15 +3887,26 @@ netdev_tx_t bnx2x_start_xmit(struct sk_b
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
 
