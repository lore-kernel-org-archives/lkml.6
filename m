Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521215179-2-9141646839008389539
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521215178; b=qF468FYbpJu27h5HYBgsuw5kx4qAwPyirO3nagxXAe+DndZ
    AcCY16PVRZxR4wxE3DPDHhl9o1gLUa8+8IMyyd+uPEUGzgXLWMJam0BJTygzbX+8
    IGB7F0akXuOC9M/dCRg9FOwfiidCHA6wBc+KHpQTU3EcAn7s7CkBvXDVHrWzQB1q
    zAlu59tYjloq+BEW9Y5HfsKCcRoXzkwR0+dwWfAmeLSgXVhwdu0xX6jhp6h1toGA
    Apu4R102h3Cy5ZjidwzOgMvpphaXflgDLaqeCYDtL4iNIl0tuU2QzBl7qYgwJr8q
    q8OIS13PYJL6IR8JzpC4AWGcIgiLVmIDfIvB8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521215178; bh=jKiQkc5uKKa+S2kjl+3SfpqYIl
    DMEEDmu/kb7zYEKCE=; b=iBLvVGxNIi0XGqW1R4lqlnuOKnjBM4mpLZDwwGPuFq
    +YFlFs7ZbNIF4ErehgCBlT9a0XGCNeOEDOySIRNtdXEJv5JvK3dM9XnB77ZyP8Gd
    ozTp33+nAKd6fgh/MXLv2kVPsn1Wj+cr7rUSWq1KW6b1dGV4A5iXw9x3D20KTsw0
    AT/lVA3uI02/E1a06Pskt4gsA+i8Y7DBQQUwiqreguALkz1g1PKKP7Py063G2VUk
    XEJCu9vn9bxHiwbyPYLiJPWh5NdqD8Q6+tJjXcZx575geviIu2vDOb333/DqBLKL
    6bvTL/7MAREo4USB/2OifBHxXWkJNMXHWyDEX1vDDlOQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965114AbeCPPqC (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:46:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46296 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934430AbeCPPpT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:45:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amit Sikka <amit.sikka@ericsson.com>,
        Mahesh Bandewar <maheshb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 122/128] ipvlan: add L2 check for packets arriving via virtual devices
Date: Fri, 16 Mar 2018 16:24:23 +0100
Message-Id: <20180316152342.514138115@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -322,6 +322,10 @@ static int ipvlan_rcv_frame(struct ipvl_
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
