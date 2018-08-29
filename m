Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9286AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE1D2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="N3p4L3gs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE1D2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeH2MjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:39:22 -0400
Received: from mail-co1nam03on0047.outbound.protection.outlook.com ([104.47.40.47]:44005
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727204AbeH2MjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQr19FdyKVYEcd0O0WA3QwCqj5WCi2NXrBaXv+kafmo=;
 b=N3p4L3gsY3vEQaA/SXUD3ZXcex8KI0IiT/Ak4Sd9WsgEiKBfrG3bsbQaEzGReRHo8JqX9n5IgyM7cseD6qiHWx0d8yIWlarbdMF1PvgC/Luy4wSeAm7kyuIB06WA+iN1kWrt0Q86Uu38j6yLVTJxONBTDbiBwelNEvtf0s1UjGs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1577.namprd03.prod.outlook.com (2a01:111:e400:529c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.15; Wed, 29 Aug
 2018 08:43:26 +0000
Date:   Wed, 29 Aug 2018 16:40:24 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Yelena Krivosheev <yelena@marvell.com>
Subject: Re: [PATCH 0/5] net: mvneta: some bug fix and trivial improvement
Message-ID: <20180829164024.41e8439d@xhacker.debian>
In-Reply-To: <20180829162456.2bd69796@xhacker.debian>
References: <20180829162456.2bd69796@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0007.jpnprd01.prod.outlook.com (2603:1096:404::19)
 To CY1PR0301MB1577.namprd03.prod.outlook.com (2a01:111:e400:529c::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0db88d57-9474-4fb6-0989-08d60d8b7dda
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1577;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1577;3:ovrcgkPHDubMHVfuvYdC0xRbXEczhVo12NFQu/Rka+ph7mqyDV7kQJiYM3BXzIaez/X+bAJvnKNtS5xwep833/mbEr51Jh0Nto2my5ZtaBX55BdWGp+sbJu15chWVAvZpG4fS6Rcy/dqrJYEOsVNKIOjV8bnYVlC0ZGIgiJMfivJvQdUyfJIzceiG/9LOesk84rBzEvCV/5/R2Qk10aUcSm3XAVjprq0daYIBSXQrS0BLjczO8E1slOJhq1NxNpP;25:ZZfEbgsriybKKHG+5jtmfGwegaKDyE3QNyLqxeMM9lYLsCkXxVYkyEchuIrXwvyQcHry5XUbwAF071XJuKvR2B92assvP+8WMkZORUUlsVEukW90bavqdRIHlwA1eYQcQm1jh1YHkWoeo/9OuiGU+LHQVw9idnhgPZSgKJwzOOeccKgctCMaGhFYDFQIDIgZ5m3A/s2N3jX4tc/mAKZeFBD5UlsF61iOHOoXiP/IlwKDTLCYLuGjsmeUXl2eILVwlH1tMFDTK7VBbbsnKqnGGUEQaPbn2ZR8p7RigRtKBfGviQHrYt+KnocfDcnRL9FS50MPHO9ZAnEkQ20sq+LUBw==;31:6FrSbr99GH3zw97h0upHYFQD5iRrxJSzzagdGxn3dQB1H8s5+xQ+pqiPOW1CKjEZ5Mykppljq4A3DV2AZYSP6N9/ao95pg35yDphitLYW7cr4pGwTjEQJT70+B6PiaElh+bvxkkTSQldF6vauq0CdS/iY6j4Q+Ht3HpD/ZEnbCmK2c5VNDpMd6tqHB+JSWg8ZCMkD/SXT3myD6vMsR6/L+6iEwZaAA7HE5t/65b02PE=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1577:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1577;20:fy8LOus6MXLbYwpFid33cCYWNtsMNJoLeYAhkwnZO/HqiFQ+c2etyomzLTu6iDNI9DZu9jUNZJ6EWM1REILNjzwZ6nxUq2xI1wwDd2KO12ohnFCeB/vyr0STxnk3StBUUIdXL8NVTkTvnuvMaMuCUaWdRx9nHS/wjgJzM0FpVZFAKH9bL8DALWtg4bSHm2lGMMNTXKR6H0zurvJvgFq46Bol6RvNQMlnUafb429B+b3sKQj0DDdcQ73iyXLGDdBWxmzKrS/ULYH2Nk4VK1My5e0mZB5aQAsRtfEoX+jgm9woniGyTHlu5415LC1NxRP5+sgl0V4LZoTMLFp5LPKRIkPlXWOfpyq/BolMWOnlFHcUVRZidrJ04+mUnRM2tRYIHvmmEh+56yzSyt/ZnSL0ODtF9ZqLNgw++eWRJFaFiTsTmLD38kPpr1N6dbwevZWMbJMo+9IPTwGHb0VYJDczY1X1yx6AjclQVM2JlQoDewQzIAA3Cb7lWh2e0kPx6ZL5;4:SIRAQrUM6PKVuPEBK33iFlvAVMNBeoBXhrbgmusS4w22Za7ZBZQIf7xiGiYUHrQ0En9GUo7A25dNgRLItQCEuPdW0xGxqVBwxl8cR8Ux4rtAEj9UWosJWguR1hS7i/K5NWM9NgUKQ6/jqHgPC+MgDsLSfQJwT4kmf/2hwUmJUsJZGY5Mtvn9EOX06C6eG+S4ut5YmBCXQ0bguXhT6H5rZD/opAvrtZ7StO+P2CIg7eQ7yBB5A+Q5+Gg3uUaM0YXvAR/lMNo9ydNxsUVkY/QezA==
X-Microsoft-Antispam-PRVS: <CY1PR0301MB15774F2C2DB2D6BEC13AF11EED090@CY1PR0301MB1577.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY1PR0301MB1577;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1577;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(376002)(39860400002)(366004)(199004)(189003)(52314003)(305945005)(230700001)(86362001)(16526019)(81156014)(476003)(8676002)(50226002)(50466002)(81166006)(11346002)(486006)(26005)(5660300001)(229853002)(186003)(25786009)(54906003)(956004)(316002)(105586002)(6246003)(106356001)(4326008)(7736002)(110136005)(97736004)(6506007)(53936002)(7696005)(52116002)(72206003)(8936002)(3846002)(33896004)(76176011)(47776003)(386003)(55016002)(68736007)(9686003)(66066001)(478600001)(6116002)(23726003)(2906002)(1076002)(446003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1577;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1577;23:d8IRGIRRXGlO2cC1Ngri65RNj9SyKyqYvl5Soa0?=
 =?us-ascii?Q?eFrpg96CR6dv1kD7+p4qD8mWEV18L0+rlPLDJdAXcwFKmW1A3juXZRdHLlSi?=
 =?us-ascii?Q?bfuTPpDIlRqKzzBVTZ96YExGhG5pVZCv0prlboZdGzOPXRxDFkNrjFJlqIVl?=
 =?us-ascii?Q?MfbiAmXyF8iicKy5alfPxSDa4UtvDr/DP3ARunT5w1gNSPW9Ay5P078wXz31?=
 =?us-ascii?Q?FCOOgA4PB3BBM+ErVJ9GfLaWLbmoSZC+woJXvsMvbhPe8aJsaotWudFsv7PL?=
 =?us-ascii?Q?2pHATAEqqm2HyA3zzOp4yGLZV8uxgNMum0h2u1hleUi+1MrPJY819YUJ0oA5?=
 =?us-ascii?Q?xY9J8MsnDQcPJcTCc2QtRQUuEUafkCodazPQjwfu5E74F/gVoNrRape8d4Mh?=
 =?us-ascii?Q?Gn67VKd2psTTu3LjNnOSldL0gvtqzmE/mUZ+8zvTOlRk9l5PwgFqTpj1rfYt?=
 =?us-ascii?Q?/dASAzkHh//bcDJ5Mk7ZrAhCOzWhhVZ8I69N+bOpLtUWT63kT0/OADPsr3t0?=
 =?us-ascii?Q?WdNFjnWEX+CQpoZYP2c3N1yxDR7bjsFdOspdrh8w1e3ikSBfGHJR2kG85nnV?=
 =?us-ascii?Q?XS+a72nyjJCjqeVtyK5+ghWQ7OnENR4BSSrVAJIi9wLihm0zvmokG5mCPySZ?=
 =?us-ascii?Q?bYkDYWVGRuAzGRkAPh7d1qhJqUA6jo5diKIegjvWXAnT8MGhkGd5Jj+AAZ19?=
 =?us-ascii?Q?m5fXiN5jmr2PTKQkPrSzj+kx680WtAIvHk22ry2NaTN2hxWligrSveQGgwEs?=
 =?us-ascii?Q?RZvkVs24fdQBruuhnnF/fyYYMlQYJ2m7oBLUkIs68fW4zgdRZmLj/X9cFMvC?=
 =?us-ascii?Q?swI0Fc1JBo9//GzEgTXSTGrUe+L+gvrfow3XJGAUN8fn2gZpjcuXJmYJbyHb?=
 =?us-ascii?Q?4IoHJ80zbUG6j5bCoWu4huelhlXm22B5HU8sIzWVomhwxZTky3Ah3Pyt64rq?=
 =?us-ascii?Q?4u39nhPjwWsSW60Yqo3c4qjH54DYs6T7lUzxLPwtESvhsewEX0BMj7LaxukM?=
 =?us-ascii?Q?/RZdvYN3HcNRPxugGovTR3TvRzXLMtkNKP5b+Nx/sSN/nQP/NSiG9pCn0NES?=
 =?us-ascii?Q?z2nqWPRzo4fe+MkLrRCT2uMl9KzHPI67rg5Lj7MImtcqvjvq5OaM6WLPGhME?=
 =?us-ascii?Q?73YMiaIolYAVzd4FfgaNh1JCEDLuEHHNyilGljI9faxILv4XxpSr57Qa4HxZ?=
 =?us-ascii?Q?K0yPRtvumFNvcYgpwoIkDL/hfTXxCRj+BJl4z6mF5E1MQTZQvZRkR4BLy6Ki?=
 =?us-ascii?Q?nlV4drjSNPa6T8QLuxPDTmWdJ3gku9DXMqsDeiygTaVy/OiQNBj837SewA7z?=
 =?us-ascii?Q?uaA=3D=3D?=
X-Microsoft-Antispam-Message-Info: Hpy2Edq3cG+/lgfIeXuPxVd/xFHBZhlFjl4iVX/YCGoagtkT4q8jo4NmdRpJpl0VQXCtDpenqoSUs0KWH0U3BuSrHxC3/PyD20AsaBCUhuJCEynKKpBFEXc9dT9XL5fDK0HIQM08L6i2w4Sp4P7ywNApD1GpKHURogLdExCYUgil2nbS9tmQ7kZOiLDVygCQZWu5EiGaSXiLn1dpHQzHEk745wHC63YVbO3d91150I17DR5heAv0kL/q4mtCXWmyLI3GpXDpW5ndOCJcFjas9m/RJMrkrj5czbPy2LedEGTnVtvn1fTrkDG+GjRbQqYJl/iJqWyvLUtt5e7gT2ytVOC+9Vayx33zc3BOFnYoNBc=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1577;6:jsH9+bialed+8JDUpH0GytT6p1DR1ryYm/R0S5qzpUmjp5ySk254WtvaupSQNYveMbvVP0n75OnK9Hw0NXEkNMS5RnrI1kdciG62WnXCgQvzNU+iEnWColqEBPriaW6agZwy4H4VSPoW2Vg1z265wftu6/d5qd+zV14OdqZ5S9F5ugQ7Jb+hcLrl0bxyBBSe2huEUzI1dOG+oK8nV550X1PflJvJH6oZU6Ap3CbXRLPIDuvQbqY0ZTeHpMZHjSklOqRqpS8QqNJv4/c7qjmypDehsbKRvHRkHaaf3fjQkcnYjnWmgdw++gd2FgZudQTFTx4CQq6tub4fSOJV/g+3wi1JoDp/PTsAjg/G5ifeapq4At7/PyFwSj4ZzUpavJVxzcQaoxOMkevKxxU0ztvSJyIRKQsZIDnVvzOaefgJwYw7NPh+nSf+YOGGr6joZPMgy9xel5YufXS0J9eaAdXvlQ==;5:SnD4IEu8j8bxaZ/xt2v6sQEkslxcdZaoHE/U+iOHB9yIlRaWPopAU5kifRqS85TQXKP0Q2TKDrUxQBZmXZgEP6YwQJXtKtSYxEqiol0l03XDAaiRB6ebug6W05DdTg6FMhQPtsTaWPOHU+Ty6CHrEpFKcxQU6LPXZXETkA3Tiso=;7:xJgSFxwJf/aMz/TVjCDNfgPqKesU7+wFrKcBVqh7/QlzvcEhfmeuCvPnsb4s/PaXrERk7dfyuzbklX9rUcUkZ7UJi2FNRE5FLI/43NMuCgq9xWWGxs0hZWoQ6KNQxrPeCGNrbPrOSWXLMypRGkpVk38prqo/M8slXNSB+UqlVmPcTIxvtwzZ2HcjFI0VNcEu8sokCDqIU5xObdl1uKYRA/t2XW8p4yyMiKEd3/VvUQ+ayHG8k176BO58IoB/S1S0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 08:43:26.2023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db88d57-9474-4fb6-0989-08d60d8b7dda
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1577
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 16:25:57 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> patch1 fixes rx_offset_correction set and usage. Because the
> rx_offset_correction is RX packet offset correction for platforms,
> it's not related with SW BM, instead, it's only related with the
> platform's NET_SKB_PAD.
> 
> patch2 fixes the wrong function to unmap rx buf

I have question about the following two commits:

7e47fd84b56b ("net: mvneta: Allocate page for the descriptor"), it cause
a waste, for normal 1500 MTU, before this patch we allocate 1920Bytes for rx
after this patch, we always allocate PAGE_SIZE bytes, if PAGE_SIZE=4096, we
waste 53% memory for each rx buf. I'm not sure whether the performance
improvement deserve the pay.

562e2f467e71 ("net: mvneta: Improve the buffer allocation method for SWBM")
mentions that "With system having a small memory (around 256MB), the state
"cannot allocate memory to refill with new buffer" is reach pretty quickly"
is it due to the memory waste as said above? Anyway, by this commit, we
want to improve the situation on a small memory system, so should we firstly
revert commit 7e47fd84b56b ("net: mvneta: Allocate page for the descriptor")?

Any comments are welcome!

Thanks


> 
> patch3 removes the NETIF_F_GRO check ourself, because the net subsystem
> will handle it for us.
> 
> patch4 enables NETIF_F_RXCSUM by default, since the driver and HW
> supports the feature.
> 
> patch5 is a trivial optimization, to reduce smp_processor_id() calling
> in mvneta_tx_done_gbe.
> 
> Jisheng Zhang (5):
>   net: mvneta: fix rx_offset_correction set and usage
>   net: mvneta: fix the wrong function to unmap rx buf
>   net: mvneta: Don't check NETIF_F_GRO ourself
>   net: mvneta: enable NETIF_F_RXCSUM by default
>   net: mvneta: reduce smp_processor_id() calling in mvneta_tx_done_gbe
> 
>  drivers/net/ethernet/marvell/mvneta.c | 49 ++++++++++++---------------
>  1 file changed, 22 insertions(+), 27 deletions(-)
> 

