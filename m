Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE0BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D462E2152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="W48jRTcK";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="egHsFbw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D462E2152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbeITSwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:52:05 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:39212 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387418AbeITSwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:52:05 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8KD6Si6028152;
        Thu, 20 Sep 2018 06:08:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=9OKxDS6NBg5tfeKPM9KxEgBae+tmhyaHBs1xfD2ad3U=;
 b=W48jRTcK/ZLpi7LkgD2bWKJRnrRQqxXpa3c7TXC1IKqJyo9uC5jMZvulMOlfTYR7WNSG
 8zjj3GF/bZ4tkm3LwzvtagVXJWwUGuTiQ78BigV+wM1PYFlxYud9pEYOuox9pV2koaE9
 53WJ5I15EuJuLqfDKbEOuUW9E7J4sf4WcqvP85D4vna82IPeIR/FbLL+y0++8Ka3Z6L3
 b8FTfGuF9GPQuvuUQLuuWI8uekj0VkSkhAiQhTyUo/ZJsdPBDCzTwM7VbKz834ZhGCos
 XxlftbyNa/k0H4iKm07EWOohucfUdlEafSkgIKJSISxSXARcykKxfhTQYuNWThew6LP6 3w== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp0112.outbound.protection.outlook.com [216.32.180.112])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2mm4h19wj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Sep 2018 06:08:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OKxDS6NBg5tfeKPM9KxEgBae+tmhyaHBs1xfD2ad3U=;
 b=egHsFbw/y0tzp+2mhyuZXo/qf4aBgH2Nm5pAkuMRwcgbshrPNQ6fT1xw/kEcdu5ANPKu0oWVtCbAari9qPTWti0U0NJnz75/lWERu8P/90yN3/dskog7fN+J9qKCLmUMR4w+/DSgqli67xJJ52FDUL/EbsoqIlQdpIeWDKbYFSY=
Received: from CO2PR07MB2695.namprd07.prod.outlook.com (10.166.214.8) by
 CO2PR07MB618.namprd07.prod.outlook.com (10.141.228.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Thu, 20 Sep 2018 13:08:22 +0000
Received: from CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::4c7c:3f0f:3bba:ab95]) by CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::4c7c:3f0f:3bba:ab95%4]) with mapi id 15.20.1143.017; Thu, 20 Sep 2018
 13:08:22 +0000
From:   Janek Kotas <jank@cadence.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: ufs: Add bindings for Cadence UFS 
Thread-Topic: [PATCH v4 1/2] dt-bindings: ufs: Add bindings for Cadence UFS 
Thread-Index: AQHUUOMBcu3VWJe0MEW94BlE4mekqg==
Date:   Thu, 20 Sep 2018 13:08:22 +0000
Message-ID: <9429A347-939A-44C6-BDBE-A892F5BCBD47@global.cadence.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB618;20:VGBBZa0CMo9JFDnZRH8qkT8GZkQvDdKfGi/5rxhJoi6bfV1XStZvS3bP46QkzZRlLMl3L6IvaxMteC83TTAKbDdiN7qab0C313cM9aSYN5hHLSs/z3Amciw8sSrNFjHaINqRJpJWFqSNnBXxmQCZJm69J07cBeCIS4+IQ5p05Ew+AOdbEVu/5wEfv+/x8gk0q3wXjJYPlg0Qu46Id+l1SYH4N0S3Q81lKg3yYexI3eOaHlMzfBktua62vAzl5LE+
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5bc23c6c-761f-428e-6d8f-08d61efa2485
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB618;
x-ms-traffictypediagnostic: CO2PR07MB618:
x-microsoft-antispam-prvs: <CO2PR07MB618682D113D9EF2196B4F3FD0130@CO2PR07MB618.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:CO2PR07MB618;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB618;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(366004)(136003)(189003)(199004)(36092001)(2501003)(4326008)(6486002)(5660300001)(7736002)(476003)(26005)(33656002)(8936002)(8676002)(316002)(105586002)(54906003)(71200400001)(71190400001)(5250100002)(305945005)(4743002)(102836004)(486006)(256004)(97736004)(6436002)(82746002)(2906002)(478600001)(6512007)(6506007)(106356001)(68736007)(99286004)(86362001)(3846002)(6116002)(83716003)(110136005)(2201001)(14444005)(81166006)(53936002)(66066001)(25786009)(14454004)(81156014)(2900100001)(186003)(39060400002)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB618;H:CO2PR07MB2695.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: o/5xu9pip6Vspg0wLbO982PgJ2MJkSirCdiM1gS1sHZaG/7DU3a4XtpLF24B2FXSIufG3Z+qtwgSGaq6fDJeOeReoDUKyxU+FAztuAvPlDbIL9Dx2lKe0aIaJhvP59pXFzJJi0/9sc+gH/GWMWXEk9SX+QiElfnBqmUSWPRt7tHcl0fRGu37o6TpUUvQNo2aipfrKxQ6Dm1xiDWtbjapYjYbCIM+snzaSnqXgWDB+00MjRvkGO+6u8aFdt/tXZT+UBZU7R4I5dOTuiwSQkGqv6M7UYEDN1Sy6yDPafRvUsqfEXgkrN5AWJAY5C1X2K3dx4O7lOHMYWr9kzafe6OkgeljsGDZSCize0YBR1mU1K4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <434C8ECFBAFC2746BBFC95BE3C9A8644@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc23c6c-761f-428e-6d8f-08d61efa2485
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 13:08:22.0703
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809200134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a DT binding documentation for
Cadence UFS Host Controller.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 .../devicetree/bindings/ufs/cdns,ufshc.txt         | 31 ++++++++++++++++++=
++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt

diff --git a/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt b/Documen=
tation/devicetree/bindings/ufs/cdns,ufshc.txt
new file mode 100644
index 0000000..a04a498
--- /dev/null
+++ b/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
@@ -0,0 +1,31 @@
+* Cadence Universal Flash Storage (UFS) Controller
+
+UFS nodes are defined to describe on-chip UFS host controllers.
+Each UFS controller instance should have its own node.
+Please see the ufshcd-pltfrm.txt for a list of all available properties.
+
+Required properties:
+- compatible	: Compatible list, contains the following controller:
+			"cdns,ufshc"
+		  complemented with the JEDEC version:
+			"jedec,ufs-2.0"
+
+- reg		: Address and length of the UFS register set.
+- interrupts	: One interrupt mapping.
+- freq-table-hz	: Clock frequency table.
+		  See the ufshcd-pltfrm.txt for details.
+- clocks	: List of phandle and clock specifier pairs.
+- clock-names	: List of clock input name strings sorted in the same
+		  order as the clocks property. "core_clk" is mandatory.
+		  Depending on a type of a PHY,
+		  the "phy_clk" clock can also be added, if needed.
+
+Example:
+	ufs@fd030000 {
+		compatible =3D "cdns,ufshc", "jedec,ufs-2.0";
+		reg =3D <0xfd030000 0x10000>;
+		interrupts =3D <0 1 IRQ_TYPE_LEVEL_HIGH>;
+		freq-table-hz =3D <0 0>, <0 0>;
+		clocks =3D <&ufs_core_clk>, <&ufs_phy_clk>;
+		clock-names =3D "core_clk", "phy_clk";
+	};
--=20
1.9.0


