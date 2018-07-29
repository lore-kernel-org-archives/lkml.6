Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08CBF83CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 07:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B19F20842
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 07:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="hU/2+o3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B19F20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbeG2Icw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 04:32:52 -0400
Received: from mail-eopbgr50065.outbound.protection.outlook.com ([40.107.5.65]:7101
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726157AbeG2Icw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 04:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GZeN5tOqnKVn5R/gWUUMFUv9GJNIw4q+rSl5GG1egU=;
 b=hU/2+o3yGt3doGstJCOuL0v2IW1LLiVRW4muBBTiG78FkPTjWJxBrgNxGwI34d4aZelGPT2P1xulfBHNJbCdjEXOhxAKGa4n8DJG6R2wNtfF67U/wMl+Z2mXzKy1o6r0UTb/qLiednVguMupOcBXmmKcR3dgBmA+DhJ0b27Wr/s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from localhost (193.47.165.251) by
 AM4PR0501MB2690.eurprd05.prod.outlook.com (2603:10a6:200:5a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Sun, 29 Jul
 2018 07:03:22 +0000
Date:   Sun, 29 Jul 2018 10:03:17 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     rd_dunlab <rd.dunlab@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Elad Kanfi <eladkan@mellanox.com>,
        Ofer Levi <oferle@mellanox.com>
Subject: Re: [PATCH 4/4 v2] arc: fix printk warning in arc/plat-eznps/mtm.c
Message-ID: <20180729070317.GD7157@mtr-leonro.mtl.com>
References: <15326613951079@infradead.org>
 <1532661395133@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532661395133@infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: LO2P265CA0116.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::32) To AM4PR0501MB2690.eurprd05.prod.outlook.com
 (2603:10a6:200:5a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b1f509a-25e7-4a86-38a3-08d5f5215f98
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM4PR0501MB2690;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2690;3:GR78vB6uDf+LqzzVxGBcGER+oCcAwEVXOStRqFwnXKZFf9OnJSp9ZSNX0InYE2kyAdFksjXtIwnlh7s7T4x6KManke1ssy4gySSJkWiA2WgeGGeNfx+/jidY51y+pFR+8EnV2pIdY2vC8uJmo5lIfjvDNVMrf0XJOMaFmg+JLtywuTEuZx1xYE6UoUBANEiN0KUmOuth4J2NPxx803qhrhvDCbuRBn35uhu5QR5/tB0r5KJ4aL/oh6g1Fj5Cfsb8;25:9tcXkYOZvEyFGhDyjH9u+eL7vslXHm8R2D366mwFPA636DPHZcXPWoo/W/aaFUE425vwQBDxhKGti4J9xNg2zAe+6q5rFBpl93oRZmmIfAbcnJxP59/emw0EWEgTo1JtWsTbLBn4YglmB/vaSQGzz1t21hpRfPGsd9kxPvbCr7PfGok8uLPUWiLWEKFoMsl8SipgVxWrAb4HuRuGKdlc4RhCL/VGNzpMvhox0pwG0yIuc4aqzllXjK54fB3PDxdIdhhEU/Dkp+pfj4Trl99ALqRlhmrxDTUQaJS0p4iUgKxaEi3/aHDImLQrh48gnq1llUNCqdOGZqhjVnmshX21Pg==;31:JEHpi9YwfNC2Ryiv2nNSYn8N31k+HAsAyu28HreNz06arU92bYJA1mQB2RWpAI3mDb2zD27aJFwVF2dOHWbQrgeFfjvRWxY/CgnQZcwJvS8vaY1NRvFagLEjXBNr3PnwIAzBD2Hfoma1z/cihrmTiRPAHsh/NO024hU5U+TvOgH1/8RahRlTSwEWhz62HCe7MKs2m22+SpnfzXkeDxbqp3udrht2T1EOaFz2ToJGDIE=
X-MS-TrafficTypeDiagnostic: AM4PR0501MB2690:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2690;20:+z8v0Ew5s+juCCY2rHCPxPKopA7Dbo8WUaXepXS7mMZUGNDm1vlwEwYAkBgCCWSoNi6I2BEXbDCyfUrBZ1RP5aC3sMOWBKI9wwFGmUzOp2zBY3mCraPnQT+3ZXtP97pOCBpBi2lOGhJehg8TP/IeLD09NBdU2LorMsDFLJxAVTgmKRk0EKe+D/9W+OPVLJk9tCqkorKhHNYzO4AJQb2g+ev6gZxln5YOk/xJTUb+ACji8bg32997HbVGIIZOrEdo02ckkanBr7/lrsIBcnxUibH6Xgy/oAwz/ecl4ljR8T/FKHtqTUPUGBhXstY6eOtHiiNQQEP/tKcMwgTXCC99tlxDmnHamavxeiKWfCmq3ojJQWmEGk0hS4dZqjbyxczkypZgxBdGV4eqmfQSkOCAASaqda4U/4hFxJgzOWi5Ffaijh5M9D4YUyKF5DXs+2DXW0P47SqDcflZOJpRqcigFByTJvir0eIijQ6ymtnfldcKwfPRXTO2VsQaIDURqZHZ;4:wD49eEzQgUMDLfRR+KVovFSjInEbTn1ZlcxAEdY4FmbP/jCrDudvijE+nxsL6cop2NGiZu75rW/PY1s4HOx0QdBEVCnlWZPkcUeXy5XpT/Kj0wjOtZ8u4LDyMJ8Mn85g8HKPG2J4N4WSjJP498pkmame7M306l2J9+UD3ZSA+p/Rn5IYcJA1AEkQA/K+C2Iy2hqyWpcUZoD7RV81hyGD58eFget4dspFthjsm0pdFpE2g9ATcSEFJaxTxraAI3PxsjP5lMuekM8rt/WJvUhBwVlI9GNxkknaEPt+QS8BWpDjACdQkSKP5Ed4qu+L0hD1
X-Microsoft-Antispam-PRVS: <AM4PR0501MB26905B563BEBF0220DF147E7B0280@AM4PR0501MB2690.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(258649278758335);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM4PR0501MB2690;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0501MB2690;
X-Forefront-PRVS: 0748FF9A04
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(376002)(136003)(346002)(39860400002)(396003)(199004)(189003)(7736002)(6916009)(50466002)(2906002)(9686003)(39060400002)(86362001)(23726003)(6116002)(1076002)(6486002)(3846002)(4326008)(5660300001)(478600001)(6666003)(316002)(305945005)(446003)(11346002)(486006)(97736004)(476003)(956004)(68736007)(186003)(33896004)(386003)(16526019)(8936002)(81166006)(81156014)(106356001)(105586002)(53936002)(14444005)(76176011)(52116002)(58126008)(16586007)(107886003)(6496006)(6246003)(54906003)(26005)(66066001)(76506005)(229853002)(47776003)(25786009)(8676002)(33656002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0501MB2690;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0501MB2690;23:Ms623GZ0wQQOpGKUyv6ixVVdBdcTBCT5EGjwV0j?=
 =?us-ascii?Q?V4JvJ1FXGUxSiAGNg4YrsJjZIKPiko1skNxXEK+wLjTEklXblDr38FZRHDmP?=
 =?us-ascii?Q?lv7/u4SLYPw7NFpSVCZrGoEOa6t3gNzF8E0SloZTBNB/+E6fbNrjqZUdc2v3?=
 =?us-ascii?Q?PMpk+eInjA0CeyzBlJAjToO5/fwNNL+IuwH5qpQZpHxFccIQhVvFwIXRIsdI?=
 =?us-ascii?Q?cbCwVqeKBnsWqghT/+E/TodfvelzHWdzpLnzISPwJJOsofgjU/JCO0YbqrdJ?=
 =?us-ascii?Q?UmMM/ifptR0blY7MidZo7S3jp8AXPzPRMrNGy5jVUJwBFSzYU7A2158hMx8A?=
 =?us-ascii?Q?nCs7qpnn4aHG7dxjcxQzVCZcbN2PV73H88/AgRO0CELy50VVw+G3JWmwbbel?=
 =?us-ascii?Q?Bm/sARStyztURHSAE1CdIfSZae3dvzP8XvdALVfnw3vSF8wOBaKqzBmXb+jc?=
 =?us-ascii?Q?IP3zIQVwRqyU1RJ1fJOGm322mrW2R9URc/cfpDoQkdDET0eSnwgElyO7RIs6?=
 =?us-ascii?Q?EH6plUc1cx1S4BWLo23ieCwe/BvoXB/go+duDHKl0deoDx9i8JPF97mAFlyi?=
 =?us-ascii?Q?Crr9LGkMskPt1Elk59xi73PayI2AsaLScpUq3sGh81lF99Ui5ksi9a+ov7Za?=
 =?us-ascii?Q?CxsTFEpEL9WJzQ4mSaTW0+vFqGDbBB+6Pexl1YpbcK1CLTLCiKXoXwe5hk/q?=
 =?us-ascii?Q?B4YYJIv+101EFKxy81KWcSsyYdIDCgWIYpXarlTGxZJYlEwVFidiASRWFDRh?=
 =?us-ascii?Q?o3itHyQSVcA7e39Vrsc4eCBEQSo7J4a+EY1lq9zWmxxx+1d2zK7eD8ii5nU/?=
 =?us-ascii?Q?8/cCHcoULiMdD5WirgaNnPXdNLugEvaLryr24QxuXg/NuWgs09fMrrtBxl2h?=
 =?us-ascii?Q?ic2lTbQxXMSRlkP4zJf1n4pFeG6BNCoKHpxLsQb684DbA6V/b9i8/0n7Gukn?=
 =?us-ascii?Q?leA0QKJ9qwmsn6UvQltFBlTG+vMRFPjh3CwkGjCTuuDZ1W+mJ15ZyfsFBhJ9?=
 =?us-ascii?Q?i2SiLqyAKM2/qbI0UsjANqEovMI4D+v5MxJzT8HQUTggWAiFRWFtBFoLloQY?=
 =?us-ascii?Q?LBaSDt6/ZfLB4WeQiDfsMA+Qg3Q27+u2u/LhOZFU6a9HkAiWIONApi/LEU7r?=
 =?us-ascii?Q?1wpLl4rGnI01BlWCEptDt3WJFvqD1Asgr2dcsxItF5PcjRGJcZwupeQFNP32?=
 =?us-ascii?Q?T4t/L3idRNjCxCw5DwKDw5oqVMJQDZGzWoRMmyqfq07GETmZ8fiogKrV4xPJ?=
 =?us-ascii?Q?Sadp8GgqSwnMweveRLt03Slwv3shW6/VSgfcU5hQP5mBHhNtHWOjEbXVYtVp?=
 =?us-ascii?Q?qLwXUgfnyc63WwYac/7p+cB83ETrDnU7X7EfdTOyGTy0igWoJpA3U1bX/7bL?=
 =?us-ascii?Q?0qdYxIQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: mMIBg752wjKSy8a4wuq0aIdMflPzixZegsquuBs1b1dfmVX1FG2gBHn6lufKc5og8a8m3FfWhCQ3PP3RlPj1xI1y7AzAdE/EBJL35aF/8K8XPUL7UZWHZ9L8uvEQlg8pbNaZBF1xBqn7LGu0tEC+IlP4sZFhp2+kuP0UVDq0eLW009ECt9Y9FUAcRvjajc8EyePB2piHlvt3LmjKvic4jG622xqEUAt1geJR3Lo+S8EOEwz25orVLjVFiDhuT1JPxBL5mYphr2Q0Z8PgfMsAin9OQMeD3frxfdScYkvLR3O7xA1WhSTez4EoCPg9Rqauqei3QtWiYI7/sLNFsO5y75FQ/3BJIgMWipOerQOBSMI=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2690;6:GFEDB9IyNirKuOkwpOPE/gWqmXpexEBrUfUZmzuq/YNkxrXglZvwxjLqxdiD91C196AqK289ivGvK15+FP4WUJWirHOo9eIBKsHITQRtkO2j2AiIvQUtXBPjyQfTmOx1VML+lCIVPJfJVE5D6YD/euOO3YO1nv+hKo2QV9fMT7aWfr1oi8iqNcq9xkckc69WH5nMS2i6s+6cz0uVEhhkVxrdrilzyKTnbdNwwvJbxZfDwlJBMvyOamhlwcdtND3IhxIuTI2Ln2llz1mJAlWD8olDqDiEUKrhFuvuBopnIUxVX6a3OvVFMj5V3FD5ECVQk+iRuW2QxuJ2f27QImRa6ugClxp+BhpvhCgGZgepn8msq4mhlDOu934OKF6w2n/OZxdPPdAgVY1w75CkBqkYa/KmURFy+XG5XytyavTfUuW3o8jD/mY0bEDk1xleHgpxselJNXTnZEqh5JboCJKKZA==;5:tfaeOqTHv/OKdBTEAwyogFnNyO10RD1m58D0bT4YxZXtbX2dkQcn98wNLN/QhaVJ19uR9w5lRVANIIsFQvAi/WiyPU4yf6SGbu5s1hKsTSA5lOd3WAJ7njD7ttKIhvk6eeaO/XhungOwllRros9qaKirFDqKEKIptVUS6UiZSP0=;7:sSlszQ1lM4mm9h2Pxg+XE9rD0NNuO0h9dXWFo761OTz10HOyYzg8wLtwQ6ARb6RlOwyjO0I9VoNT4Q/je5aVgkbFNfw9LXbToQAIpV1siMUssGdvjKPki3a85mt+8jza9cIJyjctyCg/ah99qhpQbXbXggrewe9w3PaoIfDX9RrMYvPR33vsH2pD9ByFdHmoNfaHkdrVZGFuvkSw+cYL9f9Dm6MrIU5ykf9ROUV/1aie1Vi/Gnxpr41mV0AxB6wG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2018 07:03:22.7168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1f509a-25e7-4a86-38a3-08d5f5215f98
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2690
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 08:16:35PM -0700, rd_dunlab wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix printk format warning in arch/arc/plat-eznps/mtm.c:
>
> In file included from ../include/linux/printk.h:7,
>                  from ../include/linux/kernel.h:14,
>                  from ../include/linux/list.h:9,
>                  from ../include/linux/smp.h:12,
>                  from ../arch/arc/plat-eznps/mtm.c:17:
> ../arch/arc/plat-eznps/mtm.c: In function 'set_mtm_hs_ctr':
> ../include/linux/kern_levels.h:5:18: warning: format '%d' expects argument of type 'int', but argument 2 has type 'long int' [-Wformat=]
>  #define KERN_SOH "\001"  /* ASCII Start Of Header */
>                   ^~~~~~
> ../include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
>  #define KERN_ERR KERN_SOH "3" /* error conditions */
>                   ^~~~~~~~
> ../include/linux/printk.h:308:9: note: in expansion of macro 'KERN_ERR'
>   printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>          ^~~~~~~~
> ../arch/arc/plat-eznps/mtm.c:166:3: note: in expansion of macro 'pr_err'
>    pr_err("** Invalid @nps_mtm_hs_ctr [%d] needs to be [%d:%d] (incl)\n",
>    ^~~~~~
> ../arch/arc/plat-eznps/mtm.c:166:40: note: format string is defined here
>    pr_err("** Invalid @nps_mtm_hs_ctr [%d] needs to be [%d:%d] (incl)\n",
>                                        ~^
>                                        %ld
> The hs_ctr variable can just be int instead of long, so also change
> kstrtol() to kstrtoint() and leave the format string as %d.
>
> Also add 2 header files since they are used in mtm.c and we prefer
> not to depend on accidental/indirect #includes.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: linux-snps-arc@lists.infradead.org
> Cc: Elad Kanfi <eladkan@mellanox.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Cc: Ofer Levi <oferle@mellanox.com>
> ---
> v2: no change
>
>  arch/arc/plat-eznps/mtm.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
