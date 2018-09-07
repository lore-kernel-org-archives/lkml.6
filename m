Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C896C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9647A2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Pe1MqcOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9647A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbeIGFPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:51 -0400
Received: from mail-sn1nam02on0118.outbound.protection.outlook.com ([104.47.36.118]:6328
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729497AbeIGFPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDzdh1jEuE1RpefDdN1ZqdTdx0Fz7OPkiwOfY/kUFhs=;
 b=Pe1MqcOE4lt4Kw3xpFCImHr580vlrMiD5BIvVDCgxgX7RZkNRhvWCsVEM9AUGynZ2CZRVMvKmx7IY7AoiM1v2KdvHcTzJCPUyzMTUNyWWAvZ0UwZcofg0ohRY80igQGBkCce+tlOnqwBY/LYuwA4TOVbJFw/zfZRELsmlNOnLCQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:37:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 88/88] PCI/AER: Honor "pcie_ports=native" even if
 HEST sets FIRMWARE_FIRST
Thread-Topic: [PATCH AUTOSEL 4.18 88/88] PCI/AER: Honor "pcie_ports=native"
 even if HEST sets FIRMWARE_FIRST
Thread-Index: AQHURkLg4zISU2s3YUywtPpPsElAgA==
Date:   Fri, 7 Sep 2018 00:36:54 +0000
Message-ID: <20180907003547.57567-88-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:ZCmUm4g0YsiJKgICUxv4OAzakTKz6uNfkmqWcadxc+ZIi6LujGTw3+1FfudSmPl/H6zNinv40zaFXYZJDZeE6L/KQJCKPT1+jns9dyN750fOjzsa16GxcaXg+TzOVwvhZJ89DCHUG7vLqAIptvhINwRbMhgh+PE0rSM0OFxcAV0GAym7Mjmw/JX8htu5690ARxAEQ5V0VpR8+6Cxau6vWJABiNheCbhPt4UMTu4U8sAbtt3bv7aeTNT/Po1M/dUGxX5wwSs6O3qKy/LHSD59y3i6xcAobT4alowBUAjA+joBLPmgNu7rih6b15svhMMFI6P/wIJpmclnjuh9RX+Sqgyd+VBoR+kNc5mZEb+kz/Pi4y5lUWyNLCDP5HwIREtu4Za2l17gK504RTxSjXcTrXob/S/j9jpkbXhUKokbIb+QeHW3hbGbClIe0Ov6I1p+y+YEC9YMOfu/AUOXpRo8Dw==;5:KZKrWbQbwsTMS0A0kNzjU1K+ifF3+P8bfQptaFXonL54c5kxko3ywT2Bsb+bGzDEs9s+BM1ftQDHBl0pMU6KxT68CniKL5/zyxLqKP79LXj3inFu4ZN8oiujoAniomaUhRlTZ2u8sYVoUP8rBw3GRtJyhH0KdgM/OJVT9K9xE/U=;7:pkdBBR1xG91KAbn2jb+G70mnRTG774kzhWBIow/QyqCffPlYzLDZp16+JpXgU2X1tTETmPP9vqFDpq0lHCmrm+4LMgFp5fNyUseP49SXyOU/ssXozwW+h2z7gOCbK4MOW3gmKcnCINxoxnHeuLodDYtvf/p5OA8u4VqSAuGi7URV2iBwlZA6/kJQUhsrZ+AXlOgKhLUgbTNloLUT8+i9Ka1CUvivcH3a+mjCaKE9ah1iczod1I9eyrGWrUXfKWqH
x-ms-office365-filtering-correlation-id: 5c51195a-1847-4679-feb3-08d6145a1ebf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB01819BBEBCB2889627D9B63AFB000@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(136003)(376002)(346002)(189003)(199004)(217873002)(72206003)(22452003)(2900100001)(8676002)(10290500003)(2501003)(478600001)(68736007)(305945005)(76176011)(81156014)(105586002)(81166006)(256004)(10090500001)(8936002)(14454004)(2906002)(5660300001)(110136005)(54906003)(316002)(14444005)(106356001)(6346003)(6436002)(26005)(25786009)(1076002)(99286004)(6116002)(6512007)(39060400002)(3846002)(7736002)(186003)(4326008)(6666003)(107886003)(476003)(66066001)(97736004)(86612001)(2616005)(6486002)(446003)(53936002)(86362001)(11346002)(102836004)(486006)(36756003)(6506007)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: V9xAFLjnSc8bKcTQdMSaUKNwFFObztiCu4S36WdCoZQCrlEjZLwkeOl6FlYHLiFMCalEEVXcLV/kBDjq8m0lyozjAIEiu0twDyVMPGsKEuvjYII9kRemtJ5gVUnhCOKIb193S1XAeeuKu7PG/6DukUrxIv/xjcg9aX11aCWr20yfHTmjEVOTBIkd9Kf5ygj14n4RJsFvk9VS4/p599qrv5yxMz5Z1hbkZOteipmJM57xPqnAlGpJEp6I2J63tp93xntTRlWWz7MpbDDsczcqxPcomb6iuCbiRmMkTl9M/sR2UO6Jxm5YqxOLnSMSvw2sum3ZU69eYwhojuLd1dAhbFqh0gBLmvQkBzMoj4LFyfo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c51195a-1847-4679-feb3-08d6145a1ebf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:54.6602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Gagniuc <mr.nuke.me@gmail.com>

[ Upstream commit 7af02fcd84c16801958936f88b848944c726ca07 ]

According to the documentation, "pcie_ports=3Dnative", linux should use
native AER and DPC services.  While that is true for the _OSC method
parsing, this is not the only place that is checked.  Should the HEST
list PCIe ports as firmware-first, linux will not use native services.

This happens because aer_acpi_firmware_first() doesn't take 'pcie_ports'
into account.  This is wrong.  DPC uses the same logic when it decides
whether to load or not, so fixing this also fixes DPC not loading.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
[bhelgaas: return "false" from bool function (from kbuild robot)]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/pcie/aer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e88386af28..0fbf612b8ef2 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -303,6 +303,9 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return 0;
=20
+	if (pcie_ports_native)
+		return 0;
+
 	if (!dev->__aer_firmware_first_valid)
 		aer_set_firmware_first(dev);
 	return dev->__aer_firmware_first;
@@ -323,6 +326,9 @@ bool aer_acpi_firmware_first(void)
 		.firmware_first	=3D 0,
 	};
=20
+	if (pcie_ports_native)
+		return false;
+
 	if (!parsed) {
 		apei_hest_parse(aer_hest_parse, &info);
 		aer_firmware_first =3D info.firmware_first;
--=20
2.17.1
