Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BD7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0752206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfANWtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:49:49 -0500
Received: from mga12.intel.com ([192.55.52.136]:57329 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfANWtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:49:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 14:49:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,479,1539673200"; 
   d="scan'208";a="291540043"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2019 14:49:48 -0800
Subject: Re: [PATCH v10 06/12] peci: Add a PECI adapter driver for Aspeed
 AST24xx/AST25xx
To:     Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
References: <20190107214136.5256-1-jae.hyun.yoo@linux.intel.com>
 <20190107214136.5256-7-jae.hyun.yoo@linux.intel.com>
 <CACPK8XfMyXfomepZEPJCr=A-cCPw-CVAZ0B2CuKn7oXCNz6LbQ@mail.gmail.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <abaef001-a769-ec5d-45f0-02a994fdbee6@linux.intel.com>
Date:   Mon, 14 Jan 2019 14:49:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CACPK8XfMyXfomepZEPJCr=A-cCPw-CVAZ0B2CuKn7oXCNz6LbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/2019 3:37 AM, Joel Stanley wrote:
> On Tue, 8 Jan 2019 at 08:11, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>> +       ret = of_property_read_u32(priv->dev->of_node, "cmd-timeout-ms",
>> +                                  &priv->cmd_timeout_ms);
>> +       if (ret || priv->cmd_timeout_ms > PECI_CMD_TIMEOUT_MS_MAX ||
>> +           priv->cmd_timeout_ms == 0) {
>> +               if (!ret)
>> +                       dev_warn(priv->dev,
>> +                                "Invalid cmd-timeout-ms : %u. Use default : %u\n",
>> +                                priv->cmd_timeout_ms,
>> +                                PECI_CMD_TIMEOUT_MS_DEFAULT);
> 
> As this property is documented as optional, I'd split out the checks
> so you only warn when the value provided is invalid.
> 

Please check the above 'if' statement too. It prints out warning only
when the property is defined in device tree but the value is out of
range.

>> +
>> +       regmap_write(priv->regmap, ASPEED_PECI_CTRL,
>> +                    FIELD_PREP(PECI_CTRL_CLK_DIV_MASK, PECI_CLK_DIV_DEFAULT) |
>> +                    PECI_CTRL_PECI_CLK_EN);
>> +
>> +       /**
> 
> Just the one *.
> 

Will fix it.

>> +        * Timing negotiation period setting.
>> +        * The unit of the programmed value is 4 times of PECI clock period.
>> +        */
>> +       regmap_write(priv->regmap, ASPEED_PECI_TIMING,
>> +                    FIELD_PREP(PECI_TIMING_MESSAGE_MASK, msg_timing) |
>> +                    FIELD_PREP(PECI_TIMING_ADDRESS_MASK, addr_timing));
> 
>> +static int aspeed_peci_xfer(struct peci_adapter *adapter,
>> +                           struct peci_xfer_msg *msg)
>> +{
>> +       struct aspeed_peci *priv = peci_get_adapdata(adapter);
>> +
>> +       return aspeed_peci_xfer_native(priv, msg);
>> +}
> 
> It looks like you could do the peci_get_adapdata in
> aspeed_peci_xfer_native and drop the need for this wrapper.
> 

Yes, that would be neater. Will remove this wrapper.

>> +
>> +static int aspeed_peci_probe(struct platform_device *pdev)
>> +{
> 
>>
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       base = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(base)) {
>> +               ret = PTR_ERR(base);
>> +               goto err_put_adapter_dev;
>> +       }
>> +
>> +       priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
>> +                                            &aspeed_peci_regmap_config);
>> +       if (IS_ERR(priv->regmap)) {
>> +               ret = PTR_ERR(priv->regmap);
>> +               goto err_put_adapter_dev;
>> +       }
>> +
>> +       /**
>> +        * We check that the regmap works on this very first access,
>> +        * but as this is an MMIO-backed regmap, subsequent regmap
>> +        * access is not going to fail and we skip error checks from
>> +        * this point.
> 
> Why do you use a regmap for this driver? AFAICT it has exclusive
> ownership over the register range it uses, which is sometimes a reason
> to use a regmap over a mmio region.
> 
> I'm not sure if you've ever disassembled drivers/base/regmap/regmap.o,
> but if you do you will find that a single mmio read turns into
> hundreds of instructions.
> 

No specific reason. regmap makes some overhead as you mentioned but it
also provides some advantages on access simplification, endianness
handling and register dump at run time. I would not insist using of
regmap if you prefer using of raw readl and writel. Do you want replace
regmap with readl and writel in this driver?

Thanks,
Jae

> Cheers,
> 
> Joel
> 
