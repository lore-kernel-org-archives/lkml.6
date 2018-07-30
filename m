Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73F2C46462
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 02:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3A020873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 02:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="xRj+sWg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3A020873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeG3ERu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 00:17:50 -0400
Received: from mail-cys01nam02on0087.outbound.protection.outlook.com ([104.47.37.87]:41782
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725748AbeG3ERt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 00:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag0sO7GhFanVPdPoiiE8JctHsWhlnU6zp5wE/Nd4VVI=;
 b=xRj+sWg7fJTEyS2oRI7oh5qUbAwvkzLduatSiq56hH+UnRa1vRvjCOhiUK4bhX6Cz1KkKXwEdEbwUFzVgz30QYi9ejp4VeamW2iQhALbguUMaYhUTIbVSFsQFuNqQNor100xRDvsOAPmAYhO3ggI7QRhUcr4gge+sS8Nv22Zhq8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1570.namprd03.prod.outlook.com (2a01:111:e400:52a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.16; Mon, 30 Jul
 2018 02:44:58 +0000
Date:   Mon, 30 Jul 2018 10:42:28 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH mmc-next v3 0/3] solve SDHCI DWC MSHC 128MB DMA boundary
 limitation
Message-ID: <20180730104228.28b58bd0@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: HK0PR04CA0019.apcprd04.prod.outlook.com
 (2603:1096:203:36::31) To BLUPR0301MB1570.namprd03.prod.outlook.com
 (2a01:111:e400:52a9::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73c60931-f0fd-4d40-62c7-08d5f5c67159
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1570;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1570;3:TlvbDBqh2qqJtYRyYL6T6RDKBjLCvpZ9n8gEdiAevABROnixFtwUZQTaO07x951+/eUkYCYJ5S4mJNfE2aMFTIvd8TsCzAFj/N9eo5Bx2eePXE/HWmTDCItntvd3tOwX+1SUpoWn2GgPSLCJGPWtJpXwY2e9VC0gxL7cW8Rz17tEyGf+J7kq3hgwzvCmRJVk8z6Canay+t+2t1NHr+gmAAN7MdsrXSPN83PevFcJhVbyme5YJcOJl7Owoy1qz9UV;25:SBq4spQgqTCL7n6+831Rp6sy2pta+tTF0SI9YT+XyEQb59ewQ/AEtR0F/QAS9XQBIbn53rJLLUWnlJNYdfvMCH5Gxlmr2PbGLi/cJhCYBtKeCm2uXJgzs5X6Z5hPXy8v4f6q8I1SCD4YwoU4BU00KPhhmUbqEodqUO8EPz4sfNPiGMM0yDYkv2GiSn0Eje+tGmrrP9tY56/zr+VGg3r3JK3vZbtpCugrqGQgyW7iqzE98CYNBPzDhOGeJVG1nB0YUoXJY5r1CXGvNjTDXcIWirKSROaW7v44MXRCa2oy/ftYWZIF7A7gCQaeIV0ehPZgPyOR467EANy/iaGP8Zspqw==;31:Q9V5UKsNGKLs9FCcnvcbdRWHfL2YmJyGB7OBTKeCrRH+71kERTBqh7bN8wptdjdIoXMPVrxNCYnyvYHEoekHCkug1yvfbWeuPO70GJe/S7OkdQxlYTrGjTLtaVTRWZOPmO3/3Nahuf5wt9mvMseXqLPtMwhI29pQ/EfI05Gv82vFqIE2CtleB7AtizKBm4K9BP+Phu0Yz5mcrcaLJKiyKdMU++vI3rGEpareY2KiMqw=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1570:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1570;20:mJdjvoG3XrTZc7pCxYBl5UI+DkS0JUzCdFZXJUDLQ0FcXDOfick+Bb2lviosbqdkd6IoL46Qn81B3OUUsNOmO+OexBcTUqAtd4vOJOTLBwMSEHtbB5gA9Y3qRGRDPgofOC2ij2w7yroCPlQpU5g8N3uwiGjjVnORsrQhpMBgNKdM0KCInupRssP8uRvrRAlLpCINzG32EyJwnOPnMdAFY6gWngxprRVn2RTxWqxT4vlyohJN1DjQpu9G3UbAWgoWVxC7sBjNBPs9kWJqva1KEWUOeaWA4PcuajXpYFpkomjIHXvkSnGh78oI5Vr22feEDNNhuRcj3i1iiJ7IAek7JpzFFwEZ/PL1er9alz8uHKSMmWt312YSa6UO/1R+OY0MKm/tPvZWYKE7O6QZn3e5dEnmJchdugqhOeCQk2jS0muRKZhcNnVvF4U36mJ4Pxqnjq6aafDXo1oU+hocpn/Ys8/4/tj7V1T/WS3hXDrQb/GORpnpIai0vcSS0WW9XJnI;4:40wxViXlumjTbVZ650mMWAqKbs+PncoZWl5caHTOQJokL+wdrw8Mi4cFcJMNDCjwiGnT6S+uFtkLVZBsztJilA2IgdLE+Ig3se68HZsi4jNWJsYHAGfDCZyg0zGP4J0xyAIAgfNviAVtBEuGg9uHJyOWeYmv50jDYvfCWsZWgBPd99f0QVuEuosUAPJRKd6Yyb1aXuGLCGzo90NN8ecjNmU1WHqbx0oABVUm2EZOPGWEJt/fhR+ozHZzYaztZ2QVp5JG0lOr5991bmocI+fXtw==
X-Microsoft-Antispam-PRVS: <BLUPR0301MB1570B20DF837920A2008C9E0ED2F0@BLUPR0301MB1570.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BLUPR0301MB1570;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1570;
X-Forefront-PRVS: 0749DC2CE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39850400004)(366004)(396003)(199004)(189003)(50226002)(8936002)(105586002)(66066001)(106356001)(4326008)(47776003)(478600001)(86362001)(25786009)(72206003)(2906002)(7696005)(52116002)(6116002)(6506007)(386003)(110136005)(9686003)(1076002)(97736004)(50466002)(5660300001)(230700001)(217873002)(23726003)(6666003)(3846002)(14444005)(476003)(486006)(68736007)(956004)(316002)(26005)(81166006)(81156014)(55016002)(16526019)(186003)(8676002)(7736002)(53936002)(33896004)(305945005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1570;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1570;23:1/TS0SelPztvxyXQe+0xdwReMGUiUOzSXe/n5sa?=
 =?us-ascii?Q?mSn7wKQiY6KQ9xv4I7M0uWndrs//5C37fOA6XlABM8DUFFocMcP9SVgQ26AL?=
 =?us-ascii?Q?8VCXsXw6bLG818AEPtwu94oLDsyjBM0nItD7B0QqK3RSdbT3jskhUejcL4Hd?=
 =?us-ascii?Q?jNfOyKuqMLWRYDSX3L2MOUcBpuSBiOkvywCNTfT+QnwqILxqAy2kltjEVujY?=
 =?us-ascii?Q?YVQsqO3V0C9fDG9cTdSyRTGSQOT7Tgu/yBekY3SFL/LBHch1SXUlq34VzQu7?=
 =?us-ascii?Q?KL/qcQIfr6SYOdnyIgsLk3BiA2IzzJQ1TsexVi7j2VGKQ2ukY3poucIeCL7r?=
 =?us-ascii?Q?11TY/U+h+vQ6Li2UKaufvUbalsdLxARRZlu2VsS4tOCPU9P3Yokb+etKKMWD?=
 =?us-ascii?Q?psaIvHHFieOpqVZyxJAgY51f3nH4LaV6EJVoRKQi4FkXuYcRmEnxmvuIEJmX?=
 =?us-ascii?Q?kt+Gj9KjMkE3t0bDlsVWoLro5G4/Khy38vWqf4CicSJSDF2jc0KFrofkXMgO?=
 =?us-ascii?Q?FnEy7kufWxpINOBVaktxdgYkym1cPU5/yQWxgze1Zs63UCdErNfiLQ1UoPzv?=
 =?us-ascii?Q?s/yUkmn6hcevk6797xFec1wfnweKuKciSzIH/LNGEaxgaIYQMlbOYcfJa72b?=
 =?us-ascii?Q?+r6GsM0li0n0h3B7rGb/ztauLo02FLPadKBW3t3PobDZqaT7LwT9WPyl0AUv?=
 =?us-ascii?Q?F7zWlwlZk+EtwsAYsqH72JttB37L5KhzXiYNjsEFqmol+9ojhWh0mpyABIBQ?=
 =?us-ascii?Q?4fUnkXJ2Ap+OwZp8l08VOSLCoAEVS6dzsFh/hACz5J0Kb65EWBcVRUoDW0MT?=
 =?us-ascii?Q?nqyFsSBqk9D/KZ3lZA6LAyuqSJ+6pNw8SJOlH7RVxwnHSi/fvAQrUPxi7TON?=
 =?us-ascii?Q?ZE/EA9cUPX9Ip8RDRTfgGk4UT67GGA3G6LuCA1LqCXnQ4c7mFpmyBETEXzdM?=
 =?us-ascii?Q?ziKf2zd2hkTGdKlxp/uxlUWaYCTcX3IzAJfJa9+vsCM07n3GndhKIz4aHwYO?=
 =?us-ascii?Q?Fa7Jnmmwfb/3IQD60N3nRAyOmO6OeiItKwjlDKYo0hhsfyZ8VacqszNNFfgp?=
 =?us-ascii?Q?XHbKDWOu4IpJsGm84OANcZCdqhDnA1I4PW/MXp4tga9e7zxDyMEQr7h07zCJ?=
 =?us-ascii?Q?I2PZ81k0kgsZTCa1QHf3nSUmyTMNYyQJj/VRBbVK3X8YYlh0PaA4mKEUPQtJ?=
 =?us-ascii?Q?TXaW+ddud+0MBU/Gy/y3V8YDLZ/tAnr4wdw6j?=
X-Microsoft-Antispam-Message-Info: 0M8/BvkJJrKBfPS57sinQo/Z8+wq3pGwArOLHF3f97iETzNXgCC0uHzFub56ySgcVrMube+gPUWMOMmUfL1Ql8dtBA3y73mzi/kdh5HC+vL/bi4Qm7nyX9LbvC/sh4MRNlpC7zyZagO8un7zb/8sgA922dDMRlq5tqwVqDAnY7SKXq4R1kml25Vxj2gy2LshpBzzrcHJ1agdXESOgMOIp3xyqjDyxHuLZxZZr0fMcNd5igsnx973bHTLE89Fz2D5fex9bJiHRkJx/OgGKPzQjy7PY3wCN63Ee/vLrnISZcpJkrXB9n2cAuAueXWZW7gY/YGBSUAD4XiLdcrC8pIqEpSsbZvWkWIVO81pxqEB5S0=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1570;6:htfZTpBLv1CdaUxhPoLbCITVDMgjyt/ucd0cFCdIyQIjwADK5Zqt/Ea9mTBV+BbgMrzZSNNsS+ymN6MCmZlO86Xe9CDYo6JKvpkS9cBsTK7HgYT0bzFED/a3HjefllZetL5tq9dOJLWwft5Eg6qFe3NT7B5isEGVzgBYCndWhQk8jux3cEwVsoFIz52PZ++f2/ymAtFNoLMTtsaFaruwIjATv6BNNzlx4x6gyhgHugLa6FG6SERN541CLS9q+rkCAhlrXPTKXAMgOF8OxxrwXe0JlcEYCjK25+UVdoSdk23p+SgXpWA8eqZ67IdY9zF0k7wusj2q99us4218vcOwa/PYzgoFtBrrCvwn3H9cnXRBfUf0Xe+9KoMRB3XT+vy9uyiSO2WTr5/Jkz1zvWW7HQOkP/pdqqUohrVgVsl8HFbeZ5euG30L/wIahIqghDGu0f6nqgw4BTw1ob0KzpwRHA==;5:ZKhdtSutW/0XZBdux5dmq15071GnH/eNJ9pHYFFZMkSlI9CHhbKrAEjOQFmsBLFPcry04t5dQ7eLmVrN5huawyp+jNUD+rKdJal1rL9MnQ8RMp9wQNI8PnH6NVbuKBbnSC56XfeZivGRjvhkZuUMkE/C32IWUxOF3LyHeiTWviE=;7:ohRvfS7CxX7LE8/OBWPEwuQsDPvHk4stcKas7SdY/wkfOqsDRG2NDUBGnIxzyhsyxSWHdNRlvD2tFcLPWYA5Edy/VqmUizqx4+tCcjekgyDayeMhQklF9yQBQtEnIP6nguWG5eaOl87/lC0RVu3x11ZwVVYOw2fB07ONLLarzhxQ+ab6CbjOQaZi/uvnotuNr6HfmVb/vXZplrh9tGIVn7RcgJCFyZQUUWUt6UaSDmFyxcwMAPydXJaD4WBTg4p0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 02:44:58.0711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c60931-f0fd-4d40-62c7-08d5f5c67159
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1570
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

since v2:
  - make use of "likely" to check (!len || BOUNDARY_OK(addr, len))
  - explictly include <linux/sizes.h> for SZ_128M

since v1:
  - fix BOUNDARY_OK macro if addr+len is aligned to 128MB
  - use DIV_ROUND_UP to cal extra desc num
  - fix !len for dwcmshc_adma_write_desc()

Jisheng Zhang (3):
  mmc: sdhci: add adma_table_num member to struct sdhci_host
  mmc: sdhci: introduce adma_write_desc() hook to struct sdhci_ops
  mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary limitation

 drivers/mmc/host/sdhci-of-dwcmshc.c | 43 ++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c            | 48 +++++++++++++++++++----------
 drivers/mmc/host/sdhci.h            |  8 +++++
 3 files changed, 83 insertions(+), 16 deletions(-)

-- 
2.18.0

