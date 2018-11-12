Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16B4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C6422419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VXOqFAbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C6422419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbeKMEzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:55:31 -0500
Received: from mail-eopbgr710062.outbound.protection.outlook.com ([40.107.71.62]:9225
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727712AbeKMEzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2blqNxG8NWWGhF/0yT4b8jxtN5MPiLtj9Ch7bZlfEc=;
 b=VXOqFAblXZ/HETgluxJIDQuZkIXiKAbBPgJTNoukc1haOvyrTf1dicV/0ABgFO4+wl+tQVt1RYJICrBym1eg7wdc7WZsPiOSIDpy/qXbTyZQbyJbJoz041QoM8/8Dy176ikQ+7yMkK3VF23M/J+pifBuyu7i1AX6gHYhV+uPErA=
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.176.31) by
 BN7PR12MB2689.namprd12.prod.outlook.com (20.176.176.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Mon, 12 Nov 2018 19:00:55 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::7d9e:3828:c095:b801]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::7d9e:3828:c095:b801%3]) with mapi id 15.20.1294.045; Mon, 12 Nov 2018
 19:00:55 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Subject: [PATCH] ACPI / APEI: Fix parsing HEST that includes Deferred Machine
 Check subtable
Thread-Topic: [PATCH] ACPI / APEI: Fix parsing HEST that includes Deferred
 Machine Check subtable
Thread-Index: AQHUeroKfApkIX1/+0ussSwAR+oKPQ==
Date:   Mon, 12 Nov 2018 19:00:55 +0000
Message-ID: <20181112190029.41760-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0012.namprd02.prod.outlook.com
 (2603:10b6:803:2b::22) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:28::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2689;20:VHC/2pEXGLg540RTLTG++bVCdCSbHUBQNzU8i//0Jnaw3sM3DPIeBepR5V/jRrDhhIhxTeil2AsYE3FbouYoq4mCzsAISOUmiaE06B9A57vtq0CAA3fgKrzPRZYO8Lri1FnfwERz25vivytb1RYoy3Vzu7HAzWDC8a+RlR7rGEfZ5pxWRGjnzJnZxeJlDOsGZ5LTmHW/V+9HpLR86nMoRP4YgnC34aFX/XD43oW1U2GTSIQ2eBjroRw4BerfNnGR
x-ms-office365-filtering-correlation-id: 5c2e709c-596b-45d9-ff71-08d648d12cac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2689;
x-ms-traffictypediagnostic: BN7PR12MB2689:
x-microsoft-antispam-prvs: <BN7PR12MB2689566D00A4C169D76823D9F8C10@BN7PR12MB2689.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(93006095)(93001095)(3231402)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN7PR12MB2689;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2689;
x-forefront-prvs: 0854128AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(366004)(396003)(189003)(199004)(81166006)(81156014)(8676002)(2501003)(486006)(86362001)(7736002)(575784001)(305945005)(476003)(8936002)(36756003)(97736004)(2616005)(99286004)(256004)(1076002)(105586002)(6506007)(6916009)(386003)(2900100001)(14444005)(106356001)(6116002)(26005)(5660300001)(102836004)(3846002)(71190400001)(71200400001)(6486002)(6436002)(25786009)(72206003)(14454004)(478600001)(6512007)(5640700003)(53936002)(4326008)(2906002)(186003)(1857600001)(52116002)(316002)(68736007)(54906003)(2351001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2689;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8SjXIFXD8QuVuB0TEAZmsSTVPrrzZFHKy56Y2zZsbI+mqBs28uGQGKHiNo1gTJmgA+owDInrs1rSG5UkoasBLalwJ9fNRtWb6J/uc8cS5qQ3u3jcdn86dNDZKb71J9bwqIsqM45n8FNaEb1Wo2GMCDGzqL2Xis0nPqFxNRRUpzg57NDyGRP68CXGxm+Mw/Apu77E8wLyDXQRVcV7asw4xyWzYzLH/rsaJzOk7Jrv4THaiwq1UAJHw30Nbv5BdrAaOrbNYOqEpgX0BqhDuK26J0YQpgC9oxRJO0aPSo//3XpsM7xoQl8BGFH3SpG/AXyf6+kX8orIDOYjJIBgrV1L5+5QU5oOcIRqqL876P2ES7M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2e709c-596b-45d9-ff71-08d648d12cac
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2018 19:00:55.7841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2689
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

ACPI 6.2 includes a new definition for a Deferred Machine Check "DMC"
subtable.

The definition of this subtable was included in following commit:

c042933df2b1 ("ACPICA: Add support for new HEST subtable")

However, the HEST parsing function was not updated to include this new
subtable. Therefore, Linux will fail to parse the HEST on systems that
include a DMC entry.

Add the length check for the new DMC subtable so that HEST parsing
doesn't fail on systems that include it.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/acpi/apei/hest.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index b1e9f81ebeea..0935a0ef37e5 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -53,6 +53,7 @@ static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVE=
D] =3D {
 	[ACPI_HEST_TYPE_AER_BRIDGE] =3D sizeof(struct acpi_hest_aer_bridge),
 	[ACPI_HEST_TYPE_GENERIC_ERROR] =3D sizeof(struct acpi_hest_generic),
 	[ACPI_HEST_TYPE_GENERIC_ERROR_V2] =3D sizeof(struct acpi_hest_generic_v2)=
,
+	[ACPI_HEST_TYPE_IA32_DEFERRED_CHECK] =3D -1,
 };
=20
 static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
@@ -75,6 +76,11 @@ static int hest_esrc_len(struct acpi_hest_header *hest_h=
dr)
 		mc =3D (struct acpi_hest_ia_machine_check *)hest_hdr;
 		len =3D sizeof(*mc) + mc->num_hardware_banks *
 			sizeof(struct acpi_hest_ia_error_bank);
+	} else if (hest_type =3D=3D ACPI_HEST_TYPE_IA32_DEFERRED_CHECK) {
+		struct acpi_hest_ia_deferred_check *mc;
+		mc =3D (struct acpi_hest_ia_deferred_check *)hest_hdr;
+		len =3D sizeof(*mc) + mc->num_hardware_banks *
+			sizeof(struct acpi_hest_ia_error_bank);
 	}
 	BUG_ON(len =3D=3D -1);
=20
--=20
2.17.1

