Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECE2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49A52086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="N7mtceZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49A52086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeIJNx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:53:58 -0400
Received: from mail-eopbgr720058.outbound.protection.outlook.com ([40.107.72.58]:56496
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727093AbeIJNx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gfs3cchXyzxnZjd7VI3ghAw8h7887W96EKC0AU96hQ=;
 b=N7mtceZ5bErPOSZKX9bLHTDNpLJqbOD0/5kOmAiPWPkKJvGfc02bW/ZP+KFNJ6p1RPrdZF8jxSYjI2WqdaN3rb/cawZGEvlwSc6p2coDgRffL4TJxz5gBhI/VYKi1gYkV1qOPJfTehQrxQpj2GVDRG5rxq2m5knhUkJMXCKTtlQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 SN1PR0301MB1583.namprd03.prod.outlook.com (2a01:111:e400:5232::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.18; Mon, 10 Sep
 2018 09:00:46 +0000
Date:   Mon, 10 Sep 2018 16:57:22 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] PCI: dwc: fix scheduling while atomic issues
Message-ID: <20180910165722.38218779@xhacker.debian>
In-Reply-To: <20180829110408.556c3622@xhacker.debian>
References: <20180829110408.556c3622@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OSBPR01CA0068.jpnprd01.prod.outlook.com
 (2603:1096:604:10::32) To SN1PR0301MB1583.namprd03.prod.outlook.com
 (2a01:111:e400:5232::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e77e95f-95d6-4187-4082-08d616fbe6e2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR0301MB1583;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;3:PdRkTWJJgx0hZMdc2nhHc26YA39kKoTjI4oKEvo7QafBNdUmRPi0hteNG1Wi38Je0a6LUfU/NQatruB7mQtDgAY8CHfoFCBC8icZRuU/mFTQR5KEkYxlfoGZMwebRUjpRIhxYPbxE4f0uaXsfhUrVpCiii8+2m/6DhTFooEY5rPlOm9FGIVASEz28QP+NKyPKXN4SjMiFhaqirD2Cp0CloGybErrDkRDHLqVhqi7yyFVFYMD2DhW3t+dsHGqL/UU;25:ovqAN+I8mWaYBJDCk0j4wjqo9QhcfUEA/6pjob2rgqUcuQDZZpm/1Ixi8KqV7jkQ/KBXFtWnGBtcvCSMuUy7vyHWKFI7UfixwSwGrFapohal9xyAy+RbXOSp1GxFgKaiaDlIxmHxTHj2x/AYQ4IRxfPkNNUoEJducN8uEGEGbMk6idTdfANpEHofYjRrllskLZILjG1qwnY1ybh66TFcxqGDQIF2adCVUvfqryvU/JIugoxYEtb3qFLgrNubauhXeWVdp40CnmIlW7Z//TsBviM/9MasCXlsUwgjZZBKla8krNZJ8Pd8PTWDwSsBpmQhKK8AXITPMBsWuJedKrh31w==;31:06IFLkHlqeYGfttJfA76E+K0mwfBfj2WO7k+2MNa6UYBkM1ciLF570S8I9bpilg58oWuE0JlxI0u6m2FsbgXeeI2k2AvHwVPG403dayuu115ndENirSOl/MHAh7AtiirLGXU+D+Czfr9Q+1kNt0KHJw7B/Ni2vh1idGwXNSaq749L7PwYhtUeE1LfSpj4MGiq0smT0SylK2jwT1l+TtKd3FTGOuZtN/zYSjWTnr77ro=
X-MS-TrafficTypeDiagnostic: SN1PR0301MB1583:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;20:ACMy/nq4FSO7Sx3K0j1jkQcpxSB+PjEa4g59XWEdLDlX2HarBJq14wdIVOyitTRMFxCbrN//r+KA4YuvC8Yq9YdTQEMZ2AN92VyNZu4eOp3shvSmqSFi2i1Oinf/pMtePHCdJebS0k2QdUdzdZtawGR7pJ5z4m8qWzjEmKsB+ClZZqC2vc5DfPwTU01ZhaQM2bRPHQ+c1kyQ7lPw5IIxjsSsT6p/hCwe+XC8b/sLHFsbd98WNuYhb1iGDOQY4AIQG/5bRUJtAfoocnBqF3BywOsGj7haamF+T2Qvpf9j4Iq/f1aMIzQN2U5PK74G6TpzPWYCfccQ7hTFGgaDP5fyKSc6nepVGUZdBneIiCS18hTDrPX2rALz/NJWKsKQ5VGWCdjc7vNGqw+wpbhn9kSHJeCuOTRstI+nltAzOar+HF73mq3vLCD0bigWxjZsnpjPXahGvGDVvVc8qSKsMaPnxdzz7VXeT/Zjndvv7XfOHvWPOkeLD9iVrzRc4N65qgL1;4:9E57NKRrqiWOHqmZ47etKGm/TYWMZKGn6zRY6LvC1hXlmRo5i/3GQz4uKCKRaTQB+3v2jhLwj//jQdDCI+0OoPWEVlm8xihAp6FWQwzX673X4GsvxVMFlPMpG6BdWHZvheaiLWZaut0kJRBg7o/eBD+mjxplg5mFWxvibbDhuaKb+xW36rHl84BpN91u0fQixoUAvkhK1GQ1sOjUYUtKSxhCXf0/bL3YIQ8vOJfMJiJ1zcOqX3R4fvVpmOIdmyxguYvR6JCa9O/U914aCtMKHQ==
X-Microsoft-Antispam-PRVS: <SN1PR0301MB15836F9DEB25F057B15FFD3DED050@SN1PR0301MB1583.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050);SRVR:SN1PR0301MB1583;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0301MB1583;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(53754006)(2201001)(86362001)(26005)(186003)(97736004)(16526019)(1970100002)(316002)(486006)(25786009)(575784001)(47776003)(7696005)(68736007)(8266002)(97876018)(39060400002)(386003)(52116002)(6506007)(110136005)(66066001)(476003)(11346002)(70486001)(446003)(1076002)(956004)(229853002)(3846002)(6246003)(6116002)(81166006)(6666003)(55016002)(8936002)(53936002)(81156014)(105586002)(50226002)(230700001)(9686003)(23726003)(8676002)(106356001)(5660300001)(76176011)(50466002)(33896004)(478600001)(305945005)(7736002)(117636001)(72206003)(2906002)(2101003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0301MB1583;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0301MB1583;23:yqcN+uXvQb4uaZcNcUtDjveDq8c2BXiYcQezt0x?=
 =?us-ascii?Q?sOMZV4hq4vcj4vwIvaOzXOBk4okJcsNqvy4qmln964TXcbysSz6W/6LSAkh2?=
 =?us-ascii?Q?b8LuFZiXDn8jw1r4UetXMhZewbUhQ+YNHet7f8A+XZ+g7vY7sK/dbQRNsuFJ?=
 =?us-ascii?Q?n40YnvvELrkSQlq13iKpI6REqy12gvPDRh9lSIizcVtYyo0hX/GfU4gPoE9o?=
 =?us-ascii?Q?XD1Gx3tBm6pe1mahn7bkWXaaeHW0DQOTJWrlgTCdSV3NhMvZzzJypu2zOU8K?=
 =?us-ascii?Q?ezp7l5vQq3Y7pfYer6Jc+0UxYB0A2Fny3OIfp0kYTBzJ+TXAtfXNdSo0f8BJ?=
 =?us-ascii?Q?HhNVy8bU5a8AL7YiqbEucOAuATSCXFqCD/XuA6O8rV9fVsWRzvfH2iT0500A?=
 =?us-ascii?Q?a6HOTsKHKmnAbKPPR2OXLbh756bxKZGmGQmIv39VUUzFUwuSAJONn2EFoLD0?=
 =?us-ascii?Q?tw2x+79Uvs/osRnEzADPI574uums4/bo5OyThW4nO/65bP2vqohH34E1+6b4?=
 =?us-ascii?Q?Pnwlnnk5GMV91iCh2TNPRyfhj8zJXBDSCWFNBBYoP004S6fvwx3Qq+oY/k4T?=
 =?us-ascii?Q?6vnx//pZRd51yLFSXQwZHr6wBz2WhT4LxoeauIQW1WzZolj/GTTQyPqqH51L?=
 =?us-ascii?Q?v0Qebz2Rbrkq7weY46dbkVnkfjk7OEn6DEYvfsjTT0SgG78UzXzMf+5Mx8oZ?=
 =?us-ascii?Q?TQskZrwJEh8CqOUw0XR6f+xxpnyFOBV6FOJrod4JjmH4j2l/m6wrJdoAnDOn?=
 =?us-ascii?Q?FaX6qvZoFHfy89ib4YKtEMLZn3H+p07GTKnKnRU9V4TEpS/2JgW/kGjKe2JX?=
 =?us-ascii?Q?NZr2Kg753Mbak4Pa7gV2lhbldZHoCy6H1pirNbq0A5zlovkDw7EAH3PwTYdE?=
 =?us-ascii?Q?t13PKKL90ZTD9Q/yt0cRrEIvIWlP3vLhMyIig/ituLnvL4caxNQBssxrGkBl?=
 =?us-ascii?Q?lc4SeOip81abhkzWyY9anwhZDF0BB09rWi0u7cZ7G/9U3IYOrSnmmcecNOOC?=
 =?us-ascii?Q?ntCy5Q1xoCVLnGNigZI0xXRCBuAqrOuHCPOzolzbaW0UDYUdZ0JBRQGRvxSw?=
 =?us-ascii?Q?ev7Bsv41j93fOQ6LT8/LtcIB04vcD1uW4eQ27CvDkja4cjfjjolYEk6L+tTX?=
 =?us-ascii?Q?7CXg/VD17XQ+rX62ctf0Ebx7//ml7Zy4eUikY4NWVekqda3RmDRhQmVVBqXt?=
 =?us-ascii?Q?2vj/vQMyMIdj6k1+caWTqCRkrAD/mkT7dQFDB28i44EeqSC3F8PKM3/QLZE+?=
 =?us-ascii?Q?aXMhbJyHznTJfkCavpQwsHSQ1WUYPGjPf9NRkouCP6aAbDSPKMYQjtGXLHn/?=
 =?us-ascii?Q?OVbH1RwnQlZXDfmL/9ex5/fCbOIsVWCAZw0D2PrGOVmHTWFS0Vwe2KsZRo6n?=
 =?us-ascii?Q?fCk+AKtn1+l6MhUA8pm/g9TwUW0zv3zwxXpVABkTwjPbl0Qp0dxty/Pu2YUh?=
 =?us-ascii?Q?yjo07HbjFF9wLjLrUpObSjrDBRZs0oSQQ6Cq8fNH/X2XDwGSx52NJ?=
X-Microsoft-Antispam-Message-Info: iSt4w1j3b6jB11QbawqDFL9FPKOV1GOpYNPQ1HJaJ/c9SUiQmefk4gKFfTKTJQ0/8piHqemaa2jtBugBBdJpft/T1T/FeSgN5U9Ubc8Hzw6zjOrBp6/4+HJ/ddLsfHyt76KUReFb7rf9Z3IrSDh94bCZLzMC/BQfBDxlpO8lG4+U71afDIBkZIeYYM5wqOQiNi4SfV2uPBcXmdb/G2stQFEC+zcOwKF8+aGm9A+tzJmgbsfV3b19pxZXhmmmOQYXxQySt1pL+AbF+TCVZ/oppkRjsiJmN/qHOm2wPzKPHooMSxgjbRmf9hfsr7n1kv3bnOG+6PMgh/g8Q1vdZxoTdq4Ww2NxYOhIANaVOJi5ZKA=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;6:0Zp1QiUJGhkRrTez0S9e24OLnxF5k8MjSXHgM+lpl1pBO79/qRBAjXJNeqcJ2k49vmd3GGpjBrljIEBH3lRMbtlrYjuTdSzh25ROJLx6BNAgamjRFroRTG+RVYQrxmemDoDNZR/bgOo2u7e9KmjooTs+uhorMWwg1aMv58VoAj5bvn3Bn0/bfyOkKPtm1pScBsBzuMIFuUTQBGfibKeRv2FVkDT8j7IGazo+OavCp8UkoetbILaCHk4rbw0Chyo4ucODsA2Oij9LoeMSPgUpmc6ILprWMJ8a3fJSBvxfMRkzwxojBwZiO2fS28+9GBDANP/E7PqoYMFB2cldILEufy5KvQnd737G14LY7q98KgJmkY5GAU0OD4vmYbwGFDkuggq3ufOoWLMk056Z+QGRqNmMzfATkAkHPlzroM0yO9fNLrHQhb67Axu7HG22d9hDzii4H3qEeLA1JoplspMWDw==;5:oFi3BUvdCAWucuIxuonfBzPbzCcu8jf/srbPgbcqyaos0W27zgHcdBrzZy6hVi/6a2amDjXFv1cie2ETUSBX2jplYpvI8BAjKo/ldKPQkpUsNr3NQHFfNVmNMIiIuCUPkjo/etHWMW+b0e7j1oKvdFrtOGukDSBZF4EPT/AGYps=;7:MxXExj4BcRW6FngKuDp1lOJ9hE8m64AqtUm4aBLL5KCAGev1ZBh6zcWMORztRe8ugxKmYERh/u/b5tYxqyKU/47ERb45oIRxjRp2nxyYs6nKb5qeY/V52iyflKnXN7NlzJq1ZPDaLHdrNLSwwXFpj8wCfBa1ViPqcwrDo9iUciM4LAc1VQvPDrqo76BpECM2BGaLzU65tRUqXvarBU5MxwzH9dBqF0EJ/2MuqqAdlpUDe/cfEdWZ4+PKnNSxV7E5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 09:00:46.5296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e77e95f-95d6-4187-4082-08d616fbe6e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0301MB1583
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Wed, 29 Aug 2018 11:04:08 +0800 Jisheng Zhang wrote:

> When programming inbound/outbound atu, we call usleep_range() after
> each checking PCIE_ATU_ENABLE bit. Unfortunately, the atu programming
> can be called in atomic context:
> 
> inbound atu programming could be called through
> pci_epc_write_header()
>   =>dw_pcie_ep_write_header()
>     =>dw_pcie_prog_inbound_atu()  
> 
> outbound atu programming could be called through
> pci_bus_read_config_dword()
>   =>dw_pcie_rd_conf()
>     =>dw_pcie_prog_outbound_atu()  
> 
> Fix this issue by calling mdelay() instead.

Any comments about this patch?

Thanks,
Jisheng

> 
> Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
> Fixes: d8bbeb39fbf3 ("PCI: designware: Wait for iATU enable")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> 
> since v2:
>  - Add Fixes tag
>  - Add Gustavo's Ack
> 
> since v1:
>  - use mdelay() instead of udelay() to avoid __bad_udelay()
> 
>  drivers/pci/controller/dwc/pcie-designware.c | 8 ++++----
>  drivers/pci/controller/dwc/pcie-designware.h | 3 +--
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 778c4f76a884..2153956a0b20 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -135,7 +135,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
>  		if (val & PCIE_ATU_ENABLE)
>  			return;
>  
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU);
>  	}
>  	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
>  }
> @@ -178,7 +178,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>  		if (val & PCIE_ATU_ENABLE)
>  			return;
>  
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU);
>  	}
>  	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
>  }
> @@ -236,7 +236,7 @@ static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, int index,
>  		if (val & PCIE_ATU_ENABLE)
>  			return 0;
>  
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU);
>  	}
>  	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
>  
> @@ -282,7 +282,7 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
>  		if (val & PCIE_ATU_ENABLE)
>  			return 0;
>  
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU);
>  	}
>  	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 96126fd8403c..9f1a5e399b70 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -26,8 +26,7 @@
>  
>  /* Parameters for the waiting for iATU enabled routine */
>  #define LINK_WAIT_MAX_IATU_RETRIES	5
> -#define LINK_WAIT_IATU_MIN		9000
> -#define LINK_WAIT_IATU_MAX		10000
> +#define LINK_WAIT_IATU			9
>  
>  /* Synopsys-specific PCIe configuration registers */
>  #define PCIE_PORT_LINK_CONTROL		0x710

