Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89976C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF1323E24
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF1323E24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeFVHXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:23:04 -0400
Received: from regular1.263xmail.com ([211.150.99.131]:43426 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeFVHXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:23:02 -0400
Received: from david.wu?rock-chips.com (unknown [192.168.167.43])
        by regular1.263xmail.com (Postfix) with ESMTP id 67AE46297;
        Fri, 22 Jun 2018 15:22:36 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.12.81] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id C9A653B6;
        Fri, 22 Jun 2018 15:22:35 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: david.wu@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: david.wu@rock-chips.com
X-UNIQUE-TAG: <827ca471518cfa23ab2d3b8c9917effa>
X-ATTACHMENT-NUM: 0
X-SENDER: wdc@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.12.81] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 15251SDPEUZ;
        Fri, 22 Jun 2018 15:22:37 +0800 (CST)
Subject: Re: [PATCH v2] net: ethernet: stmmac: dwmac-rk: Add GMAC support for
 PX30
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        huangtao@rock-chips.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1528956927-32440-1-git-send-email-david.wu@rock-chips.com>
 <1961033.25ax7s0Z5i@diego>
 <3aa2445f-ab2a-93b6-3a49-36be6c98d327@rock-chips.com>
 <2582999.2hZx6CH9S6@diego>
From:   David Wu <david.wu@rock-chips.com>
Message-ID: <7173b45f-17d3-2356-fede-28bdd5c658f2@rock-chips.com>
Date:   Fri, 22 Jun 2018 15:22:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2582999.2hZx6CH9S6@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

在 2018年06月14日 16:30, Heiko Stübner 写道:
> And someone could convert the driver to use the new clk-bulk APIs [0],
> so the large number of clk_prepare_enable calls would be a bit
> trimmed down.

Some clocks need special treatment at special cases, may not know which 
index is we need at clk_bulk_data struct.
1. At rmii mode, need to use mac_ref, mac_refout; but at rgmii, they are 
not needed.
2. At rgmii mode, rx is coming in from external source, there is no 
gate, and it is coming from mac_ref_clk at rmii mode, there is gate.
3. clk_mac needs to be configured rate 50M or 125M.
4. mac_clk_speed needs to be configured at PX30 Soc and next Socs.

It looks like use the clk-bulk, will not be more flexible, and we still 
keep the present. What do you think?

