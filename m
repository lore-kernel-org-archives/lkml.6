Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A7BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8362020877
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8362020877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbeGKJrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:47:36 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2287 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeGKJrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:47:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b45d15e0001>; Wed, 11 Jul 2018 02:43:58 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 11 Jul 2018 02:44:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 11 Jul 2018 02:44:03 -0700
Received: from [10.21.132.122] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 11 Jul
 2018 09:44:00 +0000
Subject: Re: [PATCH 4/6] soc/tegra: pmc: Use X macro to generate IO pad tables
To:     Aapo Vienamo <avienamo@nvidia.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1531226879-11802-1-git-send-email-avienamo@nvidia.com>
 <1531226879-11802-5-git-send-email-avienamo@nvidia.com>
 <dc369c97-6e23-02d7-8e3f-0f94ae4bf585@nvidia.com>
 <20180711122303.45512721@dhcp-10-21-25-168>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <aa1ae2bc-af60-9c1a-3e17-da1431864a35@nvidia.com>
Date:   Wed, 11 Jul 2018 10:43:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711122303.45512721@dhcp-10-21-25-168>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/07/18 10:23, Aapo Vienamo wrote:
> On Wed, 11 Jul 2018 09:30:57 +0100
> Jon Hunter <jonathanh@nvidia.com> wrote:
> 
>> On 10/07/18 13:47, Aapo Vienamo wrote:
>>> Refactor the IO pad tables into macro tables so that they can be reused
>>> to generate pinctrl pin descriptors. Also add a name field which is
>>> needed by pinctrl.
>>>
>>> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
>>> ---
>>>  drivers/soc/tegra/pmc.c | 231 ++++++++++++++++++++++++++----------------------
>>>  1 file changed, 126 insertions(+), 105 deletions(-)
>>>
>>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>>> index 3f5b69fd..b833334 100644
>>> --- a/drivers/soc/tegra/pmc.c
>>> +++ b/drivers/soc/tegra/pmc.c
>>> @@ -137,6 +137,7 @@ struct tegra_io_pad_soc {
>>>  	enum tegra_io_pad id;
>>>  	unsigned int dpd;
>>>  	unsigned int voltage;
>>> +	const char *name;
>>>  };
>>>  
>>>  struct tegra_pmc_regs {
>>> @@ -1697,37 +1698,49 @@ static const u8 tegra124_cpu_powergates[] = {
>>>  	TEGRA_POWERGATE_CPU3,
>>>  };
>>>  
>>> +#define TEGRA_IO_PAD(_id, _dpd, _voltage, _name)	\
>>> +	(struct tegra_io_pad_soc) {			\
>>> +		.id	= _id,				\
>>> +		.dpd	= _dpd,				\
>>> +		.voltage = _voltage,			\
>>> +		.name	= _name,			\
>>> +	},
>>> +
>>> +#define TEGRA124_IO_PAD_TABLE(_pad)					\
>>> +	/* .id                          .dpd    .voltage  .name	*/	\
>>> +	_pad(TEGRA_IO_PAD_AUDIO,	17,	UINT_MAX, "audio")	\
>>> +	_pad(TEGRA_IO_PAD_BB,		15,	UINT_MAX, "bb")		\
>>> +	_pad(TEGRA_IO_PAD_CAM,		36,	UINT_MAX, "cam")	\
>>> +	_pad(TEGRA_IO_PAD_COMP,		22,	UINT_MAX, "comp")	\
>>> +	_pad(TEGRA_IO_PAD_CSIA,		0,	UINT_MAX, "csia")	\
>>> +	_pad(TEGRA_IO_PAD_CSIB,		1,	UINT_MAX, "csb")	\
>>> +	_pad(TEGRA_IO_PAD_CSIE,		44,	UINT_MAX, "cse")	\
>>> +	_pad(TEGRA_IO_PAD_DSI,		2,	UINT_MAX, "dsi")	\
>>> +	_pad(TEGRA_IO_PAD_DSIB,		39,	UINT_MAX, "dsib")	\
>>> +	_pad(TEGRA_IO_PAD_DSIC,		40,	UINT_MAX, "dsic")	\
>>> +	_pad(TEGRA_IO_PAD_DSID,		41,	UINT_MAX, "dsid")	\
>>> +	_pad(TEGRA_IO_PAD_HDMI,		28,	UINT_MAX, "hdmi")	\
>>> +	_pad(TEGRA_IO_PAD_HSIC,		19,	UINT_MAX, "hsic")	\
>>> +	_pad(TEGRA_IO_PAD_HV,		38,	UINT_MAX, "hv")		\
>>> +	_pad(TEGRA_IO_PAD_LVDS,		57,	UINT_MAX, "lvds")	\
>>> +	_pad(TEGRA_IO_PAD_MIPI_BIAS,	3,	UINT_MAX, "mipi-bias")	\
>>> +	_pad(TEGRA_IO_PAD_NAND,		13,	UINT_MAX, "nand")	\
>>> +	_pad(TEGRA_IO_PAD_PEX_BIAS,	4,	UINT_MAX, "pex-bias")	\
>>> +	_pad(TEGRA_IO_PAD_PEX_CLK1,	5,	UINT_MAX, "pex-clk1")	\
>>> +	_pad(TEGRA_IO_PAD_PEX_CLK2,	6,	UINT_MAX, "pex-clk2")	\
>>> +	_pad(TEGRA_IO_PAD_PEX_CNTRL,	32,	UINT_MAX, "pex-cntrl")	\
>>> +	_pad(TEGRA_IO_PAD_SDMMC1,	33,	UINT_MAX, "sdmmc1")	\
>>> +	_pad(TEGRA_IO_PAD_SDMMC3,	34,	UINT_MAX, "sdmmc3")	\
>>> +	_pad(TEGRA_IO_PAD_SDMMC4,	35,	UINT_MAX, "sdmmc4")	\
>>> +	_pad(TEGRA_IO_PAD_SYS_DDC,	58,	UINT_MAX, "sys_ddc")	\
>>> +	_pad(TEGRA_IO_PAD_UART,		14,	UINT_MAX, "uart")	\
>>> +	_pad(TEGRA_IO_PAD_USB0,		9,	UINT_MAX, "usb0")	\
>>> +	_pad(TEGRA_IO_PAD_USB1,		10,	UINT_MAX, "usb1")	\
>>> +	_pad(TEGRA_IO_PAD_USB2,		11,	UINT_MAX, "usb2")	\
>>> +	_pad(TEGRA_IO_PAD_USB_BIAS,	12,	UINT_MAX, "usb_bias")
>>> +
>>>  static const struct tegra_io_pad_soc tegra124_io_pads[] = {
>>> -	{ .id = TEGRA_IO_PAD_AUDIO, .dpd = 17, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_BB, .dpd = 15, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_CAM, .dpd = 36, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_COMP, .dpd = 22, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_CSIA, .dpd = 0, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_CSIB, .dpd = 1, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_CSIE, .dpd = 44, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_DSI, .dpd = 2, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_DSIB, .dpd = 39, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_DSIC, .dpd = 40, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_DSID, .dpd = 41, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_HDMI, .dpd = 28, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_HSIC, .dpd = 19, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_HV, .dpd = 38, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_LVDS, .dpd = 57, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_MIPI_BIAS, .dpd = 3, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_NAND, .dpd = 13, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_PEX_BIAS, .dpd = 4, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_PEX_CLK1, .dpd = 5, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_PEX_CLK2, .dpd = 6, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_PEX_CNTRL, .dpd = 32, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_SDMMC1, .dpd = 33, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_SDMMC3, .dpd = 34, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_SDMMC4, .dpd = 35, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_SYS_DDC, .dpd = 58, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_UART, .dpd = 14, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_USB0, .dpd = 9, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_USB1, .dpd = 10, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_USB2, .dpd = 11, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_USB_BIAS, .dpd = 12, .voltage = UINT_MAX },
>>> +	TEGRA124_IO_PAD_TABLE(TEGRA_IO_PAD)
>>>  };
>>>  
>>>  static const struct tegra_pmc_soc tegra124_pmc_soc = {
>>> @@ -1779,45 +1792,49 @@ static const u8 tegra210_cpu_powergates[] = {
>>>  	TEGRA_POWERGATE_CPU3,
>>>  };
>>>  
>>> +#define TEGRA210_IO_PAD_TABLE(_pad)							\
>>> +	/*   .id                        .dpd            .voltage        .name */	\
>>> +	_pad(TEGRA_IO_PAD_AUDIO,	17,		5,		"audio")	\
>>> +	_pad(TEGRA_IO_PAD_AUDIO_HV,	61,		18,		"audio-hv")	\
>>> +	_pad(TEGRA_IO_PAD_CAM,		36,		10,		"cam")		\
>>> +	_pad(TEGRA_IO_PAD_CSIA,		0,		UINT_MAX,	"csia")		\
>>> +	_pad(TEGRA_IO_PAD_CSIB,		1,		UINT_MAX,	"csib")		\
>>> +	_pad(TEGRA_IO_PAD_CSIC,		42,		UINT_MAX,	"csic")		\
>>> +	_pad(TEGRA_IO_PAD_CSID,		43,		UINT_MAX,	"csid")		\
>>> +	_pad(TEGRA_IO_PAD_CSIE,		44,		UINT_MAX,	"csie")		\
>>> +	_pad(TEGRA_IO_PAD_CSIF,		45,		UINT_MAX,	"csif")		\
>>> +	_pad(TEGRA_IO_PAD_DBG,		25,		19,		"dbg")		\
>>> +	_pad(TEGRA_IO_PAD_DEBUG_NONAO,	26,		UINT_MAX,	"debug-nonao")	\
>>> +	_pad(TEGRA_IO_PAD_DMIC,		50,		20,		"dmic")		\
>>> +	_pad(TEGRA_IO_PAD_DP,		51,		UINT_MAX,	"dp")		\
>>> +	_pad(TEGRA_IO_PAD_DSI,		2,		UINT_MAX,	"dsi")		\
>>> +	_pad(TEGRA_IO_PAD_DSIB,		39,		UINT_MAX,	"dsib")		\
>>> +	_pad(TEGRA_IO_PAD_DSIC,		40,		UINT_MAX,	"dsic")		\
>>> +	_pad(TEGRA_IO_PAD_DSID,		41,		UINT_MAX,	"dsid")		\
>>> +	_pad(TEGRA_IO_PAD_EMMC,		35,		UINT_MAX,	"emmc")		\
>>> +	_pad(TEGRA_IO_PAD_EMMC2,	37,		UINT_MAX,	"emmc2")	\
>>> +	_pad(TEGRA_IO_PAD_GPIO,		27,		21,		"gpio")		\
>>> +	_pad(TEGRA_IO_PAD_HDMI,		28,		UINT_MAX,	"hdmi")		\
>>> +	_pad(TEGRA_IO_PAD_HSIC,		19,		UINT_MAX,	"hsic")		\
>>> +	_pad(TEGRA_IO_PAD_LVDS,		57,		UINT_MAX,	"lvds")		\
>>> +	_pad(TEGRA_IO_PAD_MIPI_BIAS,	3,		UINT_MAX,	"mipi-bias")	\
>>> +	_pad(TEGRA_IO_PAD_PEX_BIAS,	4,		UINT_MAX,	"pex-bias")	\
>>> +	_pad(TEGRA_IO_PAD_PEX_CLK1,	5,		UINT_MAX,	"pex-clk1")	\
>>> +	_pad(TEGRA_IO_PAD_PEX_CLK2,	6,		UINT_MAX,	"pex-clk2")	\
>>> +	_pad(TEGRA_IO_PAD_PEX_CNTRL,    UINT_MAX,	11,		"pex-cntrl")	\
>>> +	_pad(TEGRA_IO_PAD_SDMMC1,	33,		12,		"sdmmc1")	\
>>> +	_pad(TEGRA_IO_PAD_SDMMC3,	34,		13,		"sdmmc3")	\
>>> +	_pad(TEGRA_IO_PAD_SPI,		46,		22,		"spi")		\
>>> +	_pad(TEGRA_IO_PAD_SPI_HV,	47,		23,		"spi-hv")	\
>>> +	_pad(TEGRA_IO_PAD_UART,		14,		2,		"uart")		\
>>> +	_pad(TEGRA_IO_PAD_USB0,		9,		UINT_MAX,	"usb0")		\
>>> +	_pad(TEGRA_IO_PAD_USB1,		10,		UINT_MAX,	"usb1")		\
>>> +	_pad(TEGRA_IO_PAD_USB2,		11,		UINT_MAX,	"usb2")		\
>>> +	_pad(TEGRA_IO_PAD_USB3,		18,		UINT_MAX,	"usb3")		\
>>> +	_pad(TEGRA_IO_PAD_USB_BIAS,	12,		UINT_MAX,	"usb-bias")
>>> +
>>>  static const struct tegra_io_pad_soc tegra210_io_pads[] = {
>>> -	{ .id = TEGRA_IO_PAD_AUDIO, .dpd = 17, .voltage = 5 },
>>> -	{ .id = TEGRA_IO_PAD_AUDIO_HV, .dpd = 61, .voltage = 18 },
>>> -	{ .id = TEGRA_IO_PAD_CAM, .dpd = 36, .voltage = 10 },
>>> -	{ .id = TEGRA_IO_PAD_CSIA, .dpd = 0, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_CSIB, .dpd = 1, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_CSIC, .dpd = 42, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_CSID, .dpd = 43, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_CSIE, .dpd = 44, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_CSIF, .dpd = 45, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_DBG, .dpd = 25, .voltage = 19 },
>>> -	{ .id = TEGRA_IO_PAD_DEBUG_NONAO, .dpd = 26, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_DMIC, .dpd = 50, .voltage = 20 },
>>> -	{ .id = TEGRA_IO_PAD_DP, .dpd = 51, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_DSI, .dpd = 2, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_DSIB, .dpd = 39, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_DSIC, .dpd = 40, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_DSID, .dpd = 41, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_EMMC, .dpd = 35, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_EMMC2, .dpd = 37, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_GPIO, .dpd = 27, .voltage = 21 },
>>> -	{ .id = TEGRA_IO_PAD_HDMI, .dpd = 28, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_HSIC, .dpd = 19, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_LVDS, .dpd = 57, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_MIPI_BIAS, .dpd = 3, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_PEX_BIAS, .dpd = 4, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_PEX_CLK1, .dpd = 5, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_PEX_CLK2, .dpd = 6, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_PEX_CNTRL, .dpd = UINT_MAX, .voltage = 11 },
>>> -	{ .id = TEGRA_IO_PAD_SDMMC1, .dpd = 33, .voltage = 12 },
>>> -	{ .id = TEGRA_IO_PAD_SDMMC3, .dpd = 34, .voltage = 13 },
>>> -	{ .id = TEGRA_IO_PAD_SPI, .dpd = 46, .voltage = 22 },
>>> -	{ .id = TEGRA_IO_PAD_SPI_HV, .dpd = 47, .voltage = 23 },
>>> -	{ .id = TEGRA_IO_PAD_UART, .dpd = 14, .voltage = 2 },
>>> -	{ .id = TEGRA_IO_PAD_USB0, .dpd = 9, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_USB1, .dpd = 10, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_USB2, .dpd = 11, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_USB3, .dpd = 18, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_USB_BIAS, .dpd = 12, .voltage = UINT_MAX },
>>> +	TEGRA210_IO_PAD_TABLE(TEGRA_IO_PAD)
>>>  };
>>>  
>>>  static const struct tegra_pmc_soc tegra210_pmc_soc = {
>>> @@ -1836,44 +1853,48 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
>>>  	.setup_irq_polarity = tegra20_pmc_setup_irq_polarity,
>>>  };
>>>  
>>> +#define TEGRA186_IO_PAD_TABLE(_pad)						\
>>> +	/*   .id                        .dpd    .voltage        .name */	\
>>> +	_pad(TEGRA_IO_PAD_CSIA,		0,	UINT_MAX,	"csia")		\
>>> +	_pad(TEGRA_IO_PAD_CSIB,		1,	UINT_MAX,	"csib")		\
>>> +	_pad(TEGRA_IO_PAD_DSI,		2,	UINT_MAX,	"dsi")		\
>>> +	_pad(TEGRA_IO_PAD_MIPI_BIAS,	3,	UINT_MAX,	"mipi-bias")	\
>>> +	_pad(TEGRA_IO_PAD_PEX_CLK_BIAS,	4, 	UINT_MAX,	"pex-clk-bias")	\
>>> +	_pad(TEGRA_IO_PAD_PEX_CLK3,	5,	UINT_MAX,	"pex-clk3")	\
>>> +	_pad(TEGRA_IO_PAD_PEX_CLK2,	6,	UINT_MAX,	"pex-clk2")	\
>>> +	_pad(TEGRA_IO_PAD_PEX_CLK1,	7,	UINT_MAX,	"pex-clk1")	\
>>> +	_pad(TEGRA_IO_PAD_USB0,		9,	UINT_MAX,	"usb0")		\
>>> +	_pad(TEGRA_IO_PAD_USB1,		10,	UINT_MAX,	"usb1")		\
>>> +	_pad(TEGRA_IO_PAD_USB2,		11,	UINT_MAX,	"usb2")		\
>>> +	_pad(TEGRA_IO_PAD_USB_BIAS,	12,	UINT_MAX,	"usb-bias")	\
>>> +	_pad(TEGRA_IO_PAD_UART,		14,	UINT_MAX,	"uart")		\
>>> +	_pad(TEGRA_IO_PAD_AUDIO,	17,	UINT_MAX,	"audio")	\
>>> +	_pad(TEGRA_IO_PAD_HSIC,		19,	UINT_MAX,	"hsic")		\
>>> +	_pad(TEGRA_IO_PAD_DBG,		25,	UINT_MAX,	"dbg")		\
>>> +	_pad(TEGRA_IO_PAD_HDMI_DP0,	28,	UINT_MAX,	"hdmi-dp0")	\
>>> +	_pad(TEGRA_IO_PAD_HDMI_DP1,	29,	UINT_MAX,	"hdmi-dp1")	\
>>> +	_pad(TEGRA_IO_PAD_PEX_CNTRL,	32,	UINT_MAX,	"pex-cntrl")	\
>>> +	_pad(TEGRA_IO_PAD_SDMMC2_HV,	34,	5,		"sdmmc2-hv")	\
>>> +	_pad(TEGRA_IO_PAD_SDMMC4,	36,	UINT_MAX,	"sdmmc4")	\
>>> +	_pad(TEGRA_IO_PAD_CAM,		38,	UINT_MAX,	"cam")		\
>>> +	_pad(TEGRA_IO_PAD_DSIB,		40,	UINT_MAX,	"dsib")		\
>>> +	_pad(TEGRA_IO_PAD_DSIC,		41,	UINT_MAX,	"dsic")		\
>>> +	_pad(TEGRA_IO_PAD_DSID,		42,	UINT_MAX,	"dsid")		\
>>> +	_pad(TEGRA_IO_PAD_CSIC,		43,	UINT_MAX,	"csic")		\
>>> +	_pad(TEGRA_IO_PAD_CSID,		44,	UINT_MAX,	"csid")		\
>>> +	_pad(TEGRA_IO_PAD_CSIE,		45,	UINT_MAX,	"csie")		\
>>> +	_pad(TEGRA_IO_PAD_CSIF,		46,	UINT_MAX,	"csif")		\
>>> +	_pad(TEGRA_IO_PAD_SPI,		47,	UINT_MAX,	"spi")		\
>>> +	_pad(TEGRA_IO_PAD_UFS,		49,	UINT_MAX,	"ufs")		\
>>> +	_pad(TEGRA_IO_PAD_DMIC_HV,	52,	2,		"dmic-hv")	\
>>> +	_pad(TEGRA_IO_PAD_EDP,		53,	UINT_MAX,	"edp")		\
>>> +	_pad(TEGRA_IO_PAD_SDMMC1_HV,	55,	4,		"sdmmc1-hv")	\
>>> +	_pad(TEGRA_IO_PAD_SDMMC3_HV,	56,	6,		"sdmmc3-hv")	\
>>> +	_pad(TEGRA_IO_PAD_CONN,		60,	UINT_MAX,	"conn")		\
>>> +	_pad(TEGRA_IO_PAD_AUDIO_HV,	61,	1,		"audio-hv")
>>> +
>>>  static const struct tegra_io_pad_soc tegra186_io_pads[] = {
>>> -	{ .id = TEGRA_IO_PAD_CSIA, .dpd = 0, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_CSIB, .dpd = 1, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_DSI, .dpd = 2, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_MIPI_BIAS, .dpd = 3, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_PEX_CLK_BIAS, .dpd = 4, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_PEX_CLK3, .dpd = 5, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_PEX_CLK2, .dpd = 6, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_PEX_CLK1, .dpd = 7, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_USB0, .dpd = 9, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_USB1, .dpd = 10, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_USB2, .dpd = 11, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_USB_BIAS, .dpd = 12, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_UART, .dpd = 14, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_AUDIO, .dpd = 17, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_HSIC, .dpd = 19, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_DBG, .dpd = 25, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_HDMI_DP0, .dpd = 28, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_HDMI_DP1, .dpd = 29, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_PEX_CNTRL, .dpd = 32, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_SDMMC2_HV, .dpd = 34, .voltage = 5 },
>>> -	{ .id = TEGRA_IO_PAD_SDMMC4, .dpd = 36, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_CAM, .dpd = 38, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_DSIB, .dpd = 40, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_DSIC, .dpd = 41, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_DSID, .dpd = 42, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_CSIC, .dpd = 43, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_CSID, .dpd = 44, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_CSIE, .dpd = 45, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_CSIF, .dpd = 46, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_SPI, .dpd = 47, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_UFS, .dpd = 49, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_DMIC_HV, .dpd = 52, .voltage = 2 },
>>> -	{ .id = TEGRA_IO_PAD_EDP, .dpd = 53, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_SDMMC1_HV, .dpd = 55, .voltage = 4 },
>>> -	{ .id = TEGRA_IO_PAD_SDMMC3_HV, .dpd = 56, .voltage = 6 },
>>> -	{ .id = TEGRA_IO_PAD_CONN, .dpd = 60, .voltage = UINT_MAX },
>>> -	{ .id = TEGRA_IO_PAD_AUDIO_HV, .dpd = 61, .voltage = 1 },
>>> +	TEGRA186_IO_PAD_TABLE(TEGRA_IO_PAD)
>>>  };
>>>  
>>>  static const struct tegra_pmc_regs tegra186_pmc_regs = {  
>>
>> Can you run checkpatch on this and fix up the warnings?
>>
>> Cheers
>> Jon
>>
> 
> I did run checkpatch on it. The remaining errors and warnings are either
> about the table rows being too long or about the macro values used to
> generate them not being enclosed in parentheses. I felt that fixing them
> could be somewhat detrimental to the overall readability. I probably
> could fix the errors about macro parens, but I'd rather not give up the
> aligned columns of the tables. I guess I can try to get them squeezed a
> bit tighter together by not aligning to tab stops.

OK, I will let Thierry have the final say here. I know that we are a bit
relaxed about this on the clock data too, but checkpatch does not seem
to differentiate between data and code. 

Cheers
Jon

-- 
nvpublic
