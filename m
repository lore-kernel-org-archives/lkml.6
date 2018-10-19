Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ED3ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F002145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F002145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeJSQJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:09:15 -0400
Received: from mail-sz2.amlogic.com ([211.162.65.114]:45204 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeJSQJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:09:14 -0400
Received: from [10.28.18.51] (10.28.18.51) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 19 Oct
 2018 16:04:09 +0800
Subject: Re: [PATCH v5 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
CC:     <linux-mtd@lists.infradead.org>, Yixun Lan <yixun.lan@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1539839345-14021-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839345-14021-3-git-send-email-jianxin.pan@amlogic.com>
 <20181018223943.145e5497@bbrezillon>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <b80f2e72-7ad5-9f37-a059-87b1d8344e7b@amlogic.com>
Date:   Fri, 19 Oct 2018 16:04:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181018223943.145e5497@bbrezillon>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.51]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/10/19 4:39, Boris Brezillon wrote:
> On Thu, 18 Oct 2018 13:09:05 +0800
> Jianxin Pan <jianxin.pan@amlogic.com> wrote:
> 
>> +static int meson_nfc_calc_set_timing(struct meson_nfc *nfc,
>> +				     const struct nand_sdr_timings *timings)
>> +{
>> +	struct nand_timing *timing = &nfc->timing;
>> +	int div, bt_min, bt_max, bus_timing;
>> +	int ret;
>> +
>> +	div = DIV_ROUND_UP((timings->tRC_min / 1000), NFC_CLK_CYCLE);
>> +	ret = clk_set_rate(nfc->device_clk, 1000000000 / div);
>> +	if (ret) {
>> +		dev_err(nfc->dev, "failed to set nand clock rate\n");
>> +		return ret;
>> +	}
>> +
>> +	timing->twb = DIV_ROUND_UP(PSEC_TO_NSEC(timings->tWB_max),
>> +				   div * NFC_CLK_CYCLE);
>> +	timing->tadl = DIV_ROUND_UP(PSEC_TO_NSEC(timings->tADL_min),
>> +				    div * NFC_CLK_CYCLE);
>> +	timing->twhr = DIV_ROUND_UP(PSEC_TO_NSEC(timings->tWHR_min),
>> +				    div * NFC_CLK_CYCLE);
>> +
>> +	bt_min = (timings->tREA_max + NFC_DEFAULT_DELAY) / div;
>> +	bt_max = (NFC_DEFAULT_DELAY + timings->tRHOH_min
>> +			+ timings->tRC_min / 2) / div;
>> +
>> +	bt_min = DIV_ROUND_UP(bt_min, 1000);
>> +	bt_max = DIV_ROUND_UP(bt_max, 1000);
>> +
>> +	if (bt_max < bt_min)
>> +		return -EINVAL;
>> +
>> +	bus_timing = (bt_min + bt_max) / 2 + 1;
>> +
>> +	writel((1 << 21), nfc->reg_base + NFC_REG_CFG);
>> +	writel((NFC_CLK_CYCLE - 1) | (bus_timing << 5),
>> +	       nfc->reg_base + NFC_REG_CFG);
>> +
>> +	writel((1 << 31), nfc->reg_base + NFC_REG_CMD);
>> +
>> +	return 0;
>> +}
>> +
>> +static int
>> +meson_nfc_setup_data_interface(struct nand_chip *nand, int csline,
>> +			       const struct nand_data_interface *conf)
>> +{
>> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
>> +	const struct nand_sdr_timings *timings;
>> +
>> +	timings = nand_get_sdr_timings(conf);
>> +	if (IS_ERR(timings))
>> +		return -ENOTSUPP;
>> +
>> +	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
>> +		return 0;
> 
> Hm, before saying you supporting the requested timing, you should make
> sure they are actually supported. I'd recommend splitting this in 2
> steps:
> 
> 1/ calc timings
> 2/ store the timings in the chip priv struct so that they can be
> applied next time ->select_chip() is called.
> 
ok, i will try to split.

>> +
>> +	meson_nfc_calc_set_timing(nfc, timings);
> > You should not set the timing from ->setup_data_interface(), just
> calculate them, make sure they are supported and store the state in the
> private chip struct. Applying those timings should be done in
> ->select_chip(), so that you can support 2 chips with different timings.
> 
em, i will fix it.
>> +	return 0;
>> +}
> 
> .
> 
