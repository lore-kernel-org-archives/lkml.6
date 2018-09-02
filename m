Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D56C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF0A204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gsQumPAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF0A204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeIBRYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:38 -0400
Received: from mail-by2nam03on0099.outbound.protection.outlook.com ([104.47.42.99]:42688
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727876AbeIBRYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+QFCwXQemAs5KbBo8z3h9haFicmRs0ZqB2lICmyI8g=;
 b=gsQumPAM5qCJONLx02Yhn2hD2FIGu2b5nhgnFCA8fi6asOqsdLETR7IfXE5R+pCjIhR8BC5QaoyRfo2wCgmqx87e9Ko14SlOU6uW//h9/nUv6211TM+bPzUwl2W4MzC5ZhgjCBMq+V8EBesO+g/8H3vV/vTCoOTqdlDf05rwY68=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:11 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tejun Heo <tj@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 41/89] ata: libahci: Allow reconfigure of DEVSLP
 register
Thread-Topic: [PATCH AUTOSEL 4.14 41/89] ata: libahci: Allow reconfigure of
 DEVSLP register
Thread-Index: AQHUQr3TxvcLg2XLGku74QihPFE/yA==
Date:   Sun, 2 Sep 2018 13:06:57 +0000
Message-ID: <20180902064918.183387-41-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:FPmEizDEf7fm+93VSmTalHl3CntXbU8LqFc1Jt6PF4hf1Wn/shmm+r6c322PkIEKT3zbnbJs2RW5BcCGrb3Qul7IVp9jOgc0PPV4Y1UlhHTdJN6ie9xYFSt536cvxG/S0ZscH84MzXXMjtjWmLaXoieGRMXvGwsDlnzxz29o8jH4coVtbiuqU0jxJD2hXPS1ZVS71EB1hmWCvV186N8fRTjnwF3jIIcp3IfLMYEfmSksiFyGLvPZBV6KWtYcMk+/J6lQyoMrny5LYGEl+XUhdGS+SX6WA2IOS1SQ2waOGsmjJMLcl6JeDjX5IJqF7HTVI3G9mm2GQLJIR1XMpFVuOqwtj86SPUqIH3eOpb3AcBwHPRcmbtxI12vDUZA2YQ14mscFwzckAV+DpMIcvxEj4uNX46MeWYm9PRAxRRGvkkcnVPs+BNGzdW/Di+389VyQql9fwRHjagw32RRzsEGksw==;5:7AJMBJqvuw8IpvIbMmfeyQY9FXY1LVV3XWLrpiDDsgSEWniOZleZSDAHb8gORCvQLrs3n44QkzTNL1XZAWk+dRD5EWljaq8IUAKA2pg3L2+fRPIahjGzmOttKWDq4rk801lFdhiYWpmxHlMq8Ogp29wKKRxf639keUH5fkSWhuI=;7:/3+hLMX+Ag6i2X2wWWyJMuaSHfUzo+ZSJKISnWzDs43COj4Smjw6Y3O9oye/p8x6kbowo2TYA59Uo5H0pIMSm7kzoXlAvgm1tQBsZ+wan4uKTIOa9+oVs98gBLecN1Ss9+TNisXJ2qHisZaoVB7Ozy20AazxwrjsNF/Dwxinz6NC1Hau+cO5qHQlxi1ityTUkYenwaACeSgI3Gj09g0TCw6YlIa5uFH7hoYVzlmhaQ7ONckLNhDcVXlGEfpmZbbD
x-ms-office365-filtering-correlation-id: b1f63877-6c3d-4e14-ef14-08d610d4fea7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB0503EFA021C6F35721AD14DEFB0D0@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(105586002)(8936002)(102836004)(6346003)(68736007)(2900100001)(6116002)(217873002)(186003)(36756003)(81156014)(81166006)(1076002)(99286004)(26005)(5660300001)(66066001)(6666003)(8676002)(54906003)(256004)(316002)(305945005)(22452003)(3846002)(10090500001)(7736002)(110136005)(106356001)(2906002)(6506007)(10290500003)(2501003)(478600001)(2616005)(72206003)(6512007)(53936002)(575784001)(86362001)(86612001)(107886003)(6436002)(14454004)(76176011)(486006)(25786009)(476003)(97736004)(446003)(11346002)(6486002)(4326008)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: P1kmEdvbVlo7B+pX1d4NDgBUvJnCO3brQoWcgd8BhpWk+Cz6OFkW8og3L0TrJoIi+wEzZO3+40kfP9sUEJcqLVgoDDSqPBKAYoEELlyQ3/BQCozNo4quNTVK9rB2LO0ch/EFibAxtG9swhcFRXj03pItWKLRTzruXvvWVNFdZDJSol5NR0zGPaLPJTZ6+NmK3akqSOmXEYJU2/Yp81lR00AxhE8/lgT4Dwr6bEfDsE6Tv2bSgJ4GcO15lb049Yk7US8y602YY5RFm2P1Sf/a8E4vwnpLeAh2pit8ZEH2JTpCXgJwLVhSP/AQ6SPMaw1Q4c09rrp3FaJTIbu52W+yAUP1yqTODLNclP7Xw1pudIg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f63877-6c3d-4e14-ef14-08d610d4fea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:57.2638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
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
index bc562fd2b0a0..25edaf8f9629 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2096,7 +2096,7 @@ static void ahci_set_aggressive_devslp(struct ata_por=
t *ap, bool sleep)
 	struct ahci_host_priv *hpriv =3D ap->host->private_data;
 	void __iomem *port_mmio =3D ahci_port_base(ap);
 	struct ata_device *dev =3D ap->link.device;
-	u32 devslp, dm, dito, mdat, deto;
+	u32 devslp, dm, dito, mdat, deto, dito_conf;
 	int rc;
 	unsigned int err_mask;
=20
@@ -2120,8 +2120,15 @@ static void ahci_set_aggressive_devslp(struct ata_po=
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
@@ -2129,11 +2136,6 @@ static void ahci_set_aggressive_devslp(struct ata_po=
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
