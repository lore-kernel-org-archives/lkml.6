Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DA6C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6365F2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nfUhobl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6365F2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbeIBRtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:49:17 -0400
Received: from mail-eopbgr700098.outbound.protection.outlook.com ([40.107.70.98]:16799
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727497AbeIBRUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmWDhIP723M04HOAoqrVYgNMKgE3CPHXOl4VqdrIC/c=;
 b=nfUhobl3wDwqUucwHuyyw1mo3OpeFnU3Qj3D/fWHGXTl1/V8WzsTzR5Z0uHlqiOgzIkGptYz2hTsbyjz3FYemTPSF5P3jiilO8hCg8pCNr8KRuVbFmjat9OnWLuRzi0Bodr6uTPFfjzTZUUmpbpU8og/PCpxq/nnRedPm5PUSK4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:49 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:49 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tejun Heo <tj@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 061/131] ata: libahci: Allow reconfigure of
 DEVSLP register
Thread-Topic: [PATCH AUTOSEL 4.18 061/131] ata: libahci: Allow reconfigure of
 DEVSLP register
Thread-Index: AQHUQr11oYAqysAyokyTeUWQwMbt9g==
Date:   Sun, 2 Sep 2018 13:04:18 +0000
Message-ID: <20180902064601.183036-61-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:iMnzY5JMn00nBnMiT2aN3zcxtXLIzUvJcHbi0vkjD8MAfiuwdpFkhxq+okxLe0kF5ymf5rxUDxd4FXnbtJcy1t+qw7nQRCNCzdzkbFhl3W5mZMPOxGKN/1kBYvGDZevaz3Swih6FHGvp6YIfPFdJ9zozQpYQpDKL0LSRzTPYbXJdPU6Gy+T1IQD28ksA8njmmepFqpq/yDRTmNyA1ejR62P5Xp3YHNvQciDgZ6+FnYpROJpUObIXooIQwYsUYppzUU0A4q7JHhMSFqccTXs2qkUanv70vZqeRMfp6doMFmVTbBBxXEM0IunDaNe+a0nC5KmzgZgez63JFDglEqZYkqTw3WJtwjzCc1esaQLcfiUikL9ieGfH083dB12gLxIyomUPiw5ZZQUyTO6vEpeplvS/rSisGz9+J6+SJuBHjI4GNDuOADEmWJxt6dzeTbKeJGEKyjiW7Nm8x0tgxA9lLQ==;5:Epb5dQREhTUlT1neMlyrRFXXP3Ppo7E9868365mgzJp4w0qXk4dGzE4JmrGIEj8yr/EqTDHvCSKaUwTRcaUew9IRzfrE1cUiL5DFRuKcp5cZqqVpapxRlKaKI01nFlUQGLolFrDYmJ96yw+epvlZyJUQ10LzRz2r9W5cYoLhvls=;7:DPFjsi5T3ztP94141IJm/Zjas4fhhsc+5V/TWgvHan6hVGjNtNopIGBunr0Xy5bOFXM4dNeSOAn+6viztcEr/1y7/F3FA4JkMfj9bx5LQOOOmiICt13883vyyx8snau2QNIjcDK/5RGvxUPi7Z5TwK5kBOnwtAFflkBnW6lgrjBWuKHjIKgo9Ee3xnE/OFRrL7W0TGnPspMuJWVCYtW026fdBMYfNBmyKHHuNE3FnCBGj39NQqCNakCwV8Wtb2j0
x-ms-office365-filtering-correlation-id: 96d0cca3-1d36-4742-1da9-08d610d4aa08
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01201A00508B11B00AA6FBF2FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(110136005)(5660300001)(107886003)(26005)(6506007)(6666003)(2900100001)(8936002)(68736007)(66066001)(99286004)(76176011)(217873002)(2906002)(1076002)(316002)(3846002)(6116002)(86612001)(54906003)(6436002)(305945005)(7736002)(256004)(575784001)(86362001)(6486002)(25786009)(10290500003)(478600001)(14454004)(476003)(22452003)(5250100002)(97736004)(106356001)(72206003)(53936002)(2501003)(2616005)(446003)(11346002)(6512007)(10090500001)(4326008)(36756003)(105586002)(102836004)(8676002)(81156014)(81166006)(186003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0QFXDh9J/SymwDwf60R92fRJVVwEytuv1hCICpvPTa3DwfhS1GTYjQpuZQV+5R0pz13DHchzSpkqPzmpveyvfOK6bIKV4VqYwER858NdAlOnljEButYMNd9DG73bDYZtx90LRdyBtIJBeSLrD/yKj3aeMIoyd+qUx3qg9lNkXD8U3ZiRjQXygoSJDBObzoxcpeimMVVBF1BSFHt0GDN8pXOStBkitBUpHYPumcha8HtUOSA6SIjHf95sPU3yDSS+E28J8hdXypkJ6RYutJLw1yq9KRZzCtfnLqEKflss6vLeJbyIB276N+NxUK4mFNEUg+SYUqA7IYPLHRi7xkrDxEhHfuKVzojfgrs1p4EmSvY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d0cca3-1d36-4742-1da9-08d610d4aa08
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:18.9434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 11c291461b6ea8d1195a96d6bba6673a94aacebc ]

There are two modes in which DEVSLP can be entered. The OS initiated or
hardware autonomous.

In hardware autonomous mode, BIOS configures the AHCI controller and the
device to enable DEVSLP. But they may not be ideal for all cases. So in
this case, OS should be able to reconfigure DEVSLP register.

Currently if the DEVSLP is already enabled, we can't set again as it will
simply return. There are some systems where the firmware is setting high
DITO by default, in this case we can't modify here to correct settings.
With the default in several seconds, we are not able to transition to
DEVSLP.

This change will allow reconfiguration of devslp register if DITO is
different.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/ata/libahci.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 09620c2ffa0f..7fa4b74c3051 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2107,7 +2107,7 @@ static void ahci_set_aggressive_devslp(struct ata_por=
t *ap, bool sleep)
 	struct ahci_host_priv *hpriv =3D ap->host->private_data;
 	void __iomem *port_mmio =3D ahci_port_base(ap);
 	struct ata_device *dev =3D ap->link.device;
-	u32 devslp, dm, dito, mdat, deto;
+	u32 devslp, dm, dito, mdat, deto, dito_conf;
 	int rc;
 	unsigned int err_mask;
=20
@@ -2131,8 +2131,15 @@ static void ahci_set_aggressive_devslp(struct ata_po=
rt *ap, bool sleep)
 		return;
 	}
=20
-	/* device sleep was already enabled */
-	if (devslp & PORT_DEVSLP_ADSE)
+	dm =3D (devslp & PORT_DEVSLP_DM_MASK) >> PORT_DEVSLP_DM_OFFSET;
+	dito =3D devslp_idle_timeout / (dm + 1);
+	if (dito > 0x3ff)
+		dito =3D 0x3ff;
+
+	dito_conf =3D (devslp >> PORT_DEVSLP_DITO_OFFSET) & 0x3FF;
+
+	/* device sleep was already enabled and same dito */
+	if ((devslp & PORT_DEVSLP_ADSE) && (dito_conf =3D=3D dito))
 		return;
=20
 	/* set DITO, MDAT, DETO and enable DevSlp, need to stop engine first */
@@ -2140,11 +2147,6 @@ static void ahci_set_aggressive_devslp(struct ata_po=
rt *ap, bool sleep)
 	if (rc)
 		return;
=20
-	dm =3D (devslp & PORT_DEVSLP_DM_MASK) >> PORT_DEVSLP_DM_OFFSET;
-	dito =3D devslp_idle_timeout / (dm + 1);
-	if (dito > 0x3ff)
-		dito =3D 0x3ff;
-
 	/* Use the nominal value 10 ms if the read MDAT is zero,
 	 * the nominal value of DETO is 20 ms.
 	 */
--=20
2.17.1
