Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C7EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3DC2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="DetaQ1dy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3DC2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732861AbeISWuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:50:46 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:59136 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732757AbeISWuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:50:46 -0400
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8JH1rBf015424;
        Wed, 19 Sep 2018 12:11:50 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp0084.outbound.protection.outlook.com [216.32.180.84])
        by mx0b-00010702.pphosted.com with ESMTP id 2mgyw8p09x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 19 Sep 2018 12:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ptZkVcznF9XQnmlG35pm/Pma0L4RvsGqJciPWjHoiE=;
 b=DetaQ1dy4giOPnCx7U8GzYayx9a5WzW9xSKGyA0k3o0owSfOB9EUuIBp7rBpErkHOCPZTAmBrL9crLiyoRu8vQ7NyVlnqCxuD+WcjX0YBu/zHwkNftsyG9/xoKga0rTAYMi2nF4UdDU9eMBO8lyWsXIu8xVuBxmhaRnmAe+im2o=
Received: from DM5PR04MB0381.namprd04.prod.outlook.com (10.173.169.14) by
 DM5PR04MB0522.namprd04.prod.outlook.com (10.173.170.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Wed, 19 Sep 2018 17:11:49 +0000
Received: from DM5PR04MB0381.namprd04.prod.outlook.com
 ([fe80::24dd:2c16:1cd4:1303]) by DM5PR04MB0381.namprd04.prod.outlook.com
 ([fe80::24dd:2c16:1cd4:1303%12]) with mapi id 15.20.1143.017; Wed, 19 Sep
 2018 17:11:48 +0000
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
Date:   Wed, 19 Sep 2018 17:11:46 +0000
Message-ID: <CANr=Z=boufs6AGj5iircB3bj00ZPE+RsXgPrqGRZSc-2j1fTiw@mail.gmail.com>
References: <0997a0e77b5e5c04c9a4d277d702d93a1a8a7448.1537373294.git.michal.simek@xilinx.com>
In-Reply-To: <0997a0e77b5e5c04c9a4d277d702d93a1a8a7448.1537373294.git.michal.simek@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0124.namprd05.prod.outlook.com
 (2603:10b6:803:42::41) To DM5PR04MB0381.namprd04.prod.outlook.com
 (2603:10b6:3:9d::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [209.85.166.45]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0522;6:htUz8LaUwXm/PYW/ZpwRzZy0xIJRFncPTsuzQn5g5iP6OmOpUsSUvqPyCz86FY/dxcSPOrtLHQTj+m/KuZX8Rx0OvvySQQcFFP9qE89p/utNa9cUeop8O0R8saJxwxqELkA9G3vcbhRxIg5GLRiynpgJh871/bQdJRCyt6u3EWbeZJRSqNh/qHN7CK5n4Gyjd0Ki05XrKd5QtjUWbqQG5LcWtN+eC512KsYbt4XWqolKj9mXQTqaqXMu/SYXNjGlVC9pwvBBsC4T1AfnwGMyEFAHu+rVyGkFyJYXdgu1zQyHNYDlLR9lloGVkK/VCb1MMDMO4UDmhMTIQSUdi5aOOCDl0tGpvSoWwpP8fReToWz0kx5pGo6Lsw0s6YBku4pn1L+EPu9QGYue2OmxQKW0hU2XL2J3E+l2cBir7YdQWS+QIrYZsTKo4/Z0oPFXUP0YxhnYfLCHZ8kxiO1LWvU1JA==;5:eEoMI3CGJuemJX9G+iwL28eRhrCJQTh5PcqGzf9fJdGuWeRSApKKS8f33cGgpoM8bGJmP7dZ8wn1+Gn7VQh4XOv5u0au/5LaqUF8NVdMFJVUWzQ9TG3zreMeVPTcgtSdg5MaZ8OxdJezUNbHJdK2c9gikqnVSy/64KjOuhdne7s=;7:aazRPAzx4FGrtxhoSX5r57nlcuCFlG3UlgstJGArAqQXHaqis7lPczvRrqEetDwLkbtGa9Pmf3c5br3TdqwRriQTgps5VGrsiwr6Ey191a9O7JSAaqMNXotPoSSPXeVRF3x1IosTL3eYHVR7+Q47X9Nmr3GUc09cXL61gyvdPNuae1vT21ZXyX8X6lOBkMJMjDTy6xunmqWsJ3/2DxLoZw535puVuO9+kw3eAoZ2JqFq2K5ywe9mc1mfaMY9Qzhi
x-ms-office365-filtering-correlation-id: 00736315-449c-4637-24fe-08d61e52fa5d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB0522;
x-ms-traffictypediagnostic: DM5PR04MB0522:
x-microsoft-antispam-prvs: <DM5PR04MB0522B09D91B837D4413EE1F9F61C0@DM5PR04MB0522.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592)(145744241990776);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699050);SRVR:DM5PR04MB0522;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0522;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(136003)(396003)(39860400002)(189003)(199004)(55446002)(81166006)(105586002)(99286004)(316002)(476003)(3846002)(81156014)(2900100001)(106356001)(6116002)(68736007)(8936002)(6916009)(6246003)(486006)(97736004)(5660300001)(8676002)(6512007)(98316002)(43066004)(5250100002)(54906003)(11346002)(256004)(446003)(229853002)(53546011)(478600001)(186003)(66066001)(14454004)(61266001)(9686003)(102836004)(6486002)(4326008)(6506007)(386003)(305945005)(498394004)(52116002)(2906002)(7736002)(76176011)(6436002)(53936002)(33896004)(25786009)(26005)(61726006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0522;H:DM5PR04MB0381.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IIj7GjtY32BDA6Sv74jDDtZqBIAQZ9ER47qBxzeMwV6ciYyAImYt/SpmjLeVXVgk5QdWRRE/uahHUtRQf6hcN41QwsnovobefbkypA3vQf5CTPoTDIA6oNmSXD9szjmW0lA8Lb4/puKz9deur1ha4Cp4b2nA2gMeLV+dFP5KUBuzxUK9dqjzbiFeYNFHFTvAjKZ3r3PZ0Ayu6fIHo62Pv98WT8v8VFYUiUStyZFA40U0r0ee4Bw0lnFRpv1qPa9A/KBgJ8bVFJzOzOti1dNnmK5D5woTBitI7mGjmVkP45dZcNsSRqjO+VtS4cCTdFwY0L/ClOs4Rfj0INI8g43kkjYUFpvNTyUykxwMTlDS11w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB0C86B7550F234EA5A38F168563C4E8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Reply-To: <joe.hershberger@ni.com>
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00736315-449c-4637-24fe-08d61e52fa5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 17:11:46.1278
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
