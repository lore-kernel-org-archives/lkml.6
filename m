Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B61DECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9962147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AGO/IFUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9962147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbeIQJAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:00:20 -0400
Received: from mail-by2nam03on0105.outbound.protection.outlook.com ([104.47.42.105]:52843
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728585AbeIQI0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0ncOjyrafHCJq+/q7ztZPu7s7yrwhopdsbKhZMQ/mo=;
 b=AGO/IFUWhY4K4Qk/bLlG5PnvSSUjQeZVAtCYoS32WAdA/3K/ijAlc85hhBycJ5xp0+egwglRpGCepMoOk5Z0bMzfpjJTTvD44QTK7hBWnYx23V/G0BAHtQdENfINwh130tuqmiGqQub/xTwMMOE9BNR97Kt3RnBC8925fHWZVGI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0277.namprd21.prod.outlook.com (10.173.193.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:00:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 017/136] power: vexpress: fix corruption in
 notifier registration
Thread-Topic: [PATCH AUTOSEL 4.18 017/136] power: vexpress: fix corruption in
 notifier registration
Thread-Index: AQHUTjKSO61cwmS7+kSPgaPldbggnA==
Date:   Mon, 17 Sep 2018 03:00:21 +0000
Message-ID: <20180917030006.245495-17-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0277;6:ZGVebXhxV3p2i9+hnhhyuKKK5BE/KMHcj+eFAXYwidlCa7Kf/afKLdxRZ74FTi3A4mGWyGD1cF47OfQJ/VMPAyiOotogcFkeHWgjihEfPS8q9nDI1ArJr/AM0OjGMMBli8FaFwhN6ZjVqHT96CtVrH/DqIkPESCXVoWANHpXEwB1LjxtEIx8G2J4oFRowQRCBfnrBOpJSZEckjivKrN4RamFGwXk/oEZa4ywhMregZmUnyrOSF2OSIJ8U9pZ9bLnIeQ2hNY4Yw8siNYrcCAGu1ETcOkKHItpmNnGWqwvj2KgxaJCDJVQPAugsfrETxC/6XeU/712PVIpl2doCUCNCxCw6Ak7vrbS8cvWEldgqWbKABpgO26tfz7CztPmlbzYYbIA/YCM9/HyfoUrP/T6BSgP23vUjPBuoMG1wz2lU9+tLFVJq+djFcCImpj+VcwICzJDY47B0kVS5lWQI4C8jA==;5:P+h7Ywg/fLdkLIXUghj/vHZjs4qbod7HD+AZTB+lrM5OKAE70RTbxFu7FJwBb2Z2QrSH7+wIEnGfRkJSAKUWjsbroQddojNIHnOYfdkC42fV33TMFKAoYcG4fKAQ8QN4ccH1GD6tjIT5PMlT4vHZuEeslnspSKNgveSHl3Byl2c=;7:EUPb0J3bxv2KP1I8H0nGtnqtEbhA4NraFodQU8KVEuAeXAOILau+RMCyVGgmGUBZt+xi9xPfrRu0hQJQnpKW3DmhLDND1c/Ql6G69YoknRr5bmVX+QIC3h0UDeyv1YGPoAFqfuXZqG/oVGY+jQsHI/gX2KnXePu7Wv9sz0Z0ENIAI+JNiwt/Y9DWNeWdU9ZQYNjbPDG2cLKzXtxmNVAgcAH9iZorTBvaF9AfeGI5T0EqeTJae7ZAgz/PjA5u7pjx
x-ms-office365-filtering-correlation-id: e8397a30-9af1-4bac-6eaa-08d61c49b715
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0277;
x-ms-traffictypediagnostic: CY4PR21MB0277:
x-microsoft-antispam-prvs: <CY4PR21MB02776EF119130FE152E1B3BDFB1E0@CY4PR21MB0277.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0277;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0277;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(446003)(4326008)(2616005)(53936002)(107886003)(11346002)(22452003)(68736007)(486006)(316002)(14454004)(106356001)(476003)(217873002)(25786009)(105586002)(10290500003)(14444005)(97736004)(66066001)(6486002)(6436002)(5660300001)(256004)(5250100002)(6512007)(6666003)(2906002)(2501003)(6346003)(99286004)(72206003)(2900100001)(26005)(6116002)(186003)(1076002)(36756003)(81166006)(6506007)(10090500001)(81156014)(86612001)(102836004)(575784001)(86362001)(8676002)(54906003)(8936002)(110136005)(305945005)(76176011)(478600001)(7736002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0277;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: UVnN7iV+o1At4CcB8W9NSU1SZcUgBglwzbucAFy05PPzEhwMwYuD3zSEmi0mVSJjcFjoTPj5TTZfTr1wsxdRcX/ntrGUrztpOowemFnuz9bh9YrdIZm+dkY6wWdf5aAqC6XUulSROpqdotaerIy3FRaZfb3BBvMK5/QoZgmpt0IKupj6Ctnfsma6hyKz5nJCi5kpUXskF6b/rc4z6VpkYV4rj30cj7wdlkomCJ8WqFj4x7ctAORgP7RiGpn546g+WAUhSi9vIJX33dR1bKOsX8SnCtvNrf434GZx/iRfHMJedid+W/krfrbBDhBdU24uf94BDHh729hFimA66A0R9iHownB1q+JdGW7Inv0hYsA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8397a30-9af1-4bac-6eaa-08d61c49b715
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:21.8235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0277
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
index 102f95a09460..e9e749f87517 100644
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
