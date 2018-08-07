Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BDBC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64ABE21655
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64ABE21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387683AbeHGLi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:38:57 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:50103 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeHGLi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:38:57 -0400
X-IronPort-AV: E=Sophos;i="5.51,454,1526367600"; 
   d="scan'208";a="17494818"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Aug 2018 02:25:32 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Tue, 7 Aug 2018 02:25:23 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harinik@xilinx.com>, <jennifer.dahm@ni.com>,
        <nathan.sullivan@ni.com>, <rafalo@cadence.com>,
        <harinikatakamlinux@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/3] net: macb: add pad and fcs support
Date:   Tue, 7 Aug 2018 12:25:11 +0300
Message-ID: <1533633914-30264-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In [1] it was reported that UDP checksum is offloaded to hardware no mather
it was previously computed in software or not. The proposal on [1] was to
disable TX checksum offload.

This series (mostly patch 3/3) address the issue described at [1] by
setting NOCRC bit to TX buffer descriptor for SKBs that arrived from
networking stack with checksum computed. For these packets padding and FCS
need to be added (hardware doesn't compute them if NOCRC bit is set). The
minimum packet size that hardware expects is 64 bytes (including FCS).
This feature could not be used in case of GSO, so, it was used only for
no GSO SKBs.

For SKBs wich requires padding and FCS computation macb_pad_and_fcs()
checks if there is enough headroom and tailroom in SKB to avoid copying
SKB structure. Since macb_pad_and_fcs() may change SKB the
macb_pad_and_fcs() was places in macb_start_xmit() b/w macb_csum_clear()
and skb_headlen() calls.

This patch was tested with pktgen in kernel tool in a script like this:
(pktgen_sample01_simple.sh is at [2]):

minSize=1
maxSize=1500

for i in `seq $minSize $maxSize` ; do
	copy="$(shuf -i 1-2000 -n 1)"
	./pktgen_sample01_simple.sh -i eth0 \
		-m <dst-mac-addr> -d <dst-ip-addr> -x -s $i -c $copy
done

minStep=1
maxStep=200
for i in `seq $minStep $maxStep` ; do
	copy="$(shuf -i 1-2000 -n 1)"
	size="$(shuf -i 1-1500 -n 1)"
	./pktgen_sample01_simple.sh -i eth0 \
		-m <dst-mac-addr> -d <dst-ip-addr> -x -s $size -c $copy
done

Changes since RFC:
- in patch 3/3 order local variables by their lenght (reverse christmas tree
  format)

[1] https://www.spinics.net/lists/netdev/msg505065.html
[2] https://github.com/netoptimizer/network-testing/blob/master/pktgen/pktgen_sample01_simple.sh

Claudiu Beznea (3):
  net: macb: use netdev_tx_t return type for ndo_start_xmit functions
  net: macb: move checksum clearing outside of spinlock.
  net: macb: add support for padding and fcs computation

 drivers/net/ethernet/cadence/macb_main.c | 88 +++++++++++++++++++++++++++++---
 1 file changed, 80 insertions(+), 8 deletions(-)

-- 
2.7.4

