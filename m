Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413601-3-17610128340786046812
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519413601; b=gEzRI8JR2nUyRL9kWNnUvYOEe4oONkif3XK/k2uUWWnULww
    Iz3ZAhP/+ePjgq1VUc1jlWq1MyzzShlnsEwpxgPT6jFcV/3A6uP1stbh2uPdy59/
    DF3HLVxCWPZRzYJYGWU5BCvH7nrRhSaGkWrsBQE0k0SrQ/b6xZrQ91rsQ9CsB4so
    Ze1zSnbDn6B48J0oIq4oGasNssfE2+Z1LjyJjCWK6ERM4HG3bWUlEGNmJmb2Jkp1
    1dXlelJ22Xb8PbClc+d+6MUSAlC13HgebrrYLPJ8uk7+HUDNRPrarHfKQZxbjsQA
    9zdZbgW4UQ0lleq9gxQ2gogvF2JIjSH91mkLGGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413601; bh=/7K7Endd31mV6UcQSa1/FjwQiS
    gsihx5eGoHxfeBvQQ=; b=k6f7iuh8db0ngUrfkHxogJOsMgaDMWbdUImoVW7YKU
    CX+HokuB7tCxXBDPqfGhmZ6Jq7Bt7ATul6xZFJ03jRGdg62T1l/GIDkGPI7gh8wW
    2brEAjA0P0cXx042OniKMmHU73y19ih8Pt0/LexDW6N+Vhte42RIScqJsRBrj7QV
    ruih9qjErHCqSo0PZf3NQchHJddx9QfwaXow2+ofIRL3SBPjTICU+SMK9N3cE1Gd
    P4xGGvr1SLKKCqpgHp/RFUTeiLULoFnglKWV7ATcqjLxmwcVAzKjTBeJjv0x9v41
    I3Lpg043YmsEt5WQEhXLbpT+QSIF1cazUDGIJDxNcprQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964945AbeBWSyW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:54:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47728 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964920AbeBWSyV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:54:21 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pieter Jansen van Vuuren
        <pieter.jansenvanvuuren@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 110/159] nfp: fix port stats for mac representors
Date: Fri, 23 Feb 2018 19:26:58 +0100
Message-Id: <20180223170756.686403723@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>


[ Upstream commit 42d779ffc186f6dd26271fc60a7417cb51aca93e ]

Previously we swapped the tx_packets, tx_bytes and tx_dropped counters
with rx_packets, rx_bytes and rx_dropped counters, respectively. This
behaviour is correct and expected for VF representors but it should not
be swapped for physical port mac representors.

Fixes: eadfa4c3be99 ("nfp: add stats and xmit helpers for representors")
Signed-off-by: Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
@@ -84,16 +84,13 @@ nfp_repr_phy_port_get_stats64(struct nfp
 {
 	u8 __iomem *mem = port->eth_stats;
 
-	/* TX and RX stats are flipped as we are returning the stats as seen
-	 * at the switch port corresponding to the phys port.
-	 */
-	stats->tx_packets = readq(mem + NFP_MAC_STATS_RX_FRAMES_RECEIVED_OK);
-	stats->tx_bytes = readq(mem + NFP_MAC_STATS_RX_IN_OCTETS);
-	stats->tx_dropped = readq(mem + NFP_MAC_STATS_RX_IN_ERRORS);
+	stats->tx_packets = readq(mem + NFP_MAC_STATS_TX_FRAMES_TRANSMITTED_OK);
+	stats->tx_bytes = readq(mem + NFP_MAC_STATS_TX_OUT_OCTETS);
+	stats->tx_dropped = readq(mem + NFP_MAC_STATS_TX_OUT_ERRORS);
 
-	stats->rx_packets = readq(mem + NFP_MAC_STATS_TX_FRAMES_TRANSMITTED_OK);
-	stats->rx_bytes = readq(mem + NFP_MAC_STATS_TX_OUT_OCTETS);
-	stats->rx_dropped = readq(mem + NFP_MAC_STATS_TX_OUT_ERRORS);
+	stats->rx_packets = readq(mem + NFP_MAC_STATS_RX_FRAMES_RECEIVED_OK);
+	stats->rx_bytes = readq(mem + NFP_MAC_STATS_RX_IN_OCTETS);
+	stats->rx_dropped = readq(mem + NFP_MAC_STATS_RX_IN_ERRORS);
 }
 
 static void
