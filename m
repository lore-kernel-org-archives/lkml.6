Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1E1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222BF204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222BF204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754744AbeGCKRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:17:25 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:28459 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754602AbeGCKRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:17:23 -0400
Received: from [192.168.90.200] (10.18.20.235) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 3 Jul 2018
 18:16:34 +0800
Subject: Re: [PATCH v2 2/2] clk: meson-axg: add clocks required by pcie driver
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
References: <20180702213118.19222-1-yixun.lan@amlogic.com>
 <20180702213118.19222-3-yixun.lan@amlogic.com>
 <1530609862.2900.187.camel@baylibre.com>
CC:     <yixun.lan@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Jianxin Qin <jianxin.qin@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <7c8b47a9-67bc-b685-8c90-084299631fb0@amlogic.com>
Date:   Tue, 3 Jul 2018 18:17:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1530609862.2900.187.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome:


On 07/03/18 17:24, Jerome Brunet wrote:
> On Mon, 2018-07-02 at 21:31 +0000, Yixun Lan wrote:
>> Adding clocks for the pcie driver. Due to the ASIC design,
>> the pcie controller re-use part of the mipi clock logic,
>> so the mipi clock is also added.
>>
>> Tested-by: Jianxin Qin <jianxin.qin@amlogic.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  drivers/clk/meson/axg.c | 148 ++++++++++++++++++++++++++++++++++++++++
>>  drivers/clk/meson/axg.h |   6 +-
>>  2 files changed, 153 insertions(+), 1 deletion(-)
>>
>>
> 
> [...]
> 
>> +
>> +/* skip the partent 0, it's for debug only */
>> +static u32 mux_table_pcie_ref[]	= { 1 };
>> +static const char * const pcie_ref_parent_names[] = { "pcie_mux" };
> 
> Dropped these symbols.
> 
>> +
>> +static struct clk_regmap axg_pcie_ref = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = HHI_PCIE_PLL_CNTL6,
>> +		.mask = 0x1,
>> +		.shift = 1,
>> +		.table = mux_table_pcie_ref,
> 
> Replaced with the table itself
> 
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pcie_ref",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_names = pcie_ref_parent_names,
>> +		.num_parents = ARRAY_SIZE(pcie_ref_parent_names),
> 
> Replaced with the table itself and applied. Thx
> 
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +

I'm seeing you already applied this patch, so would you like to
fix/amend the patch for me, or want me send another patch version?

thanks
