Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeEVO2l (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:28:41 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:41884 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEVO2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:28:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Tue, 22 May 2018 16:28:37 +0200
From: Stefan Agner <stefan@agner.ch>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, dev@lynxeye.de,
        miquel.raynal@bootlin.com, richard@nod.at, marcel@ziswiler.com,
        krzk@kernel.org, benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, mirza.krak@gmail.com,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [RESEND PATCH 2/5] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
In-Reply-To: <0a3c683c-15fd-d05c-4aa2-5fa109c892c6@gmail.com>
References: <cover.1526990589.git.stefan@agner.ch>
 <86fdf19ec92b732709732fb60199f16488b4b727.1526990589.git.stefan@agner.ch>
 <2e858be88e00e26495fe47c6cd5cd70c@agner.ch>
 <0a3c683c-15fd-d05c-4aa2-5fa109c892c6@gmail.com>
Message-ID: <7efc2975ed8c24a708d43dec06a48ceb@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-2.56 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[25];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.46)[97.53%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.2018 15:34, Dmitry Osipenko wrote:
> On 22.05.2018 15:19, Stefan Agner wrote:
>> [review sent to my first patch sent off-ml, moving to ml thread]
>>
>> On 21.05.2018 16:05, Dmitry Osipenko wrote:
>>> Hello Stefan,
>>>
>>> I don't have expertise to review the actual NAND-related driver logic, so I only
>>> reviewed the basics. The driver code looks good to me, though I've couple minor
>>> comments.
>>>
>>> On 21.05.2018 03:16, Stefan Agner wrote:
>>>> Add support for the NAND flash controller found on NVIDIA
>>>> Tegra 2 SoCs. This implementation does not make use of the
>>>> command queue feature. Regular operations/data transfers are
>>>> done in PIO mode. Page read/writes with hardware ECC make
>>>> use of the DMA for data transfer.
>>>>
>>>> Signed-off-by: Lucas Stach <dev@lynxeye.de>
>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>>> ---

<snip>

>>>> +static int tegra_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
>>>> +				uint8_t *buf, int oob_required, int page)
>>>> +{
>>>> +	struct tegra_nand *nand = to_tegra_nand(mtd);
>>>> +	u32 value, addrs;
>>>> +
>>>> +	writel(NAND_CMD_READ0, nand->regs + CMD_1);
>>>> +	writel(NAND_CMD_READSTART, nand->regs + CMD_2);
>>>> +
>>>> +	addrs = tegra_nand_fill_address(mtd, chip, page);
>>>> +
>>>> +	value = readl(nand->regs + CFG);
>>>> +	value |= CFG_HW_ECC | CFG_ERR_COR;
>>>> +	writel(value, nand->regs + CFG);
>>>> +
>>>> +	writel(mtd->writesize - 1, nand->regs + DMA_CFG_A);
>>>> +	writel(nand->data_dma, nand->regs + DATA_PTR);
>>>> +
>>>> +	if (oob_required) {
>>>> +		writel(mtd_ooblayout_count_freebytes(mtd) - 1,
>>>> +		       nand->regs + DMA_CFG_B);
>>>> +		writel(nand->oob_dma, nand->regs + TAG_PTR);
>>>> +	} else {
>>>> +		writel(0, nand->regs + DMA_CFG_B);
>>>> +		writel(0, nand->regs + TAG_PTR);
>>>> +	}
>>>> +
>>>> +	value = DMA_CTRL_GO | DMA_CTRL_IN | DMA_CTRL_PERF_EN |
>>>> +		DMA_CTRL_REUSE | DMA_CTRL_IE_DONE | DMA_CTRL_IS_DONE |
>>>> +		DMA_CTRL_BURST_8 | DMA_CTRL_EN_A;
>>>
>>> Wouldn't be more efficient to set DMA burst to 16 words? The writesize seems
>>> always aligned to at least 64 words.
>>>
>>
>> Hm, haven't tested 16 words, 8 was the setting Lucas used.
>>
>> Are you sure this is only about write size? Not sure, but isn't the ECC
>> area also DMA'd? On Colibri we use RS with t=8, hence 144 bytes parity,
>> so this would be properly aligned non the less...
>>
> 
> I don't know, that's up to you to figure out. Is RS stands for Reed-Solomon and
> t=8 is the max number of redundant words?
> 

RS = Reed-Solomon
t=8 maximum symbol errors

Will do some testing and check whether it fails.

--
Stefan
