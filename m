Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06F3ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E2F2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="JuxrX8A2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E2F2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732886AbeISWur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:50:47 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:59134 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732756AbeISWur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:50:47 -0400
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8JH1rBe015424;
        Wed, 19 Sep 2018 12:11:50 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp0084.outbound.protection.outlook.com [216.32.180.84])
        by mx0b-00010702.pphosted.com with ESMTP id 2mgyw8p09x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 19 Sep 2018 12:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ptZkVcznF9XQnmlG35pm/Pma0L4RvsGqJciPWjHoiE=;
 b=JuxrX8A26DTYjQm0uzXDZh89PMX2SWXOKLWQG52fP01HFSNkkySjZ6SHenGeq9acqrNIHV2dFyuXy1xG5x1kN7cyccM/s54keYX8m7zN9IKEYdwRW/A9K17ADYqvo5tWnM8r5L9V0TLmr29cWUYA9GUi+SuP8jLkVUEtjQ9uICA=
Received: from DM5PR04MB0381.namprd04.prod.outlook.com (10.173.169.14) by
 DM5PR04MB0522.namprd04.prod.outlook.com (10.173.170.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Wed, 19 Sep 2018 17:11:47 +0000
Received: from DM5PR04MB0381.namprd04.prod.outlook.com
 ([fe80::24dd:2c16:1cd4:1303]) by DM5PR04MB0381.namprd04.prod.outlook.com
 ([fe80::24dd:2c16:1cd4:1303%12]) with mapi id 15.20.1143.017; Wed, 19 Sep
 2018 17:11:47 +0000
From:   Joe Hershberger <joe.hershberger@ni.com>
To:     Michal Simek <michal.simek@xilinx.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        "edgari@xilinx.com" <edgari@xilinx.com>,
        Joseph Hershberger <joseph.hershberger@ni.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        u-boot <u-boot@lists.denx.de>
Subject: Re: [U-Boot] [PATCH] net: macb: Clean 64b dma addresses if they are
 not detected
Thread-Topic: [U-Boot] [PATCH] net: macb: Clean 64b dma addresses if they are
 not detected
Thread-Index: AQHUUDMA8PQ0FWtDFUWFBiRoWujv2qT31zOA
Date:   Wed, 19 Sep 2018 17:11:45 +0000
Message-ID:
 <CANr=Z=boufs6AGj5iircB3bj00ZPE+RsXgPrqGRZSc-2j1fTiw@mail.gmail.com>
References: <0997a0e77b5e5c04c9a4d277d702d93a1a8a7448.1537373294.git.michal.simek@xilinx.com>
In-Reply-To: <0997a0e77b5e5c04c9a4d277d702d93a1a8a7448.1537373294.git.michal.simek@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0117.namprd05.prod.outlook.com
 (2603:10b6:803:42::34) To DM5PR04MB0381.namprd04.prod.outlook.com
 (2603:10b6:3:9d::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [209.85.166.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0522;6:PIrTKRBgj8oCTwe8IPO5qH+UrH5c/GLhRlomfjeJ/JuGBpz9XOroLqB6T90xTM3pGPw2LrW0yALk5VYDU7z93npfnxGeFom9Ye1uVnKSQndbUmIyjxqN+hOHF75DT0bK7iu4wcsIjXycXfAOtq5nZITflL9XeE+qqFIdBdshgglCwOsVCoZmj774LJFNYhdu3RAxsotqYH5z95kn5/wyt6HENssjqF9pPEspV9JiUL0f6r6QkLCGsZNox2LOFSqqs2hSqv3PNw/5bU/r8eyD+uQDVJP/3U2oOZ4m9XAu0/N5u332Mng7BFt+v3XbauOAui0zT6Qk3BLaG8ESyDM/6qwYFatRnrYdsaJDYDefynhD7KXVSoKT8C1Kldx3unKvdVzqWXgi5tBToxj1SPF2J5UBv3Hkq0zW5jwcTQj80EFpeDOGlwgrn8+5z/e3S5X50AKo2YkrxEEHuK6Z+fOVYA==;5:5xE1Wx5bZHXi68CMylAovHv9rZ+4hxircbBHcIJ63X+BA1+H/2+kDRINrTiLnQTMJfP9jqIQgxG/rkFyrZT+AKFNHYggakpWKRPhrdI76OCl08dahCfkCXFGu35UcVAEcktpQTFfNsgIqJW9vc+/hH31wJ7+IVxalzVkzsR76TI=;7:MvMCT3FGZIburDJfzHXl3McPB+fra5kH3hjkWALzGp9as+Z/T6Uu+GG+E1rOBAwFqPAhpVDvCv4rl84DVVTynq3ddWnI5t0dkMWxSzCq8/8DN5wm9hhL73DKV1X7o8dQ0a/ivfNubqSYhkGdKhd7Xcx55Z4Q3I4ITkqk0Rw0dzAB6igKiovUoJDM3flGqqZ2HZO0/9r+Dm18WGdHfEB1R2cizPzCRRtrHlzP85O90fhcwN0SlvgN3mvwYdLdO7Ss
x-ms-office365-filtering-correlation-id: 5d2a0a2c-ffea-4e78-b97a-08d61e52fa42
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB0522;
x-ms-traffictypediagnostic: DM5PR04MB0522:
x-microsoft-antispam-prvs: <DM5PR04MB0522A5A178D0A1F63C2E8519F61C0@DM5PR04MB0522.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592)(145744241990776);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699050);SRVR:DM5PR04MB0522;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0522;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(136003)(396003)(39860400002)(189003)(199004)(55446002)(81166006)(105586002)(99286004)(316002)(476003)(3846002)(81156014)(2900100001)(106356001)(6116002)(68736007)(8936002)(6916009)(6246003)(486006)(97736004)(5660300001)(8676002)(6512007)(98316002)(43066004)(5250100002)(54906003)(11346002)(256004)(446003)(229853002)(53546011)(478600001)(186003)(66066001)(14454004)(61266001)(9686003)(102836004)(6486002)(4326008)(6506007)(386003)(305945005)(498394004)(52116002)(2906002)(7736002)(76176011)(6436002)(53936002)(33896004)(25786009)(26005)(61726006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0522;H:DM5PR04MB0381.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: X9DZ/qTqvKP6pVIfiAs0X5fFYc97gwkHLj85deUY5kuSc8Ll+ArPzFiMSY+O0Y8Y7xeB/YV05tnpYehNB98Issj0oeIXSGTOb1DPluewrmEbO755ZR/4Wsu8xmDnIgb2Wnt6Xm10ZfoaUvocYxuGpBjm7NiGzcWAB+Js9dUTQfXteOzoiKgZAdIDJBoq1bZOY+H/4S+TJRdTmmDlbTQGEys/zxo3604fFRwzNEOvVQOzBrhGscxcE2vP493GZkZAqbr1TU3R0lFlNajZYYrjPy2O1HZtoYdrEhiaYRzmSytm1bycaPyw+B/gUX1mzqKI5frqZwQGhWpQ1i5+S5Ys5tD16l6Wqq2UjOXf4eXWKIE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E86760B91A3AE446A4EA5B192B5D3907@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Reply-To: <joe.hershberger@ni.com>
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2a0a2c-ffea-4e78-b97a-08d61e52fa42
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 17:11:45.9786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0522
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=808 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809190166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180919171145.i4XCtl3CuP2E-X2nvJtzWHREJByLoMa5rbbQJeKrOwQ@z>

T24gV2VkLCBTZXAgMTksIDIwMTggYXQgMTE6MDggQU0gTWljaGFsIFNpbWVrIDxtaWNoYWwuc2lt
ZWtAeGlsaW54LmNvbT4gd3JvdGU6DQo+DQo+IENsZWFyIEFERFI2NCBkbWEgYml0IGluIERNQUNG
RyByZWdpc3RlciBpbiBjYXNlIHRoYXQgSFdfRE1BX0NBUF82NEINCj4gaXMgbm90IGRldGVjdGVk
IG9uIDY0Yml0IHN5c3RlbS4NCj4gVGhlIGlzc3VlIHdhcyBvYnNlcnZlZCB3aGVuIGJvb3Rsb2Fk
ZXIodS1ib290KSBkb2VzIG5vdCBjaGVjayBtYWNiDQo+IGZlYXR1cmUgYXQgRENGRzYgcmVnaXN0
ZXIgKERBVzY0X09GRlNFVCkgYW5kIGVuYWJsaW5nIDY0Yml0IGRtYSBzdXBwb3J0DQo+IGJ5IGRl
ZmF1bHQuIFRoZW4gbWFjYiBkcml2ZXIgaXMgcmVhZGluZyBETUFDRkcgcmVnaXN0ZXIgYmFjayBh
bmQgb25seQ0KPiBhZGRpbmcgNjRiaXQgZG1hIGNvbmZpZ3VyYXRpb24gYnV0IG5vdCBjbGVhbmlu
ZyBpdCBvdXQuDQo+DQo+IFRoaXMgaXMgYWxzbyBhbGlnbiB3aXRoIG90aGVyIGZlYXR1cmVzIHdo
aWNoIGFyZSBhbHNvIGNsZWFyZWQgaWYgdGhleSBhcmUgbm90DQo+IHByZXNlbnQuDQo+DQo+IFNp
Z25lZC1vZmYtYnk6IE1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVrQHhpbGlueC5jb20+DQoNCkFj
a2VkLWJ5OiBKb2UgSGVyc2hiZXJnZXIgPGpvZS5oZXJzaGJlcmdlckBuaS5jb20+DQo=
