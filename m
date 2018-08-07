Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DA4C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1A82156E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1A82156E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeHGWfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:35:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50166 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeHGWfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:35:16 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1C809100A8C6D;
        Tue,  7 Aug 2018 13:19:10 -0700 (PDT)
Date:   Tue, 07 Aug 2018 13:19:09 -0700 (PDT)
Message-Id: <20180807.131909.2224882167750246331.davem@davemloft.net>
To:     claudiu.beznea@microchip.com
Cc:     nicolas.ferre@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, harinik@xilinx.com,
        jennifer.dahm@ni.com, nathan.sullivan@ni.com, rafalo@cadence.com,
        harinikatakamlinux@gmail.com
Subject: Re: [PATCH 0/3] net: macb: add pad and fcs support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1533633914-30264-1-git-send-email-claudiu.beznea@microchip.com>
References: <1533633914-30264-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 07 Aug 2018 13:19:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>
Date: Tue, 7 Aug 2018 12:25:11 +0300

> In [1] it was reported that UDP checksum is offloaded to hardware no mather
> it was previously computed in software or not. The proposal on [1] was to
> disable TX checksum offload.
> 
> This series (mostly patch 3/3) address the issue described at [1] by
> setting NOCRC bit to TX buffer descriptor for SKBs that arrived from
> networking stack with checksum computed. For these packets padding and FCS
> need to be added (hardware doesn't compute them if NOCRC bit is set). The
> minimum packet size that hardware expects is 64 bytes (including FCS).
> This feature could not be used in case of GSO, so, it was used only for
> no GSO SKBs.
> 
> For SKBs wich requires padding and FCS computation macb_pad_and_fcs()
> checks if there is enough headroom and tailroom in SKB to avoid copying
> SKB structure. Since macb_pad_and_fcs() may change SKB the
> macb_pad_and_fcs() was places in macb_start_xmit() b/w macb_csum_clear()
> and skb_headlen() calls.
> 
> This patch was tested with pktgen in kernel tool in a script like this:
> (pktgen_sample01_simple.sh is at [2]):
 ...

Series applied to net-next, thanks.
