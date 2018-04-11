Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49eVSDy2e/xh8LozxhpPk3GP77G65a1CB4qvcZQG6k/PCbGRwfJLe3wWtpi2stSrqXYW8xx
ARC-Seal: i=1; a=rsa-sha256; t=1523472091; cv=none;
        d=google.com; s=arc-20160816;
        b=kckfR5qIRozIKtmcGAqY9ZmwS7M6v6n0Y61HiSUVWgsw1k9N5u7NORIQ7SYcPI7ICO
         2zyg5HLVM4WtU3RKE8dBU45Bh6QJVtVJ3Z6VyWtLbTOmU8fYrwewSmYm+C7Ja3gZy0J/
         aXl2TDGg1jJ/YDOmFEkppYBmj4E7XkVOIunTBWFEVJPTzngW/rwefG3k/IUGU5qMkld8
         E2ECRGHTvBbwTM7RWlx0QupHOSUoPt5E9Bq0eJjRLrCBpm53pNzJdX0oRWh5nRxPFa3q
         +U+vVIuDSBcAw0xbYyYbbRCfrP+8tK5vu3iITw7AbsC0ESCKSVakwE3tV4H09y6vAkRr
         yGJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zMAnRFXsau00kYSgVo5vNVa8G9PWHofA1lsQTVLrWLg=;
        b=NTREZ9ae870xkQAhwLOtFuU6uzMQKauwuZwAOf8fJwJl7YAY84d/+TA/QtUe49Eqfx
         jlmJ3LDaZ7vNGVFZTer+54K5Tn8szi6M7mb1tqxpAX1KnUBTaTj5YvGcAG1Qkdn7MC93
         od/W4yZK9uQJY/lz/CkZ7RUWHtC8O2jyfR94hdyDFxeRuZzQNyonT/kOBZL1Xubx1Sln
         muQTszBHkmSQecdCkvz7YpglOsuMnMHTmmgs5SV7UOp/Apr09RQaEZFo1RlZgtSX2IUd
         kD5u+1J23dBnNSQLPlMFUKlmUpRGssearYJYuGbVvnS0zi1bTvgt5dFArHt3riz+lQWu
         zN1Q==
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
Subject: [PATCH 3.18 082/121] bnx2x: Allow vfs to disable txvlan offload
Date: Wed, 11 Apr 2018 20:36:25 +0200
Message-Id: <20180411183501.203418408@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476272462961684?=
X-GMAIL-MSGID: =?utf-8?q?1597476272462961684?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3876,15 +3876,26 @@ netdev_tx_t bnx2x_start_xmit(struct sk_b
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
 
