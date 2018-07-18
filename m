Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD96ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7AB20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="OxI11yYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7AB20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeGRGeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:34:44 -0400
Received: from mail-eopbgr720078.outbound.protection.outlook.com ([40.107.72.78]:23738
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbeGRGeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Flg97v6FOTCqJxHZGUhQSszNM8IVb97M265CDYwjtZU=;
 b=OxI11yYuDG+MdZpSww8iLy8L/7+taXtKn4I9kSpQpU3uGRku8SK+BW2i+krfeyUL7Ugl7P1QXdiXk/GTIN9lToKI772RooWUBSC1KGzwnDtL/Ib8i6D6cAwNO67BliRzQXKKYNzuXuRLNc+2sQUkaTC/091gjck2XZGl4clf1f0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 MWHPR03MB2638.namprd03.prod.outlook.com (2603:10b6:300:46::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Wed, 18 Jul 2018 05:58:17 +0000
Date:   Wed, 18 Jul 2018 13:56:13 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH v2 0/2] pinctrl: berlin: add as370 SoC support
Message-ID: <20180718135613.1c559b9c@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:404:56::13) To MWHPR03MB2638.namprd03.prod.outlook.com
 (2603:10b6:300:46::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e938d898-7f24-45dc-da27-08d5ec737633
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB2638;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2638;3:uP7bJ4Sq957CpiQ8CNI8o9k2FnEq6Xgiywh6PLXkdvr94mGZsfbhgnuVcRaGGnFGjH28JddWwUiZr0jBF7CNa5buLA5Bg8pG7WMKHOtJrnGcLA2OCVplw/8hNCVROI34R5RzkDMfrxErqK1ocxbSIf6qWDZUaLIvMJtnSQCp89ksCFowIfmop7cdfV9NK/BN9yfZJd7J0Xt1HL5dYS8BqDyfJOljGTEvewfyV7gHybPUZl48EUZTEIpFAgkrdxa4;25:wSCtoXxgGYxHNf40Dp7HnNTCX7nWDm9ZNAxhfZEeGb8rkQq0r3qfK72B9oK34j5VHlUym6wBuuYwcjGAbd6oGDB5aJP9PQ54fzkjdulBQxQlHSxv9dikqvx1i0GX/A3dg4k/ioiCyg2mUi4MtikxL9e7JuzmISqgJ0xS0ahTs5q0UblbwW0j7AM2DTPrzABQiHuzwli7KaWpMcg7RJ94i+/G0laVzvjjuZZl9kHgOd7oFoR4Pq13CrOZ88EmZVK2B8Tp2MSIlsaeM7w/NjkzGNbIb8o+MRYE9tfd3ZRfYH/d/3S6seBmBruJGSoUkUSZFJqQL+8gX+aq/duKW607ew==;31:p/EEEqcYwQxr9ZahnwOl8qkSX0qE+keVASSHCCA4XIPyTL4iXwlBBkvt+fCKOq2iOmAJAscBtI6hyIhcOBwZmu4SLaMlSQ57f5iOFNJE63q5Sd9isTBneLjpWA3TETk3FquH2K7VFuDXkH3Ppn+lTJ+GmjdV1diOCSq8OcPxM8l7kGGbUfewPKPyk8kl2ns8cSKptp3fzS/PP+cXozUXag+TERF+pfPlQKAsImgLjzg=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2638:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2638;20:J05qjGqmeTelWQq88EgsQxf9pdHAzzgYSO2ivK/GS5gYxmaaP3OGsWJl7/Ck/NtbGn5pLRp32GWsCCY6g0oafo7C76xb6XceQyg+4hU/yrBn+bU28V6HZUwHmMpOwqDVexpEscWiVMmycCgyd+oEyRYipW7Cvnk2acl/RcQXSc5HIARsPHXyG2rmokjHlrSZTmiSTy9u7Gsko5IgKc3HQzVX+WwDzLYMk5VWUmp0cTjLlZapAbtQWx5PCjx7qDsXAxRGBZYGrpz4HJsLFprgl4nSGLSCa7zE8K5JPz0LwZQby7tl++ztTlgfJVpuN0CODdc/n/+exwNm+2bZLA0rzimR+OOvbZ50wrkMihWq3j1fAXT+Q3zx9lVPSYUbytstdhnC32/wc5JbMd5mHk0WGL2jnw9PVUNhZR4ylx28HY51UnnF0kl9EaJdmH460x1z+McyH6VCOBUHu1yIVJ+Hl1xk28hb5yF490ekLIdbRQo3VvtJhp81zgEvZuO8zWJH;4:u8nLvVOpJOifd9tBhN+Nyu4oESkTCsx5/LhPvcSLuFRPnaBEnL4vX/e5ToFHY4IItPg40ciIGuboOPsMKY3OC8E+DSZj73upbRebV+c9aJcubh1fNeX0FQXtBQBWr0P/RTsrgMtWhZzeLXhlpDKujnN0e+800mMM8812Ao/rC8yw09VCrbeeSw8QRvJfjSgFXQStOcllnX2r3hUFToMvkvtdM8S6kRqMSarjTa8iqeAotj4IAgnGF2y06PLHzYQEZ2wPCzhId77nEMwwjtuBVQ==
X-Microsoft-Antispam-PRVS: <MWHPR03MB2638B5FDE1BCC8ABB0527F61ED530@MWHPR03MB2638.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR03MB2638;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2638;
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(199004)(189003)(478600001)(81166006)(72206003)(16526019)(230700001)(2906002)(8676002)(186003)(86362001)(81156014)(53936002)(50226002)(39060400002)(8936002)(6506007)(386003)(305945005)(4326008)(7736002)(5660300001)(26005)(97736004)(110136005)(23726003)(25786009)(33896004)(486006)(106356001)(6666003)(3846002)(50466002)(476003)(6116002)(956004)(14444005)(105586002)(47776003)(66066001)(55016002)(316002)(68736007)(9686003)(52116002)(7696005)(1076002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2638;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2638;23:SFHwZyvZTYm6sg3tv8iel7AassLgv6lF95KYvL0Lc?=
 =?us-ascii?Q?7JIx3/PQSj3E/U17aWsDZ/eBHhegOmxy8HxGpB16RKFXZRgCD4Cp1mvfJMfD?=
 =?us-ascii?Q?I14DuF+ms/L46sRHtSIQAx8CMtSR0l+M2sniku/KUoB/geNe7xb13efoRPs+?=
 =?us-ascii?Q?s1u1ZJoo1/lzqZFmCXeXlD1SUERFm6iqxW4GQMoiHYk+9NunLxm7uUzuQkEV?=
 =?us-ascii?Q?5dWZ0mApomR00FrzzDVUkn75dRXRLjF0g5dPZIX7BgZeaA0TogletpwNNIml?=
 =?us-ascii?Q?EkbaiTuu2na8/Lt3lcoodXrRKZxHC5YzJFlfvo+BsvYZYxD11S1d2WxDPwdj?=
 =?us-ascii?Q?Fu0ZZBuXjwM83WI1ebFhssllX7sP8pJApu32bJ8GS8M5AjWoppFRB37fnrjD?=
 =?us-ascii?Q?lz1ML4bV8FlOdFh5wzUvWTHn04waOxTssAJlfLr1vkzAzHXNpZ/LisBgGRvq?=
 =?us-ascii?Q?nxYQKs+/LN0Jbtk38xvQZmIPp1EqQi+0kkU2Oz4xekZtEEmqFwdGB+BVwrlG?=
 =?us-ascii?Q?U51gqVfJF/1Kaj0lKzZk82fPiDVrvJFGdKfNERViXnYLFEV7wPOyAlPEgWm8?=
 =?us-ascii?Q?5CCGqYAHSZoFFA3Pm0/YGvwAbpuUCsKqi6TZhuPnHme2+ymBdku7TGM4pfef?=
 =?us-ascii?Q?GkjQk+eM6M9b6e9qixAEsseRjpa55ZqG5ak7Hb8D7C3klFMVK7yMuXOWWyZh?=
 =?us-ascii?Q?jfkrEE457Xu/hlyoQJHfx79WcR4rpNhVuWvmRHYIMqm7+DBGRzHNMYwFSkmE?=
 =?us-ascii?Q?6UECJ4Tug9LA5Lj4sq3yIxRSj5bVtxNy3BwqDwIDom3UJZdtAg3261YMgUzF?=
 =?us-ascii?Q?pEHiGUKfdlCTHgJ1UW1n3YArYM4doDCQn0LhCr2JuPK8ArH1QdREjXOFPCq5?=
 =?us-ascii?Q?X548mR9sO0uRCWeMQ27dGa6R4dCFiOsv1sqVtsTYFm3LlmTZ/F0Ydy2D+AOh?=
 =?us-ascii?Q?JJh88R47xAN3BScz6aRIVgGizVL4Yj47jMACHpArwjIcYuwvBU/nEz761Tsf?=
 =?us-ascii?Q?waWUru1BNkN4hD1FsPKOQaktN0g/4JNARhDfxUMxZKsZmuV2iRf1cijMk9Zm?=
 =?us-ascii?Q?YH9RHpIF8nivK+ebpmFe2mxpTCv6hSuEg24AM2/IqLqyS5F36OKXDcuFnUfa?=
 =?us-ascii?Q?2QbkKIgd0CuQQtOCNtyOtd8xEORzaNWFdnudXu50KhG6Xp7dgwuhB1YzZyNL?=
 =?us-ascii?Q?hM65e9gkXbgrH1Vn7MaXRjnJT0xXYeYFLSa?=
X-Microsoft-Antispam-Message-Info: 5I59zJ3TfJikjfsnmLvuRdpCBjVzy0vqGw9FZiMOYlRHpRK4vOZzxg4GVNOIKoIgTejtJ7ICqIkRMNP10Hq38ckB16jQxzRJLv6KwWtUUC2jO7qTt8OlN5MK1zC0lIIvcUX6koBpMycpQ09NVpaQu9+D7b9qMjxNq5XH1DRcbHpJoRCiamXADpT3UlQuGxB+ZGUH43E0HlPygXOODO1cuY31PVb5kyUM0E3T/MqTMnHacJzR/ZeOI42RmMhukd743Ns/NjdLcUrkjGVlKtY77r7M0hZknA1gcxd8p4fXl6KjSH8N+ourgdPuEYnAe7J66sdkpp38SaX5Gj9KlQQBXlgJsLDkTNhK2/0QYgRsMeA=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2638;6:EgpGMzY7zjHGu4men6UXwJswjDHliAqojdCoobVFuVgYR1YbGkRqQvlT8Nf1jz1B+P/gLP7LNSn2o+kUKxzHr0aYSESLn/USrxbbWGlI+Lvi4PsvEQdjopCAshgrn76Ad1ROJ90PYCA7NGjB5X3ZD7iqXeLvHAispahznx5IY//xgByrdirbYV/LnKE/a2SftnWeAhaLoB0elFw6Xn+ShD6/WuRHoanikrAsS3AxH/3pVb9EjT+podJAncAWkTcjcsaQ0/hIZPh4nJfhxRmSw35NtzlfjAtI/V4EF5lOyMgGossuPoYrd0Hwn+wk5+0WaxRn0SrRj01LTM4T5uD2hyJUmdqqGJe/rukjPbtPRmPFisxArS0wwXNa5RlYIsIOsSru4NXvWgsgq1FNKuVFejCI4C3uBig/VtHJR6YKTJy1pyBDIR44kwIvS2rNiFstDsQ3dB9tQkqMsEJV0gc89w==;5:CZwvU3xT2qUlrZWXOth8uPcn5MTiq2LCndmtYA134bqep98JJdHmLRWK+yl4sTDDHAFf6iNVJUbI5QJLRxFDusuVs+AGzU+eWNsdNl0UQEGm94N/CBO3QysJqDX5v0DsMiSOhjCnxnofZ3Zoe18rGiBchfLY+HGVp5+MDON9hOE=;7:vBXXFY9s+YWlL8XLYdmOdMBhmUUG/iuyTmO8td+NPblRgzBXfgDLk+RH29WISH/KxnP4EzO2eGRX+GhFDvZAeld7DuNphTGrJf9zfTZNhODuXL3pocYwjJdASfD30WV2Y+BmMRV4UG/uVQ4d0XvVqRRRm69HSEgEfjp8bstaBUxgcMOuel5bv+RCjzXrdsguCgNyhFhNIhx3cqclyoZwluN2yM2n+7OYWhh7gS8t9sK1nUh84PgpanlPIgQJ/TH6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 05:58:17.4633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e938d898-7f24-45dc-da27-08d5ec737633
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2638
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is to add the Synaptics AS370 SoC pinctrl driver.

since v1:
 - remove MODULE_DEVICE_TABLE since the driver is non-modular. Thank
   kbuild test robot to report this issue.

Jisheng Zhang (2):
  dt-binding: pinctrl: berlin: document AS370 SoC pinctrl
  pinctrl: berlin: add the as370 SoC pinctrl driver

 .../bindings/pinctrl/berlin,pinctrl.txt       |   3 +-
 drivers/pinctrl/berlin/Kconfig                |   5 +
 drivers/pinctrl/berlin/Makefile               |   1 +
 drivers/pinctrl/berlin/pinctrl-as370.c        | 368 ++++++++++++++++++
 4 files changed, 376 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pinctrl/berlin/pinctrl-as370.c

-- 
2.18.0

