Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8A7C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA832077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HwZjlQNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA832077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbeIBRpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:45:22 -0400
Received: from mail-eopbgr700098.outbound.protection.outlook.com ([40.107.70.98]:16799
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728267AbeIBRV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwlnYovzaUSjC2W0YcUlcF4+UuOs/2PklDxIW9siygk=;
 b=HwZjlQNEr4kP6xKOo/adNzRHupNiZgeAkE+wuHcrspWtY+xD3ifzQQuXZzPUaBKtIzpwBcR7Y1eYRwyGoUqg0wQnRCs9moN+Qo3YAuw280HnPsD3D9XtnQjwu7g6J0IqWJLjb8Z93Iu74zmx0oI92wO2PnOAuae98FPmWAWVLaA=
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
Subject: [PATCH AUTOSEL 4.18 062/131] ata: libahci: Correct setting of DEVSLP
 register
Thread-Topic: [PATCH AUTOSEL 4.18 062/131] ata: libahci: Correct setting of
 DEVSLP register
Thread-Index: AQHUQr12Eptwio1jwkKl42Ju0013OA==
Date:   Sun, 2 Sep 2018 13:04:19 +0000
Message-ID: <20180902064601.183036-62-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:od9taaDlt1eNWIEA/Lp9vylu8ytGf8XQrjYN1xzlLV835yvzXHaeHYiQc7gjrDNPM8fiy1xFq1IEKixBFA8xS5bb2DhyW7mJfj5FJ+vWfKTUQuFZ3cSBpUeXR1HN30KwOvIuJuHxXV6/jAlvgMld4eVuIUC7VWKtP+dA+xSQpqINg2iJo3yOcHBYzUjeoB5QzegKtQw6uXe2x9OB1iGviXFGBjayMhZvMajzd8hLLUVyV7ySveUQzKzWnNotmRFjUTo55jyETUXaKUlZ+sX0tqCHUnPdXteLQsW9ysLLsePk6kcYajllBL4CJEqwunwGn3MC/srAFpfnsx3ld3KuNBjfJBRY3H/8kG+CDjdTjck2swnvnqamdUeWUW8vPQFLjCLMIeMh8THi3+KdOwi4WO0CdITf3iQ9sEyMErP+OBq9UhUHP53krpbpEgRHARPFgZ6ZLC7uxY9NzuBAuSvfgw==;5:AqKk5Qyi4lDzaEdoSqBoizl7Hnw9Fkm2kgHnyF9qayNlo+VLZpnZluGTtBsadwNzmXvGDHzSjQuR9KLU0zIWV/u/vhzhjQwUzTvVGkKIBIEGgrlJeI1ZMcwPHd4fvbGuUA2REznK2FxoKC4NiiWZx5BoMVREMiYdx8xYxAXERco=;7:29ZJy2r0TBwCupf52psDVjA/n1vh31B3zvKXhbPbJrl7Iiv+eAmL9Tw5CXRmlnd6jWuYPe3Xfpnd0FwMXvGs8olpbr+A0tAjTQb3MZPkVIzW8+8ksDEfORPS/Xxqq7P/R+nfvoj9Ka6XVCsZEA7winGLMFctrpY2BukRiYV7N2oy5W9nuU5o8oMrx6hKIRWShqXzBbLqOjKcB6Ho4xHyfxPW0v7KqgSvrtSWEDZUtfiX1pHbx7vCK2cO5Qf94d7G
x-ms-office365-filtering-correlation-id: a7d9eb8b-3d71-4b6a-baa2-08d610d4aa46
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01203F75F3C0B4C3EFEE3B96FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(270512070085399)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(110136005)(5660300001)(107886003)(26005)(6506007)(6666003)(2900100001)(8936002)(68736007)(66066001)(99286004)(76176011)(217873002)(2906002)(1076002)(316002)(3846002)(6116002)(86612001)(54906003)(6436002)(305945005)(7736002)(256004)(86362001)(6486002)(25786009)(10290500003)(478600001)(14454004)(476003)(22452003)(5250100002)(97736004)(106356001)(72206003)(966005)(53936002)(2501003)(2616005)(446003)(11346002)(6306002)(6512007)(10090500001)(4326008)(36756003)(105586002)(102836004)(8676002)(81156014)(81166006)(186003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: w3+51rcVzNHluw+qzye0ahKJ9WIjgNwwNJBL+dFUxMbyxooA7PA6PYHrIYp0O51gc+z2fxLui1f8ZA4Sm1Trk9WGFfbwNSgmI9MRCyDB/FQFMt7V4zPfyegYTUvoUtcupwklyIv09zxxI4XgvV43DRTaYZrwkoLHTbN/HQWlqJLme+a1ybnQ42gztSdxmTENldGmzFgbfzSAItHDJt045Zm9BM3oqPK/bszbMk1vsODyKm9LTgbCPKB/eM5MdQSeMdJE7ddvINcw4bRoM5ixCRx5UIGsFxSFootKzsSWl4dP0Xbzih2nT2W57LJ6ZuPu0oCpc9s3Aj1k28JLCkIleaTT2nCcoOIb1V4VTL7vG/Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d9eb8b-3d71-4b6a-baa2-08d610d4aa46
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:19.9673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 2dbb3ec29a6c069035857a2fc4c24e80e5dfe3cc ]

We have seen that on some platforms, SATA device never show any DEVSLP
residency. This prevent power gating of SATA IP, which prevent system
to transition to low power mode in systems with SLP_S0 aka modern
standby systems. The PHY logic is off only in DEVSLP not in slumber.
Reference:
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets
/332995-skylake-i-o-platform-datasheet-volume-1.pdf
Section 28.7.6.1

Here driver is trying to do read-modify-write the devslp register. But
not resetting the bits for which this driver will modify values (DITO,
MDAT and DETO). So simply reset those bits before updating to new values.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/ata/libahci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 7fa4b74c3051..704a761f94b2 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2164,6 +2164,8 @@ static void ahci_set_aggressive_devslp(struct ata_por=
t *ap, bool sleep)
 		deto =3D 20;
 	}
=20
+	/* Make dito, mdat, deto bits to 0s */
+	devslp &=3D ~GENMASK_ULL(24, 2);
 	devslp |=3D ((dito << PORT_DEVSLP_DITO_OFFSET) |
 		   (mdat << PORT_DEVSLP_MDAT_OFFSET) |
 		   (deto << PORT_DEVSLP_DETO_OFFSET) |
--=20
2.17.1
