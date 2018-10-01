Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE7DC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0552083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MMwYVQ5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0552083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbeJAHRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:17:13 -0400
Received: from mail-cys01nam02on0136.outbound.protection.outlook.com ([104.47.37.136]:43745
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729539AbeJAHRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8wbFbhzlTDmP9WSJOt3SYsY6JVgJMW/Oq34rFtgf5w=;
 b=MMwYVQ5iEUXcTnHkCredQpLyYrW36JlfSdJqn1yh78GU/g8QxgVJYNBFM5GnmgRugwwNumzoKjVmfPJwDJUYFcTBxLuTOOQCMspzY1LVfTlsuZFjOcifMeX/aNh2NJmP88dr2NlJEHffSRaiaxagK0vn3dynkXje3aPlkuD6ED8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0791.namprd21.prod.outlook.com (10.175.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:41:49 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:49 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 09/13] r8169: Clear RTL_FLAG_TASK_*_PENDING when
 clearing RTL_FLAG_TASK_ENABLED
Thread-Topic: [PATCH AUTOSEL 3.18 09/13] r8169: Clear RTL_FLAG_TASK_*_PENDING
 when clearing RTL_FLAG_TASK_ENABLED
Thread-Index: AQHUWR+JKBoP/LbqAk6C8RBUQgiqrQ==
Date:   Mon, 1 Oct 2018 00:41:49 +0000
Message-ID: <20181001004139.147341-9-alexander.levin@microsoft.com>
References: <20181001004139.147341-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004139.147341-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0791;6:fL9weAgLxXSexgZGHyaXVS2qmM6aP2+dFxfq5J44AgHGrCv9CMXxRkTpJDqXbsUmYf5tN8p3DBEXUk7mIogSSGuPZSIyb1VALOuMWe77SDtXnFIXB+TQB1g8U3glTeCQbb93JFsPeZhwOf7Hu5+/+jzBAC2ZRrPoC2P73CfXHq2ZddlqXkCY5SYoZxHDoGKGCYROgmspsFwyWgpURnw1RGpcAoDQfVgMehcr4nwQV0kcwtOY3yrnPkwzVAeskjln6jYSGGXWGKypyHoLIZ/VO0tZcpADuhXx6WEe7wp9J28SE+zRBG0qcCs6Nl5LZN2LIAYNhcH42YzMXQiebiDYczjXOxBAjZPvKmXAELqoV73HnBuHN3nPZAxPDujYXq3eLB/VYdL0PYF/4nSoCzD5bazSILVb0KGjoCOp0mpQaqbN04Xnm0ijKHY72nlW0TBSReoovVnt4OyyDevthWwMRA==;5:ap9fuOV54vMl82AZSmMft0ERCHBQypZ6S7EZl9qu6OKH38e/+DzZpI52YyQFQVbciryPotlZN5cUlBfgSHHxcf1J6rXpGUq1qhVCtXgw9+7kC9WpNVh9jRFQQRbGgUjvcDdmcjb+26aMAJTSoYL3wudT8mvUPI9lNKqjaqI3MM0=;7:rhWJb078t2GKQJfKN8Vz4dEttqVMalQg/bBDbEdpMGo2c9V2MQHvEj3kk118+yXRAvSFPwShJxdOgIsbPfuQhsZ8TkX+AX7Zkb+YJqrWCHZX97dUI64jeg3CK+BMroFStTcc7OYwf2fvdqTm0eu64PQypHfT/CNzLC7XEEQ4793rDdzrBCYfCAkP2hz2A0cbuaD3JjXaJXZy0bSv0IFCUaaAHbJub6wmaynHxgOwpbnRa1M/mdCdApTjY2MgoM7H
x-ms-office365-filtering-correlation-id: c247ea95-1115-450f-1c52-08d62736ac59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0791;
x-ms-traffictypediagnostic: CY4PR21MB0791:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0791DF673799681357A38121FBEF0@CY4PR21MB0791.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0791;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0791;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(72206003)(71190400001)(478600001)(316002)(110136005)(14454004)(2616005)(54906003)(105586002)(107886003)(106356001)(186003)(305945005)(26005)(34290500001)(71200400001)(22452003)(7736002)(256004)(14444005)(25786009)(10290500003)(99286004)(68736007)(53936002)(486006)(6512007)(446003)(66066001)(36756003)(6506007)(81166006)(81156014)(6486002)(5250100002)(86362001)(2501003)(5660300001)(4326008)(11346002)(6116002)(476003)(3846002)(10090500001)(97736004)(1076002)(8676002)(8936002)(102836004)(217873002)(6436002)(76176011)(86612001)(39060400002)(2900100001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0791;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qRrGJGd69JEIL2SPss7L60pAGHoY1xRXw5/tMSh6+FaswgyvZ7T3uQ/R7dj7cftTE4yuGlCuqMymVx68uVG0sAskMiIPgqGc2bCAh3twW9n0Us4E3p3vEOaAuZIyVFJmJEENnLjd1+sNeJyjVLRVGNUzh0i/PvADDFC4Wt16VNFErkpYb26KXLJmkAYR+5i1kBT5/y9zCGUT0hseY6MQ/MWyQu766WrzfXJkQAAakSZiwjH4hnqLFIPTtMfsSBGusPzUWGT8ydjdlHy95nbluGu3pzVmu0jgAHCIixAuNITKPwbo0MLXtPALgBVT5c3/Z1TWeH6YluehYppmpMRa4OrShpFPIA+9biIW3WYIXqI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c247ea95-1115-450f-1c52-08d62736ac59
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:49.2061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0791
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
index d1ea2dfbe16f..c9aa42ca2b64 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -749,7 +749,7 @@ struct rtl8169_counters {
 };
=20
 enum rtl_flag {
-	RTL_FLAG_TASK_ENABLED,
+	RTL_FLAG_TASK_ENABLED =3D 0,
 	RTL_FLAG_TASK_SLOW_PENDING,
 	RTL_FLAG_TASK_RESET_PENDING,
 	RTL_FLAG_TASK_PHY_PENDING,
@@ -7523,7 +7523,8 @@ static int rtl8169_close(struct net_device *dev)
 	rtl8169_update_counters(dev);
=20
 	rtl_lock_work(tp);
-	clear_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags);
+	/* Clear all task flags */
+	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
=20
 	rtl8169_down(dev);
 	rtl_unlock_work(tp);
@@ -7679,7 +7680,9 @@ static void rtl8169_net_suspend(struct net_device *de=
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
