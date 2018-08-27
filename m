Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1A1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B5A21746
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="eEMWdlTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B5A21746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeH0MJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:09:07 -0400
Received: from mail-eopbgr720068.outbound.protection.outlook.com ([40.107.72.68]:3570
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbeH0MJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BI98gPlZS4bCcGS/GVVcu+MGSnwvcsWKA2d0ucP+YUU=;
 b=eEMWdlTVhrT41dQOJhXj+PwmQUwm39BJf8WvgkxB+oq7R/9OiqzmHVhWnQvjnVJ50WyGaIuf9LE5OdtHkuwvumpGozUf4/Hpe3hEjap50/KKPQJFYtOdqyVZDdXaO44pMgVlY8NQO3A/3cRBUohVSjyzg3KqIw5bOCEGzG4+z48=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1578.namprd03.prod.outlook.com (2a01:111:e400:529c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Mon, 27 Aug
 2018 08:23:26 +0000
Date:   Mon, 27 Aug 2018 16:20:26 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 0/3] solve SDHCI DWC MSHC 128MB DMA boundary limitation
Message-ID: <20180827162026.3901de27@xhacker.debian>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0023.jpnprd01.prod.outlook.com (2603:1096:404::35)
 To CY1PR0301MB1578.namprd03.prod.outlook.com (2a01:111:e400:529c::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ff0340b-a62d-4bc1-56c0-08d60bf65d8e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1578;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;3:zHzahhfL6h07hXmF7YXokiogtuka+BuvniJ3o8bumpgTkRCUxTxvXCCKG5Xm7XciP0MPhSeR961QJXordmVS02HnibqPf5j5l58fPVVCCmfqEtennxbyPvpTI/Qa+Zfmp4YK9WZH2muv+Y2LxgqDrM836HSCtdsHG/HUmopXQoa9BJvn3zcGk0AVr3VmXRxJ+ar/O4/m8x47GOhybAuMeJ9D1LvJnh60MOcn4QD9RkI4AQfUpaS15mXDHRNh2sZO;25:s101zUJgOkpJ7a/JXM8ebBOFsYRWmg95cuMAEdUMjcdLb+FIAn87tH0AStO8kzKtibStt/iLa2Wdkh9ZsdIiMqo7r5SAgeqU45HdUeibLwLOO1TpH/LLsswJZ2VAecAI1SvxcNtAPHXpGs9Q9Qhdbx4vO89/0WPVd/iaYDKyfG8PNCK84aGm7qW9J2KKUBwSg3mx5n+Hc5NJzgdu6x7csoIs5AVC2NwhmTCxA5t+Dlw15/NJGS1QZTCEVPCm6OlXFzvuE7gBQkYKUa9+hASN/dR7xZc8dvHOC2YV0eE3A1CXvip3pO4BMybd/O6ulKuqp3E/Ju6JIsATvrjfZNxipg==;31:L07DIt3TCy7iZZqU85gwwfzymlNo19LWxHBAqfwGcMAtFHBVP3s1Si2Byk4giLwpxo3o6tHhNpv0Nnku3J2QZKxNT2jtY+4fglPCbjvTQH+a3YOJnPcQyfhYvBO3ug8E6RRXD4CGhjVheTrrSfcViSinHVj4eoJMqghU8+nHbagkBM4UxFQJ7F8qgogtx5m5Do1LhBHVmJ0bHwB2alJxEx0vV3FKIZMbzBRhQBRuy+k=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1578:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;20:9IuO1SieObUGr9qUYPghlr6vpo2s4Yt7BGEE3kUW7BesPZOEocfekuYhGGqqo8SfZxVeBOvmieYWJaQV/PMiMz7smLkpjzN81rCnNzosUGHs4Wz/p5LrWHQMn0ia3pG4QFf0ZEuzzw++J/+ZeNTuULb0x5v/5XdPlohahi1oFRIasNv8vy13HH0kcVwa0i6L667dE9Js5bKekDW63S3sTU4mYemfl6P+OHrN+06WO07I603GvZOOxqXtucFMq+VhFIiiSCY9iO6Ch9MyQO7Y2u7APNVWSEjFLcgzqNe+Zgz8DNhRvSuQ80LImfIB95gneGeR33QSHVjH6c28HLuQtPxuXd7uZEW5/jYiV0iIEs4PXrf8kugTDYluwSKJopjTPu1DYeufjOLDRsPTLLlI0IC+N5hlZeIbB7OeUUE5j308+CobBNNWMVJPknCh9vXsunwh8PN9/yyZHy7UU1mJE0/wtFUyyUknBo0oit9GYu50BcSKrEZNib+Q1M5Nrsg7;4:ViYSBegQpzxlRAwvC/dfvyM7/XYjVXaMqQY+wmZAxi5gf4tWoyt4eheE1+ve0MWdXVsVDb6v7sxEKliixiOWRX7nsZg6JV4P2J7+Zt3ODLzdL3M/Y1+Om9D+W8Iq3BMlrP7k5I+MGSnlxku+BBMufORG9MmJJaMxX0LU/izgURgnJtY8eQgWBy9npKkWBaxjtzwW+PKCL63H7xqP8/j/KJL4TGmXreVmEAXagy7Lqdl7YCIfwNidN5JetxA/bfLv6BzfBUkjBeORMwwp6720yQ==
X-Microsoft-Antispam-PRVS: <CY1PR0301MB15788DF6F909F4976DF90948ED0B0@CY1PR0301MB1578.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY1PR0301MB1578;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1578;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(346002)(366004)(136003)(396003)(376002)(199004)(189003)(217873002)(23726003)(6116002)(3846002)(478600001)(230700001)(4326008)(47776003)(72206003)(956004)(476003)(54906003)(316002)(53936002)(110136005)(50226002)(9686003)(8676002)(5660300001)(66066001)(81156014)(81166006)(105586002)(186003)(16526019)(25786009)(2906002)(97736004)(7736002)(106356001)(8936002)(33896004)(55016002)(50466002)(26005)(68736007)(6506007)(305945005)(86362001)(1076002)(7696005)(52116002)(486006)(386003)(14444005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1578;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1578;23:MWkacPCEm+E9iSMeFX+IQRf5dMvC6YuSqIQp4uW?=
 =?us-ascii?Q?GfZhLTnjmlpN6hUFYfhYR4SbjMuGb7Bb6TWDZ/pdN96qwBdwa69KWOHa+Pfc?=
 =?us-ascii?Q?Pw95cxWyGgd/Fm/SXsUAFfhtgCoQ1OVeZg3XZKfUYF9bn6xc9AarSM3q7zeW?=
 =?us-ascii?Q?wD+qK4v5aKCJZcoGRYlJH8+oFE6ijI/6Aq9QMJ6K4iiRSOIcCKeZCCQGL+Zk?=
 =?us-ascii?Q?CB2La9DdB0ikNtbxmrhshTTr2S+ZFqHjvy6p9zO8t0H10+OABZZpT8H9QyOF?=
 =?us-ascii?Q?QS0rZuUJXulroujVvACFkCfSEvfYqBPN4pOHFaA+1lxkGCUNXeVjI14gtlQP?=
 =?us-ascii?Q?ba7dQwTXLRoE0trTj1UpktdVcoJVJzW8F08opQ7UHmFzbwU6h4urKQJns3Qb?=
 =?us-ascii?Q?4LHMsiutF/2urbjtb372UMr8+FlUSXVzFEAcMLqBrKGLy0Gbt+SEDcCYXct9?=
 =?us-ascii?Q?G8H9OyFLdH48u3Z0X3vN8vVx8njbNYf6KKjJMqFLwITc5CZCzDt7qD54wLmp?=
 =?us-ascii?Q?ByofbhV62KLqIPA0qQHVVB7Uj12wIQPrWaQekK/cTRYVVLQj7PniXS293hr7?=
 =?us-ascii?Q?3Fay3Yi7oOIU3XgqXVVLtnxTTa08ppZCjuapo9kUka0VEmyvu0N9HRR0SFtt?=
 =?us-ascii?Q?nv/5u74YkWjzBjA2z7i6ujXF684u6YA9ObVz9J8sDo5EjnepD3rzsJ8OEm3e?=
 =?us-ascii?Q?0hWpe6G3JPKBfBIW3tkq8wSM711k2AofYw8DhPP3GlHy2HIEfmrrdonV2zXs?=
 =?us-ascii?Q?CyVsvjOa+3AjUOLdRGf9xF5GVPAZNdQH8eanbvXDEqHgXoZdQ3kSwOO5okAH?=
 =?us-ascii?Q?OitawLdB6PuiouxbF7qt4ByjdU4hvm9psRVSEaGviRBhrZCd2AdRScByITgE?=
 =?us-ascii?Q?Gl3DW9y7C0xhittFWpU0AIWcwl0bABa8iIkJrL+cbNfxg8nVJQYMcnyfrobu?=
 =?us-ascii?Q?oDbgDaXoEx5ACv6tmKx6312O3FiFa5+MwrUoOK/uvu1zKVmLszY3KO2eYGHs?=
 =?us-ascii?Q?zlPyy++yq+B+UicewN2ZPS8ehR/8wIOYQR8DUWHnU07WU9/xHtBfG4/8smZz?=
 =?us-ascii?Q?c5erupaYmNcbUlE5W3rBrZu/hvd9iwxKhUMHmWO/MDq07O4asfKEvDOdIynE?=
 =?us-ascii?Q?sAAZAeCGoOzvF9YfHTDdOvWWOFErIHsjJKuZcR8oBzBgohcv/GSm8r+I/AeS?=
 =?us-ascii?Q?kaIbRGVnBgmNIMTjDzc0AlT3s9M61SjTCxmUx?=
X-Microsoft-Antispam-Message-Info: 2uh30WL/o/OeOMBMp8+elLsiVDvWNGHcY586BJJ5757WZVpyPfDPu7Qs98JH2NYyXFWDeFIxPEklLka7RPnGJNF+6olZM/mjU80h1PkMLjtbAoCPIzqkqNQtn5fIBH6kBW5cDNZ/UEL+5ca0yTnCvYwzKpz1YAouGJQ+4SePUXIziCtDjZC7Q4QsMCzGOYsghG1P+3viXbQFGtLbqrnNz70gOKe+3ipqMYKEsNWVCRMix3uofJ5HJ4DiZfamBpnLDIxd03IY4gb8hs+Z3RddhiiLXM4kkrk0BJfM4PycbQjT8dWGLA1a1FxfI2wCCb70p7Nea1wBLyzU9NlpjXoGun46Sw9TDWWhD4eyJBOjJQU=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;6:LnoIbZDO91AYBLD0UEZ7vYvoSq5R7YfRl5SDpv2lAT026TSKu2YqDDmSr+wO04OHEWMgNYadRx7aIRFEk08RHwz01YLk5LNipRox6nBv5sdmAxotgCUrI5IVKHGgppdgqepLQCdlNBB3yznhQe1cVZ2hXJs14rtRKbsUFfyOzDsBN2Hzj1iyLuRbrYpka/iSDNEUs4yMctzTbV8GuEsFra8PrWoIDmF123kyfCAI5ij5jw1H65oZsmaHxJnvRczrCsGccva8letLfAwzvbheP3oLXH8e5lcjENkqiy+L0ywr1rOBaNrad024R8zBYqy+vvntT2J+uqt013fjaNV/nqnfZywdvr27zUDU7K5zKUDhTQNO10dFxPKR4gVvnJbC7QhQrMFTI/7s1RMszB55MlJUK2SW6oKgaNcXPMeXqKdF7tL4OGxpuc3xLPdG7q2dY6A1gK9+Sc/i2iU8JBFOhg==;5:zilmuCXZkCYSwittzMjqhUMBB1MYUqhk5CLISUL9KzpE+WIDrnBxl/jSHpCZF4W+Xr8pzhsfbq4OJ8THaBvf2kWAadSqePzrahr2o+z1muFsqxpLTnwWZKEIFHpzA0WsL83R5/l86spLKoD7kXtfwSW8G0nC+qmopJp6ZjDFaZ0=;7:SVB4mEJmoAjl3HKAvxXCSI34zs4AzztnCTkGWxEINgZH4apOPaH/16sUVY2iP/LrzJzhQl3niktSpsHO8L/I6rlYO/TKalEnnt5QxJVDfDZ4y2bYwh1nOzXYAbOLnRESd5KiArqQ97CsNLRwxL0tPyisir/iTKXVfFygJ5/xZS8USKRnXXYNylRODuVq4qJdyub7ENDEK5KieygJyYTE4nXLo0JXnkpQv/nQ3wlBSsYSYPrNJIkXO6ednnwnD8ht
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 08:23:26.1629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff0340b-a62d-4bc1-56c0-08d60bf65d8e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1578
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using DMA, if the DMA addr spans 128MB boundary, we have to split
the DMA transfer into two so that each one doesn't exceed the boundary.

patch1 adds adma_table_cnt to struct sdhci_host so that driver can
control the ADMA table count.
patch2 introduces adma_write_desc() hook to struct sdhci_ops so that
driver can override it.
patch3 finally solves the 128MB boundary limitation.

since v4:
  - add Adrian's ack to patch 1 and patch 2
  - address Adrian's comment -- if the boundary is fine, we have to
    return after writing dma desc once; adma_table_cnt updating could
    make use of the fact that it's already initialized by the common
    sdhci code, we just need to tune.

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

 drivers/mmc/host/sdhci-of-dwcmshc.c | 41 ++++++++++++++++++++++
 drivers/mmc/host/sdhci.c            | 54 +++++++++++++++++------------
 drivers/mmc/host/sdhci.h            |  7 ++++
 3 files changed, 80 insertions(+), 22 deletions(-)

-- 
2.18.0

