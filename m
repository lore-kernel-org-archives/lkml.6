Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1808ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4146C2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="d2xa4ev4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4146C2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbeIQJDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:03:17 -0400
Received: from mail-cys01nam02on0089.outbound.protection.outlook.com ([104.47.37.89]:40222
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728348AbeIQJDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 05:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2bV/5H1CxKRnC9H1VTa49CA03ZDDlpX5OAtE68D3VU=;
 b=d2xa4ev4MeIYECVoCebdGL7dGT8oBDPh/KxbpaxS6dAQhboQRw3KttttyQNCyl1bghCUT2AaKScxKZ81afdvDftI5j0YI2McVMBv3qMBH1Z+PzUgFGrVzD+EXidrZEeHIKLmR4hFBjT0jnsgCkS17QZl4rGBzZK+nZ3ybSnJabA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BY2PR0301MB1574.namprd03.prod.outlook.com (2a01:111:e400:526e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Mon, 17 Sep
 2018 03:37:44 +0000
Date:   Mon, 17 Sep 2018 11:34:18 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] i2c: designware: select gpio/default pin when
 prepare/unprepare recovery
Message-ID: <20180917113418.16881f6c@xhacker.debian>
In-Reply-To: <20180917112949.414dd56f@xhacker.debian>
References: <20180917112633.252c591c@xhacker.debian>
        <20180917112949.414dd56f@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:404:56::17) To BY2PR0301MB1574.namprd03.prod.outlook.com
 (2a01:111:e400:526e::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84acd89c-872b-4039-2f00-08d61c4ef000
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR0301MB1574;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1574;3:fm/+83mnLL4q5gWcDYDYLzeEU3r0Yd50AQPm+2rb83YaET/0KGbuNBfSUDwv4kroUE23GaDrsHwPsqxzE0vBIFe2Voult2gZmp54lF0eBQls94NjHGYEZLoaL2rNHcRuc4Y3IAeyTpLXrhxfcRqVC6OUuw6SVdUrZy01uZK6z6n/80AmDibg5Mhf9pBM/Njg0GC/BG+qOjWaTStSlGZx3f9wO+xBajicjWZ1YaDQdKVv1GprLQrmujNSWu2unX0K;25:rxfhcm4sCVZU31EaKKjLZQzzO4lqIUY+Iutt0ZfG3C4YiD3iaDYNVPcaAwo8C0msDGYvNJ1UZM/lSLBvMJKgB/dWzQ4cVP0jhwS350usox3KMO4GLwoFyUrV4vRrO7IO79wxBEEsj6dSeH+cyQrwCuEdrt0Oz1/cZOnc4B/70OMhA4/JVOVoX7TBrcLlzHxORc2umE28sPoOUlI9C0qtA1dfuOEKcDsCiiTmJqRrtXANsh847mxH6N2u+KvyQL1crYLh1lSMcaTDTLQ9XwYfysnk22NUj78eKgiu+VFpCfENqfexm+BP3OKRDwPRtqymScZY3yYegXjG55Sg1uSSZw==;31:y6JQt/MM+YWMIZVRDC40krmwlXXhSABKd0YmvicgBUAxu3NeTIO2QVGSMcMobElK0wiN8BsXKzz0HimFsW8llRtZbnk+zaYOeww1FoyqaLki0xPD1Ang9rMDDn/Adaa7HdfBqcqQEDS1KFTOs7eEySDZ3hMUTOkVUgd9cmq7ku//OuzKAzT/i3f1hJajcqtBVmUawmjMS4EBKbbskTeMz7SPjWfjJbtxX2HdLYWGkho=
X-MS-TrafficTypeDiagnostic: BY2PR0301MB1574:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1574;20:wuviXHebg88fPF/0YQ7XhtaMYE1HSqmhTxdJUk31/ZfpCuioSFzdhmVHgb/YTkLw5pndlVx40bMUiMqJ3gfEY8Sl0+mb7UfuNpWkWSss5pd070pj/8LcEYJQmCFs3XXHmidLrLIUoe+BLfpYoLUu78J9CDi5nOcy15Y/hT5kHkx61+Wke+TUgBMKjevxqhuEidnxDh6aq3/HClImaVPEgQJJmqWz+AE14ajDs0T2e01P2C8Hf+HbirWkfv5wADk4u+CEvvz7+hl8fyLPNBwSUIkRP6cydPviPRNFxFsSDPBbfJFfR2vmU1UA+w7w1KLIv7opWpT8SaC/okxIVAeAx7BHyCx2mDvtT+96FK97peHsqjdfXuLgn0wzs+Pv+pjtvO4jPSsur60eBdgmuDd9iPcFvqJjWTH49Hb9H2l8bXj7xBnN7XG4MNUzHDSPQE+VrrOO4dn/f1MIq/LJzbV3vnlfmTK/5ZYgnvN4999jZrZKEuzUdCLtzF/Fq4Hl9rLt;4:iQY03DLWHYlpQbcCzkv9oxBiB7mwOR82bZT+LGoMgSxNitViPT+MYoX5YIMVLPfBXWv9vMD/mkFhWrMTqVXQacFhDmsmHCoIChbK4i0rsvCtEEo7gv5mAl1rCSE707Ehp3sUm7SpDFarDTgtmT16V7NbMHHCq91tJ5/rj2hIKJk0fPSKAn+8CgDO399bJqBt7mEP1hxauAl7GOnB80gqijrWgHlF/SNVJ0MGtBBYiIaQa3oq1J1PV8vwKODGekFM4vYSqIv4QVG4eutIK2XLqw==
X-Microsoft-Antispam-PRVS: <BY2PR0301MB157433EEDBF72C0181815F3FED1E0@BY2PR0301MB1574.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:BY2PR0301MB1574;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0301MB1574;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39850400004)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(14444005)(81166006)(86362001)(575784001)(229853002)(53936002)(8676002)(5660300001)(72206003)(68736007)(486006)(7736002)(305945005)(55016002)(478600001)(8936002)(9686003)(105586002)(66066001)(3846002)(230700001)(7696005)(52116002)(386003)(6506007)(6116002)(186003)(16526019)(50466002)(7416002)(50226002)(4326008)(110136005)(25786009)(1076002)(54906003)(2906002)(33896004)(316002)(6246003)(956004)(11346002)(446003)(106356001)(97736004)(23726003)(6666003)(47776003)(76176011)(476003)(26005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB1574;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0301MB1574;23:0ZWfFbXMRYXPde4uHW2cqvMa6W0VzmOf2HAXT1l?=
 =?us-ascii?Q?GaDSLKM7fm/rVIX31VdrRxLkuP+Uvxnx1IvVv/4cnYpKTqw+wpa3kxREz3TP?=
 =?us-ascii?Q?tjnDg/aMEdCy9FJlHRY6baZKM05236IPnj3z4oS6Xb06aAdxIWfOVDZnAWRt?=
 =?us-ascii?Q?1OILbRRWYy3BNmI6QnyxGWvtUXmDfO/JslKtZWmaKTfDEvvjxDI9CfXCyuGQ?=
 =?us-ascii?Q?nIB9CXMTnkrCCasSDUS0uT10uUQYvD9NsGh50D9PZVDyc8Hb9UsJxC+27JZa?=
 =?us-ascii?Q?T/oqiD8IAE+NOB+JTgQYkJW4v0+Cs1gwMwbMZvXTTrIoMO3naBCBw96iB4Sa?=
 =?us-ascii?Q?rmmVMvW7/YtmRu4oSrEipr35aLaZnOZhWgTAndU0GYPI2MSf+cPUR+rviwhM?=
 =?us-ascii?Q?Fe9sp4qQ8SP2Zs0MoGtZwnYAUDwG9rx6TBT0A+sabzWYiskS4O1BbLalr9BP?=
 =?us-ascii?Q?3NdnQB1uglBHT8wt8I/WslazBtLrZyKDWt8Wb2EEZ1A5U4lUQf7pIWFgrcte?=
 =?us-ascii?Q?M/ZZOuZSNLYmyq3lE+uXmLjRTKx1ZHShKIg503aWeLhjuer5ydzCnjgfE2QO?=
 =?us-ascii?Q?Q+f8xlUlNiqw7XKV95YxTSQ9351JT1WJuloWM4bobxDFAXGTqAi5hMn8JJbW?=
 =?us-ascii?Q?LfZTlkHYeG9GqA0Ejh7bSgxGuMdSQLNXuAT92dVGq8wMPlyBdmZicmfmSo9c?=
 =?us-ascii?Q?nq1tYggskCiN+nPSIRBgv9mz0bKWXd/mjyMH66GxWy7Kf5pis0TECD8ntEFo?=
 =?us-ascii?Q?nLMfiNIUfX5S12LrIsWxtSGxya69oY2TS274G9PuLHce6UpQb7399Ls8aPa3?=
 =?us-ascii?Q?wGRfN6NqMwaHUJuTbCZ0lnWZj3/0epEEOaIRqU1o8Ix8XA/XAwsUbNSrvwV6?=
 =?us-ascii?Q?Kcfw78UBumV1+Llx4r1MV3GxTYVe9E+Rk4LsU7URdMeFRFKWHTU+b98ajTrM?=
 =?us-ascii?Q?/Jn5rSBYLNpqJYXDC4G8vxCLgaMF7bfCuu59Eg4yqe0HrU04C/b63Y7oBjIB?=
 =?us-ascii?Q?+IvQutx5BmyG8Z8D8YVPJMzt37ulWBnMr5NKAo0wuHzn9lif+nlVNh1XA6PB?=
 =?us-ascii?Q?+bF9rtQea+KTzVNx+7tQcxUN1JhAfyNmAnYGLCipIThSeTyMdMW9gvJlq8ZX?=
 =?us-ascii?Q?iVZv77QI+ygN7qXgDhxmeo5ObYVN1omtx+PJSEW6O6aj2QTob/L256h9+Ymo?=
 =?us-ascii?Q?RAlP26m04NxpB/11OIObFhI6LFRhxyGyD1qzYLtIKmt3aN89v3RBvQcivk4Y?=
 =?us-ascii?Q?De6Co79Doy0lIp3cLn1bDj5fn2gi7qUHSXrAQfqHpNRjpvc9l9pRidjJSfzV?=
 =?us-ascii?Q?D0TWyhb8Axf0Itur8Bki3g5Muonpr8jYr2N4TcrGmkJkp?=
X-Microsoft-Antispam-Message-Info: ByzkXJk4mqrBKffNSPTHPr5U699EyjwGvfvNG1waz/pJ1kGSqGu1EgH49K7rXqoatfk7kILWKddyaMdwlyJbWVMSefSGY2yga/6FadhyXneoWFnebTBYjThBwpwwc3qOWd86NnmHsSlOtIKc664lvolwoh43dWNSOHgmewiGL4BaoGowI9ZQvjh6bH4WMm1u9DDrCNr5ICLTCf3UGMD/CL7LC7yXkTNBYZA4txVBMxtpjp822k7GMD2ZviULPGDdVhIoXpuZu4vrIB/C1lMgHc+Gi5Cl+aE2k/PqCzaA76eZc7iYCXKgWskp7CD8M/4JTpawBnAOI82BdAJ8nGWUkwrytGPwU8/tBOrTQTbd6Fw=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1574;6:mwSoSTwuQKjbSsrQmGD8Bq9MH6rAS6Vff7O35IJ85skMXSE6E3tf5ywS47YOiCh6UhKj+HU6pcHEbwwqupurjboxwgAworl9+rYr4w8uc9Gb6MkBcckf9bSEjQa7f3p6SUXKk57XGwCfoE+FnhlO0j1gX+15AhDsOkGtUo7xeSKrLxditE9C7bv5DGcsfmzuLiE8alEbgOkM0fYobqVbmLRsAo16R/6vuWZVLpBtzbSKvpBS4AxnaHUZPsXrU1bROurSvZ9ysvsBqf3A3a7HD1KeBX650lfev08qIBvEMeqBpBkY5WTDu+W0jzx5wzHu3GfMGzBArwT4sJpjacLjRcjxPP2ZsED25NsdwWAbKrDdH6BWIPHeZLaK83IvRCWu9iBdqgrRGmnEiad1Ilqh1EMZscCFvKc7PEfw3OqZ17veZ32R7P4EnKIAEsfUyhaUf0P3l+pi0Y4iBptDVWjLEw==;5:7ZNeUgvXPgKuFjKKxlT5IYvX54xvd3Ur3iFB08ejp9y8uXqLW8kEU2yX/EqLVxSNugx9nYl8KH5eFsoAvOB58RsRuv7zCL+8yo8KZPQovFQhotSoUWLBSk85WhNZotleVTvX95o6qnuDQzl8NSLCLoXcT+Eud5NmUxBUHRe3ihE=;7:EfIF7MufZw8Pm2AbFbDKXMLlo/XKgvK217Xy8YrQ9NC0UtF3ph01+B0tD/xsfvgeIsf94fTBqTLq/apl3DD2pB2uzYgeTWKbBSyN6MTG8Vo8SY2z99t7aQFvINyndJ1ZhOXENdC1AaoxmI8zg222u+cnJH8yYBXE7is1Yz9fdmQOvEQK6G9aGHa8I45xxKC68Jb2YdS2/oZX2o8r6WHqKd9aZp31Hk4PSodfOYciqexskAYZD/MUUeGfGu4elDJw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 03:37:44.4396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84acd89c-872b-4039-2f00-08d61c4ef000
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0301MB1574
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ DT maintainers

On Mon, 17 Sep 2018 11:29:49 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> On some platforms, the sda/scl pins are muxed with gpio functions, so
> they could be used for recovery. Select the gpio/default pin function
> when prepare/unprepare recovery.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/i2c/busses/i2c-designware-core.h   |  3 +++
>  drivers/i2c/busses/i2c-designware-master.c | 22 ++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
> index e367b1af4ab2..01d5f01691a4 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -271,6 +271,9 @@ struct dw_i2c_dev {
>  	int			(*init)(struct dw_i2c_dev *dev);
>  	int			mode;
>  	struct i2c_bus_recovery_info rinfo;
> +	struct pinctrl		*pinctrl;
> +	struct pinctrl_state	*pins_default;
> +	struct pinctrl_state	*pins_gpio;
>  };
>  
>  #define ACCESS_SWAP		0x00000001
> diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
> index 94d94b4a9a0d..384d6630366a 100644
> --- a/drivers/i2c/busses/i2c-designware-master.c
> +++ b/drivers/i2c/busses/i2c-designware-master.c
> @@ -17,6 +17,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  
> @@ -629,6 +630,9 @@ static void i2c_dw_prepare_recovery(struct i2c_adapter *adap)
>  {
>  	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
>  
> +	if (dev->pinctrl && dev->pins_gpio)
> +		pinctrl_select_state(dev->pinctrl, dev->pins_gpio);
> +
>  	i2c_dw_disable(dev);
>  	reset_control_assert(dev->rst);
>  	i2c_dw_prepare_clk(dev, false);
> @@ -641,6 +645,9 @@ static void i2c_dw_unprepare_recovery(struct i2c_adapter *adap)
>  	i2c_dw_prepare_clk(dev, true);
>  	reset_control_deassert(dev->rst);
>  	i2c_dw_init_master(dev);
> +
> +	if (dev->pinctrl && dev->pins_default)
> +		pinctrl_select_state(dev->pinctrl, dev->pins_default);
>  }
>  
>  static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
> @@ -648,6 +655,8 @@ static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
>  	struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
>  	struct i2c_adapter *adap = &dev->adapter;
>  	struct gpio_desc *gpio;
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *s;
>  	int r;
>  
>  	gpio = devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH);
> @@ -664,6 +673,19 @@ static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
>  		return PTR_ERR(gpio);
>  	rinfo->sda_gpiod = gpio;
>  
> +	pinctrl = devm_pinctrl_get(dev->dev);
> +	if (PTR_ERR(pinctrl) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +	if (!IS_ERR_OR_NULL(pinctrl)) {
> +		dev->pinctrl = pinctrl;
> +		s = pinctrl_lookup_state(pinctrl, PINCTRL_STATE_DEFAULT);
> +		if (!IS_ERR_OR_NULL(s))
> +			dev->pins_default = s;
> +		s = pinctrl_lookup_state(pinctrl, "gpio");
> +		if (!IS_ERR_OR_NULL(s))
> +			dev->pins_gpio = s;
> +	}
> +
>  	rinfo->recover_bus = i2c_generic_scl_recovery;
>  	rinfo->prepare_recovery = i2c_dw_prepare_recovery;
>  	rinfo->unprepare_recovery = i2c_dw_unprepare_recovery;

