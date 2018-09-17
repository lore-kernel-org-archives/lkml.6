Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007ACECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E98208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fSaePRI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E98208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbeIQI7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:59:19 -0400
Received: from mail-eopbgr710118.outbound.protection.outlook.com ([40.107.71.118]:45407
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729031AbeIQI0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqnHB/Pj4yfI5iIMOTIGW6zOKBHGUX3wvO+n6d3mfRo=;
 b=fSaePRI75pdrMSEcAbQLJjxPN7VREFC2InHYiqNKQ9Divy1OTOirpXvCvVnBsfdlMdrpYt/grDdWbmJhEo4fLxH6Qz3yZ7OM6QBWGApfuws5mg+RLxWhre3h+nklJgqSFtfEQMuVz5WWmXYMDxyeSMBmbKHF72oJgypv+DJSnhE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:01:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 057/136] ACPI / button: increment wakeup count
 only when notified
Thread-Topic: [PATCH AUTOSEL 4.18 057/136] ACPI / button: increment wakeup
 count only when notified
Thread-Index: AQHUTjKiviZ1UzJFMkKToahw62Ez7A==
Date:   Mon, 17 Sep 2018 03:00:47 +0000
Message-ID: <20180917030006.245495-57-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:ebaVW/tQklFslnlK5yPbr5OyD62dzMx2x+rO+d4BcnbDlBc3IvwQ5cio/c27fTXCgpeZgbLmpzvIJrwnbiGFQW48wP+1AZcwj7awHn70H4fXtrUeVQrT0nAyJ4+7TW+hCBwB56p9XaSJUKnQjTepHdbVCbMd7H6QWkxGq2DP7rs3oI8i71SBfa25Ybf+Gq6NLYRHB/sMo1/Yf434w7tagqOtP4g+GEQmGHgGVlZfkz8Xx98SVBPGKGPqVsLBg/b0gn+EbecryYAfOrUGZNIVrKz+Hsr9g6u/lpsUVwXNX5xUFI3lv6LLucc0zhJkL14PuBSAscEQ0vYh6VC6Y+lReS00Z/JxZ+FMczk/ao3kOpmmoOv3zZVzHr4WFIi/hQlsj8FQSxlBrtYkHTBmIOfxYffsw8ZgzoLf1HeYUVKAFDqaOLnQ358AnUS2xRAK9+PzwgA3Mctl7MTjhGIa0OfbiQ==;5:FU6bQNaLLIM93dMCqKpuH44Njo49j+rBYi3I1TNxratO+4lsrqd7OXll6C/ZKfeMwHwSoyDjGRYAsHltKNLWwQpF8VT9/cz1BghcXVqer7D1v6Gf7GLgsEKKf1hxjBfck+De6Ki7rpahlFcVNcPCTn2SK20lp76lg2WkOr7ru74=;7:Urwk8goiCfq27VMFTbp2tpynFHIxdYa0ukLjGAame2F6/fdTIR+utyUK4T9afgufjmPhQGZSqUEXMpO4Yv2wAl2qK5b2DG08J/gCzoFXzvPBWCZqDQd3jrQ5jMC7UgXEjHbpp4d3v5OI/xHAlnvlp2nvIhvKwDyrjioNLvI923ThwIi8dSXsKEeOXH2OPNaxlnmO0IsWQwcodZcMVfCqgia5fSSG9zx5Me+kG9Vtef0ZStcn/wV+L2e661R3SnVS
x-ms-office365-filtering-correlation-id: ceeda4d8-b9fd-4c91-6513-08d61c49d58e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167C6DE2AFC6A860A192C81FB1E0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(6116002)(1076002)(86612001)(4326008)(97736004)(53936002)(2900100001)(7736002)(107886003)(106356001)(10290500003)(81166006)(105586002)(68736007)(3846002)(99286004)(305945005)(36756003)(8936002)(2906002)(217873002)(54906003)(86362001)(110136005)(25786009)(316002)(5660300001)(102836004)(66066001)(76176011)(478600001)(446003)(11346002)(2616005)(8676002)(486006)(476003)(6346003)(186003)(26005)(6666003)(6506007)(6512007)(5250100002)(6436002)(10090500001)(6486002)(72206003)(14454004)(256004)(2501003)(22452003)(81156014)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 6x3LiGtDYas0PafQWuB6lS/bOsKumxBUzuttKB+sudTnH2pQiIXu/cQhxKEHEnPUJGT+NazvzvYcrNO/lrVSCRmIiqCs1QTFA77+A/Deoj3n0nhy/iLSB6UY86BrswWtl+DEI+byhuBbWHHZR73wo/TrI+ecuofr/6TvUFccdcgvajA95Ssi/AX60kWtHx9vvoiQ7FdIh2+DoGjiGOSuPfmYuaMGHtiJCQbh8KFmTotKiIZmkGKxoA/KtXgxv7pitKl9gwnvp4oXs2nO0fVhfsqZDSGD0WFWTxKggeDd+ozQiw4D1rnfhtFxadMH/WR5r4b9QNr3VvtlqqmH4AtI6gk7CV35TUju9uQ3v3tQrMw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceeda4d8-b9fd-4c91-6513-08d61c49d58e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:47.7451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Chandra Sadineni <ravisadineni@chromium.org>

[ Upstream commit 7c058c7c74b3dbeb7d157c273959f87faf710350 ]

Because acpi_lid_initialize_state() is called on every system
resume and it triggers acpi_lid_notify_state() which invokes
acpi_pm_wakeup_event() for the lid device, the lid's wakeup count is
incremented even if the lid was not the source of the event that woke up
the system. That behavior confuses user space deamons using
wakeup_count to identify the potential system wakeup source. To avoid
the confusion, only trigger acpi_pm_wakeup_event() in the
acpi_button_notify() path and don't do that in the
acpi_lid_initialize_state() path.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/button.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 2345a5ee2dbb..40ed3ec9fc94 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -235,9 +235,6 @@ static int acpi_lid_notify_state(struct acpi_device *de=
vice, int state)
 		button->last_time =3D ktime_get();
 	}
=20
-	if (state)
-		acpi_pm_wakeup_event(&device->dev);
-
 	ret =3D blocking_notifier_call_chain(&acpi_lid_notifier, state, device);
 	if (ret =3D=3D NOTIFY_DONE)
 		ret =3D blocking_notifier_call_chain(&acpi_lid_notifier, state,
@@ -366,7 +363,8 @@ int acpi_lid_open(void)
 }
 EXPORT_SYMBOL(acpi_lid_open);
=20
-static int acpi_lid_update_state(struct acpi_device *device)
+static int acpi_lid_update_state(struct acpi_device *device,
+				 bool signal_wakeup)
 {
 	int state;
=20
@@ -374,6 +372,9 @@ static int acpi_lid_update_state(struct acpi_device *de=
vice)
 	if (state < 0)
 		return state;
=20
+	if (state && signal_wakeup)
+		acpi_pm_wakeup_event(&device->dev);
+
 	return acpi_lid_notify_state(device, state);
 }
=20
@@ -384,7 +385,7 @@ static void acpi_lid_initialize_state(struct acpi_devic=
e *device)
 		(void)acpi_lid_notify_state(device, 1);
 		break;
 	case ACPI_BUTTON_LID_INIT_METHOD:
-		(void)acpi_lid_update_state(device);
+		(void)acpi_lid_update_state(device, false);
 		break;
 	case ACPI_BUTTON_LID_INIT_IGNORE:
 	default:
@@ -409,7 +410,7 @@ static void acpi_button_notify(struct acpi_device *devi=
ce, u32 event)
 			users =3D button->input->users;
 			mutex_unlock(&button->input->mutex);
 			if (users)
-				acpi_lid_update_state(device);
+				acpi_lid_update_state(device, true);
 		} else {
 			int keycode;
=20
--=20
2.17.1
