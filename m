Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDAEFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8263420853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="RfyWgCtw";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="XdlQZAjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8263420853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeINNai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:30:38 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:47292 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728005AbeINNah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:30:37 -0400
X-Greylist: delayed 1831 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Sep 2018 09:30:36 EDT
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8E7fMWu027587;
        Fri, 14 Sep 2018 00:46:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=proofpoint;
 bh=JrQR2/1Arx/XHwsdlqG6k0DmBOLg2XOCRSjRpz3INUY=;
 b=RfyWgCtwxDme/whm8tOP/vigIn0QtW6/+yx3NxXuTUQJvbO5oLV48ukrMbxeQHYz8ZEV
 w4pcm/McdenPO8KCtoq8jEuF9K06E9vEfAacktDtUHcaAMq1sOEVSHj+a+wHunppRplj
 j2wGt4XfXne0x/1lsJMFU9s8eLM6Uln8OpbaCQ3oRwFbMwP6Dz+hBGXy9skzTtbRLst5
 R6O9hL2qdPQN9owMF7uwwdES0VRvh1aPBLB+WDUXlqs3YLZk91hJbcIWY++j5DgMzzXw
 MZGIsTy7Jve2NkIM66FWi3S5arRmIiD6WZmqyPYXGVL4JK4l9ZRS5tlbU+yqh+4rjLxU 9w== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp0119.outbound.protection.outlook.com [216.32.180.119])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2mf7y7yrfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Sep 2018 00:46:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrQR2/1Arx/XHwsdlqG6k0DmBOLg2XOCRSjRpz3INUY=;
 b=XdlQZAjCq4HcN2R14STL4ah5PqLns+8gj9mMFrKPQNA79f3WkMAbd9TEwVxB/catg8hkws5AunWybFGDEB5pIzJa7nFyFX2+jUjY9go9EkwWpvdLTrouoy/j7KkTMiULvfiMKRPpm1EQXsz0kbWQZOLkVNkUU/1DP8MaSukay9w=
Received: from CO2PR07MB2695.namprd07.prod.outlook.com (10.166.214.8) by
 CO2PR07MB2725.namprd07.prod.outlook.com (10.166.200.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.18; Fri, 14 Sep 2018 07:46:35 +0000
Received: from CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::4c7c:3f0f:3bba:ab95]) by CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::4c7c:3f0f:3bba:ab95%4]) with mapi id 15.20.1122.018; Fri, 14 Sep 2018
 07:46:34 +0000
From:   Janek Kotas <jank@cadence.com>
To:     Sekhar Nori <nsekhar@ti.com>
CC:     Janek Kotas <jank@cadence.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] scsi: ufs: Add UFS platform driver for Cadence UFS
Thread-Topic: [PATCH v3 2/2] scsi: ufs: Add UFS platform driver for Cadence
 UFS
Thread-Index: AQHUL+RvFd21/pjtRkOnI6b092KKqaTWpfUAgBj4XoA=
Date:   Fri, 14 Sep 2018 07:46:34 +0000
Message-ID: <5BC4E8E4-566E-415A-9B57-36D725D8AB38@global.cadence.com>
References: <66C16650-56D0-46A3-8050-A5540E48C702@global.cadence.com>
 <0b273e2e-6d60-ac10-a1d5-78ea2346c1d9@ti.com>
In-Reply-To: <0b273e2e-6d60-ac10-a1d5-78ea2346c1d9@ti.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2725;20:PrntmmgwvA4Fi/dnAtsiYKDSBeOugwAVleR9FuLAZoAVkmbLFa04x5m32r0O1bSobjgOur3HhzJUTjlIeHxn2WteTmtdUTOiWj/uX1YArs43ePTQD8PSo/YEUDOsH5V4Y+GPZHY8U0UM3bv8hf3KSbNaA86pfR8mQBgJ+FHAayXv+xgzbgYK6jnm2bTJvdddFcao82H5cf4axTUj1eot68lZ2coc0FrCmp9Om7O03NN4J4CeGusf4Z1t4iar/aDt
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(36092001)(199004)(8676002)(2900100001)(82746002)(6246003)(25786009)(106356001)(39060400002)(81166006)(105586002)(2906002)(97736004)(5660300001)(81156014)(446003)(11346002)(7736002)(66066001)(6116002)(3846002)(4326008)(33656002)(6506007)(5250100002)(14444005)(345774005)(83716003)(14454004)(53936002)(53546011)(316002)(8936002)(486006)(68736007)(99286004)(102836004)(476003)(6512007)(305945005)(229853002)(478600001)(76176011)(86362001)(6916009)(6486002)(26005)(6436002)(54906003)(186003)(256004)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2725;H:CO2PR07MB2695.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: be80c036-4909-4a99-0b2c-08d61a1631cb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2725;
x-ms-traffictypediagnostic: CO2PR07MB2725:
x-microsoft-antispam-prvs: <CO2PR07MB2725D0772B03A33CAB80F0E1D0190@CO2PR07MB2725.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050);SRVR:CO2PR07MB2725;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB2725;
x-forefront-prvs: 07954CC105
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wORcGCNGu2sBbr5NwnMVophgvKE7iX5TyB/36iQhfP0qFima6w9/ujR7DpBmUE9mmhRDWNXPYq/UOXb0KD0CSFmKYmPwEx6pwKVMUku29UZtPIH2mZbCMOcmP5M8Fd97WvNaItkGX4DamWbExs7OiCpg0yjEW/FBRf/jvJ1seC1cuymtsB5dyCuUIetHeK79VJID6KsSifht6XRIvoHsiXzOdfmpZPRSaFEGYny6uXVZvGqGtVnf+uq3DzR68FKhO96PwVXre4+XJXoXpK9WwNrtJFVZuhEc0fde2mkjkafRZ/jw4gMFsr52Jw55Th35S6URenZcmn9EK/N+Ua2DPLU9FpOsG9eAsNA1flsxMnw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BF4028831657345B0488A31841B350F@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be80c036-4909-4a99-0b2c-08d61a1631cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 07:46:34.3674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2725
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-14_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809140082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIDI5IEF1ZyAyMDE4LCBhdCAxMjoyNywgU2VraGFyIE5vcmkgPG5zZWtoYXJAdGkuY29t
PiB3cm90ZToNCj4gDQo+IE9uIFRodXJzZGF5IDA5IEF1Z3VzdCAyMDE4IDA2OjU1IFBNLCBKYW5l
ayBLb3RhcyB3cm90ZToNCj4+IFRoaXMgcGF0Y2ggYWRkcyBhIGRldmljZSB0cmVlIHBsYXRmb3Jt
IGRyaXZlciBmb3INCj4+IENhZGVuY2UgVUZTIEhvc3QgQ29udHJvbGxlci4NCj4+IEl0IGNhbiBi
ZSBlbmFibGVkIHdpdGggU0NTSV9VRlNfQ0ROU19QTEFURk9STSBLY29uZmlnIG9wdGlvbi4NCj4+
IA0KPj4gU2lnbmVkLW9mZi1ieTogSmFuIEtvdGFzIDxqYW5rQGNhZGVuY2UuY29tPg0KPiANCj4g
Wy4uLl0NCj4gDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Vmcy9jZG5zLXBsdGZybS5j
IGIvZHJpdmVycy9zY3NpL3Vmcy9jZG5zLXBsdGZybS5jDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KPj4gaW5kZXggMDAwMDAwMDAuLjVkOWU0ODc1DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysg
Yi9kcml2ZXJzL3Njc2kvdWZzL2NkbnMtcGx0ZnJtLmMNCj4+IEBAIC0wLDAgKzEsMTQ3IEBADQo+
PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4+ICsvKg0KPj4gKyAqIFBs
YXRmb3JtIFVGUyBIb3N0IGRyaXZlciBmb3IgQ2FkZW5jZSBjb250cm9sbGVyDQo+PiArICoNCj4+
ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTggQ2FkZW5jZSBEZXNpZ24gU3lzdGVtcywgSW5jLg0KPj4g
KyAqDQo+PiArICogQXV0aG9yczoNCj4+ICsgKglKYW4gS290YXMgPGphbmtAY2FkZW5jZS5jb20+
DQo+PiArICoNCj4+ICsgKi8NCj4+ICsNCj4+ICsjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+
PiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9y
bV9kZXZpY2UuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4+ICsjaW5jbHVkZSA8bGlu
dXgvdGltZS5oPg0KPj4gKw0KPj4gKyNpbmNsdWRlICJ1ZnNoY2QtcGx0ZnJtLmgiDQo+PiArDQo+
PiArI2RlZmluZSBDRE5TX1VGU19SRUdfSENMS0RJViAweEZDDQo+PiArDQo+PiArLyoqDQo+PiAr
ICogU2V0cyBIQ0xLRElWIHJlZ2lzdGVyIHZhbHVlIGJhc2VkIG9uIHRoZSBjb3JlX2Nsaw0KPj4g
KyAqIEBoYmE6IGhvc3QgY29udHJvbGxlciBpbnN0YW5jZQ0KPj4gKyAqDQo+PiArICogUmV0dXJu
IHplcm8gZm9yIHN1Y2Nlc3MgYW5kIG5vbi16ZXJvIGZvciBmYWlsdXJlDQo+PiArICovDQo+PiAr
c3RhdGljIGludCBjZG5zX3Vmc19zZXRfaGNsa2RpdihzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KPj4g
K3sNCj4+ICsJc3RydWN0IHVmc19jbGtfaW5mbyAqY2xraTsNCj4+ICsJc3RydWN0IGxpc3RfaGVh
ZCAqaGVhZCA9ICZoYmEtPmNsa19saXN0X2hlYWQ7DQo+PiArCXVuc2lnbmVkIGxvbmcgY29yZV9j
bGtfcmF0ZSA9IDA7DQo+PiArCXUzMiBjb3JlX2Nsa19kaXYgPSAwOw0KPj4gKw0KPj4gKwlpZiAo
bGlzdF9lbXB0eShoZWFkKSkNCj4+ICsJCXJldHVybiAwOw0KPj4gKw0KPj4gKwlsaXN0X2Zvcl9l
YWNoX2VudHJ5KGNsa2ksIGhlYWQsIGxpc3QpIHsNCj4+ICsJCWlmIChJU19FUlJfT1JfTlVMTChj
bGtpLT5jbGspKQ0KPj4gKwkJCWNvbnRpbnVlOw0KPj4gKwkJaWYgKCFzdHJjbXAoY2xraS0+bmFt
ZSwgImNvcmVfY2xrIikpDQo+PiArCQkJY29yZV9jbGtfcmF0ZSA9IGNsa19nZXRfcmF0ZShjbGtp
LT5jbGspOw0KPj4gKwl9DQo+PiArDQo+PiArCWlmICghY29yZV9jbGtfcmF0ZSkgew0KPj4gKwkJ
ZGV2X2VycihoYmEtPmRldiwgIiVzOiB1bmFibGUgdG8gZmluZCBjb3JlX2NsayByYXRlXG4iLA0K
Pj4gKwkJCV9fZnVuY19fKTsNCj4+ICsJCXJldHVybiAtRUlOVkFMOw0KPj4gKwl9DQo+PiArDQo+
PiArCWNvcmVfY2xrX2RpdiA9IGNvcmVfY2xrX3JhdGUgLyBVU0VDX1BFUl9TRUM7DQo+PiArDQo+
PiArCXVmc2hjZF93cml0ZWwoaGJhLCBjb3JlX2Nsa19kaXYsIENETlNfVUZTX1JFR19IQ0xLRElW
KTsNCj4+ICsJLyogTWFrZSBzdXJlIHRoZSByZWdpc3RlciB3YXMgdXBkYXRlZCAqLw0KPj4gKwlt
YigpOw0KPiANCj4gV2h5IGlzIGl0IGNyaXRpY2FsIHRvIGVuc3VyZSB3cml0ZSBjb21wbGV0ZWQg
aGVyZT8NCg0KVGhlIFVuaVBybyBjbG9jayByYXRlIG5lZWRzIHRvIGJlIHNldCBiZWZvcmUgaXTi
gJlzIGVuYWJsZWQsIA0Kb3RoZXJ3aXNlIGl0IHdpbGwgY2F1c2UgYSBsb3Qgb2YgZXJyb3JzIGF0
IHRoZSBsaW5rIGxheWVyLg0KDQo+IA0KPj4gKw0KPj4gKwlyZXR1cm4gMDsNCj4+ICt9DQo+PiAr
DQo+IA0KPj4gKy8qKg0KPj4gKyAqIGNkbnNfdWZzX3BsdGZybV9yZW1vdmUgLSBzZXQgZHJpdmVy
X2RhdGEgb2YgdGhlIGRldmljZSB0byBOVUxMDQo+IA0KPiBUaGlzIGFwcGVhciB0byBkbyBtb3Jl
IHRoYW4gc2V0dGluZyBkcml2ZXJfZGF0YSB0byBOVUxMLg0KDQpJIHdpbGwgdXBkYXRlIHRoZSBk
ZXNjcmlwdGlvbiwgdGhhbmsgeW91IGZvciBwb2ludGluZyB0aGF0Lg0KDQo+IA0KPj4gKyAqIEBw
ZGV2OiBwb2ludGVyIHRvIHBsYXRmb3JtIGRldmljZSBoYW5kbGUNCj4+ICsgKg0KPj4gKyAqIEFs
d2F5cyByZXR1cm5zIDANCj4+ICsgKi8NCj4+ICtzdGF0aWMgaW50IGNkbnNfdWZzX3BsdGZybV9y
ZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICt7DQo+PiArCXN0cnVjdCB1
ZnNfaGJhICpoYmEgPSAgcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+PiArDQo+PiArCXBt
X3J1bnRpbWVfZ2V0X3N5bmMoJihwZGV2KS0+ZGV2KTsNCj4gDQo+IFRoaXMgbG9va3Mgc3VzcGVj
dC4gV2h5IGRvIHlvdSBuZWVkIHRoaXMgZ2V0X3N5bmMoKSBvbiByZW1vdmUoKSBhbmQNCj4gd2hl
cmUgaXMgdGhlIGNvcnJlc3BvbmRpbmcgcHV0X3N5bmMoKT8NCg0KSSBsb29rZWQgYXQgcWNvbSBk
cml2ZXIgYXMgYSByZWZlcmVuY2UsIEkgd2lsbCByZXZpZXcgdGhpcywgdGhhbmsgeW91Lg0KDQo+
PiArCXVmc2hjZF9yZW1vdmUoaGJhKTsNCj4+ICsJcmV0dXJuIDA7DQo+PiArfQ0KPiANCj4gVGhh
bmtzLA0KPiBTZWtoYXINCg0KVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5Lg0KSSB3aWxsIHVwZGF0
ZSB0aGUgcGF0Y2guDQoNCkphbg0KDQo=
