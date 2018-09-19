Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E101ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38672150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="UXL+LFp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38672150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732778AbeISW43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:56:29 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:59614 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732111AbeISW42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:56:28 -0400
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8JHFbqf024489;
        Wed, 19 Sep 2018 12:17:31 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp0085.outbound.protection.outlook.com [216.32.180.85])
        by mx0b-00010702.pphosted.com with ESMTP id 2mgyw8p0vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 19 Sep 2018 12:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ptZkVcznF9XQnmlG35pm/Pma0L4RvsGqJciPWjHoiE=;
 b=UXL+LFp+shW9nG0NjboLezThluSTMohDsakqQeWTWreTfw9NMVKSR3Egw8kW5DCdortPNy337WXYZz+A7eA2oJgGw73T/pwhOn36wwlP7ncFWbtYxBVhAoX2p9TxuNGPXnlxF9RDq+ESVkubdTm/aYo/tdtzUONcye7E/4JqzEA=
Received: from DM5PR04MB0381.namprd04.prod.outlook.com (10.173.169.14) by
 DM5PR04MB0620.namprd04.prod.outlook.com (10.172.187.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Wed, 19 Sep 2018 17:17:29 +0000
Received: from DM5PR04MB0381.namprd04.prod.outlook.com
 ([fe80::24dd:2c16:1cd4:1303]) by DM5PR04MB0381.namprd04.prod.outlook.com
 ([fe80::24dd:2c16:1cd4:1303%12]) with mapi id 15.20.1143.017; Wed, 19 Sep
 2018 17:17:29 +0000
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
Date:   Wed, 19 Sep 2018 17:17:28 +0000
Message-ID:
 <CANr=Z=boufs6AGj5iircB3bj00ZPE+RsXgPrqGRZSc-2j1fTiw@mail.gmail.com>
References: <0997a0e77b5e5c04c9a4d277d702d93a1a8a7448.1537373294.git.michal.simek@xilinx.com>
In-Reply-To: <0997a0e77b5e5c04c9a4d277d702d93a1a8a7448.1537373294.git.michal.simek@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0079.namprd12.prod.outlook.com
 (2603:10b6:802:21::14) To DM5PR04MB0381.namprd04.prod.outlook.com
 (2603:10b6:3:9d::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [209.85.166.49]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0620;6:6M2Szsr8o6Pn7cihB6SJsbxBSb6GYyge8NMLa2Ugu9BdhzviR4sst3yarsrbqOL2sI+G5W5O/R/SujXA1+ZYr5YbHsrYnPvKyA+ncYmTQKNuQAw0Pe/+tZc2b33ouQZv02zFC8i50gyl0gX7/Xmy/1EJYCJbaAk/jEBTkEC14tHimsSCFgK2v20bD7ysnEioE9xeFm+ma67xMTAiWTyqYl9oKAuELh/Gb90t8NFZZU5N9CMdgcOU9R30EBUEb+NQqP3r9RxeqhurNDU/+uMO2ApKdCSsHFqD/9reNCBQosPeVomo73HGUysjAO+y802unIf2iB57Rv8nafoCYb/+v6qGvz1PXm2xhLTIZ/JPXoHIA+UflKwywU0JsrhX7Pwbz5Sa9X13gMrFXa/NHx453H7Dr+VyGKMKtgKE6nL8Qesyb8xD6Gwr8B1KoM7gJgZPB0E0sfWSLyVVHwhPHF4uSw==;5:pgKzcKu8NshwgMklL7ZtdyU0+6/A6hDFkz1IjAAKwRmxn9KlfOQCdcxxcZDy8wUsrBmOT/UKaq7PE44R60epxEMo4E6OH8oJPGFemXcuwKpzMEwziA6K3o63U8BURjNnIWJPDZEnZSrmTboGo8G+Oa3/ibRUdsaOVgR7TfN4Y84=;7:GCK68OQeci0Wr5heUJLvXPHNX+X2ZjKxlBUfeGfLTB9BwbmXldW8Hvh71cHm2yRt5kNS9tvpzwBDkEPytyQV6f8Xv+bumGEoM/dmZuSLr/pLkkwfHhntciFaC0a795Myzdz0zPpQ1/Ok8G3XvSJg4MGWKwAIDqNd+HoxAtVde0G/UT57zfegvcqhV+3KO1+ovDxxAsHbjyBD7hqCQFTKPJgxE9tvmapr8qCaMawmpI+zaFrV1VWPoRSEGW7X9Dvv
x-ms-office365-filtering-correlation-id: 29c7a367-de09-4ec5-7cab-08d61e53c61b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB0620;
x-ms-traffictypediagnostic: DM5PR04MB0620:
x-microsoft-antispam-prvs: <DM5PR04MB06204E8CBB27384E0F8B4854F61C0@DM5PR04MB0620.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592)(145744241990776);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699050);SRVR:DM5PR04MB0620;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0620;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(136003)(376002)(39850400004)(199004)(189003)(55446002)(5250100002)(478600001)(61726006)(2906002)(6116002)(81166006)(97736004)(316002)(2900100001)(8676002)(6246003)(26005)(14454004)(81156014)(3846002)(102836004)(8936002)(68736007)(186003)(53936002)(486006)(6512007)(9686003)(66066001)(105586002)(98316002)(6486002)(52116002)(386003)(4326008)(53546011)(6506007)(33896004)(25786009)(106356001)(54906003)(6916009)(99286004)(76176011)(305945005)(229853002)(43066004)(11346002)(476003)(256004)(5660300001)(498394004)(7736002)(61266001)(446003)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0620;H:DM5PR04MB0381.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /4iAImlH5iv4YmUw/Cx6we/TFEI9cPPAKaWQM1tx2KNHa6dUmiRZR+ZhutzJjQrrKTehCQA0mDGxwnUjHQc8M8MjbQHVHo3QjlSkBT9miYjLxvfcsjRkt7TQl20wdDm8rNmwekb05UmMEyB910Sqmht5N49auQtqTVelRJHlau1BkD45EO7YHveKtf3Zb08kZpf1lsIFWk+zQzSpwihIssyxWYx8PItaHSP40GXL/ru0IUjriHpv8VMR02Q+OLXUjL5ANCMnHlxPrnOnqoRmIlHWTsXfwf9UuhvLKaHy4L2HFaU8AsVZOIsgjjmUAGg/tSfajVS3zW+9kzELJZpl6SxKb/8TwBi3Ru6WYo5zWRk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <68208860A2935047A1E77B280A9E170F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Reply-To: <joe.hershberger@ni.com>
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c7a367-de09-4ec5-7cab-08d61e53c61b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 17:17:28.8915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0620
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=808 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809190167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180919171728.VzMBUapcCsDR1NSuJLluxv6ViVR4FvB9vmrIVHER5Rk@z>

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
