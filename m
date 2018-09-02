Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852D4C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206C72077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XKIebFaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206C72077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeIBRT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:56 -0400
Received: from mail-cys01nam02on0091.outbound.protection.outlook.com ([104.47.37.91]:41829
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727487AbeIBRTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CX4ClJAUSb/cRZt72GK2AvWmBcce09C/rn2dTb0t4GM=;
 b=XKIebFaHS5R4BIkcTlm8pv+aiMXZrAWOJVgRNN6+um4ZH7ZYXbTJdM98ePEXlQk3Y6ksYG6Xl6JawnWno4yrKMYb5y+NFItODDcRm7VuQOryoQXwmnv6rmw60OSqfi2X/Noqp2L3QSNpS0TcIy8W9cfL6DBha4wlV3Y+6RLVrH8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.4; Sun, 2 Sep 2018 13:03:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 019/131] clk: scmi: Fix the rounding of clock
 rate
Thread-Topic: [PATCH AUTOSEL 4.18 019/131] clk: scmi: Fix the rounding of
 clock rate
Thread-Index: AQHUQr1TS7hfywG6tkW5rjEl4+mItQ==
Date:   Sun, 2 Sep 2018 13:03:22 +0000
Message-ID: <20180902064601.183036-19-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:ag7Rmv5e976PvyaaYC9ARo3QfNjP8Xz3ilANZu8VMmwIjAdMM3/8xZZjLrjLsbCQg8e75cjJy54DkQcLZ6Lm12vW+3XM3HYjQ36GD6RvdJHd+5AwFxG+yMXeestb7ss5ztVZA1hVHcK97xfl84SVEMmSmmPzmmBUAbx1Tu2UI9AIDuNsjxdj01321YxJIft1qKncPrTGb3inLji8INfUpw8+YBVNkIKP1aBIhi+FXdo9JOiAtkj9zhMgTYSnQgDt4059rlGuJy8lSnTKg0iLqBkpPzjcpkkEXUCsyCXZFJoGB4cuHMcVkdpE2jeameKjd4dJuWgUH5z/5Fq0MJnAZjLVilWQ6r0W/WDcxhdWcN+APnxx+MoivM7afPzf5Dzf/M1FdKeKRxabc6jztlAMwf9touFdyS1l4wFVSIby+kzvYNJX7MgPDv+5pah01bkjoOXAik19Z0qUQ2gaZBWV2w==;5:MuBOz2E1H3rvbZ6nyEueStqgUAuRoZzB7R0jpFWAhPYtIxcnJVNzB3mIFVoOqBrf9/mFQUaMJ0Fq5HfU7XTGWNibGQQp7u5Nt2wKK1IDw5MNmEDLhcwxZW7aJ5+daYDFEoLI3aLqJM2tKMJ6WjZa8Dep0J6t5LB43xyr3C3AY8U=;7:ohhLFm85+Q3N77f4i8tH0LvmlDNoXYZql1UC7xuFqVPGmY5Tdwvw1SJWvwQlEKuot5lZPvpbgESloxfbvy1L54aTtGYNcC95/JDvrOnyeUS6EEDBlpMaOuCViJaAJY3XFilOly2TPF0EIueUBVYohhNlSLKrwVl0g1u+5Iex+b+R0kUYQY5WjQaViDNVEfRaePUea9ZypNKocbQY+sW8xx+2myZg6Yn9Mo0CjMQ2cm+lv0niH59akLEozRrKGIIm
x-ms-office365-filtering-correlation-id: 358e781a-5a03-43fc-60ea-08d610d4766e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB015019223C5979A007410DDFFB0D0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(256004)(22452003)(2906002)(217873002)(3846002)(68736007)(10090500001)(6506007)(6116002)(1076002)(6436002)(102836004)(486006)(53936002)(76176011)(106356001)(105586002)(7736002)(305945005)(8676002)(316002)(5660300001)(6512007)(99286004)(36756003)(4326008)(97736004)(5250100002)(2616005)(476003)(2900100001)(11346002)(186003)(2501003)(81166006)(26005)(8936002)(81156014)(110136005)(54906003)(107886003)(66066001)(478600001)(86612001)(14454004)(6346003)(6486002)(10290500003)(86362001)(72206003)(25786009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: bGNnN5prBI3ZKJDkLmQrFffVTQ2TYUfcqYy9nOPTaLJ9o/wR71C0ekqVEzIAquW7YqlkcN4BfVLEfhrcNCmMf8MvdvgkbDtzGQe7OSdKfzD4g1c1KCpu97MoNA2lRnhjjm8X6rpOLmjzra99VRITrsyd4VU7S29W0dv8nFf41nqAKml6uJppprPX7bg8VtjEU4pxMvlrASSYCBVTWFeDT6drlk6ajS8Q/kQC2G75vkQ1ryf+nyqnOJZovpLRjfGJNMYaTa6JYyx1xidI9E5EaoniHm3w5m8ZmJTki6W9FVfA67wm/ixMGimyoi++4grSuVH2EuPJr15pcp7kP6TYhFauBY84xS7kjtFtSt3HB+E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358e781a-5a03-43fc-60ea-08d610d4766e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:22.4009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Daniel Kachhap <amit.kachhap@arm.com>

[ Upstream commit 7a8655e19bdb3be43f6a3b4768c9b0928a2585fc ]

This fix rounds the clock rate properly by using quotient and not
remainder in the calculation. This issue was found while testing HDMI
in the Juno platform.

Fixes: 6d6a1d82eaef7 ("clk: add support for clocks provided by SCMI")
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/clk-scmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index bb2a6f2f5516..a985bf5e1ac6 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -38,7 +38,6 @@ static unsigned long scmi_clk_recalc_rate(struct clk_hw *=
hw,
 static long scmi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long *parent_rate)
 {
-	int step;
 	u64 fmin, fmax, ftmp;
 	struct scmi_clk *clk =3D to_scmi_clk(hw);
=20
@@ -60,9 +59,9 @@ static long scmi_clk_round_rate(struct clk_hw *hw, unsign=
ed long rate,
=20
 	ftmp =3D rate - fmin;
 	ftmp +=3D clk->info->range.step_size - 1; /* to round up */
-	step =3D do_div(ftmp, clk->info->range.step_size);
+	do_div(ftmp, clk->info->range.step_size);
=20
-	return step * clk->info->range.step_size + fmin;
+	return ftmp * clk->info->range.step_size + fmin;
 }
=20
 static int scmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
--=20
2.17.1
