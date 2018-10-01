Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A77C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083BC2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="O3IO5nq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083BC2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbeJAHZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:25:48 -0400
Received: from mail-eopbgr680138.outbound.protection.outlook.com ([40.107.68.138]:20182
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729230AbeJAHOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChowiGe90n24CNk7BxGrMglzCtYKnYjIymwYRdhTdAk=;
 b=O3IO5nq+DjrHQl6JL4Zz1S/gVoixC8rZc6FeYy2kjd1L8EJT/d4U8746Jl3cUiQz2YugjiisFPVNTlVHVyjQ+ik08Lp8Pftqv0jP2c+ZVwSE9WzGnIYrowuZGrqOwna4gVJpsbXUAO9+3BtwuZcve7EQ0a/8BAuRyyPoxbvhUek=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:39:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 57/65] r8169: Clear RTL_FLAG_TASK_*_PENDING when
 clearing RTL_FLAG_TASK_ENABLED
Thread-Topic: [PATCH AUTOSEL 4.18 57/65] r8169: Clear RTL_FLAG_TASK_*_PENDING
 when clearing RTL_FLAG_TASK_ENABLED
Thread-Index: AQHUWR8Y6PSO0Uh5qkqHKcN7Bjzk+A==
Date:   Mon, 1 Oct 2018 00:38:38 +0000
Message-ID: <20181001003754.146961-57-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:KdY0tIFj4/uSTunJf0uwqRgwEZZCs52PnSKa/fmRlQk9V/qlXxNloY7H+oCGoRUzTopMHo5oFiir+WezWeyIvbOC5RHvuVqlIKLDrS1NfOwV2vk+6ti6nk6yGr1l2xFlhOIzai2Z9r7zpDQv6g1jR3sY8td1+rFMpYUkFtokJ/8SUJAgLvPnKFiR5C8z1TZkZMhp3v/NmWd8kI5UJa7VMpDnZxDk9Zcl0oSgnwH3qvAgrTMoF1sSbe7mV68uEiAMyNhTazkxoRU5OhLiXrCIl+l0iEz6y4+1SFCvdbKEhHFmVsKqwsybM2iMMH8l9OUIIbs8poxQfcnVvgd1hhSdHiKIv4TCfNQluLfjaN7X+ZBJl+GJfXU0DK9RPGYpdD7CXt88hr7Z/Y92dzZ132u3g6PiUccv/sD/yWcCc0brID+W96I7h1QwwwzyFMIRk6ITMIrl5LCJPUiYmomQjl9oYA==;5:P6M7LtbP1zakMZB/Tx7zWC+kKk3fCPYgv0n97zx6DvZ0Tjwxcn75fhGIrfYpjT5eKoqSMOITh0RCS5LaUwM0AG2GMc6v/VxC4pit5CaE5XKdmjOnL5EuJ5mda+w07JK9JxFGMcoFY01WBCN0CfYlc5/9YIIZEU6o5tBa61ph7So=;7:6E9W6B7pY4jV1Rd+Q4WvRSkMR/dSaghasjQMu/ssT8x1MflTvuZwefMjzQxMuwmjOVTCkBodAsu87kxRyUTnStNnDi3I+FyFJNk14jZT18DazeWUe80Nj6xM+mX+BzO915FJCV8MYqJgU9687q8sdr/y045SsiMCXUxoPcwoMwvtmulCf86VScvC7+WwiXfAy9iOG7FKGNWmITIGWzuV3Gtl87W3Dv48hG9+8XZs38d+SMTOP2Xf0rXnA+dwU90o
x-ms-office365-filtering-correlation-id: e49222ba-8f93-407e-8951-08d627364a67
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0824A1017002F41F9FD74AEBFBEF0@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(256004)(99286004)(86612001)(22452003)(2906002)(25786009)(2900100001)(8936002)(14454004)(5250100002)(36756003)(10290500003)(76176011)(2501003)(478600001)(316002)(68736007)(8676002)(72206003)(305945005)(81156014)(6506007)(110136005)(54906003)(7736002)(10090500001)(81166006)(107886003)(66066001)(486006)(86362001)(575784001)(6486002)(105586002)(11346002)(476003)(446003)(2616005)(53936002)(4326008)(1076002)(6512007)(217873002)(6116002)(3846002)(6436002)(97736004)(34290500001)(102836004)(6666003)(5660300001)(14444005)(26005)(71200400001)(71190400001)(186003)(39060400002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Zg/4HSYmg1DZocZOwc+1Riqm8YhO0FJyhkCzTUm2lKP7LLPBLmvfB6TLTtKgZl8KcE4m8DLJD+XJvDfTkU8V8finPGJvmXVO3V+jU1Ytra/UsNAoQgHU608rNeHiw8LkHSjG3efub0gmRk0cHLPqkhtukRjUYwrD0uXrIxa0e4wheHLrCBtVTNlVf+pBn7N+lDo0+QJmR1mijGzxRY71Bozd8VvOWGI8aCPexK8x/PeaHBDuKtuDih5x8b/D7OeKNxRR25aM1iFQhnDlUATRLp60sNleAPYBiOpFtd2dVnqDG2bFcsAVTeeOwlOzcMpDFPhGb9PRBD1Nkxz/cFnhJnBUEVlzp9eyN8PNBQnApWY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49222ba-8f93-407e-8951-08d627364a67
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:38.5561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
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
index 5d4b094acf0d..1d1e66002232 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -730,7 +730,7 @@ struct rtl8169_tc_offsets {
 };
=20
 enum rtl_flag {
-	RTL_FLAG_TASK_ENABLED,
+	RTL_FLAG_TASK_ENABLED =3D 0,
 	RTL_FLAG_TASK_SLOW_PENDING,
 	RTL_FLAG_TASK_RESET_PENDING,
 	RTL_FLAG_TASK_PHY_PENDING,
@@ -7125,7 +7125,8 @@ static int rtl8169_close(struct net_device *dev)
 	rtl8169_update_counters(tp);
=20
 	rtl_lock_work(tp);
-	clear_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags);
+	/* Clear all task flags */
+	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
=20
 	rtl8169_down(dev);
 	rtl_unlock_work(tp);
@@ -7301,7 +7302,9 @@ static void rtl8169_net_suspend(struct net_device *de=
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
