Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B0BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9478021525
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Mf8TwfWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9478021525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbeHWNhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 09:37:52 -0400
Received: from mail-eopbgr680045.outbound.protection.outlook.com ([40.107.68.45]:58691
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbeHWNhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 09:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hysea9UFcL3FppkQ2P4N+Ba4g6bzUajyLtruoawRqM=;
 b=Mf8TwfWGL56QxWzwrPvm8V21bYpeNuKxGwXak6eBnd3LRNKuTN6tfPz6Aze5OfPa8mtU9kt7msGHRq8wky+51g/MDg9zsNUhGJZjAbjt729UJ84gC6FZZUFIHXeqOl3rS1ZAA47quBu/+0efNysz6litenyPCd1ywqWOFJnfZ5k=
Received: from xhacker.debian (124.74.246.114) by
 SN1PR0301MB1582.namprd03.prod.outlook.com (2a01:111:e400:5232::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.13; Thu, 23 Aug
 2018 10:08:48 +0000
Date:   Thu, 23 Aug 2018 18:05:49 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 0/3] solve SDHCI DWC MSHC 128MB DMA boundary limitation
Message-ID: <20180823180549.78e508db@xhacker.debian>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0173.jpnprd01.prod.outlook.com (2603:1096:402::25)
 To SN1PR0301MB1582.namprd03.prod.outlook.com (2a01:111:e400:5232::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ad12380-fa9a-428e-04ac-08d608e06c6c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR0301MB1582;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1582;3:oj4+Z3pTBh6F/tS2xLE8fM/kLw8hb1ftlr8vPYCRg5jxjkwJ6oncVpOfIV3iaOPwkhBD95fdqRNkL4JwWNVy26TBV33lrLSKWMuNEoVajnkOeADbTsfxYOjhCBZcagjMNfDL0cxKPuyTURYJdAuAhDcOLM0RKI8rjGjbAiQRoi8bEbXo/cOrLduMT9o0mwapGrWweVAMaNlx7Ppj+NvU20NewemFBQjzAmwe52+IXdNhWkJvVF5S9Hb7kBdZzOAX;25:Culry0TXHvIj0lC1SBBEqDvVQ0cW8uNrF0OSRuT4GDb+5Mm48zLG+ug6vgkpcglfOpE7MwqZgfduvZ9ImdV00Zp3z2ybF2YlJnxmZ+M8KxAAPxnvYX+MRthOUNJL0N+j1unngXXw0RYRXvT0YdVxQL/UhsZXMuppVClPFhlFe7s3qWfkS+o3SV8dww0Bf3cFR7lmDC6Kkkk0A3keL+t2cLANTFCquqPyYu5cHHEbJh0mpeK6ysSQZeY7J9aGlAgJ/uZJ0DVEvVzk3VvRKUkTP4DEqzIrS9Pzapj77FhI+VahAlcBxxp/++z1tlNqsl9CDQt1ngDkdyyNn7pXV7vuMw==;31:XsFgYzP1mSJWJ1P25mP9QOBFbTIm9nUg04ZPLzZy/SDfSN31/f7+1f6/qUYDL1OA6ULY+SiGDuCrrRlybmRbJd6GZqr2irNnL+kqzYT0VK4cR9fdeJJwoB+VJh1HARZOxAtPFl9sRTkh9W1dlbrXLDm549uaR1nGOm4qZU8TBx2ibzsHlF/SSJNb4VvbYRjlFUz4xiCzKH4dplCkWBjWMnsxODtQVdCI3JR/GVucmUM=
X-MS-TrafficTypeDiagnostic: SN1PR0301MB1582:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1582;20:ULvrlWEycFtfbaJTYwpO6jZX+ivw7A/stOvyzW0one4JuhiqxlyRlNNgcK8Qepg/VY3sK3AA6AkBw8iB26rQSsdVzYgEXJwX+KwVJ1kARk83d0AaJLVYUjqrfOqFZ6q3WG/EoDE3H8yN3tMCQ59T1P70wGwJhniBNPmSIPXZQPA0fycHnAkX/SrhBatr5PN1sgHKEOoJqNgphq9VnBqzdb93eVGstA9LKbrQWrjIKUiABrZ/62aPYjhwIxxvhrlKCjirHy8JYSFTl/IvB+lpfM2EasgnPgZ3bjvqPsrrYBNfJbGVgwe/Z3oAwJtXZQOE8ouTun616nls/q4QTfSWRuOo9bSo89In8fRneqgJ9KRrWOXHl3SPnME5gQd16+kBwKDi1bazSohrbuSULcYI2tG4ItI9EzDYkkrzqhYR8R+4nZ5euAeQEbmXbI9CGgKn02ui/NIR4BNJWJASBMpUhwAr9cc/dqjrwPfoIkMZxcm64fmOtE2hvPKGq2qF6V7y;4:5cjenahAHPY48eqcYLx6+7VR2DHwaVOPxSgek1zHy1Dv3JS3b5ETPYDBvUm4tV/YVhu8qeBvyEvF9uAUkahTy9vy69FfP5Vp8hYhr6UqBzeasXmo/UhoyFrCzcuRM+STPT3/wjRUqnH+XjfIab8CwJwY2zXGuL10Cf+JQhrlPX6WVjPK+8j0aqxdx3kjhgbcCGLea/rEmxqX7Ar1iUYWAoSA0qKw8jWDkCCBZ0pGPw2mWPiNFJYrww6g13gjzwkDIMX6TnZZh+tqEAScXxJ1tA==
X-Microsoft-Antispam-PRVS: <SN1PR0301MB15825FB85FF1054408A4C61FED370@SN1PR0301MB1582.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699016);SRVR:SN1PR0301MB1582;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0301MB1582;
X-Forefront-PRVS: 0773BB46AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(366004)(376002)(136003)(199004)(189003)(66066001)(25786009)(6116002)(52116002)(3846002)(5660300001)(110136005)(956004)(50466002)(54906003)(81166006)(81156014)(7696005)(86362001)(33896004)(8936002)(47776003)(478600001)(106356001)(97736004)(186003)(4326008)(486006)(16526019)(105586002)(386003)(6506007)(50226002)(26005)(2906002)(1076002)(72206003)(23726003)(53936002)(14444005)(217873002)(7736002)(476003)(68736007)(305945005)(316002)(9686003)(55016002)(8676002)(230700001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0301MB1582;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0301MB1582;23:eJq6qzmg30BishWlhmaKnFPxloHABIbDoMVcBhO?=
 =?us-ascii?Q?fjWhuYj10EenIIX6+ffKgyByhwox9AGjVGMllQuRXTj+VLD0WRezwbf0PeOa?=
 =?us-ascii?Q?gmVdJJU8gbDhyac18gtTWmKakUhyiO+hlFuNPyq5Yq31tft9/FhKalrZmWcC?=
 =?us-ascii?Q?xyWEUfI1f6qPG+x0SYHcLoUKxemIc/jRNO25AAelQOodvC38xSCBs/oMoTpf?=
 =?us-ascii?Q?zvezQolPT4AsBEpe2KDbG6AFgorJE9nONFAJsSnx/2zWNFReXQvZk9lgnrcJ?=
 =?us-ascii?Q?E0zvGl3xp88eF/j1msJ3HxdirX14KXYBQ2yceSxjJtDTMbrjgqQ+j5jwEguG?=
 =?us-ascii?Q?dIZ4U3OfZkV2drQxdNM25QvSgreRLAA4eC5pv8b0MQd+blkk1o+5Jlq1FVcn?=
 =?us-ascii?Q?CtzCi6dUv8lTFf6OeBX/UOBvDPY/y1lVLfXvGyJ3zgWs8hVcNoA7wU8dUepR?=
 =?us-ascii?Q?YXeV9JzbPp11HGnUpL6BI7wGTH8g5aXACep+GWLEXnHAtKkgSf1U3zD5uV0/?=
 =?us-ascii?Q?hXFSZQtGTDgXMA6n/rmQRLy7Mlo7ZkkimrfoNqoP7IAtz/unJW2WHTZ17krH?=
 =?us-ascii?Q?so5X/0Iw1bCYqRE2SV/om2bTVIX0xsdaFvEaT2HdOAbzZCiZtwVZFcbtrZNC?=
 =?us-ascii?Q?ZdcThk535eoLNi2YWZHxkavx6zbAyMqFcym8pdageN/MiMii94lnEvNPiAML?=
 =?us-ascii?Q?PP3RX8BLQlOQovP2RIe1eQq1DFvvrZVGEH+b8Ni4xmKywk+g1v33VjH2H6o8?=
 =?us-ascii?Q?0ZN+4Lzn4u7aqkobH7nD0aucZUL+bG0yTPVGGcNi+7x9mhnAfHEkPy5FDNDF?=
 =?us-ascii?Q?pE3BC6lhV/I/ULCClJf/xXawXHSv6+9ObZAf+x7qqBYyi++qt5EYo2kZP7jt?=
 =?us-ascii?Q?q88nSN4UrKCSUKf1gi7WP+oTBhznUQWOj6hHbAAKBrEt6oU9oDh55d1BLMh1?=
 =?us-ascii?Q?s3uAedyB80lrjOjrIqZj439disILi4bkSncFEWiyFFRSr9cC9JVSOGM0UM1x?=
 =?us-ascii?Q?hx5QKdUI8UwJPwSEAKW6vCN+Y7NwPBblIcCWp9W8oQGTavf4J8RVvvCubuAy?=
 =?us-ascii?Q?h/NZdMEvltIXsBvtBLCYU5aPG1kgOfbrxCaEkarFDH0OK4Ptocq2H+BYhKrx?=
 =?us-ascii?Q?cQtR6wDL/DVJdwk3AlMgJnbyFkrslflUL4wSbW/2QixUK3EQaU9evSJffUXs?=
 =?us-ascii?Q?JnECOPBGhhwcTBgJZXq9isy2IoXrZNJMWBwCm?=
X-Microsoft-Antispam-Message-Info: HNvLOB+4UVF+AJvtT96SPYPY2xffehm5HBtgY1ZAXHgmd20Queqc7qn0vnSV/GRbztgovnLuHbbRXVMASGgWdB8NAEK8jxnJzTMoVyEotHefacMKggiDDeg798N6BjHbcTbvfVJWFU2K/lKNMPCss0wbH+SD9IRugZUKUEvstD0eZOk6J/m+3kvZkxTypf6vp16GK8D74lX6iNUcaAF6lssoggZ/Do8sm2mU/qIWc9EQheInv78Zle4mKmRe6f+Z8QJgsr5IpySy1PDQpB4fNPwBo7Wb1hkTzdbrrhZRj6w2Rufs3arCQDW5kHw+36q9QZBN1uy0zclaQJ0CctuJjbDp+CdQexuhuUYysHhlbvY=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1582;6:9TfrH7Ufb87Dg1ASCvIgBpsbgfmUKU0Vcl9iEEEEte5e0WXtHr0+KRmcTkGDW42MphKEVU3tXVYJoV1g0jgSpFXQC8AYZZ6dNL0CCEwP4irGelN1WWq+wIy3JA7mFoZUbijgUYnugHKeaGuAmDPe+YJg4+OvEzvK335JB3E5CMZMzmABgrbiLvDHM1/Ls1XLc5LNX3Agz6qWyfqXscwz+R96rClMf31iICtTwrH/rBc61RYtia+xEUfMplgfWz3pY07QBfo1AB5Wdr2BFqvtD5ZFIbRUTk/s5RPGa82/+bv2Q49a9fQFLoIvpA6EfQol0/YfqXL+sJLMFrdlhfGI4kLH8aowIXk4SkA7M3Ha+B3CpsSEKDBvI+XwHhMr9TWkO5ziv/TiTsEkqW/aoqCiLNLJQSCmy6kTJQjxsRQnSTWy3Jie1K+FVL5UtN3VDyHDgmDaOjInpjgSwuchYYRSgw==;5:Wuh7U4dONmuHGF02MggFzr2uVKj2RAWO3c/l1K2tLrfpPPGmqpASFdSVY9uFASb/bPRjfI5PLNUrMbNAPQFK5OEkYOmIvDmxVnFqGyEEjjWatdAQWCJckwOLtD2hefbNT0K4QiLmuieCngB5cG354OTUJy3Yi3Q4tJx4AZmqZ9A=;7:p3QEWXRHYwxmY3+26t68coTvqmPqIXYIMK0G+sDsAatgLNBZQSO1mpm8uKElmP1+U09U9Ly0ciGx8W5jkahylwm/1GaHxJ0O1NGuBjE9bf/A2Bhuhv6hMYDQlu6EkUlG+YwPGvhKd3n2HMsyfoIJgcuqgTbtwvzSfngkni7dowekK8BsYagyv3QUKg8Mc1lwreNZ3fKcHv/xDaXqpMPSRwOxQ7FuZSWt+tulCX3b4AVIYt9dnB5YEHD/lp4pLK3Q
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2018 10:08:48.9999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad12380-fa9a-428e-04ac-08d608e06c6c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0301MB1582
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using DMA, if the DMA addr spans 128MB boundary, we have to split
the DMA transfer into two so that each one doesn't exceed the boundary.

patch1 adds adma_table_num to struct sdhci_host so that driver can
control the ADMA table number.
patch2 introduces adma_write_desc() hook to struct sdhci_ops so that
driver can override it.
patch3 finally solves the 128MB boundary limitation.

since v3:
  - s/adma_table_num/adma_table_cnt
  - add comment to adma_table_cnt
  - make the exported function name without the _
  - let sdhci_adma_write_desc() accept &desc param and set the new desc
    value

since v2:
  - make use of "likely" to check (!len || BOUNDARY_OK(addr, len))
  - explictly include <linux/sizes.h> for SZ_128M

since v1:
  - fix BOUNDARY_OK macro if addr+len is aligned to 128MB
  - use DIV_ROUND_UP to cal extra desc num
  - fix !len for dwcmshc_adma_write_desc()

Jisheng Zhang (3):
  mmc: sdhci: add adma_table_cnt member to struct sdhci_host
  mmc: sdhci: introduce adma_write_desc() hook to struct sdhci_ops
  mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary limitation

 drivers/mmc/host/sdhci-of-dwcmshc.c | 39 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c            | 54 +++++++++++++++++------------
 drivers/mmc/host/sdhci.h            |  7 ++++
 3 files changed, 78 insertions(+), 22 deletions(-)

-- 
2.18.0

