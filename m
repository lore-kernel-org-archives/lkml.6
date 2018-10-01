Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548B7C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEEB2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MS7f4Dk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AEEB2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbeJAHUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:20:12 -0400
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:2896
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728957AbeJAHP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++0hQbvx7aEkwRc7oBg5z4Tyhm3vXIbSNl9QraFeKpM=;
 b=MS7f4Dk4iChdU+vSQccyxSDp+hmqvbpx74zUmScU7n8LV+b1Q5Z9CufPqu0pcSCKA7TP9Z5HMvSe18z7wJ0TYZKMeiY9POs+EzMSNOj9uxFMDIUGvVTNXdjnYkgpFRIDbLeE2zfjmFF2ve165Z7y7Xwc4RqxAN68UCBcmmQI3CE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:40:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 20/26] r8169: Clear RTL_FLAG_TASK_*_PENDING when
 clearing RTL_FLAG_TASK_ENABLED
Thread-Topic: [PATCH AUTOSEL 4.9 20/26] r8169: Clear RTL_FLAG_TASK_*_PENDING
 when clearing RTL_FLAG_TASK_ENABLED
Thread-Index: AQHUWR9h3bX9vNdCXUuGbRehhGgpHQ==
Date:   Mon, 1 Oct 2018 00:40:41 +0000
Message-ID: <20181001004026.147201-20-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:BJStfxTLKVzJ4M36QgmnezwSEFdXw8tPBFJoVfX7i4x0remH1iEiYpC0o7uAcmSxW8NrWsLSnVZpI9TZ9Rux644JT6zpzL/dwbs8d5qKDB3eycnCX7R4cWzk/uV/FaZyAy/fTVbUHu1nm59l+vv8PZB9icpGuOQwDkgIAI/Aj9OLuamv1C3hVV2maxsxM6p0tjKPI5JlCLBVVS/sK5WXFYekLW2x1Bv/eDtXBrNFjqWKvGFKD+Xenv996RZ19ADmyrFjOcB7SdbEsgUF+v9M2K9d0WJpCiMm76nh9r9ActmReAk+hkpXsyFnXfccoCM2NHAAnq2sn4jb+BhLuLtMiBv7+KBt+zGULWAb9CAqgxDD9CU96da9liD1nncSXZzSixxrmVwU4uUaKW3YAzboZQFHz3Yn40V4buK6/skxhmyE9SI9lHWCjlV279iiOquguad9eQjFzY1JnSBNoUqYTw==;5:+JgYVi77ZXW/JrFZY0uG+w0StsahYVXRrro7IMvkAbU5mUsnM4Mu/cuFFGRVmU4srS7In6BJPn3gdrekd8c9dLHIJwJefK1GIdcc9FA4zs1R3fzzpOO5vxUDpwfolyuAaOr/1rJ1q5jOS6VBQihdwcxkjeAPPgGdP35NUpd0xFQ=;7:/gpk/IcEfnmO1kxSV4Y+xCAUhQNnfuGGz1TTduMJkzDbhzQQ16RyhqWJ1XWltEOYv2m/Ccvxw6gUVrWkjQAFsX1IXINqOB3vvFuhO9rcO6PFxsdBoEe6pXuv72IYSgUTNbE9R7lO7WxE0kjqfHneE3J6GPNgTQKmT/aOLHgJmu+jYNVFPJPaOZRSSBdj3TYdWMVdJnaEvQNmTiR4eS3Q16QM1h0v3qzilI52H42Eup6l0KavohbhrizjRMMWycPk
x-ms-office365-filtering-correlation-id: e649e51a-3964-4596-36a8-08d627368406
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB0165D65834651581F1E5B953FBEF0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(476003)(2616005)(256004)(217873002)(486006)(6486002)(575784001)(1076002)(11346002)(446003)(86362001)(97736004)(2900100001)(3846002)(6116002)(2501003)(110136005)(478600001)(54906003)(2906002)(5250100002)(6436002)(8936002)(316002)(53936002)(14444005)(81166006)(81156014)(68736007)(5660300001)(99286004)(8676002)(10290500003)(26005)(6346003)(4326008)(86612001)(6506007)(305945005)(106356001)(7736002)(76176011)(6512007)(39060400002)(72206003)(102836004)(25786009)(105586002)(107886003)(186003)(14454004)(71200400001)(34290500001)(71190400001)(22452003)(36756003)(66066001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: eDThvT3tGE2weOClWQsNnPfjHo68PmfTzc+WiRSYaHq2+mHrUbP0F0NrQWvAjdJhFGatWJ1esWx8jg36stJZb73Wx7/YQjZtnowdCeM5JxOiH8K2z7meOcIPrM+EYih6NhLk+Eh8dTfwo0T1JdBthGzMUAqdV92LUtl75FF6Fj9nBd6jcZhgeUJFetN7PDA/1pakUrHPZIHjyr2USaweHRFzHWV+oaK0RiVXK4BdVStcNkmMnVsZENlTHhnHtvqwvR8Ykjmbwkv2Z/gkqpBJrbkDQ2nsnd8gQSvCF1h7XA3SPl+FKJxHTNNTg+rok8gQmGKjhx8QOvN3EVkolsabqzrkRi6u8ctMYtTa3U1tapY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e649e51a-3964-4596-36a8-08d627368406
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:41.5129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
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
index f65e8cd6d144..20f5c0cabc89 100644
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
@@ -7637,7 +7637,8 @@ static int rtl8169_close(struct net_device *dev)
 	rtl8169_update_counters(dev);
=20
 	rtl_lock_work(tp);
-	clear_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags);
+	/* Clear all task flags */
+	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
=20
 	rtl8169_down(dev);
 	rtl_unlock_work(tp);
@@ -7820,7 +7821,9 @@ static void rtl8169_net_suspend(struct net_device *de=
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
