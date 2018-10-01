Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42FBC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3FA2064D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AvWII/Zs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3FA2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbeJAHPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:36 -0400
Received: from mail-by2nam01on0090.outbound.protection.outlook.com ([104.47.34.90]:27744
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729720AbeJAHPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IILSDYwQxeylMFZHyFbpVsaNHD704cpzRzTIeuYPEB4=;
 b=AvWII/Zsj3foNuV81bAyIwmYOm1OQqhCPczsAI5e+KVXbG0QmUc7JQ2lxudJcseEuvA9rl7XsaLFJqwx2MHNvpMohKhZh3MsOxP/JQV7h1gq0Tso+BZ74zH+0gzn5aE7RNtsvWSVHbxwH9RE3ghUfPMeImGCHurAglR9cFZe65s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0854.namprd21.prod.outlook.com (10.173.192.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.4; Mon, 1 Oct 2018 00:40:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 31/37] r8169: Clear RTL_FLAG_TASK_*_PENDING when
 clearing RTL_FLAG_TASK_ENABLED
Thread-Topic: [PATCH AUTOSEL 4.14 31/37] r8169: Clear RTL_FLAG_TASK_*_PENDING
 when clearing RTL_FLAG_TASK_ENABLED
Thread-Index: AQHUWR8sbLGRolMiME2wc252Fr1itg==
Date:   Mon, 1 Oct 2018 00:39:12 +0000
Message-ID: <20181001003850.147107-31-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0854;6:2Dl7UgbyNF6xkMP3GITLxn2q+V+hMycuwpTdXc81XwVPoQ1Fp6DIDUMhs7GbnWSfY1x9V7I4UgI23SsNb5lTAF5+hxuZS4IlZTEUOcW1RXvVgA0QhmufFX9cb15aM/bQRK0iumsvI+UeRqhOHImBQ9/M9KHFMI/Ah+/ysYdDhmDAc55W9XVjYzsKvIjjzVRut3ijOD57kvdcuyqg0gEj/Rn8s77ms7LM4dSy3kmAB/z1qLUoT5OBac1DcUvGX+xlhgBht+wPBv1HBYvS2V3QilsVlpkFa55cMQlQ4on2FgQONkUVzRYXkZj2Y1BYysO8BULZ3LsFSwPixKRRMQSAM8hvPhhmrGdbTLwot/QaS6Wuet2qkQI/cYftDHXnSwXh414ylOHI+5aPd7D6cm0hDszwmH0aHf/+9K/+7bPXd1DzyLVdb+NxYN7y+lMgENaCrX+7ugS7yF0OIoclO3shNQ==;5:HTahBxJq0IHkXd+0Ql+ccIYn9GDRcC2suHQSNjExegvAYc/HlNohzTYXihMruTWSPhKVW+BfYFOvRQEyGlu+ii4B83x07vsraOKGjDE5rBkgNqol+DF90S2sm5i9SgnlrBiXqf82d4cEwqE7SpTocJrgOhlvNqaZkVQWV+r8gAQ=;7:KqBXl9DjtH/+MUa4ffWaM0vlv6XOPMf3GRfabzpJdVcfcPKsmwbytenoS3ppPnmZSD1Y79/fubhM4CUsQ+Mjc3l5cRRH5ScWZNABdkmJ5xhfoPFZ3LeuvhofZJuEceAp9oLFaqiAu3FdT4lokx+e1XgxEjnU5Zh48q2UAcC5Rq0eEUhY/tLwf6ThJDc+b8YEHsHd75tEfL9CbMcW85J+mXl0YH/ynpiPAuCqd0K8FF5m8etpeKHTDvqzWOMUo1y1
x-ms-office365-filtering-correlation-id: 3f583140-16a2-4062-c7b9-08d62736767e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0854;
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-microsoft-antispam-prvs: <CY4PR21MB08542FC21A3B7C166AF05681FBEF0@CY4PR21MB0854.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0854;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0854;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(6116002)(3846002)(217873002)(5250100002)(1076002)(71200400001)(97736004)(71190400001)(76176011)(6506007)(99286004)(36756003)(6346003)(26005)(39060400002)(2906002)(446003)(86362001)(11346002)(476003)(102836004)(2616005)(14454004)(2501003)(10090500001)(14444005)(107886003)(4326008)(22452003)(486006)(316002)(34290500001)(186003)(256004)(66066001)(86612001)(305945005)(25786009)(2900100001)(6486002)(106356001)(7736002)(6512007)(53936002)(81166006)(81156014)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(10290500003)(6436002)(478600001)(72206003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0854;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 0qOKuBu5r9yzgqL7r3A6jp1bthsFGA0PRj4Z/H/7at44G9a5iLaLBFn8GLMf6quTFWgGZJFkiGlKLE5OKoXsgJu5DMTstkrnsThSReIBDCKpD9kmmtbliYJ8XembOkNg5RwTolfFq9y8XybiGx1+SKc+fxcYhlKJ7SqpexYegaibDeP0feWljnwU9AKqHB9EHxBcgR+dQHzU3ROeCamORfKxK3iyDW7I+BhHltNZlM+nKLXL6KOTlH4zrIpBlx2Jnr8HfKNwPFPSCyU7Ya6DGNJ4URDd5MZKQKMQwjIgCWc97ntSV1i9kD+LDdG4QRAU2WCTlT1CaQyfqV1GiOXM4mpyhz4wiWxzbLXg7mI33nI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f583140-16a2-4062-c7b9-08d62736767e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:12.4822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 6ad569019999300afd8e614d296fdc356550b77f ]

After system suspend, sometimes the r8169 doesn't work when ethernet
cable gets pluggued.

This issue happens because rtl_reset_work() doesn't get called from
rtl8169_runtime_resume(), after system suspend.

In rtl_task(), RTL_FLAG_TASK_* only gets cleared if this condition is
met:
if (!netif_running(dev) ||
    !test_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags))
    ...

If RTL_FLAG_TASK_ENABLED was cleared during system suspend while
RTL_FLAG_TASK_RESET_PENDING was set, the next rtl_schedule_task() won't
schedule task as the flag is still there.

So in addition to clearing RTL_FLAG_TASK_ENABLED, also clears other
flags.

Cc: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/realtek/r8169.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/re=
altek/r8169.c
index 3669005b9294..f7e540eeb877 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -760,7 +760,7 @@ struct rtl8169_tc_offsets {
 };
=20
 enum rtl_flag {
-	RTL_FLAG_TASK_ENABLED,
+	RTL_FLAG_TASK_ENABLED =3D 0,
 	RTL_FLAG_TASK_SLOW_PENDING,
 	RTL_FLAG_TASK_RESET_PENDING,
 	RTL_FLAG_TASK_PHY_PENDING,
@@ -7657,7 +7657,8 @@ static int rtl8169_close(struct net_device *dev)
 	rtl8169_update_counters(dev);
=20
 	rtl_lock_work(tp);
-	clear_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags);
+	/* Clear all task flags */
+	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
=20
 	rtl8169_down(dev);
 	rtl_unlock_work(tp);
@@ -7838,7 +7839,9 @@ static void rtl8169_net_suspend(struct net_device *de=
v)
=20
 	rtl_lock_work(tp);
 	napi_disable(&tp->napi);
-	clear_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags);
+	/* Clear all task flags */
+	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
+
 	rtl_unlock_work(tp);
=20
 	rtl_pll_power_down(tp);
--=20
2.17.1
