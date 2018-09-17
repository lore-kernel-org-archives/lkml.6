Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0420ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBD32147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kt5YXi/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBD32147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbeIQI2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:54 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:50080
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729856AbeIQI2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0ncOjyrafHCJq+/q7ztZPu7s7yrwhopdsbKhZMQ/mo=;
 b=kt5YXi/yb0/+dej0XVknBNm7sQGaUQCItNvDRWHTUvADdUhCxWh0viYsQUTDDcpenuEUgackKMpGXd7HRtN7Ot9Svu9Wzlgql9FSELlJVmjVbiAHhyIr4WSFSwxKARKI94t336MTubG71sf20reSw766ZOxL40x8YkJaxEh799o=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 11/87] power: vexpress: fix corruption in
 notifier registration
Thread-Topic: [PATCH AUTOSEL 4.14 11/87] power: vexpress: fix corruption in
 notifier registration
Thread-Index: AQHUTjLgR02SHI1GEkGQQhY+BDpR0g==
Date:   Mon, 17 Sep 2018 03:02:31 +0000
Message-ID: <20180917030220.245686-11-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6://xvVmIeE4aHzHp4LN0uoDza0Hixkonkh61ZbBYK0Mv3z8xM7IJjNERRvzMtYuGCHAEt8vpd/LCyRKf8z9A6zvYtKhb+fP/xRYYqt10gtUZLg+6JHdctCsSIeJBcEOTig+kA+W/gtHfRSgRASiM/6UHYXaeT+we9M6fTvkU1ITKJ7dWlbtp8iFW+fgGHaxfmoC+/oq4i7pA2+sX6upj988OBSdJWoXCT3D6PN96XqInAGZjhgz2IvboH+ycosbf9RdClm5zfwldI+apdyqj174h86P/thtlIdLFcbI48fjAG0m6bvZ7YEMGIae/5jqErIxEgo90ffoiswjsiuw7jq6sbKS6Gm+K4Avf73bzB/eiHhxel8IAwQLZ54bJOC5zGY7wTRWpUuiO9YRENyEzbZ29UzCClAX8kixfI6SNHEj5HaiPGu2E7zXub562fdT6TzSQsWXPcIKRvdoQ0hli3+w==;5:VXtGelZo20tFIhYJnsu06g8SiocmvNZEdXL2+HsMFjiEkXque2z7mcL1t3yXwUbJ3wbNmuRUf4lmJveuPrFg9V51Py72QMxFXO7skuPAOeznsJNaK87fmrX+SBmtva6V7oPt5iE41KA2ZKnOAqUJRRQZNtxTiao6ohUBEF7SLCg=;7:jJgEH1XTX/LZShBUw6ix/Uwu1nwckrJx2l/5LGGbTqAYw27+L5WjiXgxyQn55O4qFSM9fLZyNTOgkmYhctCI3YmtFdcEQWhAELfL9jMgI4UJ7eO6iQuOGaitMu3vKyEo4/usgPMp2WwtUhjMF6X+N2rAySeUd0HFc86ca0K0ieN82TKe9GrArIixUNjZWquH23Ktr7MNP9tSgnh98XUPTp7jkcFBEK2oS8LTseox+qWBRM4gEhPvTOCKRuhQvI14
x-ms-office365-filtering-correlation-id: c6d4d61d-2438-4055-fc24-08d61c4a2763
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855B0B7C6ECAC3CCB3B6F88FB1E0@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6436002)(99286004)(7736002)(110136005)(54906003)(97736004)(5660300001)(66066001)(446003)(72206003)(76176011)(86362001)(86612001)(81166006)(81156014)(2906002)(478600001)(305945005)(68736007)(105586002)(2616005)(106356001)(476003)(11346002)(22452003)(575784001)(6486002)(10090500001)(10290500003)(8676002)(36756003)(6346003)(6116002)(6506007)(3846002)(102836004)(107886003)(6512007)(1076002)(25786009)(217873002)(4326008)(14454004)(26005)(256004)(14444005)(486006)(186003)(316002)(2900100001)(8936002)(53936002)(5250100002)(2501003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 8ODFQwU20lTDPyNK8BrjY8PsreR/cAFN73SfZWTQB423edKMam9jQSlP+lRJOk1BQByzRfOey3BkZvAGUQlm0feTShtD+9VNWE6pfNqbo2QQHAJpaGmNTSzyHHe7iOMCxGc2M0a9VK/JgV7RBB3UwyW6+5o2juvFqqwbuwUsu0tT+XbsRhhaMidwMpUOWDDQuIbz0SLL/WO1LEHnzutN1GinfQqbtXjVe9lxWpyN/hmD13CpDz/S/7lDv8qinOcLcH5IQnO1MoCZOgsiM55QUh/EqOhlwKnHAcBasHKYQah2pheob2NP0wOTWeFuDAtZ3jC9w1+oD1c+ZDtcAaFLdyxNrRJ56HEJfMh6762PPj8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d4d61d-2438-4055-fc24-08d61c4a2763
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:31.7751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
