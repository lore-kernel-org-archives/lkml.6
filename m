Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBE0ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C60E2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Pz3kZxDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C60E2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbeIQIcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:32:22 -0400
Received: from mail-eopbgr690120.outbound.protection.outlook.com ([40.107.69.120]:6882
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729631AbeIQIcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RocoyjXW8KHfkvBSgBQRn5LR+teywWJUGFzXncryNI8=;
 b=Pz3kZxDW8DLX7JFog57yo7G/d9V/GDRrv7dyrXlAzipeeCuiJa6RL5nVy8/U6qWEtgKAaooZ4EKqOX1OK3Idg8EPu750twRBKIC7fLDuL2EFIvIh84/yeq95pcj45vSqj5IQXEf8YFcUOrS6iuLBe3aIYt/qWI/sswzZ9PvlGsU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0166.namprd21.prod.outlook.com (10.173.192.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:07:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 07/43] power: vexpress: fix corruption in notifier
 registration
Thread-Topic: [PATCH AUTOSEL 4.4 07/43] power: vexpress: fix corruption in
 notifier registration
Thread-Index: AQHUTjM0SJZWIkKXmk2yzPEK/OUNqQ==
Date:   Mon, 17 Sep 2018 03:04:52 +0000
Message-ID: <20180917030445.484-7-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0166;6:/c2X3HHSa8F0pwtSdBWrt8YD8jTHmC+wvk/kmW4WanKrFAvKEivqtT5s6TM4Y5R3Yw3gu3tTKuKGucempAuSEh6NsvkUeXZuhem4qoEng1FadcHtaPakwDxb3At0w4qISgSDmPbcTbD5s9GhOa/qKzhg0AubORVU2s/fvv1JZxmEsUZX91c1o3lU8ujPxYpCN5sy4ZOfbdhXmvJ2HvS8rhP2hpRNCJltRaYu710KbRj8KX/8wcsjLHgcvYXnvP16boToOFrxXueZz7FGNID83S+d3sX9PUtyAkwzbvLKk0Qz4m/RnzK1TLKMPFV5g8R61cL0QCJj2XtxLccHJ7jnokygdBovlZQUdsZiz3zFYhZ0VYRR+7MlOf+rIuxgs8NWdQm+8u2PbdwRA2mUKkO2KjU4gJRlPjzaVVmZvggo35yLdhQVbO40YB98fpcOsmFSW1PeXKWeAwHzVR8CBAlvjQ==;5:t4o2bSKFecS8ZZbOYLrmj5SajkBYeYnoKeahuyqaWgu0/QSLqQPImiZCn+54o+9DUti2wiEg/AfCSpdAwaFjGWk8RwOvWudWouXxPjmaizWhKKaSWIXTHs5nL2sfYIcvpgWXV7m3MhPaevIqalRP4miBhYRMSYDkZONuF0ZkYco=;7:MDs3uLrJD4f8ZwpkDQmjtCAq3op19Vay8NQjKyZcawHn326gz5DqZ+JjR2YaVCxxpvkut9QON0AOgy42qr/OyH6AT0Hip+OX5z6QW/Rl7EWK+RKr9tdQj+a9H05bD0KyxpjmQmOjvfiGLRK3fj9GUMLMuwEZ9+9JAIAXxM8yBboUlTgFEMZDexSlRdJTUsRI25a0JK5QlFfMfS+5xM6x8hDE91CDU84dMNHncTMjUJvvMIvgYza7HANWXAKC0sqQ
x-ms-office365-filtering-correlation-id: d1abfbab-700b-465c-827c-08d61c4aa454
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0166;
x-ms-traffictypediagnostic: CY4PR21MB0166:
x-microsoft-antispam-prvs: <CY4PR21MB0166C7C423B7CC56BFAD82FCFB1E0@CY4PR21MB0166.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0166;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(305945005)(256004)(14444005)(217873002)(486006)(186003)(86612001)(66066001)(7736002)(6486002)(102836004)(6512007)(2900100001)(25786009)(14454004)(6666003)(2616005)(476003)(1076002)(575784001)(97736004)(86362001)(6436002)(5660300001)(6346003)(316002)(2501003)(6116002)(76176011)(6506007)(105586002)(8676002)(478600001)(3846002)(106356001)(53936002)(68736007)(72206003)(446003)(22452003)(5250100002)(81156014)(8936002)(36756003)(10090500001)(107886003)(4326008)(110136005)(11346002)(99286004)(81166006)(2906002)(26005)(54906003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0166;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: HKxOCCfvqxFIGZZ/dwk97dEQ3K4nD7ghs4bEkxpgZFg+33deTiu/h9lzbTS+WP18jy65nFTmOt5G7AK/Lvc1Jwe2MMo8sipE+uz2Y2tsc5Huj99M/jiL6AlnA56HU8OPA6OiYfdHJ7oZRY43yW09nC0zWndkIMjzRmsF+pHYUv2qyuAJPbSEl9Qe7Uy2x9ewcqzl5Jdp2bN6Uq1uB52/NzwIC6ZGKbU6sjcJI++blUMdT1kDi7I159T/y2KofBXXIq14oiYjpmdbFtmpFK+LjR1X5os5B+kRD37EgjY480NQbxx2CMEMQM2/rfMgOordCuQ1YhCLsrBsFWtiu/iYymmvX8e7ybSPgSw0D6WQYTo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1abfbab-700b-465c-827c-08d61c4aa454
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:52.9924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit 09bebb1adb21ecd04adf7ccb3b06f73e3a851e93 ]

Vexpress platforms provide two different restart handlers: SYS_REBOOT
that restart the entire system, while DB_RESET only restarts the
daughter board containing the CPU. DB_RESET is overridden by SYS_REBOOT
if it exists.

notifier_chain_register used in register_restart_handler by design
relies on notifiers to be registered once only, however vexpress restart
notifier can get registered twice. When this happen it corrupts list
of notifiers, as result some notifiers can be not called on proper
event, traverse on list can be cycled forever, and second unregister
can access already freed memory.

So far, since this was the only restart handler in the system, no issue
was observed even if the same notifier was registered twice. However
commit 6c5c0d48b686 ("watchdog: sp805: add restart handler") added
support for SP805 restart handlers and since the system under test
contains two vexpress restart and two SP805 watchdog instances, it was
observed that during the boot traversing the restart handler list looped
forever as there's a cycle in that list resulting in boot hang.

This patch fixes the issues by ensuring that the notifier is installed
only once.

Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Fixes: 46c99ac66222 ("power/reset: vexpress: Register with kernel restart h=
andler")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/power/reset/vexpress-poweroff.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/=
vexpress-poweroff.c
index 6a9bf7089373..ccb619632e46 100644
--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -35,6 +35,7 @@ static void vexpress_reset_do(struct device *dev, const c=
har *what)
 }
=20
 static struct device *vexpress_power_off_device;
+static atomic_t vexpress_restart_nb_refcnt =3D ATOMIC_INIT(0);
=20
 static void vexpress_power_off(void)
 {
@@ -99,10 +100,13 @@ static int _vexpress_register_restart_handler(struct d=
evice *dev)
 	int err;
=20
 	vexpress_restart_device =3D dev;
-	err =3D register_restart_handler(&vexpress_restart_nb);
-	if (err) {
-		dev_err(dev, "cannot register restart handler (err=3D%d)\n", err);
-		return err;
+	if (atomic_inc_return(&vexpress_restart_nb_refcnt) =3D=3D 1) {
+		err =3D register_restart_handler(&vexpress_restart_nb);
+		if (err) {
+			dev_err(dev, "cannot register restart handler (err=3D%d)\n", err);
+			atomic_dec(&vexpress_restart_nb_refcnt);
+			return err;
+		}
 	}
 	device_create_file(dev, &dev_attr_active);
=20
--=20
2.17.1
