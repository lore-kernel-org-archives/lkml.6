Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B03C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D528223EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="LDCb6hy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D528223EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeHJLSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:18:10 -0400
Received: from mail-cys01nam02on0060.outbound.protection.outlook.com ([104.47.37.60]:29616
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726997AbeHJLSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icJTMiv923QW9KrYgElR9WFFNsJhcQlEKmMPabb82LU=;
 b=LDCb6hy3TR2I0iqIAwJ4ZCh6pIqb0Svt5cmMh4nQr+IOx5uehvlBwzI9NF6YuIKYBrCp1JVrYRCX4FQL/edXGUNDqMrtGDqJ616tAyUhxProS2/i0QTV+iN7XAD4t3v4rJT8IcszrNSpR0t8VIX8xLSHFRoBhZ6MuIFIWSklKKU=
Received: from BN6PR03CA0006.namprd03.prod.outlook.com (2603:10b6:404:23::16)
 by BLUPR03MB550.namprd03.prod.outlook.com (2a01:111:e400:880::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.19; Fri, 10 Aug
 2018 08:48:06 +0000
Received: from BN1BFFO11FD023.protection.gbl (2a01:111:f400:7c10::1:197) by
 BN6PR03CA0006.outlook.office365.com (2603:10b6:404:23::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1038.21 via Frontend Transport; Fri, 10 Aug 2018 08:48:05 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1BFFO11FD023.mail.protection.outlook.com (10.58.144.86) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Fri, 10 Aug 2018 08:48:04 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w7A8m3uY019200
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Fri, 10 Aug 2018 01:48:03 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Fri, 10 Aug 2018
 04:48:03 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Crestez Dan Leonard" <leonard.crestez@intel.com>
Subject: [PATCH v6 3/6] regmap: Add regmap_noinc_read API
Date:   Fri, 10 Aug 2018 11:46:20 +0300
Message-ID: <1533890783-13456-4-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
References: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(136003)(376002)(396003)(39860400002)(346002)(2980300002)(438002)(189003)(199004)(106466001)(7636002)(305945005)(4326008)(2906002)(72206003)(478600001)(77096007)(126002)(2616005)(476003)(44832011)(486006)(11346002)(8936002)(106002)(7416002)(50226002)(446003)(50466002)(51416003)(8676002)(6346003)(76176011)(426003)(186003)(7696005)(14444005)(246002)(336012)(5660300001)(110136005)(48376002)(16586007)(54906003)(316002)(47776003)(356003)(36756003)(6666003)(53416004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB550;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD023;1:lDprLMYSWV9Lnlip7g3/x5wYNjCeTRpuaq/6AijLg0qB04Fkw0NkXqkTqZslItQkVIWdEpCe8vZ2KHrvp+Qq6n3T7D+iiOnnLChw0e13lMbczk1DPl/Gi1AHbx2O1Mzc
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2ed74a1-e1ef-4c2f-6083-08d5fe9dfd20
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR03MB550;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;3:aZPI+Rx2Ai0pQPEqPsDREcCFkMDmdif/bEkLoI0Pg3Kvli/qzZRQQS4pRAwFLzk+OdQCxjWJLZYusqc/lsJNeCvAVp1Ea3kWLVXbZtTglHzCq7FAbzRwlhiaNRogtFkci712HSLHuP8oemqtqX9x41iTAL5u6YK/QJOh3M9MsS6vpRsrl6vvApbbz5XF/w5mVbw845n9opQDJOmEqBvKDxInrEtPcAhOuIAWzXwBEEWbSMG3e2IdORnAS0eg3XUsqIfzcfJgRBrLGTiv72tky4MffUUHNWgOCuEK5yVk3Lk0hWA4/R37pA9Ht6JwIRs0ABi33YnOyJK1TZD1AzBUgYDe4s7iQUx5XVs4YwWmNd0=;25:nhPyxrq6DP06FxPwEWqgRc9WA7Q93qY4tgscaffQWimzpPm1e179qw/YuAGjmSnBqjTqnP88oq0vEt95nx6nieAxxs1M+ypHNivznN8R24al2+nkH22LALXN2cq+FgYmmk8rBYxAmoyo7wOLiGD9eEOlmAVUgm73L8eLuVcner4ZVaqVYbpX/XZM3iARb64IpiUu0RdYW/I6gi++aGc33ATLiaciS1FJ3rndtsmPXL8oQLYkxn2RaGFnuFDDdn9n2UbScEo9SshBfV5zs5ky1hmgFq6VOcvTZ4pE8XEAOf9mKanKV03qDiHa1fLDnoUDTSX3TiavzdX34Psjw989lg==
X-MS-TrafficTypeDiagnostic: BLUPR03MB550:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;31:JTuQi+HNbAAn7ETsoafLCgPuHv7vg3ZEyzws0iwZNlezYpFti6FmyI02WKQmBEaJwD7C63i7hZy8W+/qNr4E9mD+3pd+w9x3BOs9Ob2LwfzWHeL2moZiQIQnjmaUCbmeTR1X0/auQpMlcl7LMkbQmFH+1XMNtbvdaeDGyIr6jt6j1gfovVZZgnPDBJ8wloDrRa0EeDNKl6TX/TbKM4aBZgCEnoE2xUY+VCAhh2zcTOw=;20:OeKr5gU46yqs0XDuhBZqedPHoZKEUBFDNUbbNOf+F3g9rN+beMbJUoylT6prVEG8HNwneaXcjqOJ/tXjOwQdkDEAStTAfKry48S5K3OlLE76LMIuC96ivxYxMZ5Q7mN3l2ubRN6du7papEIBbVWgfVJso7c3ydMTL1SAccbwgZ/h8AYGZ5EBGSNWkoIql2y+uq7jwHEhfOx2EnpkNSDDEZvoJ1co9RamKCcOKHlsiESuvn4I8d6xxOwt1Y7k+eVwBQ71xrTEUEcI8OT/v3T9h2cKrGc6ybzkCnY+dVrQbGWR9+U9DVwlQLqXbaELjPpPZ5e9OTV6Uy8kz8+OYHW+qSRBB+q4Gvv522KU8hRClZkYN16jkHJ85lefHvLPJBexatZc9UmbgWrvkoAEDGjJMTBrbdWrsa+Ndu20LRwKtdCb7J8wOk/dQzIJIgBrc1sAJYPGDmAf3MNgV31Lu0e879P47t7i8qzb4LrzgKW/6iXFQgok7PKaFPHd9/RkiLYN
X-Microsoft-Antispam-PRVS: <BLUPR03MB550BB00FCFEDC7CA53DC8DF9D240@BLUPR03MB550.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(232431446821674)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BLUPR03MB550;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB550;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;4:hC6UWZmr1PD1XQ+e9LxJcdry/tDQ2PkBPubGYc93bVOKFjG0xAxoS6uNT0bjaf6KdlPFBwqtkD52LznnMT8AahELiws+TVPWSKjcJt31/2sevC1bJEZ0J02WPE9p9Ctau9knRYQhMuL73ToRpGUIqiJtG7S3f6GR3PziOYNvGqCtu9TQhlfEovuY+j3atxjqBs+lM/g5zuJUeqvJHm5IUOXSL1k9XVWaWaXBMlVWbXsj+jePmETLVMkVaOFWdniBstagWHd5RMTeQH+/a8bUDNcZRnar4gNQVKCsAjWsGwSFOhSOFzCX4Uz+V2C/MtQbcy7Pd+sgqmz6d9AJdedIuuppqH3XHdP2bCCH4vX8zFjI0rKFXHGvpxNM5T3+jhFI
X-Forefront-PRVS: 07607ED19A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB550;23:oHaIEiqkZ2EXyGfQ+11kDAoKrBR3zlbFJpkzLBMuQD?=
 =?us-ascii?Q?wYmw6kp6cS2hKzVr3m6v2xvHPaiNewZNSn9Xp6TGvK+1BoIzZthqsyRKOGgc?=
 =?us-ascii?Q?9ti+Jb2wvmFdBKy1STBdzmmiPO7Yx0Bb/3HQgPLgt3sIlKHom4bQ+C3anNmY?=
 =?us-ascii?Q?gMD69DCxhcNbHwAvoTSpqa9GI66ljUGJnrGTSMYDv7pmZpVSSN/DG99T7Iwt?=
 =?us-ascii?Q?hIR2VlKSQbMzA9LTrg8EbU/mITcucUfwp4lX0KfsQT5SinNjRKKx5hMWUVNe?=
 =?us-ascii?Q?Bgw/cRJqpuY2a5muZds08MntOnUP0oa4HQkxZpVnan/6lqprhwYRp5Ql4sRN?=
 =?us-ascii?Q?0YxMUxSXa+bmMj+9REJOYpZ2XWT+HIXOxyyRAUhYGhvbVY+0041kdwpwGUEP?=
 =?us-ascii?Q?4gx3q0zP+lTY1yDurR24Bk+RIaUTSXdRfwUMbh9KzR+6408XwGdfFyqNnOFV?=
 =?us-ascii?Q?fPFxtwEALvlFtLp+r5y1A/Zo/brYboqleGwSlPxI6E66lzgUihNfdM8sWS/f?=
 =?us-ascii?Q?2mXblvcG0AHtm7vgzfmgdwVi2PW0nXuNUocGHEgyaZz+arPXPkArMIG03Q5H?=
 =?us-ascii?Q?XpafU8N8y8xjmq9VzKtN2tHkdL0yH0dG/3Qrn93YolkFQWbo+2FYo+cOAM0D?=
 =?us-ascii?Q?xi5FvjDUwnRZiL3G2YNrL6vpck+XPrTG4ztwl1DvtNQXSpYcvGGMlhfqk7Hx?=
 =?us-ascii?Q?HaD24lGUvb9HjgMOFfr+ZkZzBkviNZuCiFERCxVpiBB+gPTleXd2Fx0GuMSp?=
 =?us-ascii?Q?bY/qnCOz0nIIZ2YUXYMpxsMiXXFhj8LcGHJWbEo6gKFZXjbq5Red8FPOhC+v?=
 =?us-ascii?Q?nHvYInX6pk7guQXu49mZPjWv6jHBrkymyyISbPITGGMxHaZhlX51ds+y2P13?=
 =?us-ascii?Q?qCY0ikiqW6fj0Qfwjpk4uYotce9DndtHyzHcmTMGS6dEZ4kll1G9nX5BgrFI?=
 =?us-ascii?Q?jF/5fknSrCQ1oaeE24gcyX2EdrZYd2aF6Yov7hukwO+uKEmkF6VlErBrm/jt?=
 =?us-ascii?Q?gi8dSDBx9kdErlmePcAGfEF5arJ4mkvp/hB8GBQthgd0ZZ6ZjQVpplF0i2Fg?=
 =?us-ascii?Q?5PgZ0ljh1DSeKios8qzfNuLwwx6ESRV5DLz05sRNbcauGD+jiWh10FllJ1db?=
 =?us-ascii?Q?s/u+dWqhoQm4EgL0FEvkICacvnyppR?=
X-Microsoft-Antispam-Message-Info: kt9V7VvrxGrxpFMA6CU3CCrgfdWbzKMem9Aw6m9u1Kd3O34TRFOrBvxZqUgHNpE0H7cCkQwFu5JZtL+59EEls3ZewXAZj68aRxUkxuBx7Q/4Kr2bxpdztSt9VsgOT641jJftUSRoPeV5Q1Ranm5ErzvhGVXzYmfy5jE1M9mbPyEBXc1hxYc14SR2xuCzw4hDWSDUi+jBdeE5tDGGTd1sSQutn5u6r5MDQ5ixqfgqWt8mEgB88d3WzGHI084kwmZTzVWzne9DFYPwDjB8of/7dX4IxJfNgfS/bz0Xz/2II7J4h4qzERwOTCDHpVtbtdtwPcO5UqonEywngmheAyI0CJhyFvTHOz3BCr3mrBWOZh0=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;6:DQZXxlKjCCB0lbu4G4/5kjPkl8OUu/qCfFVZNU84AE+U2vU7j6MEHvyZLuC+sLiS80rF+NdONUutm4iyykdNi1L0pSafhdWNSigFjC9CF0JT1iRqn0bnTBExEt7wke1Cadr5FdVMgjZMJK3YrJJAB30y09RgGsdh72sdboiDnpH7AISrBvIbIOq8U+34MO+r6TR6rQ76BOCJ6CWwUvYfwNwZSWCIJUknGfHXdfgPYh68gMDJLXFz7ap6yAVbl9z/E8/annXe1zQ/fdEpuOMahmHnXAAW+XA2P7q2zFUZZF+DRsv+CBj9IGohdXe/GMuQncwHF0JKzjB+sV3zzC/FqEjyy/8eeYKKma9ijcTXqkBUxJxGxU2ViDUIEq5qtu/3BCEidHJyD0lFo7pdkOSv1wUssKWQ7/JQmgXGd+YbDdoP6CIijk6DEqMFY56omz41A7miTjMg+Mp5FZEG0LZfRw==;5:mnBU+SmUX1KmjMRTb2O6FWa7Lv1x1il9ljFdxqKd5nbNJ5/eRifDVSGYrBUumQMoBRyAmEoDRHqkM8eVA+OcRtRNthLBz/3pExMoHnlWNlAjH92djIw/2F4RwxQnPuuzqeGZcLpD4cO9vwcd5EM0MZvN3ilw8cB/9fqSPllq8Ag=;7:EdP8FbDg2ciTqTqDM6jlpQi8Xx0hGpKCENhdCvIGK+oRnzykrGAbbIeZVbJCRKahZjEsAYmCBg0ZFOoCP4UJNSd6rjtOZ6dN/CCbvi0vMIKRWWtLV18zbvRXKV4b/DEyegyajppx1Gf9tG491PMUGPOla7cMoKZVFFwIDWOg6X1IdL9dlRPMmlsT9MVgEYoSaZtKldzu5CJbHCErjDgEGrnMQcvbKSzWjHHPaWVfTZ38kOdVGTnOvMeljp01xuLr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 08:48:04.3808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ed74a1-e1ef-4c2f-6083-08d5fe9dfd20
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB550
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Crestez Dan Leonard <leonard.crestez@intel.com>

The regmap API usually assumes that bulk read operations will read a
range of registers but some I2C/SPI devices have certain registers for
which a such a read operation will return data from an internal FIFO
instead. Add an explicit API to support bulk read without range semantics.

Some linux drivers use regmap_bulk_read or regmap_raw_read for such
registers, for example mpu6050 or bmi150 from IIO. This only happens to
work because when caching is disabled a single regmap read op will map
to a single bus read op (as desired). This breaks if caching is enabled and
reg+1 happens to be a cacheable register.

Without regmap support refactoring a driver to enable regmap caching
requires separate I2C and SPI paths. This is exactly what regmap is
supposed to help avoid.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/base/regmap/internal.h |  3 ++
 drivers/base/regmap/regmap.c   | 79 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/regmap.h         | 19 ++++++++++
 3 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 53785e0..a6bf34d63 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -94,10 +94,12 @@ struct regmap {
 	bool (*readable_reg)(struct device *dev, unsigned int reg);
 	bool (*volatile_reg)(struct device *dev, unsigned int reg);
 	bool (*precious_reg)(struct device *dev, unsigned int reg);
+	bool (*readable_noinc_reg)(struct device *dev, unsigned int reg);
 	const struct regmap_access_table *wr_table;
 	const struct regmap_access_table *rd_table;
 	const struct regmap_access_table *volatile_table;
 	const struct regmap_access_table *precious_table;
+	const struct regmap_access_table *rd_noinc_table;
 
 	int (*reg_read)(void *context, unsigned int reg, unsigned int *val);
 	int (*reg_write)(void *context, unsigned int reg, unsigned int val);
@@ -181,6 +183,7 @@ bool regmap_writeable(struct regmap *map, unsigned int reg);
 bool regmap_readable(struct regmap *map, unsigned int reg);
 bool regmap_volatile(struct regmap *map, unsigned int reg);
 bool regmap_precious(struct regmap *map, unsigned int reg);
+bool regmap_readable_noinc(struct regmap *map, unsigned int reg);
 
 int _regmap_write(struct regmap *map, unsigned int reg,
 		  unsigned int val);
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 3bc8488..0360a90 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -168,6 +168,17 @@ bool regmap_precious(struct regmap *map, unsigned int reg)
 	return false;
 }
 
+bool regmap_readable_noinc(struct regmap *map, unsigned int reg)
+{
+	if (map->readable_noinc_reg)
+		return map->readable_noinc_reg(map->dev, reg);
+
+	if (map->rd_noinc_table)
+		return regmap_check_range_table(map, reg, map->rd_noinc_table);
+
+	return true;
+}
+
 static bool regmap_volatile_range(struct regmap *map, unsigned int reg,
 	size_t num)
 {
@@ -766,10 +777,12 @@ struct regmap *__regmap_init(struct device *dev,
 	map->rd_table = config->rd_table;
 	map->volatile_table = config->volatile_table;
 	map->precious_table = config->precious_table;
+	map->rd_noinc_table = config->rd_noinc_table;
 	map->writeable_reg = config->writeable_reg;
 	map->readable_reg = config->readable_reg;
 	map->volatile_reg = config->volatile_reg;
 	map->precious_reg = config->precious_reg;
+	map->readable_noinc_reg = config->readable_noinc_reg;
 	map->cache_type = config->cache_type;
 
 	spin_lock_init(&map->async_lock);
@@ -1285,6 +1298,7 @@ int regmap_reinit_cache(struct regmap *map, const struct regmap_config *config)
 	map->readable_reg = config->readable_reg;
 	map->volatile_reg = config->volatile_reg;
 	map->precious_reg = config->precious_reg;
+	map->readable_noinc_reg = config->readable_noinc_reg;
 	map->cache_type = config->cache_type;
 
 	regmap_debugfs_init(map, config->name);
@@ -2564,7 +2578,70 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 EXPORT_SYMBOL_GPL(regmap_raw_read);
 
 /**
- * regmap_field_read() - Read a value to a single register field
+ * regmap_noinc_read(): Read data from a register without incrementing the
+ *			register number
+ *
+ * @map: Register map to read from
+ * @reg: Register to read from
+ * @val: Pointer to data buffer
+ * @val_len: Length of output buffer in bytes.
+ *
+ * The regmap API usually assumes that bulk bus read operations will read a
+ * range of registers. Some devices have certain registers for which a read
+ * operation read will read from an internal FIFO.
+ *
+ * The target register must be volatile but registers after it can be
+ * completely unrelated cacheable registers.
+ *
+ * This will attempt multiple reads as required to read val_len bytes.
+ *
+ * A value of zero will be returned on success, a negative errno will be
+ * returned in error cases.
+ */
+int regmap_noinc_read(struct regmap *map, unsigned int reg,
+		      void *val, size_t val_len)
+{
+	size_t read_len;
+	int ret;
+
+	if (!map->bus)
+		return -EINVAL;
+	if (!map->bus->read)
+		return -ENOTSUPP;
+	if (val_len % map->format.val_bytes)
+		return -EINVAL;
+	if (!IS_ALIGNED(reg, map->reg_stride))
+		return -EINVAL;
+	if (val_len == 0)
+		return -EINVAL;
+
+	map->lock(map->lock_arg);
+
+	if (!regmap_volatile(map, reg) || !regmap_readable_noinc(map, reg)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	while (val_len) {
+		if (map->max_raw_read && map->max_raw_read < val_len)
+			read_len = map->max_raw_read;
+		else
+			read_len = val_len;
+		ret = _regmap_raw_read(map, reg, val, read_len);
+		if (ret)
+			goto out_unlock;
+		val = ((u8 *)val) + read_len;
+		val_len -= read_len;
+	}
+
+out_unlock:
+	map->unlock(map->lock_arg);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regmap_noinc_read);
+
+/**
+ * regmap_field_read(): Read a value to a single register field
  *
  * @field: Register field to read from
  * @val: Pointer to store read value
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 4f38068..19df946 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -268,6 +268,13 @@ typedef void (*regmap_unlock)(void *);
  *                field is NULL but precious_table (see below) is not, the
  *                check is performed on such table (a register is precious if
  *                it belongs to one of the ranges specified by precious_table).
+ * @readable_noinc_reg: Optional callback returning true if the register
+ *			supports multiple read operations without incrementing
+ *			the register number. If this field is NULL but
+ *			rd_noinc_table (see below) is not, the check is
+ *			performed on such table (a register is no increment
+ *			readable if it belongs to one of the ranges specified
+ *			by rd_noinc_table).
  * @disable_locking: This regmap is either protected by external means or
  *                   is guaranteed not be be accessed from multiple threads.
  *                   Don't use any locking mechanisms.
@@ -295,6 +302,7 @@ typedef void (*regmap_unlock)(void *);
  * @rd_table:     As above, for read access.
  * @volatile_table: As above, for volatile registers.
  * @precious_table: As above, for precious registers.
+ * @rd_noinc_table: As above, for no increment readable registers.
  * @reg_defaults: Power on reset values for registers (for use with
  *                register cache support).
  * @num_reg_defaults: Number of elements in reg_defaults.
@@ -344,6 +352,7 @@ struct regmap_config {
 	bool (*readable_reg)(struct device *dev, unsigned int reg);
 	bool (*volatile_reg)(struct device *dev, unsigned int reg);
 	bool (*precious_reg)(struct device *dev, unsigned int reg);
+	bool (*readable_noinc_reg)(struct device *dev, unsigned int reg);
 
 	bool disable_locking;
 	regmap_lock lock;
@@ -360,6 +369,7 @@ struct regmap_config {
 	const struct regmap_access_table *rd_table;
 	const struct regmap_access_table *volatile_table;
 	const struct regmap_access_table *precious_table;
+	const struct regmap_access_table *rd_noinc_table;
 	const struct reg_default *reg_defaults;
 	unsigned int num_reg_defaults;
 	enum regcache_type cache_type;
@@ -946,6 +956,8 @@ int regmap_raw_write_async(struct regmap *map, unsigned int reg,
 int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
 int regmap_raw_read(struct regmap *map, unsigned int reg,
 		    void *val, size_t val_len);
+int regmap_noinc_read(struct regmap *map, unsigned int reg,
+		      void *val, size_t val_len);
 int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		     size_t val_count);
 int regmap_update_bits_base(struct regmap *map, unsigned int reg,
@@ -1196,6 +1208,13 @@ static inline int regmap_raw_read(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
+static inline int regmap_noinc_read(struct regmap *map, unsigned int reg,
+				    void *val, size_t val_len)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int regmap_bulk_read(struct regmap *map, unsigned int reg,
 				   void *val, size_t val_count)
 {
-- 
2.7.4

