Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ECDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73AF22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="FGtEgjWs";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Obj+15s+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73AF22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733274AbeKOB2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:28:12 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:62565 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732485AbeKOB2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:28:10 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAEFNoNP016134;
        Wed, 14 Nov 2018 07:24:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=vNQjv9q+osEOfDfvb9Qdoh60uRs6hugA5PDjOZPG9TU=;
 b=FGtEgjWsco17XeXD4rHiswnGvOfuUYUkuclHC0hX8bjZE6kNsQgtcqAMI7yCDmKsvH8t
 pay/2qOU8lx7fE8oB5SsP5zBXnJ64hFJ9t77wMyaO1r35gJ9UyqI5Mb5DCiWwniqyBxf
 OnSCiXdqy65OJKaTtdzrD4VKnuNgDiHl8HUhEGQxz38heNOO4MG43YXTF89kfi3yLdSk
 fCAVTF+H2IPWDHBNWnJyXZcNDD18UUhAtwJdkdWozdgxqYL/yTxZpYYQOte7/YztDzqt
 XKfvlwfqdSuCSAp0ydpsrgctr6KqwEluqIbMth/UMysOBFxYLxBNG9818o7nqo5SK+au gw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp0246.outbound.protection.outlook.com [216.32.181.246])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2nrnvf85m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Nov 2018 07:24:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNQjv9q+osEOfDfvb9Qdoh60uRs6hugA5PDjOZPG9TU=;
 b=Obj+15s+vwF0I+M6cRAALCpqtXZa5Y6asQHdgW1yAJuBxLYpKxY5VufhJP4kYvVMkqW9zn6o7ZIejBAf0bgepp1pSlqUSg4/ssTx/H1G6LjhVxuGe3VQc7GEi5frhqb0C8bScA9IbE21FrmNEsOY1DBl6KtzZkPblJwCeFy7kI8=
Received: from CO2PR07MB2695.namprd07.prod.outlook.com (10.166.214.8) by
 CO2PR07MB2552.namprd07.prod.outlook.com (10.166.201.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Wed, 14 Nov 2018 15:24:21 +0000
Received: from CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::d846:c378:fc67:e1cc]) by CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::d846:c378:fc67:e1cc%5]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 15:24:21 +0000
From:   Janek Kotas <jank@cadence.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: clk: Add bindings for Fixed MMIO clock
Thread-Topic: [PATCH 1/2] dt-bindings: clk: Add bindings for Fixed MMIO clock
Thread-Index: AQHUfC4e2gMBoJ+ib0GB0lKUssWI2g==
Date:   Wed, 14 Nov 2018 15:24:21 +0000
Message-ID: <1B94C733-F941-4403-9498-4BBB35B25345@global.cadence.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2552;20:Jg7dfS0njtI4oBFeWVcxqG9A7f/jY5b94SV/ufa+rLhFrnqIcuBvCmtucG67RpAsxbl/+gjn4ySdMFUtj0FraLyTPCrGuLn1kTqP/50cQa6+ZumU05b/CIyQyObiaysxDCnVh+rzT52WJ+N8ITIY99aFJzQycgrZ6iVV24C8lzkBR6RnlBj1kJLciQTEAUxq0H+MUVK+v6gcztjOPw3FqdO6n3yVnOdXuzvyZIBxFQ/NAcgR6f/yYOV4KBus24J8
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 11d720e0-5ca6-4666-33b6-08d64a4540bb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2552;
x-ms-traffictypediagnostic: CO2PR07MB2552:
x-microsoft-antispam-prvs: <CO2PR07MB255270A759FC38E0AB06DE63D0C30@CO2PR07MB2552.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231410)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CO2PR07MB2552;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB2552;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(376002)(396003)(39860400002)(36092001)(199004)(189003)(2906002)(66066001)(81156014)(25786009)(3846002)(81166006)(68736007)(6116002)(8676002)(4326008)(71190400001)(71200400001)(83716004)(97736004)(486006)(54906003)(110136005)(476003)(256004)(316002)(86362001)(305945005)(26005)(53936002)(186003)(2501003)(478600001)(33656002)(2900100001)(99286004)(8936002)(6436002)(6512007)(105586002)(5660300001)(14454004)(106356001)(6486002)(82746002)(6506007)(7736002)(102836004)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2552;H:CO2PR07MB2695.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ANJUF/klAyLvyUgPK6xBx/bwslaC2PN5dfK13J/jbNP6ThH+B5Z7UoU/mh+OHgxjMc7uvKQQLc5swGcrhyExN7bWycXZ37K8zvR1LRggEE7ZCjVpvh3zpGO2OcoanRR2a+Dwx2KAhj4DX4nDiibv9rFZhfAQ3X7udn3iBdRZR9XLgB1nAESQLyoCoa+50gvt6n0C6yed1dqVEKNfOkApdOoEsV41vgJbCuQsFZaQvclecsAdK5ipTlNsjfp8bqBXFzh/zz4CBtiZWeW//Lrz6ixndxrnUMJEGpIzrYZvREciNDvm0YjdW3QtlLxBfGktWKN+LAk9RAG8yR1yQam9m5h6CqvEVrEkw7MvaCyg0M4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3BF9F34C8A14849A087F9E343802EB8@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d720e0-5ca6-4666-33b6-08d64a4540bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 15:24:21.7011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2552
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-14_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=927 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a DT binding documentation for Fixed
Memory Mapped IO clocks.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 .../devicetree/bindings/clock/fixed-mmio-clock.txt | 22 ++++++++++++++++++=
++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fixed-mmio-cloc=
k.txt

diff --git a/Documentation/devicetree/bindings/clock/fixed-mmio-clock.txt b=
/Documentation/devicetree/bindings/clock/fixed-mmio-clock.txt
new file mode 100644
index 0000000000..6441821688
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fixed-mmio-clock.txt
@@ -0,0 +1,22 @@
+Binding for simple memory mapped io fixed-rate clock sources.
+The driver reads a clock frequency value from a single 32-bit memory mappe=
d
+register and registers it as a fixed rate clock.
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be "fixed-mmio-clock".
+- #clock-cells : from common clock binding; shall be set to 0.
+- reg : Address and length of the clock value register set.
+
+Optional properties:
+- clock-output-names : From common clock binding.
+
+Example:
+sysclock: sysclock@fd020004 {
+	#clock-cells =3D <0>;
+	compatible =3D "fixed-mmio-clock";
+	reg =3D <0xfd020004 0x4>;
+};
--=20
2.15.0

