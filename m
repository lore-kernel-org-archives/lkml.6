Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvStohgp9kXJOwThNmy+pH3HxliAQl/xSmbD1OZ81vfL64f513vo4XstHIxAETnVQaUGLYU
ARC-Seal: i=1; a=rsa-sha256; t=1521214734; cv=none;
        d=google.com; s=arc-20160816;
        b=ea6eoJ4rLsb1HcbGSdr9VC1SDWsvvB/DXdWTftDl+0BXbG93xJxE9L2XfMRzPhSNIJ
         AEBhrJh52z9QkbWFjk24EZChsHSLoVupbEEX4EvfRoZ4v8ffj8JMdwKDZBJuJ6e8J+eg
         23c6ePAlNgnbK3U/uNzokLeiOVAak0/DsV/NVmtYsDpSQwqPnjw7mNFXqa967H1NKB5C
         lRE747rUWH7SH8qK2dxdw2UdgA1ky88bIoN2VkChyGL1ryGOFBfNfRnBTrKhbkjv6kBV
         0BCk0Oz7fde1QZVizOjKpaMlfB87HHyeSyJq7L1KddBR32qnFH7MOlZw6T/jpn429lw/
         zzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=koPalqGxY9MszQuLyX4feCyOOnZxTVuW02ikMURxGus=;
        b=b7LuavPk7pnnNwobRVG3j7adePNdOPqfTlkg27SOUzmGRp2D6eNeZx7pK+qKmMu8H7
         aPwZR84Cxpyrk3YC+n4l3Uj444qE8RLws0A36dThKTy9tMGHKkXQpsQ1h6twMJ18rgeP
         pS/7FX/UcqjlpDiqpUvviHp/Wda5upFRTQWRqws8+OuqJnMRWmP7vLxKSIiBuMqAdUbm
         qRJcKjTj5vfBtxukCkkNZNIg4ykY4zaQwp4l4GWOn1S5MtZGO5lE6gGSdjunnMLRqrJz
         rdTqHr7eHIISyprBXaRLTWRec90COop3wZe7AhJkBeO2oGkpwP26VcQH0Po5uyMxnQlW
         LTkw==
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
Subject: [PATCH 4.14 103/109] ipvlan: add L2 check for packets arriving via virtual devices
Date: Fri, 16 Mar 2018 16:24:12 +0100
Message-Id: <20180316152335.448287990@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109262089805463?=
X-GMAIL-MSGID: =?utf-8?q?1595109262089805463?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -304,6 +304,10 @@ static int ipvlan_rcv_frame(struct ipvl_
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
