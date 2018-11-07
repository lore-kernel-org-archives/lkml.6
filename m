Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A14C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7425720862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="WD9Zcyy+";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="KuCOzC47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7425720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbeKGRxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 12:53:32 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:58174 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727178AbeKGRxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 12:53:31 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA78Ldws008715;
        Wed, 7 Nov 2018 00:23:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=proofpoint;
 bh=gYVkRi48BiUdMmSJDBF62pXScLCfF/esiK3cGfHRZhg=;
 b=WD9Zcyy+liABqSypSRRCSun7dhBnlMuDjdZCNoI9D98BbmNcVsq045zLBVUvKOIf9kNE
 rDc274BKKk/UjDMYtSmLV2/F/b3Wfop6620GR/ofhZQWPLCtdAlJIcG6O57l+nT/i4Uz
 IjFKqquJ4a/yTJ35bCGsdlx/wUszVkFlvXNCZhDBYybGZO6Rf8TMqaCGb+ygtvTM+U4g
 o0FZYtV63uiwuUFlcFuoaHdz1LbIpiHrFEU7DMfmsvoicU8wFBRatH5ZBIbIEgH3fnDq
 A4vgUdUP4KKcduumK+rraqGCmuBJgzaz8HHKP9j9u1Zom6Pb3we1XWMQAhcoU5Vz1T2b Nw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp0175.outbound.protection.outlook.com [216.32.181.175])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2nkvbng19x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 07 Nov 2018 00:23:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYVkRi48BiUdMmSJDBF62pXScLCfF/esiK3cGfHRZhg=;
 b=KuCOzC47dKOiVDZp5WEUd+zMQCcCsq//EIIaMC0uwRYfcYB+T3bysFrgqYiDBS1OKOppQ30ooDoS+mzOxz754xrAK0h0CM0M4axmiP4LnAAbY+qxNcluD1SjXI6ZmPVWHH2eiNJlKsr4F1Mx45r7SWOHtKxMEY3XvOoimdTYJnY=
Received: from CO2PR07MB2695.namprd07.prod.outlook.com (10.166.214.8) by
 CO2PR07MB2645.namprd07.prod.outlook.com (10.166.213.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Wed, 7 Nov 2018 08:23:52 +0000
Received: from CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::d846:c378:fc67:e1cc]) by CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::d846:c378:fc67:e1cc%5]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 08:23:50 +0000
From:   Janek Kotas <jank@cadence.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Janek Kotas <jank@cadence.com>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] scsi: ufs: Add UFS platform driver for Cadence UFS
Thread-Topic: [PATCH v4 2/2] scsi: ufs: Add UFS platform driver for Cadence
 UFS
Thread-Index: AQHUUOMHXEPp/a1DKUixcejdU+ucqaVDCeeAgADT3kCAAGbeAA==
Date:   Wed, 7 Nov 2018 08:23:50 +0000
Message-ID: <38D3DEAD-C318-4BE2-8605-102FF572AD45@global.cadence.com>
References: <C77CE2E3-F88A-4B1E-BECB-5D031E2930E3@global.cadence.com>
 <1A428C77-982A-4EB8-8FDD-A33979753660@global.cadence.com>
 <yq1tvkt1vly.fsf@oracle.com>
In-Reply-To: <yq1tvkt1vly.fsf@oracle.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2645;20:34rqS0Dh2Y1FuaGcBKK3wUIEVaqIbVOJGEA31Vtchh0W9dJRGd6YvDGfRDmBbQ/9v/HhGT63xyM+a6OesgGwVNKdeQayen4L1Z50kxAzdR2pkH7tGC+XIWdPH6lkyD2Vhg2Z6+U/Qzqa8JNmuzCZPqmJ6iAuPvF1sJ8dIkjmdV+87yPW5Fwlv8nSrTgcEpeRE2KPiL0xnWAEO8gba9d1Uvcfil/9q5w1uJu/ZI9lFNL/HNvg34CVrWew9fGmO9Gs
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(346002)(366004)(189003)(199004)(36092001)(68736007)(97736004)(3846002)(71190400001)(71200400001)(6116002)(105586002)(5660300001)(256004)(6512007)(2906002)(106356001)(6436002)(6486002)(6916009)(229853002)(316002)(305945005)(7736002)(54906003)(86362001)(66066001)(14454004)(4326008)(82746002)(83716004)(53546011)(486006)(446003)(11346002)(476003)(186003)(478600001)(39060400002)(33656002)(99286004)(102836004)(8936002)(8676002)(6506007)(76176011)(25786009)(81166006)(81156014)(53936002)(6246003)(2900100001)(26005)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2645;H:CO2PR07MB2695.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 04275a72-8e63-42c2-fae7-08d6448a58c2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2645;
x-ms-traffictypediagnostic: CO2PR07MB2645:
x-microsoft-antispam-prvs: <CO2PR07MB2645CE138CDED87B255BA616D0C40@CO2PR07MB2645.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231382)(944501410)(52105095)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:CO2PR07MB2645;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB2645;
x-forefront-prvs: 08497C3D99
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: auLKiXCpC6E7ywq1LGNKvuWQNcziPP+lJb+YJPzZS4zWoZueI+QTn1XnIKjBVHWlAZS0Z+dEtGhE8mKcr5EqYIERQ7GN3ZFslQuyAgvG/VyDVLgnRZod6irmSpxPsyTuEWblN2+a0/RmF36BrOGATExgMNYSrQyHt7c51REu6vjEJEdIyKEiDf+atIHh00kpteSYtQt60TSt7E6beMaRAJBEzuY94I6RjrHzwrvUSQh0+5vjB65T+hIZ+B1R5woebSUGLIChL6H5eRqVC2qgI3QQmLt7uleHHOviG5IFxZm4+vd5eL20yKpRbtfFMAkP1pyar76tUuM7MtRFi+IMI7miVQHdOYy7FkaFSH5exqs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <29A784408F1CEF4AB32F104934783533@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04275a72-8e63-42c2-fae7-08d6448a58c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 08:23:50.3451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2645
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=929 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811070078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFJvYiByZXZpZXdlZCB0aGUgZHQgYmluZGluZyBwYXRjaCBidXQgaGFzIGl0IGJlZW4gbWVy
Z2VkIG9yIHNob3VsZCBJDQo+IHRha2UgYm90aCBwYXRjaGVzIHRocm91Z2ggU0NTST8NCg0KSSBk
b27igJl0IHRoaW5rIGl0IGhhcyBiZWVuIG1lcmdlZCwgY291bGQgeW91IHBsZWFzZSB0YWtlIGJv
dGggdGhyb3VnaCBTQ1NJLCBwbGVhc2U/DQoNClRoYW5rcywNCkphbmVrDQoNCj4gT24gNyBOb3Yg
MjAxOCwgYXQgMDM6MTUsIE1hcnRpbiBLLiBQZXRlcnNlbiA8bWFydGluLnBldGVyc2VuQG9yYWNs
ZS5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPiBKYW5laywNCj4gDQo+PiBDb3VsZCB5b3UgcGxl
YXNlIHRha2UgYSBsb29rIGF0IHRoZSBwcm9wb3NlZCBwYXRjaD8NCj4gDQo+IFJvYiByZXZpZXdl
ZCB0aGUgZHQgYmluZGluZyBwYXRjaCBidXQgaGFzIGl0IGJlZW4gbWVyZ2VkIG9yIHNob3VsZCBJ
DQo+IHRha2UgYm90aCBwYXRjaGVzIHRocm91Z2ggU0NTST8NCj4gDQo+IC0tIA0KPiBNYXJ0aW4g
Sy4gUGV0ZXJzZW4JT3JhY2xlIExpbnV4IEVuZ2luZWVyaW5nDQoNCg==
