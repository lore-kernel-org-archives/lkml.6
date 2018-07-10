Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F63EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54062086A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="L6xW5TL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54062086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933187AbeGJDMH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 23:12:07 -0400
Received: from mail-co1nam03on0046.outbound.protection.outlook.com ([104.47.40.46]:9488
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932998AbeGJDLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 23:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxN65LLnWCMxe3o4RNjVRoyY7rvanlbbtAF0G0ruM9I=;
 b=L6xW5TL0m5bOVLVFTB8G/2tZv10ehvZvO1v4/ZElmJ++lH6M59cc4o1ga5X1kea+U08xVpvAyxveZyAWzNK+snW02SlEduX9WY5CdYT02kzS/WMQ9UTlPWdOtaX4TzOBV1qQceDNnvQqoXweBUqUvvw3PjArNA7JcMBZKEML1u0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 DM5PR03MB2635.namprd03.prod.outlook.com (2603:10b6:3:43::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.22; Tue, 10 Jul 2018 03:11:46 +0000
Date:   Tue, 10 Jul 2018 11:09:42 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: [PATCH v4 0/3] serial: 8250_dw: add fractional divisor support
Message-ID: <20180710110942.5b0a016e@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: PR0P264CA0036.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::24) To DM5PR03MB2635.namprd03.prod.outlook.com
 (2603:10b6:3:43::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eeb42cc3-4eee-49c7-c9fd-08d5e612e2bc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2635;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;3:j8w7KZtgvgRKyzD2Ehemfwyj0XZaR+5Vb/4ukU46hFPJ0VzgsG4ujHWFwpJvvzXsW7Ay5CzAZ70kGywMTl6qW8SQBsdEqzAH6h1Cb/z3f+ThRAdAOp0Wi04cABdqeCiZgbl7BWuIdfERTGq9vwXQF3bfWdZfXfHbMnTbQXB9POsjopU8JvUMmcDbhtMRYV4wIziyaZoGGX0A6kBenmG3Dp3++MI40qYaLt4JIZXTDDl38E5WAbbSBpnPD3OEW0+I;25:RejEo9bfzu/wVnoaEBgueL5RW1bnw/YfGbxvk6qUEtVA3Pv1iVnw0thX3PZibwdzzq9vOkpJ8RCd+GNP6bseDGsC3CuCQ+xdhRM+Ju4iof2mg4j/6NulbTn5X2qZ6vAPT3w4akGBCHfmggFQjcSvHAsbmfMGxbbFtWnQHlKrc0g4e7uI6qinvIfLvBmQceCDcP8WlRXU+mdReoiRl6Hz7iSNKAQSDV9mkNcw0fNx9GYJSnhP6Bbh02ZrcvQ2hE0BiR7tY7/EIP0D4IiAzwk62rETQeRodT8O8lyXhKaCNyp9TiQI5oIb0VhD9Mj+1FwDWHrcc9r5IKKbBwyhpO/gUg==;31:YBJM8ryPxPAVUdM2wgMfTSKw1MVCwucLxkayo6Hcmo2V8zJlPVWAuNt1QOcry9fLO1630vFbpF+IL9MbfRk4gpmiS7xIRyu2u+f/iljN9CXy7E9HRsoFMa26AXW102WSfqTvU4AhbGiNJZ/C880Q82QvsE85GIg6UVHt369hlVKdxgS0IlEo4GiUmHH5Er2veP0Tt+kSc0udegfP4IZlNMR5+3QkbELA1ZuFjBCM8Tw=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2635:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;20:70EhptuyK56fTRrqrUnTNJcmMZ/LLTPtFVhp1UacFos+/ejcWx+diVEABguDLZS33EpcPNCeDBZ6zWxCFNRpP8X4HH1Oq3IV4RD8HbnnxYWuP3MNREZUhVdmZa0rJ3UM59n0i3kVX+PKiAxjOlA/B5rPYebtM+/atLQmSSHeXT+28KswUfVsUdoBPYbb6p0Ykj+aWlCUqo7cBoCE82oQJw70TgL77r9els3N44pqOAkiqiD3gBjtfmDWC/0161XEGtKSSBvvQEL3F4+4bDvx8qDvg8/+xx+YTLfz64g1hT+EOFWjtbElwPqFonmfND47jReEm5FK69LWQhR+jF9Gcd8jbNhbALACHN5NL9+KBsxQHOo6kWeVZf5wCcZnGTqevMSEWaBeWxyIaaYB8xaDTGqiXAw73gBYEknYiHiHjKyjQ3dnqCic1Dd3ooWKOeDSW0keq8O9jSBwTb3ToeTpHUlctr//j0n31nM20jG4zgd7tt43wGyb8y0aILPGLjKa;4:SPDrOGwJ5hynxFhoLXE1SLQsNwBO0tbyYpkm/edjxgA0nYBLQCtCHtytM2DM5aDZVQe8YAnhdu/T0B1N/QtXudqhXtajDQvgoK2ueI9z8sn9EKgImXPV9n4WRhScAI/FJp6f3SkzZuv8g9zVROI0ozIMQDI3Qe34seu8UI55XX/lBMCkgthQpSnokEtMPcPNgDGrbS1xzZkwUpFWPuHqh911YbKeHcq2PoQps0uzpJbCwZA0UB4qBUtPqZA+qn3XpkaDHWv5Aqt+ahGB34yRFA==
X-Microsoft-Antispam-PRVS: <DM5PR03MB26351731A8F09D850E16E667ED5B0@DM5PR03MB2635.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB2635;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2635;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39850400004)(136003)(376002)(346002)(199004)(189003)(6116002)(8936002)(50466002)(8676002)(81166006)(81156014)(7736002)(305945005)(9686003)(55016002)(66066001)(50226002)(5660300001)(2906002)(97736004)(47776003)(4326008)(3846002)(53936002)(23726003)(230700001)(26005)(1076002)(105586002)(478600001)(106356001)(72206003)(7696005)(25786009)(476003)(110136005)(6506007)(386003)(486006)(33896004)(186003)(54906003)(16526019)(956004)(6666003)(316002)(86362001)(68736007)(52116002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2635;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2635;23:AoYWd6GBZ1eVk3+PmFOXsK2e4fGLtV3o+/QU5F9p+?=
 =?us-ascii?Q?xk9Ze9fwNDtOI1kBm9Qtv+lLwSyNWwwbLGxQ2mAaziK3OGa52lFNDeTxcxIU?=
 =?us-ascii?Q?MHc4Cb8y7j/f+Kzar41t6WGk7yWcBJqp6STePzpwW+OfK3jwst4xtr6Cdr9Z?=
 =?us-ascii?Q?FIVjET+21nFanOf2XEaKqDi88e1MCe7ypb7bh1KRFks+qN+GInl4/vLGK/jA?=
 =?us-ascii?Q?B10s6zM/vEnQWVprXsokr1T1gJCRs18xjxfEaXkcwzwrGTuy6kD9VvfYeY+s?=
 =?us-ascii?Q?FaH5zdxteDKPrPvZPB4kAFvI/07fnXh+y28RicnXE450lcNuBQ9tTvP7z3ey?=
 =?us-ascii?Q?AzwB0sStIfVZPAR4ubQcLod2d9kDoQLVuJH/KDP1Jj+eywWdf8aok7jIM3kp?=
 =?us-ascii?Q?17Ln3ijsIdEg4ucya0wfESZL8Ee/M5UUddxQ2CevNbvZ5owgwo9IEw9LlFEm?=
 =?us-ascii?Q?9mbd3zoWRBa7UdNkct7DoRV4OM4mapHOxBVKtxXsW9fiH6L/GIMsikrhwFLe?=
 =?us-ascii?Q?+PDaoZbcZ/PJkBH6WdAmkFg35/kGXoN/vpi1CoYV/YxPO2omLVLw8ae/CK7a?=
 =?us-ascii?Q?EzZM7eOKw91+pNTJTS8Q5X92mV/lzHeBeaBEvN8yRNSTyAeQdeSz11hnHZFG?=
 =?us-ascii?Q?GoOhDscpOeye9/LGAikRUFFdHeZv3bsKBvxiOEIRiu1Kd3nLqzlCMXlV0QFt?=
 =?us-ascii?Q?JX+fr1ctmazHzEG6wYcnQGjXUcJ25AZnEVc841ppdx/8AeG5Gp53KvQTIbl6?=
 =?us-ascii?Q?yOWBGoHyzG+jz4nz/dPN3dTOwgGYU9jzSNDdkEWUJks3bLBKHqwIl6FP1OHT?=
 =?us-ascii?Q?cSVJTAaRJPRdGuoYJdBNNKwk96MV4HKkdMZEr28GVCKcRlbPlFqh3+2A88ne?=
 =?us-ascii?Q?27SgXFHtGIH4QfOMPvDKJ+TIfWluwdtz7xIQ8uecPJg/hqeoFl/NB/ygV+Bp?=
 =?us-ascii?Q?lYV7fJ2WDsfyRC2wM+1LndWBPrxLx90656hXBYx+P8S+8T5sudm/KDWQUVEZ?=
 =?us-ascii?Q?Lp+aFkrS8Fv+Kh6tzwJr5+eoEZkXGo0t5qfGFFHXWiXadaUfF0cdYh6SkZUk?=
 =?us-ascii?Q?PsymnNAnvCFzXzl4NDacPHE1PVhdUZ01vMNdVNC/mANMtvSbmrXQAZAKSmC2?=
 =?us-ascii?Q?B3KIO0e2poVo5hJjnohurSGzDHewUf0xDomCcji434RHmPHc3uu7kMeM0bC1?=
 =?us-ascii?Q?YvkOofGPBxTymk=3D?=
X-Microsoft-Antispam-Message-Info: 2Dn3Wl1vi6YkemVXle1GgmOvLJuhwOA8uwoN/Zjs4nIGTYU1s3xTGxmIayGJV2tO3Nkca63LC09SOcxreQoFVrxdfZgpR53uDNU9Ni2naaz6Pi7X1Lx5F2wH+uyRLM1WIhkGj2z/gkEbqtBEFmcOzlwooc+c+ETt66n8n3j8KKlnyTv7Y9fo3/gldYWe4xUjyUx+OySNCFJnPKyJOez6RwPbvuUe1KnA3T2Tet6RvCMCIvQdu1p+cooNFjciVCwSsbFLqLDZmQ6D9f1f0FKlcFrPyaRYR/Up9ReAJ5pslfTyc8t7VWg0W9uWai3WPRz60uMscQWT3H9/9KiSoIe5KS4JtJU3WZznKTWIkBy82Fg=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;6:WxnIhPMSdjlvclP9giubnKYIqzbNY6fPvmkbP5t05sDoKg07NkKlXCA7uSMLaiEKlqsC1GjuPdmqDisKMEt3RmnUxJaEOKPpBcW1ID4nSI7NHZb5nDuS8S84LD8OJbSgw/4IdjwbDbwhhiNXciPU0Vnq5ahtlxG6YoR0qgsJHtBWqWu9/ZBcTfDWUjXbxW3UyXAPZ7wMVrPmQdNSa2HkkSfrzREA8SrPH8gRb+BjZwoNkxnavgLECzqCGeVAo22bmjYJrznf6wpz4Qwr1PF8TqQ78OExpYxRfxRHDF/M5sHJGNJC6cm5uwxMRq4o/IdbJYBV3hmM19bw1sfF0c+sQ+BZL8pw0L+8ojqxrnEMUkF/qxng8Y1k537PFEH0S2B6t8xFFkfj4FxWoEHuVGAQOIR1TxtjAPz+68WFIXnlTAOEztRZFxzw87IrnpUTzFzsLg2TCOT7fLQwmf0SFDFUuw==;5:osr+rjepIP32ZIBmXgZTgbxRZjM2Sa6qd77Z+An31UVkVnqwMncd5XuBH+K2A+kGD9idAeIPsdLCP1FOxZ/KKTZR7dg689gvTTLRFrwdqvrAaMOaaGL4UhUYU2QgkZ8Dl0mo1tuztxEFYUY9NxV853nKuLIAWwNykonTNY8HEJk=;24:sS21o5ODK3cZptw2sOstonGR7godW8bay65BR0Bh2fHj3aqK8bm2kQEnMyAWs/Y6aUKTfGMP66tsoMp+AO58r+5jWa1i36aO53frhLdfVdQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;7:O2C7zs2AHwamxwztP7pIHjhU85wc1IGlU+ufE8AVIAAqVovz/GkgChhiwboEVJ7kNTu/4feUjvLUGxBPRtnY9Ix+gXUBidS6Z5MkSrOvEHaUQhy6+D1yuzs4uzLiLkaq4rZNq8s07G7FSlzxzJL5myzurJEfh94gu4b06R3qSEs99UhQnOJNLlRzk0xDFMKL4gawdhgx6g4FxeL/z+JFXk27iTWFNw7cm3hMHQtWSYret2i6F5MXi2o+4i2saPxB
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 03:11:46.4789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb42cc3-4eee-49c7-c9fd-08d5e612e2bc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2635
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
valid divisor latch fraction register. The fractional divisor width is
4bits ~ 6bits.

patch1 introduces necessary hooks to 8250 core.
patch2 exports serial8250_do_set_divisor()
patch3 implements the fractional divisor support for Synopsys DW 8250.

Since v3:
 - simplify the dw8250_get_divisor() implementation again.

Since v2:
 - rebase to tty-next branch, since I need one patch from Andy which
   is in tty-next
 - drop the patch "serial: 8250: let serial8250_get_divisor() get
   uart_port * as param" since it's in tty-next now.
 - add a new patch to export serial8250_do_set_divisor(), and reuse it
   to complete dw8250_set_divisor().
 - remove DW 8250 version check, since the DLF register always exists
   and if fractional divisor isn't supported, the register read as 0
 - add comments to explain how dw8250_get_divisor() get quot and frac.
 - the frac calcuation is simplified with well implemented GENMASK
 - Add Andy's Reviewed-by tag to patch1.

Since v1:
 - add an extra patch to let serial8250_get_divisor() get uart_port *
   as param
 - take Andy's suggestions to "integrates hooks in the same way like
   it's done for the rest of 8250 ones". Many thanks to Andy.

Jisheng Zhang (3):
  serial: 8250: introduce get_divisor() and set_divisor() hook
  serial: 8250: export serial8250_do_set_divisor()
  serial: 8250_dw: add fractional divisor support

 drivers/tty/serial/8250/8250_core.c |  4 +++
 drivers/tty/serial/8250/8250_dw.c   | 45 +++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c | 30 +++++++++++++++----
 include/linux/serial_8250.h         |  3 ++
 include/linux/serial_core.h         |  7 +++++
 5 files changed, 84 insertions(+), 5 deletions(-)

-- 
2.18.0

