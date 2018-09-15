Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61634ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDA2208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lA9w/wTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDA2208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeIOGrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:07 -0400
Received: from mail-bn3nam01on0134.outbound.protection.outlook.com ([104.47.33.134]:14354
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728226AbeIOGrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPKlESEbbukYz3qXnqYFQ3IXnBVDSQaVKEOnIHLX1T8=;
 b=lA9w/wTLVncBIb5wUAWETOZmkHDRa4WyNZp5fHvnSTrA17uVK7gSjymdaxfurxktNB6/QcFi1aggKpMjRANXglww4ov0HePyDUeCqpCrBl+X289oaw6ZtVCtb7Vb9X0H/ZCLQ82VpaSYLJN6uN8bf7jmd6YdPcqKm/46T4NXYxU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@mips.com>,
        Huacai Chen <chenhc@lemote.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 17/92] MIPS: loongson64: cs5536: Fix
 PCI_OHCI_INT_REG reads
Thread-Topic: [PATCH AUTOSEL 4.18 17/92] MIPS: loongson64: cs5536: Fix
 PCI_OHCI_INT_REG reads
Thread-Index: AQHUTJOefJl/QpOAuU+n04q30sGJPg==
Date:   Sat, 15 Sep 2018 01:30:00 +0000
Message-ID: <20180915012944.179481-17-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:mSUH48yVkbfXGweLwNNdffITObZOa02ImzcQ9H7zOctEOz9Jl5ZDlBASxeJypQNOoJRq1XgkLUSlqe1/9DpbO0C5S0bzn5Y7ZzGMUYsESOmxV+NqNooX2XOCRxVnmF/HT8YYvOZBrRYhYSSL9PdwgYLr/ebZiYV33vlNWwAhl/eFdZ4O81swiS0AI8irJ8j3ElBsA/1VdTeieOew9aexKi5Era6FIi0uymDWGZi14ZP2fD5JJdgtfj0rgoY8eKmjU01V7en3Dn37Y5UFDhLXlgGPdoSTHRB87cb3sVhPP/ePb/B9gXWuLgkK6ENNCSai4Z2olaVBH+p+ZjUewH0PVUv+nMxVL0cgOv6fZGRZ2UlKvGf+OXQ7ibHi/2aNAqiKXH1g7g0YS7+Yht9++EDt8e7Nl/y31IOKLqwsW/42S+0kPX8Gs9X4ilm/MTRlHBu0RB/fhOJe2PKldD1tsVGC6w==;5:ZM5aqL5uMHfjzLH+YT7t84N4o+mT9s2HFDGM3SskmJu40tIsTUbFW/L7DTTzpj2vsOXQ85uCp8OexIEk7j6/KyhiFms0Gj0vVi3Ci7f2vt1C6ioJlaDOHgN22zS9nfwALFNvkQDx+DCUiUM2PpeSIKwE4dF2iZw9j2GN9ECviTI=;7:HM3z16DrCckPQtQpyRIOdrQoz4OOv6KphxDbxz2i4blUGqWfzQ3SdKwNC5EBBueTV0Ro8cpO2FHaGRmf9s6KyqQVrcTDqit7fpJ0jje5n+k3L4WWPDX/iFktR1AQ2JApNCwAOZg5jqiStb41NdN4lz7c3cv0ZAsDDE9fYCK9V2xnpeQmopKASvsvlVPVxUeEyig3+BBQ7GkBVoaTMXwSpd0KCRIZGhC6T8iRROpgj3Co49MlyWbOGnGzm4hxNS4M
x-ms-office365-filtering-correlation-id: 0e5f1bc3-e002-400b-2d36-08d61aaac10f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB0840C6D346E2FC22985E6B3FFB180@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(14444005)(6116002)(81166006)(2906002)(446003)(478600001)(3846002)(966005)(8676002)(106356001)(105586002)(10090500001)(22452003)(8936002)(486006)(2616005)(72206003)(36756003)(11346002)(81156014)(186003)(26005)(14454004)(6506007)(217873002)(4326008)(25786009)(256004)(107886003)(102836004)(6346003)(476003)(1076002)(10290500003)(575784001)(86362001)(66066001)(6436002)(6486002)(86612001)(53936002)(54906003)(2900100001)(97736004)(7736002)(6306002)(6512007)(305945005)(76176011)(99286004)(2501003)(5660300001)(316002)(110136005)(5250100002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: xnn//b/6sqnwnVl7WSVupK+by1hFRCvsREeFP2DKMGabyuHyIc/KTdn61MHUelkZhE7K3+zIj5p8WVHfxhdysFH85FfiOP46FLGrkx2kiZQFlMHABnc+KMvumQqs2YmUejeBKdkko/4tifbYGbCnSL73fjZX543EHyvGoG4KuvtY5ZzdTrBo4yY1kCqcBRAIWUVzzVfepUY2Eb/dNBMQlHtiN/UQpcoM1JRjwY7QhFJGP7xOF+WV2JOBoLmGa4/8ibc/FTpXgYFMgOb8n0Irc23uf/oOI3uoOljTkA5QRpYRfshzsJnRNuswWF+FSl5otSlqKfsc6Bu/brD8okTUhQew1p85+ISwWaMEF2jGPr4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5f1bc3-e002-400b-2d36-08d61aaac10f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:00.4013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paul.burton@mips.com>

[ Upstream commit cd87668d601f622e0ebcfea4f78d116d5f572f4d ]

The PCI_OHCI_INT_REG case in pci_ohci_read_reg() contains the following
if statement:

  if ((lo & 0x00000f00) =3D=3D CS5536_USB_INTR)

CS5536_USB_INTR expands to the constant 11, which gives us the following
condition which can never evaluate true:

  if ((lo & 0xf00) =3D=3D 11)

At least when using GCC 8.1.0 this falls foul of the tautoligcal-compare
warning, and since the code is built with the -Werror flag the build
fails.

Fix this by shifting lo right by 8 bits in order to match the
corresponding PCI_OHCI_INT_REG case in pci_ohci_write_reg().

Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19861/
Cc: Huacai Chen <chenhc@lemote.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/loongson64/common/cs5536/cs5536_ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson64/common/cs5536/cs5536_ohci.c b/arch/mips/l=
oongson64/common/cs5536/cs5536_ohci.c
index f7c905e50dc4..92dc6bafc127 100644
--- a/arch/mips/loongson64/common/cs5536/cs5536_ohci.c
+++ b/arch/mips/loongson64/common/cs5536/cs5536_ohci.c
@@ -138,7 +138,7 @@ u32 pci_ohci_read_reg(int reg)
 		break;
 	case PCI_OHCI_INT_REG:
 		_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
-		if ((lo & 0x00000f00) =3D=3D CS5536_USB_INTR)
+		if (((lo >> PIC_YSEL_LOW_USB_SHIFT) & 0xf) =3D=3D CS5536_USB_INTR)
 			conf_data =3D 1;
 		break;
 	default:
--=20
2.17.1
