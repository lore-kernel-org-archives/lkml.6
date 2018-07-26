Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190DFC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7F420673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="JC0olube"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7F420673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388446AbeGZS73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:59:29 -0400
Received: from mail-bl2nam02on0091.outbound.protection.outlook.com ([104.47.38.91]:18245
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730285AbeGZS73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7imGy8d9I+0TqVyMHyKClb0KpJeBIaSa7ol94ZVi4KM=;
 b=JC0olubeMnnyoUxvACFkuYt3LXizQcDL+/CMA7GzLZakhQJasdTdQhX5Lwd6L+JdmKipisjyAoON2eaok4jOtuLwU4EL2LVjR47w1dFXjZImnOxS1oTjrp2qECUO5zhuQkMCo6bubuiVaTXC6BjshNGZ6IfoZjk73ouJuA5iaYs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Thu, 26 Jul 2018 17:41:31 +0000
Date:   Thu, 26 Jul 2018 10:41:28 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org, jhogan@kernel.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] MIPS: mscc: ocelot: fix length of memory address space
 for MIIM
Message-ID: <20180726174128.vixw6ratago26sli@pburton-laptop>
References: <20180725122132.31187-1-quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725122132.31187-1-quentin.schulz@bootlin.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR2001CA0018.namprd20.prod.outlook.com
 (2603:10b6:4:16::28) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 513e820f-fd04-4c87-2d7b-08d5f31f0614
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:qVtDSjlM26H43da9SVEJZYMm0P4DZaw7aYFOMH/igR/PCqs/gUcJMLgMV4TXm2mMEnM9f1JiF1B7HH4J8EHn2Rl8Rq2oOcSXtMoeRGOb+azzzPtyHipfmdu74a7r7WxoMP46nnTOlFsUR8l6wbeRj54dhsWnJ2WGRIuXDi9niuNIIqEwLN/53BOy89dMywDlPQ+BgfX0H1BiHCXOor4UtZj0WeeMPZ41qfvVNFHnUZdcCXv3GuCD+jEB5iYZ86GP;25:D9sNav+VQq/Hqfyc/ouc2IEaiZ/Ni1Exv2TJvkwGc91FEaPC47WIuEvV6YM1Dw2A8XWIWR7Z28I2CkNdXZ6hJAOouDdVZO9nYmbcep88KyRJ3esse2cWuztCzgqdAZIsINUXoF5Fk0h2U5GaNKnUufc+DoQ+Vpa7WDUP9VAwR9fpU5Rc1WrkV83vBC1UpSXN6mlW2T76SMd04X6wzWz7NjKihf9dsei082mdnUv3rfJzClwXMecGSamdYscdwIJZJsChKteyThXUGSalvMFJ8s7mqORRc754KgmfLL7xfGsqzqDoqSxozDv5ETCNTY/MX0bZiTa9YM0CqPPmlXvrWQ==;31:DSg2XPv1tZmxRdlj/TUkSdf4PLGEtfnLw0pXkJLBjzmjQSH09MMtBfG6YEET3zPZUbkpuITdLq+g0alrreqNLguTcAv8QcEXbJOsfqxD7kMF18hs20XjsrZrjUf3g7mD0yP5/jU8myKnOz+udswICjoXx80hgDlZ14ShgOnRb1VQN9ktR455dGnKvOf7aqixGG1bt5hG0upzBdm+RqyEGiAJ3heF/w0Zk3f5itnYz/c=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:OEoGtR2hfSeGOgPpykFmEXtSzRPh9UdhTQ3S/v/I6sPAdWG/kagi0ESyZ8GE7KWkR3gN0mgMJv3+afFRt4K1K3N1OQLvOKgHWV8wb6xzN/UFDRGBIGbE5vMzLAKwLeFC2Nk98zDcIbdxJdUm5iEIjbnIicvnSsf1XPMLlBstn+nS+pQ4E2g24Zb0r8jz1gCiBGpPGPrr6y3Kh6aDH32cLavtYqZrmEC4KRZc+GXr852rXQK8667lQLSSYfD04SI4;4:BIRq9vy1gvKQNlJ7EfOU4BY3QHd5i+SuRZTT7ZUITqSOI9EI+93ZoD/x3iljNB4l10a+bH+29PtemBg6kI6iRhzpYNC11l6K1+ktX4XdjfjV/zQ/FhchFDN36nYlrjWuka40izy9qm1ZUz1UCcRTUwCzx5n86onRnZ8JG4XjLHQ5y1QOw8dhwjoY1v44ksUs3DYUigiOFDDdh0QaL/ZIJ7uUDlvqp2xKusFsqodvzZZD+wQnl+t8LOT4w6TNMKTbLhYg+jZpfbZJb1jHjBmleQ==
X-Microsoft-Antispam-PRVS: <BYAPR08MB49344A3B4A717D60D53444BEC12B0@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 07459438AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(39830400003)(346002)(366004)(396003)(376002)(136003)(189003)(199004)(7416002)(386003)(305945005)(186003)(50466002)(76506005)(105586002)(106356001)(5660300001)(14444005)(2906002)(476003)(8936002)(6666003)(446003)(4326008)(7736002)(6916009)(16526019)(68736007)(52116002)(9686003)(26005)(42882007)(8676002)(33896004)(25786009)(478600001)(956004)(11346002)(1076002)(316002)(66066001)(229853002)(53936002)(33716001)(6496006)(58126008)(44832011)(97736004)(6246003)(76176011)(16586007)(6486002)(81156014)(81166006)(23726003)(6116002)(486006)(47776003)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:y+20sb7j9wLk47xCbl4mFsLJ+B9PYD8dMaqFiLVIj?=
 =?us-ascii?Q?3gnvqdffMM/751dZeRlyZ80XqIw6F9Efa9CggegwYJCz+Lkm9xb99qoryaCK?=
 =?us-ascii?Q?Ot1WlkNnmauzaMK83BkCPWPsw0EbqcTEK4mryEVY1cd8zCXMYFrAqJh3G0M6?=
 =?us-ascii?Q?EQaIFPJ6VnuAhQy4vefjH1FkihYEuWLmcSYTbmVilKZ8VdaQxyUxtPxih+J6?=
 =?us-ascii?Q?AT3+x5RRmuSF+wF7iOz8vbNGYHybL8NJ6rwwelzbxh26YRsLn+WBCIsr0w5W?=
 =?us-ascii?Q?ArHzLw9spjtLQIr+/H233evauhGscqOAHMSUF77gkzvn7iOBCxh+QwdaL3xB?=
 =?us-ascii?Q?NCCJOBwtFH2O/TawZw9JE9T+rhNJGol3MTkX8YH/TmRD27VfyN7kBmRx85KC?=
 =?us-ascii?Q?kOWJmE2TZNdFj8m4jfi815D6A77Ggzw71uo6Ma4ChKpW42FvYb8J1d0ZZPlr?=
 =?us-ascii?Q?Qd3F1QojrY/oplScWpc74T2L607vbonk3WFQkSKt57gC1HGmEToeDnGy+3lA?=
 =?us-ascii?Q?dSmqf6hnPALKQZBgGslVi+Jz7zJoKXktPyloZfJoFw328vL8ufdCycMHW9Qu?=
 =?us-ascii?Q?DVzhPHtpmNoKI3RRCRDOURToEhmMQIRTKOOWDYsuUSIlDEL2WKQ9uYm54nIu?=
 =?us-ascii?Q?FG7VQTqn79zdeiUSmJq0uQbDeo9+/U047jeUF/bsl58xm3JxNF0wqVQNeri1?=
 =?us-ascii?Q?I7sSoU1mMM0W6jUQzc/g7IuXJ+FZfKUk/etvMPCrr6fCMfn02dlgPJ5Ebk6+?=
 =?us-ascii?Q?DIa7QBHgOIIGH4imrJbSPyi8ra1TbwUSIons+gh+JQNzgYMrmNMxgC+YnalQ?=
 =?us-ascii?Q?0pI+Fg9zQwcBb0RrUjUzHfHabZXuKwNydPSQxAntJ75nJ0yjsltQ5q2+8gG2?=
 =?us-ascii?Q?IfO2zzybUr5wW+lYOGSlOs2fzkf20Mop3CQIByTJoUQdOwrPEOQ048rODwB2?=
 =?us-ascii?Q?0UcMC61BaYDB8AR4+yFxMBQbn8ycJqucLfhw9e123tMqFoZGQ97NQaVS2Wpb?=
 =?us-ascii?Q?OhBWn+IdGFUW3X+M2z99CRHfBL8e6SfuRjlh1TXXSZzvk5iNDbQR0YfhCR2R?=
 =?us-ascii?Q?W38dP0h6P0qCQ6cZ0AF9jWB3Bjdfu+aWvFc1Vith0ooChLyCEzMDhpC6zcK6?=
 =?us-ascii?Q?azSgvRcgYzIgrtDkPcvKW4X5+WGJ+VAavm/Znmf/Rmp0HJrTi6oOFla6IjCn?=
 =?us-ascii?Q?adHnjiEXLi/IVGhlofFp4FdQDpa83w8lzVObHBl8mGP5s/4QmNDN2Jbw2aQP?=
 =?us-ascii?Q?Hr3MJ3M8SA4PgJVEXVLuTO6ek+au04nGJ4yQ0UwUBLun1IBvy2FFk3NGcP8Z?=
 =?us-ascii?Q?03ON93Lk8nvaiYDUkeXeABChOtnAblmUnciIgHYKs83?=
X-Microsoft-Antispam-Message-Info: 7cjJsJmWbS6VV0QuXnhU1T1Nt3W8iJJKyM/cMS4MWA2Wbn7D1z1OID1uEZ8ysqcUvXCUl/2ChNYoRUwhBKys0nt9XSH0eEwpHwwCKT4vHvyoalHQ+ezaTmT4T2c4rG/pnAIxFXR0L3qmHjFo82ZZleXgfpFnLOTOYDpJ0Rf2CvWrF1OJqWscEVsWe6SAaLikrZWNwt589HXAv0fyvFSyzo5eaJ/qtw+bmIbsG+UvLQcAuLV6PnBuCg/wGkDsuChHhM29n0Hv5I90D984mqfjG1u4WLXGIERiu9GJwGMLXCQwMe6PgffO4mxK2YT5j8xx9lIikfKkxU6pJ4/TKbXQiuKjao+pWR8h2xua07KrbrA=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:GF2x76D67AnCFsN6/KcnS4IDIrwpjZJff4J43TryfiNaKU0Sn8ipqZX7TTM8ve7VMg8vJ6lKoTTpc4M10i0rN99LRExMfLFBrYeFvPpA1uiAJW/MyHWInGT6obFJX2hafJjRQkynbbDr7aRwhezEt+5ZxdfTeqFrdx+fwzCCCnjOblFybmHWZM7Oe3CkT/uedFajjGklil/3sdMwVQDqAcTxirocgEjJ7qnL/3CUGFsFYF8u686uoY1YLEDPCiHRtMI0zyIGQkn8+bWX532/6mvf0IhoqRyUEY8LE/Y07GKO0DVA31Fn2NsFyYWGmjFLcs5OUoq4gWIZBl6GMxqxXLQmdFxXsq6NCeG3MamnmuP01OSMeefPyIvzC48z3Iav5jBQr2TiRAv0Z08O7hFB1d6d04ZjfVUm6kaySJwEqbQ0/RI9+EqxJx5YzJfFkLN9ubu9a6EO4Yvh8vAwIlbUnQ==;5:GJRB+pBjH84AOJx3uWA2Vx0WSanmDFONqOjCT7Z9AtUchioD9ooJuTYAW4ZrmnP40Zgfh6KsIn/78y/RzwTh0d3Ffe3j3dHxptNhIkwpavicIM+m809OaUBSSm0KAHzVXOAL1gNr0Rs68mWsF1zlukcWIOJo7dDi1rId/xMKAOU=;7:NFiTjX9XO6jcdyd2pmH9z/7DnMZ8QuhjVyVLbIIx5TpUpeqA3j4SZnZKQhZbeI+firKYuk/xIOn9LdYbl/t9mhl4HEYIEXrxehbweeoIlCoxoIyRRazNCS0w81B4pH5yx5NRC9vFhdv42NkWB2+gmxUXxwx1VRJwIxId2lAJulAwsoSYnjKNVWjtFfGr3vRJPRk0WH4wN4q/Gt+qJ9bOvZexGwYS/huspH1XUjMzIUxe3wX2qalBJFRa5vHvtVlk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 17:41:31.1970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 513e820f-fd04-4c87-2d7b-08d5f31f0614
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Wed, Jul 25, 2018 at 02:21:32PM +0200, Quentin Schulz wrote:
> The length of memory address space for MIIM0 is from 0x7107009c to
> 0x710700bf included which is 36 bytes long in decimal, or 0x24 bytes in
> hexadecimal and not 0x36.
> 
> Fixes: 49b031690abe ("MIPS: mscc: Add switch to ocelot")
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  arch/mips/boot/dts/mscc/ocelot.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks - applied to mips-next for 4.19.

Paul
