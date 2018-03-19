Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu4DmRrnroOp65LmDlSkrtnctXxMqUezHjnuU/N/lcuF3Gsy7S7+3BYSTeqAX/hw9P8Osku
ARC-Seal: i=1; a=rsa-sha256; t=1521484034; cv=none;
        d=google.com; s=arc-20160816;
        b=KuRcCe294gBPgj5lIAyDLT0UN168U0IlZ4m9C2ooq6kkavz+LbnGKaUPazpRwv2HGp
         6MvVHqm7YCneGd2lxY8H0DDOu7kOHvZpdWPeDV3ms9ekcMvdQ9bHrtQrHmcxrNK7SDf+
         lSYZ+MBr050PRbGIf9qb8AChNNBnSrjf6FPlUeqqkBcN9Pkf1RRKN39R+HcqaCBlsWzR
         ax51uYekz+F0m/+YmRB4xzX8UTgChr4bQ1K8fVyVh6LQURfhjSX/BknFSBt3wU5t2RCP
         ERgGVYwwYTgfiEMkUlddXULBlqVxfLHJXH0apNdfAPG1udHtF+0TxEV3hdZQjeoyha8E
         HRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RBIq3jspxtPI3/0M0nxtykfxLqpnJIn/OVHxQlvXth4=;
        b=XxkkB5BmKw+fil8ClBhaa4UWh47Hp4A2Ugg+cVW2ehnddqTJQODCcW++rL6CFCWOCx
         RHoKkDZ4jHOcqOZy7V62xSJ1DHZESWwOnjANhZfaJj6XRCyA3wfRbOvc7DbHLBx+pyHu
         dF1IvubAioDLaY8MfpNBxR4Iw8Zt0mCKEcW7l96aBMuRt3wC1X2C1gt5rjpqiJjNy9vl
         vY9GnjsxcrB1To5/CWhpu+QTwLULAowT76MVdc718jGwbNpAfqBxvX1PTUPwi/+00bL6
         MFBIsloBA6pdS/bb7XP+Tg59efRdOtfLvqbAKbmUceHbuUGrQk/DaLNsNZ5T8S4BBGM9
         LhmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Amit Sikka <amit.sikka@ericsson.com>,
	Mahesh Bandewar <maheshb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 206/241] ipvlan: add L2 check for packets arriving via virtual devices
Date: Mon, 19 Mar 2018 19:07:51 +0100
Message-Id: <20180319180759.704620255@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390973665404691?=
X-GMAIL-MSGID: =?utf-8?q?1595391642016779534?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mahesh Bandewar <maheshb@google.com>


[ Upstream commit 92ff42645028fa6f9b8aa767718457b9264316b4 ]

Packets that don't have dest mac as the mac of the master device should
not be entertained by the IPvlan rx-handler. This is mostly true as the
packet path mostly takes care of that, except when the master device is
a virtual device. As demonstrated in the following case -

  ip netns add ns1
  ip link add ve1 type veth peer name ve2
  ip link add link ve2 name iv1 type ipvlan mode l2
  ip link set dev iv1 netns ns1
  ip link set ve1 up
  ip link set ve2 up
  ip -n ns1 link set iv1 up
  ip addr add 192.168.10.1/24 dev ve1
  ip -n ns1 addr 192.168.10.2/24 dev iv1
  ping -c2 192.168.10.2
  <Works!>
  ip neigh show dev ve1
  ip neigh show 192.168.10.2 lladdr <random> dev ve1
  ping -c2 192.168.10.2
  <Still works! Wrong!!>

This patch adds that missing check in the IPvlan rx-handler.

Reported-by: Amit Sikka <amit.sikka@ericsson.com>
Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ipvlan/ipvlan_core.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -299,6 +299,10 @@ static int ipvlan_rcv_frame(struct ipvl_
 		if (dev_forward_skb(ipvlan->dev, skb) == NET_RX_SUCCESS)
 			success = true;
 	} else {
+		if (!ether_addr_equal_64bits(eth_hdr(skb)->h_dest,
+					     ipvlan->phy_dev->dev_addr))
+			skb->pkt_type = PACKET_OTHERHOST;
+
 		ret = RX_HANDLER_ANOTHER;
 		success = true;
 	}
