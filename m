Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A487C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49AB2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CS+cdqqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49AB2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732171AbeG0MMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:12:40 -0400
Received: from mail-bn3nam01on0055.outbound.protection.outlook.com ([104.47.33.55]:64475
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730801AbeG0MMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqSAKO6WT7iao0rMalzpdzRCbVop0PO/KmaPetFYNrI=;
 b=CS+cdqqK4adB5l5zXxkSyxmWAtb1uKDooxr1/DxaogDoMSDwTjLD+3wryiFwjZgahtvWl61cPhqXFdgauqC75GQcVvKJc0mkiNmw5vES5gMXzs8Igg//bC1mxuSkceRjZ8+20aOgF/evAadNEsu0GcefgTwThH3U+Vg0j2Yj6iE=
Received: from DM6PR02CA0011.namprd02.prod.outlook.com (2603:10b6:5:1c::24) by
 DM6PR02MB4330.namprd02.prod.outlook.com (2603:10b6:5:2a::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.17; Fri, 27 Jul 2018 10:50:55 +0000
Received: from BL2NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by DM6PR02CA0011.outlook.office365.com
 (2603:10b6:5:1c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.16 via Frontend
 Transport; Fri, 27 Jul 2018 10:50:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT043.mail.protection.outlook.com (10.152.77.95) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Fri, 27 Jul 2018 10:50:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fj0Kh-0000O6-Mq; Fri, 27 Jul 2018 03:50:51 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fj0Kc-0001O0-Ji; Fri, 27 Jul 2018 03:50:46 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6RAogVZ006055;
        Fri, 27 Jul 2018 03:50:42 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fj0KX-0001NO-QX; Fri, 27 Jul 2018 03:50:42 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id F4138B20466; Fri, 27 Jul 2018 16:20:40 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>,
        <michal.simek@xilinx.com>, <appana.durga.rao@xilinx.com>,
        <lars@metafoo.de>, <radhey.shyam.pandey@xilinx.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] dmaengine: xilinx_dma: Refactor axidma channel allocation
Date:   Fri, 27 Jul 2018 16:20:37 +0530
Message-ID: <1532688639-32230-2-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(2980300002)(438002)(189003)(199004)(7049001)(4326008)(81156014)(81166006)(103686004)(6266002)(8936002)(478600001)(2906002)(50226002)(5660300001)(48376002)(50466002)(106466001)(63266004)(8676002)(36386004)(2616005)(36756003)(6666003)(2201001)(305945005)(356003)(90966002)(47776003)(476003)(106002)(51416003)(336012)(76176011)(54906003)(110136005)(26005)(52956003)(486006)(126002)(42186006)(446003)(186003)(426003)(16586007)(11346002)(316002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4330;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT043;1:mE++tB/xb2bhycV/aKGXsPt5I/To5/9heIxmzkzieierHBlj1aJ5feDzo0MI+jr69h7n0ix3aD3T+a0efAKPgO864I/bJ5EM0YqQFXLGQof0uZ33x3PAUZ2C8do1AFAI
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3338dc3-ef6e-433a-ac37-08d5f3aed3a5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4330;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;3:MCsdMar6Ll2LNjIUcmGqcxAcXVy2d+Jpxa50z8EbUfD12kcB53tGQ7F8RHfq2VBLRk0hPHQEMkh2JAkiILLcbZWvzR8vtoISDTfvCGVVX+sDC086ADezguNSKLI9WuxOk9c3DDpWQhqg6bftUw9mUuCdK+5bmcoRkn3Mv0af02QZXkaXAYHbW4ljiO08CyEPHC2bGrw6HBhFIGSBS4vziNFO3X8kyhav2MAGKz51ae84JMgit9uSR4n2OslXrnmnq/ZHbcoESnDpuh/Vwq2hvrI643TWHlKs45jrHJ+er0e9O3xffcSVsq/gyfHzczlmoYVNV81CJ/t3dAVUor5rhrcTyf4mGIXcO68Z7YznJnM=;25:/85eec9LhVFmTmwjg4eszU15SqmRl9QyO4pEoRMQ6mAAvhETcZlqG4DQeJUOkJU03kWvq06MZdgIzyx/yWgSDGHtOPWMfDPnzA45uGIOTk+cRhcX5QMu0Jm9YqCgoXIXl9zk4g+c0QTrQqte/9s2JLVmRU+LCgRHgN/4OHkFILPW2z/L/z/hvAqnptaR6b3P2wVEfGc+OXeApVuF3Sb2Wv0aQ4XVjkt4m5/LKbo3C2KYPnvtYT5S+39r4YILmtBPHHX6+D+5ek+81xXl1mfekt5CWCcZVDNMK5NibehGYjbNzpz+ew4I5aJcdkh7r0CuTei/UgPq9anfEQgBmBDDeg==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4330:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;31:9xec6qlPYSZ+vTLtJGQpxVHOgzje8UBvBN0E7hVu2U30gtVzuZzQkn7Y6qKxEGsI2xqpfGv3rOH7Cdnqrm7dJRazj7Wq3ikUMGB7XHFK7K/HgEyZM3yAyvdd+zYoJtnACQhHZ+O52asovUqagfFe3KBl11pvhT4W22pi0pXLOlzZ2XXos7KnCva+Jm30QK0mlGboTITbXBOVm1HhQiivDvtMbMZkOYwogvy0jaEklmw=;20:+d2p5nyscoMV3E3wo8beMI7bovYkayp0rsgOUOu073uY0Yl/2zKHaDIKsFvyF12EiRG48TGBELiwwsftakY3ybDk5BgciK6BjBTBmKkKn1aLNfCpc4itJJQdG8RXcxVPOcJTbZpvrhncfW32j7B0ryAZyLsrmAMEWdsghP+vjZra6KrSBUMctDq853SJxJPdtzPL04i+U1fmKPTL5bzse2uYhzU5aJU9eyuPzEIwweOWWj88xUhjluaQMlGrsioAwt/fMS8KW2xcLfHZ9GORQ9Uh/ZqY7PHoDXuQsT3gx+yi2J8gpBazEakvnEYyOQoobpOQq+lG6BIZmlSu1VJvpcWQ/KoKexs0mO/p1Zw86kV4WZrsyYUgx30u4B0JNPbBCYrm9kk70URR2iXYF+PuA12itkDoJTbT9jLClJ6Hnzb21xTCdOfKy3FrmFF/RX0F9sh+q+yQnQVtte4EOVRJy9RRvXinbaMlkfd6JbjnfoJMoEILV1NuAypcNJVWosVp
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4330D44800F9B5E276C5D18BC72A0@DM6PR02MB4330.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4330;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4330;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;4:EdKOWndz0CAt/GlkjxeTXO1a6az3gihssazZX+S86hwSyL5Or/Rimw0AdT4H4t30oUGsC90Fu+tCoiMxp8Kc7yYN7jxgT9Pu2rpUe9L1MyUCRM7NCg4gkAnT7CyMWPR3Q8gt8c2XFZpEiJcjI/EXoA3ixcw5OEKuPIn5zokWS+oaRipp7zCy1Jp/vl74h9n6EgfAjhdCDUX6Blq5kXcXfx6xQD2NFcU0Bjrl4SwcQZEoNmUzUE6n/t0LWo2hcyjF22/UWgq6JN8mZUKCSzjX5CBh6raFplfTL2a7vw3cLLrjIoCaKWwPDd9L/cdLl7sc
X-Forefront-PRVS: 07467C4D33
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4330;23:jTvQw60VvfgsR8nwVu6hUT9tiVnEi/T9Cg7H7gOe2?=
 =?us-ascii?Q?Uj4iOv6Twjff0aAhhKEYB6RGsY4eI7FQiMd6iEjTkaZTW+/ZBHmqsvia6jHi?=
 =?us-ascii?Q?B7bjCHk6cU8AxMTB0NJ/Hd0c5zpM3qIBbAC7Qe1YecCfwFX1k6hSrltKYVXk?=
 =?us-ascii?Q?RmS4q0VPsbEE6CuZQ4yrq4ZN/W84vyW0hOVGgOB2SbHpjadGha4Kb+oVrKqB?=
 =?us-ascii?Q?/hvPIyKz7TaZikEg6ri1+8RIUUsPFb3i8fjvag96VZzWk5hFS6ze4XX3k5Na?=
 =?us-ascii?Q?Ox39oA1bsXzXpxwuk16wv2/k6YKDjyTWFpO1ZJ/Ytw35oj+bhtncffnNG/c2?=
 =?us-ascii?Q?rDkydfD5H+lHTN0PY+dUNcLNut9JOV7rAQwfVqUDtr8faQoGgGhWc9q+KfLz?=
 =?us-ascii?Q?uzmoLv+dKeoSKdBwyZOE+ssYSh7fMcySf7Wz+hj3gtXApiY5mUyJb20K5cxN?=
 =?us-ascii?Q?fUvnO1DWk+mODZ9J2OCKpvqKnPOlVuh04WrQ57FtMyZam3iqoVrYyhrnUr1o?=
 =?us-ascii?Q?XRJfa04JAqfofHhg7hK1ypXCehJ9x+7knukgZgIhz//KCO9zD9vOCTBQf4YZ?=
 =?us-ascii?Q?03pCLRJmoO7T+tC+TWrj1cc0zGcmfNFutBcerJ3d6UD9em9Yc7rwAjj7+ere?=
 =?us-ascii?Q?CY8UDruBY04qPK2BRnOQrZClqucyojw3ZA+VT88FsXItWfC5SLNHK5Nex+cR?=
 =?us-ascii?Q?KBtfxlSpkcvmKNqHgh4hsIk7zt6gvPDySJtvgS+Fu7lHAHh+aLoWqGeIof8J?=
 =?us-ascii?Q?N+LIZ/thsNnjMgCZRu6nWobO0FBUqG5Utk27t3Hi89cldpwjhhwpBHHNyfsu?=
 =?us-ascii?Q?9Ov25bede/GZozia9sMp3Yj4G2AYj+eh8MJkXHOzEkQG0tJHSHpT/SCYohOD?=
 =?us-ascii?Q?eCYLefwxENZNYyUNrfIIssfPNGDUneuqlJxH+JzKsNX33lvvxVqv6fA6DGDd?=
 =?us-ascii?Q?j8pGXgbpNd/Blab8AOvkpxSgLA3RyqCoSWGLSBbS8qbyNMe2D4QuYPSvxSHm?=
 =?us-ascii?Q?D1iYY6UeSJ1VW5p0deg/rkEMENho7d1ZUAUyc3dZHUk/K/XVGMVcr7fzpN0a?=
 =?us-ascii?Q?8gwuq86OrMiyG5B7SehXFXLMXuclk17TEdM0Hm+E4raBozgQZkGx2wyEd81m?=
 =?us-ascii?Q?HaPg42GWonfH3lWonYkJ3i1+Anrq2tC5klKEKhoSNSZ8vh/FeDfPQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: qRL5FG8z+CbF6f6ntxveGi7QpzJ7rwmH/DLaMlq614njm5HTEkW//8Qb4WondMdmD0gjALKB1664+LPY9Ucn+Nl3JE88KAbQdRvF4c1gWQTksvs1KURreMorn/2LUcT455oGFMJ5WoJUPq1w8Uzw1zAKX/r11VDRBEyHz6xM5st9kIM0pXnPiRnrsjZLtgbUgDkqUmMjzrKvMMDYd721yXJBLwbPavhHc/9jw7CJqOvyWHSnznBZvBiGVibEvb2Ks237Rb5krg/OuA2NpRjZRoCYtD/iXT//1ayoc5397fdCu8kxXz6rKWfv2WA4PyKtqvn6ehR9j9GdSf44SPH4BpjkdWhHuEOPDL86OLvVsYo=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;6:hr/oAc4YKDT0DEy9fwwCt2CYmnJ/PFFV/Xzv805kMBI7LiILffyLwnWc+prAHUtii7TdQHHWY0z3TaSD+iRDS6wYahVExUGeGE2TMGGBL/2h6iACgsW3pPZbiu86fQCQ/Ze0Bug8PlZAH0vOFupEPPU59miZ5ErlK+eYANmYdtJEbT76QO+AwdQbK/OFLKk8F35W5aHGVLkHZRUB6n0DN5yhddXEV1TPSZLocetsSPVDNNwEUKz3hWS59PJESW/418SsP4+WuRBw8ad5MKqH0gG9sHmeLwhdONqh/nwhPZnQIl30u2XdEJS7OycXe/v6qubtbUiKMmKm+GMumxV929v0d/D318ceqKbpEKcJ1+TDhE+KMgySumFJTO186JrE11UdCCWWKOJYmdQ2gcC0QSdFX0cSS5JpH09FU1rY8rRCmiQO8rJLf9IR31AGl0ZVkTfGsiLQItvXmPfZR/WAmg==;5:4cwoFyxCpawj2qu53PXIU4NNGpx2YqRIeq9AFYXz+Qho7Gw4SBaHUnipJ6DNOp3cqGtswWxvEvvZ00v+JQLsQ1sXCDpcuOD/mNX1htQ3YcUErZYm+O6X1d6kFhEiscLI16RMRRcQIXDioSN4OG+sWwoD38OwZ1GNZDD/6OipsGY=;7:NZYFguhREujPAFSP7fHZAuGmuHDiZckee1DT2V+Sm0nLRyzfp9vc8MGw+XetEt8Zq5IbaABqFdG8o4s8LZqCTA7iJO6WX/otX90khoys8fPMsCKt5uP8+RQFU+6+1GynSXTOfurzO33aEvprZ9TlFIrSrbyOcvNmXcpuRZvnQKPsDVXvpQU9Nbak92utdzUeaB2FOhK0EbGwk9FeYEjOOYqcjsy5ceMvsGj04TW6uye/jrZxbI3Q2FwQ2/FOj5cT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 10:50:52.6291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3338dc3-ef6e-433a-ac37-08d5f3aed3a5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In axidma alloc_chan_resources merge BD and cyclic BD allocation.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index c124423..06d1632 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -887,6 +887,24 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 				chan->id);
 			return -ENOMEM;
 		}
+		/*
+		 * For cyclic DMA mode we need to program the tail Descriptor
+		 * register with a value which is not a part of the BD chain
+		 * so allocating a desc segment during channel allocation for
+		 * programming tail descriptor.
+		 */
+		chan->cyclic_seg_v = dma_zalloc_coherent(chan->dev,
+					sizeof(*chan->cyclic_seg_v),
+					&chan->cyclic_seg_p, GFP_KERNEL);
+		if (!chan->cyclic_seg_v) {
+			dev_err(chan->dev,
+				"unable to allocate desc segment for cyclic DMA\n");
+			dma_free_coherent(chan->dev, sizeof(*chan->seg_v) *
+				XILINX_DMA_NUM_DESCS, chan->seg_v,
+				chan->seg_p);
+			return -ENOMEM;
+		}
+		chan->cyclic_seg_v->phys = chan->cyclic_seg_p;
 
 		for (i = 0; i < XILINX_DMA_NUM_DESCS; i++) {
 			chan->seg_v[i].hw.next_desc =
@@ -922,24 +940,6 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 		return -ENOMEM;
 	}
 
-	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
-		/*
-		 * For cyclic DMA mode we need to program the tail Descriptor
-		 * register with a value which is not a part of the BD chain
-		 * so allocating a desc segment during channel allocation for
-		 * programming tail descriptor.
-		 */
-		chan->cyclic_seg_v = dma_zalloc_coherent(chan->dev,
-					sizeof(*chan->cyclic_seg_v),
-					&chan->cyclic_seg_p, GFP_KERNEL);
-		if (!chan->cyclic_seg_v) {
-			dev_err(chan->dev,
-				"unable to allocate desc segment for cyclic DMA\n");
-			return -ENOMEM;
-		}
-		chan->cyclic_seg_v->phys = chan->cyclic_seg_p;
-	}
-
 	dma_cookie_init(dchan);
 
 	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
-- 
1.7.1

