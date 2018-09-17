Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE32ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1318208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="k/nGr6lL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1318208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbeIQIa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:59 -0400
Received: from mail-eopbgr690134.outbound.protection.outlook.com ([40.107.69.134]:52946
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730105AbeIQIa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0ncOjyrafHCJq+/q7ztZPu7s7yrwhopdsbKhZMQ/mo=;
 b=k/nGr6lLsd2+BRUnvLXZa7idczNcwelnNGn+zqkjWfacTFW80yEeqFqmKI1Sv76I7/xp/AVw2uhG/rPnQPI8svC4hAM714b/d7RKzv/1e80ScsAXx+9B2RDQRppOBmFEzMniToNfzf83yuDxRTtv202lbC2oh79WfM4ZdNB9wNM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:05:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 07/57] power: vexpress: fix corruption in notifier
 registration
Thread-Topic: [PATCH AUTOSEL 4.9 07/57] power: vexpress: fix corruption in
 notifier registration
Thread-Index: AQHUTjMNWIR4bA6t60CLtpiSJiXfIw==
Date:   Mon, 17 Sep 2018 03:03:48 +0000
Message-ID: <20180917030340.378-7-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:QYjzH+oCqPM3XAHYH27WM3L8McLLAE8S+Uf61jjRYsZvtYicaNVENzgpqrHSgFEpW17F87KokftOqxS8qBiEqR6r/zLZhGJpV/chGyOW7AKV+U3ooqzVkgXfVZHIcF75jeknKphHAnxYVd9a/SRP86HCixBtTAimqqNEFa2OKgGpOrI3RiMD2TPuZ3bQykokaeZZTeRWHXMweCp7vNdcuzgHLUyu6glarM4i5NHeNCGFWOHRWlkFmbzhhMg/0J+Zlw/3k8WDevKnF2fFhiEH19yjqRR5gebP5jvAc3KV+BeqE5yuJhEdyrwyETtqlhTox7Zh/aT2xzmSnzfJhUP5rXLOA9WGuGzS/mMfmYsh6Tm9Jz1yWIEjF75TJH4PKb+CsoRCOH+0xJh1uaKUYqiek6MSNQZI0CFtWZJTpPxJFiYnCW1ezWCQdqLlHbY0qeLc/Jbww+Ky3wqsRTSgfcdkfQ==;5:aSiqcN2Mftx8UwEela2HWYFL4DhVmKg98z4Y80Cl1ilSqkQOM62bGOj17lunqEmd7jqF1a3iUWMLqkKYzRMejrEPSI5Z5E5FCRjonMJoq9N/91zOPlO9NLtRj8ylpBde+3cOkoCxZ6ddEsBFAN6FVz3jcDH1FoP+3NQQ2hzSfQw=;7:V7JwljVKP35HSJ39G6FYmTar85qTi67UdH2oKfVwXJftPNYchvs/0lb82N/6iySp0HxT+YH63x9lFYF0O3uQz34mKAar+cHJ/8DSiy/5eLYK3lnBHvveqm1smXDatFVGVl/nAvk1AlupCbxKIUWZU40a1tWPej6tvuNCqF24FeA3j50R8KxZPCfUbbMPQufEbUjYOgQPrAKJMRRO988M5lP25YImfAnsCfjOzF3jS+q1BBnYvemhL43PX/d+4Gx4
x-ms-office365-filtering-correlation-id: 70934518-d61a-4cf8-cea4-08d61c4a7179
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB012098A5C96551E106C17EBFFB1E0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(54906003)(26005)(110136005)(446003)(2906002)(6346003)(99286004)(316002)(575784001)(86362001)(25786009)(102836004)(10090500001)(2616005)(2900100001)(76176011)(97736004)(36756003)(11346002)(72206003)(478600001)(10290500003)(3846002)(6116002)(1076002)(22452003)(107886003)(5250100002)(2501003)(86612001)(4326008)(217873002)(105586002)(106356001)(6486002)(14444005)(14454004)(256004)(6436002)(8676002)(305945005)(8936002)(6506007)(81156014)(81166006)(7736002)(476003)(486006)(68736007)(186003)(66066001)(6512007)(53936002)(5660300001)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: tA8HuxYtYGK2e/pIHwWtDZh2GtEkkncGTx5CS5bpSI+4EGN6t0zYb4p4h2Z7Q1EWAhv5wzhmVP8OOgj/ClTFvnqZbf32D33yBNbM1SIHPdrOw16kQQoJcLKYJSpV0a7KXvxJSJWsvd3K2ZOHjmbxZthAfwRGPY8DqDjGFm0g/osUKVYxDzrp1kHfmtUugtGin7D26ywe3083q82kUsV2sKbtqy12JsrejNYthqO96ZSxrms/kff+ambYUXK9F1fJDgZzA0/+EUi6cqQj0y869FnM1tc2XXE3+A945Isf6ax4gtBKL+A2kPgyMoCw+IKTTO5p2ALacS085pOcZCP49lZfuU3/A0xGsYBjzcvgeA0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70934518-d61a-4cf8-cea4-08d61c4a7179
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:48.2117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
