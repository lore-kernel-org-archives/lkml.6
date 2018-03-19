Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsFhL+UukC7gbokzy1n52simY6i9VgGOAN3FJgRCypSOWFVdE0FEl/HLapyhF1O8fe0yJp9
ARC-Seal: i=1; a=rsa-sha256; t=1521483396; cv=none;
        d=google.com; s=arc-20160816;
        b=oOOV5QD01OR6bNh+96prhGkKJNXrzVv8GAHjUWVRvpnaSJPEmw1YC01Jk8Y8zF2Ii8
         utrCI/rhOgbUnADINLMei3pW2lfeHXbmVe8XI28tUiIO4C0Nuw5kGOsoLVRT7PL6IgL3
         nsp4J0D5m+rKSVsTjo4xVyda+VfWAM1hqL75DqSnQo1CmnRurhZYbsIMBN7uLvrPb22y
         7/SvD5xfMOBEVR6TqOEQZtYvc997HorBZ3tekF3sZg1pR+sRTlNnqc3cIy6mYSu8tml9
         hHY6OLO5a2gasEXUw/mJqj6pWxnN2nEnMXFwPWWdtRHgoT0cQM+wBWQRMJtSnsCqpUoO
         XIaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FBu1meLZXWgTqU/95ocPADwzFpU7MPO/A0KaTvfNUSA=;
        b=sQMxwCED8MIAHy3Xs+wfFx83dY3mW80RbZWesvlTZuYEd0Mb8Fh9xfr2h7Fwv101Gh
         /6r3XySxJwsR/JzgCYDjTW2nZg53f0dlXPlAUQPDRtiuHoopxm3gwEFxpuXPBYRhaKOS
         /0mJVj+w76l4vuTkplECjb8Qfi3ufSy5GBqYqisdz61ZfFMGZ+y0KmkbUcrn07eLD8mA
         FB+G0M/9IHAWrJk7aj0RoQOm+0l9aJXDih5cCim3Gf+JNQ0IXr3EuDZeTQLrf+LaRPlu
         LilEEOKip0bKaE421EMniGs2TOF4Uz81ojm/Xuo6VRtitYg14ICrxJcObPAnEJlvuPQ5
         gT3A==
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
Subject: [PATCH 4.4 107/134] ipvlan: add L2 check for packets arriving via virtual devices
Date: Mon, 19 Mar 2018 19:06:30 +0100
Message-Id: <20180319171904.697457654@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390973665404691?=
X-GMAIL-MSGID: =?utf-8?q?1595390973665404691?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -282,6 +282,10 @@ static int ipvlan_rcv_frame(struct ipvl_
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
