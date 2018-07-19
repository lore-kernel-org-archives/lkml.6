Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402F5C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75F020858
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="uJf8NZ8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75F020858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbeGSO1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:27:41 -0400
Received: from mail-co1nam03on0066.outbound.protection.outlook.com ([104.47.40.66]:4608
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731236AbeGSO1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pHBi5nzY0G/OTIkYVKS1e7DDRXRvkduTIKIGWF47Ps=;
 b=uJf8NZ8YSTIBxkjJuRbsJ/adNEmddmeLrUx6M+5TUu+/pvFuxqEpxY3/82uyN7yMjILykxz6okTh2Tq8QE+HxT6riZ1SEO9gaj+YV78poz/pI8mKaB0HZ+pu2j/gf8yuexQkWWhx2qC+A5hQ3MuRM39vsxxKs6bTcP+CsXnHFfc=
Received: from BN6PR03CA0069.namprd03.prod.outlook.com (2603:10b6:404:4c::31)
 by BY2PR03MB553.namprd03.prod.outlook.com (2a01:111:e400:2c38::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Thu, 19 Jul
 2018 13:44:07 +0000
Received: from BL2FFO11FD009.protection.gbl (2a01:111:f400:7c09::154) by
 BN6PR03CA0069.outlook.office365.com (2603:10b6:404:4c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.973.16 via Frontend Transport; Thu, 19 Jul 2018 13:44:06 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2FFO11FD009.mail.protection.outlook.com (10.173.161.15) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.20
 via Frontend Transport; Thu, 19 Jul 2018 13:44:03 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w6JDi3mk012866
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 19 Jul 2018 06:44:03 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by NWD2HUBCAS9.ad.analog.com
 (10.64.69.109) with Microsoft SMTP Server id 14.3.210.2; Thu, 19 Jul 2018
 09:44:03 -0400
Received: from mircea-Latitude-E6540.analog.com ([10.50.1.102]) by
 zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id w6JDi182000501;      Thu, 19 Jul
 2018 09:44:01 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <peda@axentia.se>
CC:     <davem@davemloft.net>, <mchehab+samsung@kernel.org>,
        <akpm@linux-foundation.org>, <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V3 2/2] =?UTF-8?q?mux:=20adgs1408:=20new=20driver=20for=20Ana?= =?UTF-8?q?log=20Devices=20ADGS1408/1409=20mux=20=E2=80=A6?=
Date:   Thu, 19 Jul 2018 16:43:59 +0300
Message-ID: <20180719134359.23714-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39860400002)(376002)(2980300002)(438002)(199004)(189003)(54534003)(7636002)(44832011)(2351001)(72206003)(478600001)(2616005)(7696005)(126002)(486006)(106466001)(50466002)(14444005)(476003)(5660300001)(47776003)(54906003)(316002)(106002)(305945005)(53416004)(246002)(2906002)(2870700001)(356003)(23676004)(86362001)(8936002)(5820100001)(1076002)(107886003)(36756003)(50226002)(26005)(4326008)(186003)(77096007)(336012)(426003)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB553;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD009;1:S874XYt2nl24tm1qEqYT2FnizmZ9kNwV5N24vwC2dTG6k8hF0Go59ItLC/FpJvjJuNPa5/gmkJpfoE7vQLRr7LMYiiOd0CMr9MHU1XVm8ROFT/RQBbqRAzifUQ7CjcJu
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0eb26696-bacc-4d2c-dfce-08d5ed7db252
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY2PR03MB553;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;3:LG1kFoWi2ect2qK48hPLPI9uIWJy7aTtXvm+MzLUZTyPP+CyhXS94mqBy0Aq7hPq/Ux7S9PVvH290/oKIhkQFLuO0PYBYDH8OEWvFpgIBKqEolJyJtUiCw/mNbpfn5Pmdg8VfCIsl31ueuuZhtuRj2DwH1gZs1NObCrN7cEM/drleM7KR9Z9lAKAMFvz6EHnD9FAvB4HKIlFYAV5xEA2SmWkusfeeqnEfZFN3gjzmisgJeyBC7klbrMw0apOgFPWTvHb3T5xvaFJVWv+oYxtK1O6ncc8RBVr2BEal+/qKs8350Hut/zYpPWgjdnZPRsifqVQxrD5VnM/rDCNmxbSGA==;25:s5ZgecvPh6UR7Y6FXIIH23Y7WKvKD3HNiO+eSPCAofSZqDRiNOyeBoVeV7xbZHuZchTj74FlzaA09Fdkkrud0YGW5ArCaWsEDGQiOZyo+0iBKBYRX4hbb2Fw9oZwrmv17R57btkrg4oNOkeG+UnKAao5CVwUjHntAgOsDtx+mLkBnTVjGFWshi+vRttusPHTGBM+gXE5i/zFGI/F0p+eSbR0jXGNQuVc3Rp2uNdOPKmR0wEfRAdAu5JLCsqBNR7nWj8uBBRJitpQuxCHvGX7Li2xeGeF3q0GFco3NO1frurpFwthvKM0ew8eQljqIUtoOT4wmT30kmn7XDUkMCW+rA==;31:pOJDcZ3IIn8q/9KI/bGExxiMSNw8seHnGcNvXKFhex6ZcEMs3M6arQhMOR84aCU7aHKkhrkIdqLyTqqiFXpJ4s9yPj/UEdJM0PykLvtACKnUtMIqbysi674Us72Zo4YuPpJAiSxsVYA2IuSLcXvO3RYMimTTbeFio8PEMi1PFR7tuxTeKCK+0RM2BRnXMLmf2Sh18PQqK21bPbBrL7tsWQsqrb2YKcMbb3C/CoLWwFM=
X-MS-TrafficTypeDiagnostic: BY2PR03MB553:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;20:uXHIoIuDJY1n8ombohcMjjK+nBpARdfbUOCsniLuaqGZAWiIHdNyPazGnlKt8+ZFGS4oRbNc4pLqAuWTVCeB2NEQyDL7B0f8cNgPQGFovyn8rh0xRUeDOv3IZ9pbsBW9txmCLBt2sKpPbx9NJ1y0Ubkl8gDBNH2/Pzj9plSBmB1PImjR1DLqPMcBYOcDLN7U9ub97FI3u5WJavrjoCVwjDUKcoamJha9WRu72dElGvbpqGrzmNbH4/XR7fCUD6ZZMhtTTIxo0mPZtcMDnT+h7yollFriXJ0yQUELsGFHdzdYNYUSQePI6IwDEqiK6XwcW4BQMV0gQjE/uHorX3lCClB2klJeng+D6OOiUiMYWlYXMwEw6/+VfqhYcNnMyhxHiwB+bV+rUZxOFcYTfVXOFHnvwkYp63y4YrJxLhPczZpBnTK21dzdJiLpeuvkwsLnB4b8nRfWyH6AXeZB8VbN2LmNUd5lw819B5nN3odU2KNvh9F/3nBFESlbMz99HfrK;4:CguVjbIt3eEpW9l8pyU4wM2fQV9AJTmT9hPGjOFZID66kDujUD7cDIJNSljsmR4fuf0MOKLgwYny1a8DP1L4Z/xC9EvUWS/YthWMiIRHfq/SWzmbZPfSLkEOcRNGP6o1xX6k1eWb+D8s3O+hW+pvWwkuo3Wwe9RYnQb6FuqMLR8JFkRSojGD1PGPBkjau7RTUtQOwIpLllwGLsDOAjH8gE9gWB6EHODmwFFUgP2VZ87W8w8Q1So7Mj3iSUsWWm2qYRI2NL7jsYSIj4s7mSbr6BaMOTu6GGKYjsMrpoO6AjFio+Ladn9aaCNicNcFPLWtU0gmLbtLGB0t/YCvEhWNhOCsIVJYZf0E2oL9MuoWO+k=
X-Microsoft-Antispam-PRVS: <BY2PR03MB553D3C8EE4FE611F8C5E73781520@BY2PR03MB553.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR03MB553;BCL:0;PCL:0;RULEID:;SRVR:BY2PR03MB553;
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAzTUI1NTM7MjM6TkJpMVhDcCtkYXY5RjZMNXJEQ3lyQ29VS2NF?=
 =?utf-8?B?NlF2b0V2K2xHTTYzdmp5NS9PLzg2SHJ5Q014Z2ZLUDdiZit0dm5VL1pRR0xz?=
 =?utf-8?B?emhvNWZQTkxPQ2ZZaDhOSzJWb1lvZXpaendlVXBlYzQwRjNlUGlkeDE5QThE?=
 =?utf-8?B?T1VrWWFwbExmaGlSY3FwT2ZVN2JNOTRYWHFBY091eXdTOWwrWUY2WERaZk4z?=
 =?utf-8?B?NEZlNUdyOGJydUdjWS8zbE1ldHBqU2ZoK1dxeDl6YjNLZXh2bk1uYWEwRlps?=
 =?utf-8?B?U3ZLOFN3VnVGY0xtL0k0SjliRW0xbXZzMFcrUmVmS2ltZlVsR0NkTmkzc2ZC?=
 =?utf-8?B?aTNyQllCKzY3eVBxbDJzWFJhbzhQWUo3UXpFMGg2MUdKRGl3aDliUWhJUnRh?=
 =?utf-8?B?MHF6MHpWSjNqcGR0SnFPa0xkcDN0cUNZazY4NDZtbC9Ic3JET3cxSnRFOENF?=
 =?utf-8?B?YXFlTkowaGMxR1poaklkbDE0RUNhcDVxU3k3cVhxZDRGVnRQMDJCOElqQnM1?=
 =?utf-8?B?ZFFCV1BtSnord3NMUVJZR0JLVms3a1FMdXR2cGlyT25iQldNZmhkcHBoeHVk?=
 =?utf-8?B?UGJPTk5ZbFNxMDE0dUN5V0l2VHNzSnNhbEpKdTZhVGpRRTZMdTNJbWxTR09R?=
 =?utf-8?B?OHdKVlJmQmhwMHZ6S1E3SHJ3cnZad2VJZHZtUEpXeUtMWFpyS1R1ZnN0WWtB?=
 =?utf-8?B?VXBGSVBOcXl4Q1lCUUxSK3ozTkJETzJjdEgxVWNYTHZEUGY5dTBuS1gxbTZK?=
 =?utf-8?B?cXlMdk1rZGVPUjRhRUVpYjkxVjA1dUFWR1UrNDBHMjlELzIxQktjOW1xL1pP?=
 =?utf-8?B?cTR5R2VHZ2VyMXdpZlpKQzk4Vlh4L2dMUUVVTEVMcXMwT2lnSFkyaUljdDI1?=
 =?utf-8?B?TndsdDdJQyt4b0h0TjhrSUxlbE4vSHpSUEx5bnpzbmx3d3V0OEd0TzZDcGdF?=
 =?utf-8?B?aGNLZ3o4M29nTDAyc0lBWUgyVkQxV0drQlRPZnRPS21sQXB3UmRkWlM5ZStK?=
 =?utf-8?B?bDVqU29IQ1pobVh1Rkh0ZEhCL0xQS0grSWtZN1RsbXQxY1J5NEZaUWE0S3Nv?=
 =?utf-8?B?MDRYbk5MZi9TWTNUVnhGY1lYb2VLNUdtZDQyLzhmSm9UT3JzMEZuQ2pNL2Ur?=
 =?utf-8?B?SDJPYk5nU1pucGVOWjk0NXYwQzhrRXpNc0xOanBybTUxT3V2UGNyWmhFbHFY?=
 =?utf-8?B?M0t2TDBGL3o1TWxqOXdSaWZBa3o2OThOMVliQUx6TXp3b3FTNE1hQ3JtMGxq?=
 =?utf-8?B?OWU0c2RVanBCWjUxRGh6UjIxTGtINUxqaUE1ZEZneHgvWFY3MkwrWTVQNHZ5?=
 =?utf-8?B?UGlYRXdOWlRVQUlqVkxhNG5vV3plY1NRMk9iVXZLQXFFc3IxckhNUjcxWUt0?=
 =?utf-8?B?ZG1rNExQWVNTbWQ1NDlIaHBkd2pKd05DOU5TMzFZd0hWL3Nwb3cweGh6K1lp?=
 =?utf-8?B?UjZuZTBCdkgvRWhRdTY2SG45Q2duTExUc3JaNFdxWXJYb2ljRGpFMVdzMXhz?=
 =?utf-8?B?OG5BPT0=?=
X-Microsoft-Antispam-Message-Info: Oyn63cvQDr3JFToMs2GbZGrobHGlqlBGanOxpT21pIdxniQra8QN9V3NSjVP+tftjYYQYMafKgZnvL9bki9MkUoHb8oZc0QTNrk4l4I47x+mfgxGBTEvNc/7CVPZyrEXL4OizCjUwJTBWOiGoWPVtNnoBrO0sqj2FOJRPo9TXE4afWDi4dIFC8nhoUBBJ1CEj9lKpAOFfPPnarLgzqfqs5BykqzpgFrjwR6W8z31/Z0+2zqKAEAuHWFhE1O4wN5fnD61oxs70MSgFIo5vXKMp3xymd54SIUJlDG/vdv878GUgjHOZY5k2ke/JUE3h6TS50jM9B2f3EoS1ds2B/YnT6rc+J7KLxbHFxixVbWJv+Y=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;6:a5fq4L0KQUr4a1PmVxi9XD7rMmkGDnonK7670/0QjU81Vdaz5MX0TLzXzQdo0e2EC962jrdcWgvrd15r4Z+zxnAwhxq9Mr7sCVMIGLMbTqCHfUVNHDekrTEJvDnnKgOT4gXNZFF6g1UvetJYrZyXObnGxkszh/EvmQjFApO7iEeKT4op4CYK9HZdSlIuSM7kU74PHaRntM6lINDkvN/goQD4P3NB2Wqz+aAB0QHZXDOquTYOsPRPMOeUqcBKAkf0lF/4NjB18LiHa7sYPTwj/hVhJZEKCuiRkrwKHCRGQfZdFPwfMCEmywpi/Dj9CJCaE2pjNEkOFYdKkuRxfiPvtCIB5WIRluwRj8Trv98F/GfDR7+oLuU/wCe0AJzzcaONMn0KaGcGe6lOM4+zJFCavQz+lj5BUrrHTaqn0o0rA800YStZtlmpgUDwKLCM3IzcOY6WbJREo0kj/KDsTAlC6A==;5:3q6myeD4imPMu8Ncb8+9/KB/T/PJPgAb24KztFbMMptdS+Iu65hGhcht3hBMiwep+4N4acfYMTX1zVoZzNaJvQ2WvzP/cHhd2WgCXF5t1qsKYq7usYX0f5sJYdSwng0Zy/jcJeQQbw5eDo3SWbqqgXU0Bl9Xc3V+c+ec4sx5+jU=;7:T92xRhAnzDDsmP6n8yUK/gMEFbEEBbRUSzsqgxL9Rx9bOQL3LCPz0GjDCf6V1tkjGfjN69x3DL/yB1GONZkR5evXXx36V9qwN5EHXqoVe5XZ7jyQWsR+IVgIPhfLdxZ43tlhbBjdtKc85m+3JeD8SgnS2GEGgKyKa8ouzWyWIBIPsi7j/BE/uijV9C+0PiPKRephsRsewsFnRyOCaDS0MPjGAQgAoVwN6fLBt2gv1JEJCQRkL8PJD89hSBMt1qjy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 13:44:03.9076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb26696-bacc-4d2c-dfce-08d5ed7db252
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB553
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic support for Analog Device ADGS1408/09 SPI mux
controller.

The device is probed and set to a disabled state. It uses the new mux
controller framework.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
Changelog V2 -> V3
- removed Kconfig line
- changed to GPL-2.0-or-later
- fixed typo in ADGS1408
- moved spi #include after linux/property.h
- added trailing comma
- reverted back to .of_match_table
- removed duplicated logic inside switch statement

 drivers/mux/Kconfig    |  10 ++++
 drivers/mux/Makefile   |   2 +
 drivers/mux/adgs1408.c | 128 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+)
 create mode 100644 drivers/mux/adgs1408.c

diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index 6241678e99af..7659d6c5f718 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -21,6 +21,16 @@ config MUX_ADG792A
 	  To compile the driver as a module, choose M here: the module will
 	  be called mux-adg792a.
 
+config MUX_ADGS1408
+	tristate "Analog Devices ADGS1408/ADGS1409 Multiplexers"
+	depends on SPI
+	help
+	  ADGS1408 8:1 multiplexer and ADGS1409 double 4:1 multiplexer
+	  switches.
+
+	  To compile the driver as a module, choose M here: the module will
+	  be called mux-adgs1408.
+
 config MUX_GPIO
 	tristate "GPIO-controlled Multiplexer"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
index c3d883955fd5..6e9fa47daf56 100644
--- a/drivers/mux/Makefile
+++ b/drivers/mux/Makefile
@@ -5,10 +5,12 @@
 
 mux-core-objs			:= core.o
 mux-adg792a-objs		:= adg792a.o
+mux-adgs1408-objs		:= adgs1408.o
 mux-gpio-objs			:= gpio.o
 mux-mmio-objs			:= mmio.o
 
 obj-$(CONFIG_MULTIPLEXER)	+= mux-core.o
 obj-$(CONFIG_MUX_ADG792A)	+= mux-adg792a.o
+obj-$(CONFIG_MUX_ADGS1408)	+= mux-adgs1408.o
 obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
 obj-$(CONFIG_MUX_MMIO)		+= mux-mmio.o
diff --git a/drivers/mux/adgs1408.c b/drivers/mux/adgs1408.c
new file mode 100644
index 000000000000..2722fb466e38
--- /dev/null
+++ b/drivers/mux/adgs1408.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ADGS1408/ADGS1409 SPI MUX driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/mux/driver.h>
+#include <linux/of_platform.h>
+#include <linux/property.h>
+#include <linux/spi/spi.h>
+
+#define ADGS1408_SW_DATA       (0x01)
+#define ADGS1408_REG_READ(reg) ((reg) | 0x80)
+#define ADGS1408_DISABLE       (0x00)
+#define ADGS1408_MUX(state)    (((state) << 1) | 1)
+
+enum {
+	ADGS1408,
+	ADGS1409,
+};
+
+static int adgs1408_spi_reg_write(struct spi_device *spi,
+				  u8 reg_addr, u8 reg_data)
+{
+	u8 tx_buf[2];
+
+	tx_buf[0] = reg_addr;
+	tx_buf[1] = reg_data;
+
+	return spi_write_then_read(spi, tx_buf, sizeof(tx_buf), NULL, 0);
+}
+
+static int adgs1408_set(struct mux_control *mux, int state)
+{
+	struct spi_device *spi = to_spi_device(mux->chip->dev.parent);
+	u8 reg;
+
+	if (state == MUX_IDLE_DISCONNECT)
+		reg = ADGS1408_DISABLE;
+	else
+		reg = ADGS1408_MUX(state);
+
+	return adgs1408_spi_reg_write(spi, ADGS1408_SW_DATA, reg);
+}
+
+static const struct mux_control_ops adgs1408_ops = {
+	.set = adgs1408_set,
+};
+
+static int adgs1408_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct device *dev = &spi->dev;
+	struct mux_chip *mux_chip;
+	struct mux_control *mux;
+	int ret, idle_state;
+
+	mux_chip = devm_mux_chip_alloc(dev, 1, 0);
+	if (IS_ERR(mux_chip))
+		return PTR_ERR(mux_chip);
+
+	mux_chip->ops = &adgs1408_ops;
+
+	ret = adgs1408_spi_reg_write(spi, ADGS1408_SW_DATA, ADGS1408_DISABLE);
+	if (ret < 0)
+		return ret;
+
+	ret = device_property_read_u32_array(dev, "idle-state",
+					     &idle_state,
+					     mux_chip->controllers);
+	if (ret < 0)
+		idle_state = MUX_IDLE_AS_IS;
+
+	mux = mux_chip->mux;
+
+	if (id->driver_data == ADGS1408)
+		mux->states = 8;
+	else
+		mux->states = 4;
+
+	switch (idle_state) {
+	case MUX_IDLE_DISCONNECT:
+	case MUX_IDLE_AS_IS:
+	case 0 ... 7:
+		/* adgs1409 supports only 4 states */
+		if (idle_state < mux->states) {
+			mux->idle_state = idle_state;
+			break;
+		}
+		/* fall through */
+	default:
+		dev_err(dev, "invalid idle-state %d\n", idle_state);
+		return -EINVAL;
+	}
+
+	return devm_mux_chip_register(dev, mux_chip);
+}
+
+static const struct spi_device_id adgs1408_id[] = {
+	{ "adgs1408", ADGS1408 },
+	{ "adgs1409", ADGS1409 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, adgs1408_id);
+
+static const struct of_device_id adgs1408_of_match[] = {
+	{ .compatible = "adi,adgs1408", },
+	{ .compatible = "adi,adgs1409", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adgs1408_of_match);
+
+static struct spi_driver adgs1408_driver = {
+	.driver = {
+		.name = "adgs1408",
+		.of_match_table = of_match_ptr(adgs1408_of_match),
+	},
+	.probe = adgs1408_probe,
+	.id_table = adgs1408_id,
+};
+module_spi_driver(adgs1408_driver);
+
+MODULE_AUTHOR("Mircea Caprioru <mircea.caprioru@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADGS1408 MUX driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

