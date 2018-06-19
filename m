Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAF6C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8262E20883
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y9JWOhcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8262E20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965654AbeFSI6w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:58:52 -0400
Received: from mail-he1eur01on0087.outbound.protection.outlook.com ([104.47.0.87]:3242
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S937494AbeFSI60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpbCtIlhOduohHM0lr5Cs/2jY4uvyDpyo/o6FLvHZwM=;
 b=Y9JWOhcTArxeMw6xiluD8XBVqcF9RKpwaxo6dLpC6Jn/cY7eFw3zsaQDzyiJTu0SsbN1Rf1Mj/GppTcOrfmEPzuyufx1nZH35YwM+TgtUXHcb+pG8DBDNme3szTeDn4XsRHHwhiB/cU7yjhqsf0WH2fM4KU8HhfpLooHTcQc2Ao=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3231.eurprd04.prod.outlook.com (2603:10a6:802:6::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Tue, 19 Jun 2018 08:58:16 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v5 7/7] dmaengine: imx-sdma: alloclate bd memory from dma pool
Date:   Wed, 20 Jun 2018 00:57:04 +0800
Message-Id: <1529427424-12321-8-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0073.apcprd03.prod.outlook.com
 (2603:1096:203:72::13) To VI1PR04MB3231.eurprd04.prod.outlook.com
 (2603:10a6:802:6::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7783f25-4c9a-4f5b-af53-08d5d5c2ce21
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3231;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;3:flmssNHmeVTTv/1XHQzCTvso2ZTxBPsFX9ZXeAbq6tBmtPZjlCEhK0skIxQUDQTUj5vZu0IvVA7ZiIndLi1GVLMDOM62s06FPDk6RKTKYUPYsQ722t0QV5HL/JWvJgmFKVmNITIlEdmCzHMwJrXKtc834zHSjlcSIbx9aTuLlNIZQwda+noXCWXEjZI776a5iElmAWunATy+Avh2Sj57L8Z6ZSFtThR/0cf0g3I7U4QwH8C12dQLE0wOgynMcN9L;25:/6+YjmK2ctI/LrKfXRmEHqoBxkYjTX0+bph/vqAuxnGcZQbbI7by3elwWSwZOPLi0DLbakcPwVNRXafIMCD0Kt6vrUFa1wA9E5gFVE8UFkT0Xjmm7qRVBN2hNg9HEPZZ7MCeyvyGHPU7saxMrMdRiJ+36AXVvM1t6R5XBpkBrVrgBR8QzljmpDuxcr+pOQTRrvCOsrEPLurU2Y220/vQGSp2JPF/1ymwnycyhJ+PyBGbPR3YdwHhfkc/pQPr95k4i1IW+c1AEcjWLQzZmTp03aymbFPq2+urKWqEqQi5TBxBdnTsiiyxCvkq7ZpbQ9zn5sqW2pKkvpGSAKFi6Xflvw==;31:Qbk2Vtm2Nfj7e91iG7PATJvGtC8qUPXtUwQ38xlK2XERu8IfZk0aBfu/qAALBVdb+fevNR3+OqRUzGDLj2kvv77wLAZCRuofoN4WBKX/mXN6490aRJ9jTlCiVCdGqK/fZSKZ7cjzPlSNweWtn4rFJ6D4BbE0NXVjmk/90/l5R13qbK3fNPyXZIYfDhone5tc9XXkJBkeVrqKl9/ya0QRUDtzPAWA3sJTU8oLWN3V4Tc=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3231:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;20:cIUtBrhX+WMcWf9yFVw1lwd2Jj0gAh5yRnCC9Ez4pSSmF+uwrmbJ8CO4HEAMqL7vJnbRZbVD1ch/EmG/n6KFVWYn6HBoOrOeBKY1kxK6ny5fnUdAIzjMLS8jfPxahRUZBx4WRfthvbECamR03y4AdoK2mlgwBQmOvUj2L5W2L9wxWFuFZCaWCR3/hbFndbYSWMxzeOc9oAJVAaJluouzyKV4Z35k6kMhMrcbVU3/5PmJR6OfECHJfsLR26D9Tg7qEUHDsdHkKTt/6kGhaYR1tNMgspM/d7EuUO30jIjkBaQJTwum0sGznbkPU3qnxCwCYHbKZqROgR52j7LTkG1d5y9lNQ8l568na92hvILLjLehR0ukWv6aBNqprnCbRIg0nuhjSIMKgin544DChIqhx9J5Q8CXPr9A5fwN4ZUnOd0UHPyrqYePT34SqPwwKkilrqbZS/UqLcrcVs22pLqLiMbuAba/yEleImbLyXRQcldiBvSMWc/IhJFbeUHQD0nT;4:QEaNwN6pkwk5USj7s6RmSo0tncBMYIkmCZ+L94NDDwzhlsyLpJdyjERehTHDFhtcSZuXKpTcJUxfvNu6TsT+oV+JwYRphsGI7l9a33LhcCr1Ehign4tF97Hg87nUtqWGAJaNBZpPeVoVGtKhJzuWjDRuL107FHNAnHhgxlGzugqgtVaWpc/QKQGgtZGdOMn4xGezU3c/p9AT8+hLENIDPAhO/q/O2U/VSIeexSlDN4hBaymGM54/B4kWFoKwRTruyRoN4XA3wdnfm3BavmT3CMAOaNB2yFLsEHsiVLQhf4U5KGemOIMls4et2NNh5ofD
X-Microsoft-Antispam-PRVS: <VI1PR04MB3231464409DB2169EC07AC1D89700@VI1PR04MB3231.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3231;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3231;
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(366004)(199004)(189003)(53936002)(6512007)(5660300001)(478600001)(386003)(6506007)(59450400001)(26005)(52116002)(4326008)(25786009)(97736004)(51416003)(45080400002)(76176011)(68736007)(47776003)(86362001)(66066001)(575784001)(7416002)(6666003)(105586002)(36756003)(50466002)(6486002)(48376002)(106356001)(316002)(11346002)(446003)(476003)(186003)(16526019)(2616005)(956004)(486006)(81156014)(8936002)(2906002)(3846002)(305945005)(6116002)(50226002)(7736002)(8676002)(16586007)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3231;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3231;23:DR0imgYRqxkZzOBiEO3vuFnJ/UkJnX3kVQKLGKGq4?=
 =?us-ascii?Q?DmuFzmdGtcSBGD17MUHQ7UzGllda4lGkaqQU1ILZA4dpp005TY9xzqCuKEs/?=
 =?us-ascii?Q?qlmglwOwdfbB5Sc5r9/BCRnxzRqFIn+e6RhkQNaT3kOj7r/pUyjUHoo9GF4V?=
 =?us-ascii?Q?Pks3taeLSi18g2Satc70r0EYmWmnoZvq8iLGg/zwjxbeV+cMNKNqgwplVDYX?=
 =?us-ascii?Q?cAOZWJlIJeuuvAUov8D2Y67lH6FKBc+39Yjlf1DyIY8FEmu/bnJYwT9OQqZc?=
 =?us-ascii?Q?3ywyc1QBMdJjpXRw5xM0WWIEE2X9ysqo4/wacPr4nHFPZd2mwPmiuO5oQUFR?=
 =?us-ascii?Q?60Kkma/Zm5gYPam4lfda4YVW1EV/IuxbrVGZG2+USgqOExBo1qqQkB/ARDWj?=
 =?us-ascii?Q?Mjk9JrcG63LW8rsRjf3E5GAAlU7MTyquaqik8EfNFaUMkga6YAZCuuKjUUlO?=
 =?us-ascii?Q?CeBJq9v/59WwRVC7q5so/rB6FbTIov3CUNuD9xhJ2pJnUJtTZul8IbbrQCXG?=
 =?us-ascii?Q?d799G1Z6URzsvQFMdqf5ngyit3rK/4N82KzW4Iyn7uUDf2UNGE/W5B+7gTIf?=
 =?us-ascii?Q?GMHLFnA5DYJLRIiojTjTKPgjMuewe0TT7RQ2m8Nm0tKQjK+rOfj6O+5yihpb?=
 =?us-ascii?Q?0mR7x/CURROOUIFUi44msK6igfDNXAiBAuwQLUEvkLHzyiE3shUdGlhbRZ4L?=
 =?us-ascii?Q?zJN2Bkgmx6dPNl7ZSwXLxpn0hGEQ0Ijt7yY1dV/Nbq54aI30rdFe05r9bxX2?=
 =?us-ascii?Q?kxWb8LYvUta27reWvXaeDhy7zyIuD0gHStYi81tJtoxqX23ayQrCIAZp+nnb?=
 =?us-ascii?Q?jKcfh6qfjg7dtmLPdfK8D2MFk945KxxomAgZcwsvtk5mbJxaYXnnljZebzrD?=
 =?us-ascii?Q?wuMfpFL5hg0+bIZXhq3eIFDLLr4iEP5G3QOQ8mNLBt0kqFlLhEEiO2o0OyQC?=
 =?us-ascii?Q?cM+3SCUVKFNihEtYSgssr49EVq+wKiT08Cufhc9N8lAaF2QPhoS7M7lIiQNq?=
 =?us-ascii?Q?SrPPirjSehPacoWwONZilMRssDPq7J/9G/O38t1cdCIsO6Ayc7V3C8yMzIol?=
 =?us-ascii?Q?OUxUaQFVF0F9Q3CE+xrCggREMkKfFihxV/HGitCj5UBgV4+LjpMPCIgpD1LR?=
 =?us-ascii?Q?q89dD2RjxyfdjTs8PpXgFwcLVs9lP7plx1x1d0zjIxv1L+3W01DiFQ30NqFw?=
 =?us-ascii?Q?dnQtGgVDnAPGPG1oTsLVoHNcR9lTp1lksMtBrWn/CVLLFZSb4vUx0nu82INN?=
 =?us-ascii?Q?8guofA3mzJaoPpu2L4=3D?=
X-Microsoft-Antispam-Message-Info: b6qlk/qMNQXA4Y9LDcv3m3zlPPVN6PrtB6RrM2eYNaG11jE+YRBaFGTES4pbGwxXZegr9dBHMkCFVQnK6LdS9dbCtAZRLkV2EPD4K3cwCDup5z+RsC5SEBDu/6qOOnc17GQovj1kz/yyhuZtynpF/gXEQD9cfYgQepeCeh4OuUYm2KfhBiPPbO2xX/hjxC4fHext+zPpl+WKKvb4hemVVf0sAQoqb0uMfWx+ONkLDju7lix1FW0IMgvhkoBdHtxWE5p3fpa2jY96o/FIeTL0EiP6q4btsxO7HrIW2hXU15J7CzfBSJvmuLRn7y/Jc7vo9vC0le5sAJTry+gsDtZjoQ==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;6:+NDVyBUhtFJejvPLh0RboKe313BRNstla/IfDUcBFCmfS/FoJXd7xgpq+CDFXOmsvgR0pyTPNgjD3dJa9Q3uI5FOi3C4jMxUNUlkL+WdnSqkjOxtadv0iN2wrHiXQtJgNMXSq6URi9MAMJTacEwRY5Jny0Q1rZVInx3vi7FMmZSsFx8gpxBzqUIJcPN6qlGALEYNUfFqk7ZBqCa8LU5reFfz6bUt+FvIiy8foLv6fP3MzMO/yW4gOtGS9edzMnJmwBEIhfpjRG5IvtjPaPYbo6GC/CiN0TkGWBuXM+ADq/ddjtGk2ca+GUzyX32Mrn7LuAb6gogmzR+Ubq9YivL6ybZrtublogL/nrOKgDS0V5dFl8lF44jjljEctr93t4N2bTcXJcXEPpVxo8tkCJq+MJ4ltK7uYfK90V3nJ3YrAAAAK7NO1SvmqpG224UGCmu0unk5W5EMnucly8lVXJhceQ==;5:Ba2DOwzM6bdBvXNKMpyOeIZMU3EfGj2p8AeumEA7kYJJoSnnPveVFmjXLLEFC89Bxn+caSEKcYYhFwjQQzNvZ5RyG2FWqKHIZYpJmQVWRZcFc6lyKO6ptsNCua/QGCesaW5p4FprIJN6z0sVU12kY2JQhOfVrDM+Yaooa8bNd64=;24:0foX4qLj5LngceU2v7nmdGPvHysHaI6zYg/nKf8zdlyCXi62a+mDVNgTEda4c8T71kgPAuLDozc3rnS7q3FHkHewW+NVmCU4Rr4eM/qBxrc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;7:1qyl52bRlMcm4ByXcYGIMICypuYdWvi/sybg69Vka3J67Fc96oQ/SLX1JvMR9zpRsRfgOL/zLT/IpUEwmomm4NtSpnfCWeGg8xycFaLaRjU3Y4ftQTOAGNnlaY9w2jux+Lbbggn73UkrsGP7WjiW44L6zCM2QFrHYc1ssESoBIZ9ecwRAD6uszijpMElsM3LGcMPlTy1Cm4H6RTiCRMhyoX0DPjGKTMxujh4BW6Qd+iYdfNscFeColYklLzrm16J
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 08:58:16.7705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7783f25-4c9a-4f5b-af53-08d5d5c2ce21
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_terminate_all maybe called in interrupt context which means
WARN_ON() will be triggered as below when bd memory freed. Allocat
bd memory from dma pool instead.

[   29.161079] WARNING: CPU: 1 PID: 533 at ./include/linux/dma-mapping.h:541 sdma_free_bd+0xa4/0xb4
[   29.169883] Modules linked in:
[   29.172990] CPU: 1 PID: 533 Comm: mpegaudioparse0 Not tainted 4.18.0-rc1-next-20180618-00009-gf79f22c #20
[   29.182597] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   29.189163] Backtrace:
[   29.191685] [<c010d1e0>] (dump_backtrace) from [<c010d4a0>] (show_stack+0x18/0x1c)
[   29.199306]  r7:00000000 r6:600f0093 r5:00000000 r4:c107db7c
[   29.205029] [<c010d488>] (show_stack) from [<c0a5bba0>] (dump_stack+0xb4/0xe8)
[   29.212312] [<c0a5baec>] (dump_stack) from [<c012703c>] (__warn+0x104/0x130)
[   29.219411]  r9:ec3e817c r8:0000021d r7:00000009 r6:c0d1d440 r5:00000000 r4:00000000
[   29.227204] [<c0126f38>] (__warn) from [<c0127180>] (warn_slowpath_null+0x44/0x50)
[   29.234821]  r8:ed129dc4 r7:c0b01978 r6:c04d4e90 r5:0000021d r4:c0d1d440
[   29.241574] [<c012713c>] (warn_slowpath_null) from [<c04d4e90>] (sdma_free_bd+0xa4/0xb4)
[   29.249706]  r6:4c001000 r5:f082e000 r4:00000024
[   29.254376] [<c04d4dec>] (sdma_free_bd) from [<c04d4eb4>] (sdma_desc_free+0x14/0x20)
[   29.262163]  r7:ec3e8110 r6:00000100 r5:00000200 r4:ecf89a00
[   29.267873] [<c04d4ea0>] (sdma_desc_free) from [<c04d229c>] (vchan_dma_desc_free_list+0xa4/0xac)
[   29.276697]  r5:00000200 r4:ed129d9c
[   29.280326] [<c04d21f8>] (vchan_dma_desc_free_list) from [<c04d482c>] (sdma_disable_channel_with_delay+0x14c/0x188)
[   29.290808]  r9:ecae560c r8:ec3e815c r7:00000000 r6:c1008908 r5:ed129dc4 r4:ec3e8110
[   29.298605] [<c04d46e0>] (sdma_disable_channel_with_delay) from [<c07c5c84>] (snd_dmaengine_pcm_trigger+0x90/0x1b0)
[   29.309087]  r8:ecae5000 r7:ec940800 r6:ed31bd80 r5:ecadb200 r4:ec26a700
[   29.315855] [<c07c5bf4>] (snd_dmaengine_pcm_trigger) from [<c07dd800>] (soc_pcm_trigger+0xb4/0x130)
[   29.324953]  r8:ecae5000 r7:ec940800 r6:00000000 r5:ecadb200 r4:ec26a700
[   29.331716] [<c07dd74c>] (soc_pcm_trigger) from [<c07bc008>] (snd_pcm_do_stop+0x58/0x5c)
[   29.339859]  r9:ecaed5a8 r8:ed31bdc0 r7:00000000 r6:00000001 r5:ecadb200 r4:c0b9c4d0
[   29.347652] [<c07bbfb0>] (snd_pcm_do_stop) from [<c07bbde8>] (snd_pcm_action_single+0x40/0x80)
[   29.356315] [<c07bbda8>] (snd_pcm_action_single) from [<c07bbf1c>] (snd_pcm_action+0xf4/0xfc)
[   29.364883]  r7:00000001 r6:c0b9c4d0 r5:ecadb2d4 r4:ecadb200
[   29.370593] [<c07bbe28>] (snd_pcm_action) from [<c07bc8dc>] (snd_pcm_drop+0x58/0x9c)

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index f8becaf..7dab7e9 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -24,6 +24,7 @@
 #include <linux/spinlock.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
 #include <linux/firmware.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
@@ -343,6 +344,7 @@ struct sdma_channel {
 	u32				shp_addr, per_addr;
 	enum dma_status			status;
 	struct imx_dma_data		data;
+	struct dma_pool			*bd_pool;
 };
 
 #define IMX_DMA_SG_LOOP		BIT(0)
@@ -1153,11 +1155,10 @@ static int sdma_request_channel0(struct sdma_engine *sdma)
 
 static int sdma_alloc_bd(struct sdma_desc *desc)
 {
-	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
 	int ret = 0;
 
-	desc->bd = dma_zalloc_coherent(NULL, bd_size, &desc->bd_phys,
-					GFP_ATOMIC);
+	desc->bd = dma_pool_alloc(desc->sdmac->bd_pool, GFP_ATOMIC,
+					&desc->bd_phys);
 	if (!desc->bd) {
 		ret = -ENOMEM;
 		goto out;
@@ -1168,9 +1169,7 @@ static int sdma_alloc_bd(struct sdma_desc *desc)
 
 static void sdma_free_bd(struct sdma_desc *desc)
 {
-	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
-
-	dma_free_coherent(NULL, bd_size, desc->bd, desc->bd_phys);
+	dma_pool_free(desc->sdmac->bd_pool, desc->bd, desc->bd_phys);
 }
 
 static void sdma_desc_free(struct virt_dma_desc *vd)
@@ -1218,6 +1217,10 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 	if (ret)
 		goto disable_clk_ahb;
 
+	sdmac->bd_pool = dma_pool_create("bd_pool", chan->device->dev,
+				sizeof(struct sdma_buffer_descriptor),
+				32, 0);
+
 	return 0;
 
 disable_clk_ahb:
@@ -1246,6 +1249,9 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	clk_disable(sdma->clk_ipg);
 	clk_disable(sdma->clk_ahb);
+
+	dma_pool_destroy(sdmac->bd_pool);
+	sdmac->bd_pool = NULL;
 }
 
 static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
-- 
2.7.4

