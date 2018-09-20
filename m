Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBEEECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D66721531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="erD8FFB3";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="MH8sBe6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D66721531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbeITUj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:39:57 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:48924 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726990AbeITUj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:39:57 -0400
X-Greylist: delayed 6479 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Sep 2018 16:39:55 EDT
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8KD4MAp023636;
        Thu, 20 Sep 2018 06:08:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=XUv3hdOlVxZVCzslH1OZYwOGNQ06MaG2bH/IRS2HYPk=;
 b=erD8FFB3Q2gnQXFG2l+poLv87Y0aPiPOhBD6Ig/KiPf3zbsbj8yrcBIhTblMM4voKW2Y
 4YHJWMu8cQVtXK87fjGaT98mKl6hUdE6j4/QQX2YA0M0wg4nTeJVxVfrZNLxVTEDHgZ+
 J8Vg0MFNbKzr8pmPQDQRnsQOb9GKlguIokqjEjpMOSkB2gkHsHy6AuQp20iMg6I0boZ9
 EWabKPVenb3AvZd4A/wClhdP/HQLm7Mp0qOFA1FCF6O6xYBIc+NvdPAZ2YCEXEeTJLIy
 /V92ftHdPrU/waGQrLnIdSn/9jKzfH+cnt4RPUyRUsQ3/EyeNvobLsTTdriRPdZ21kj/ qg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp0120.outbound.protection.outlook.com [216.32.180.120])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2mgwnvjk6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Sep 2018 06:08:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUv3hdOlVxZVCzslH1OZYwOGNQ06MaG2bH/IRS2HYPk=;
 b=MH8sBe6T03ryVIxhaCZezRvEow5CIHqQnkYts27Ts+wBBpA3x5biINeYsM3lzYaiv0zV8FH74lDHnwnukEuXJfEkR2iX4VQvTVrIIXw9Pq6CZ/F7STG2gu5zGbyig4pkr1kCiRkV+go3SUf8KamDUto5HjXplVfjdM4NJzW+zRE=
Received: from CO2PR07MB2695.namprd07.prod.outlook.com (10.166.214.8) by
 CO2PR07MB618.namprd07.prod.outlook.com (10.141.228.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Thu, 20 Sep 2018 13:08:16 +0000
Received: from CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::4c7c:3f0f:3bba:ab95]) by CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::4c7c:3f0f:3bba:ab95%4]) with mapi id 15.20.1143.017; Thu, 20 Sep 2018
 13:08:16 +0000
From:   Janek Kotas <jank@cadence.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: [PATCH v4 0/2] scsi: ufs: Add UFS platform driver and bindings for
 Cadence UFS
Thread-Topic: [PATCH v4 0/2] scsi: ufs: Add UFS platform driver and bindings
 for Cadence UFS
Thread-Index: AQHUUOL+kmgCUykE+ECBLZZPsPTWxQ==
Date:   Thu, 20 Sep 2018 13:08:15 +0000
Message-ID: <2F2BBFEC-A4C9-413F-9FBC-E63BA0770BE2@global.cadence.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB618;20:704p0erj4yxf57imrM/ouMMEGOb+bbaJFAW3Fo6MOs8GqRoWhTqJfi64qARknCBfjfWNIBEDytQYbKiUmNezaySZOniw4MpZrDQLCRlz1kwpob5JBaQnpszdlmUdyRjLAU08TLyFKgnQFfxPYRCq1VjEjU/lFpdJOsZkgmgNi4IiXO/A/KHqaq0a6breFJZNxsW490xJSEm/WvweIEiLoEdsK0MQKLCOoGabHquuKK+DLRZ9Bnke8KfeHywO+XqU
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a1184130-e2fb-4ab6-6d13-08d61efa20d4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB618;
x-ms-traffictypediagnostic: CO2PR07MB618:
x-microsoft-antispam-prvs: <CO2PR07MB61892A1FBE329750C77EB4DD0130@CO2PR07MB618.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:CO2PR07MB618;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB618;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(366004)(136003)(189003)(199004)(36092001)(2501003)(4326008)(6486002)(5660300001)(7736002)(476003)(26005)(33656002)(8936002)(8676002)(316002)(105586002)(54906003)(71200400001)(71190400001)(5250100002)(305945005)(102836004)(486006)(256004)(97736004)(6436002)(82746002)(2906002)(478600001)(6512007)(6506007)(106356001)(68736007)(99286004)(86362001)(3846002)(6116002)(83716003)(110136005)(2201001)(81166006)(53936002)(66066001)(25786009)(14454004)(81156014)(2900100001)(186003)(39060400002)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB618;H:CO2PR07MB2695.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vh7oAvCJYarSKtIdexLpdLLW6XUPPLamNctVVwLnEFV+c/nV0F4PZBr25A99HcUEV+eagMrf35wKwkOvG6Y8wBTycRfW6LkLezgdNermdtOlfH0O5SdIP+TRpFsEox5eWEFLwMjcOxZewxF8A9t2hDbEOwCjzfiSfv/j/sq8gOy9pxmwzuoc9HrTYovcTPZC2EjV3co6+NjrRLKRYyySvovIxFrPnzVgcra065LSJMxMtZaVLO6mIwYUM2KLECa+m3JwrZKNvMcreY0I4+7s4oT1509Py4TwrW+/WOEF48vJf6/D4SmaU2khieCiYD04p7dArtYe/itxxFovIelL7uT+BIazSNEjCMiYefQWhTA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0CDB89ACA507B240855166C80F5DEFC2@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1184130-e2fb-4ab6-6d13-08d61efa20d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 13:08:15.8631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB618
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=858 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809200133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a driver support for Cadence UFS controller.
It was verified on Cadence Palladium emulation platform.

Changes since V3:
	Updated comments and cleaned up the cdns-pltfrm.c.

Changes since V2:
	Updated dt bindings documentation.

Changes since V1:
	Renamed the documentation file name to cdns,ufshc.txt.
	Updated interrupt and register mapping.
	Added license information.
	Added a missing PHY clock.


Jan Kotas (2):
  dt-bindings: ufs: Add bindings for Cadence UFS
  scsi: ufs: Add UFS platform driver for Cadence UFS

 .../devicetree/bindings/ufs/cdns,ufshc.txt         |  31 +++++
 drivers/scsi/ufs/Kconfig                           |   8 ++
 drivers/scsi/ufs/Makefile                          |   1 +
 drivers/scsi/ufs/cdns-pltfrm.c                     | 149 +++++++++++++++++=
++++
 4 files changed, 189 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
 create mode 100644 drivers/scsi/ufs/cdns-pltfrm.c

--=20
1.9.0


