Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4AFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 09:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB7C218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 09:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="blpGAfam";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="X/u0jNMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbeL0Jhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 04:37:43 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:41940 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727926AbeL0Jhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 04:37:42 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBR9alsf001827;
        Thu, 27 Dec 2018 01:36:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=/28zhW78OJWdl1eKI5cXg0MuD2uSYHis1+HSd5ZYYXU=;
 b=blpGAfamB14xx1cEvsir3NkG/picKLtpPSa0zOA4L+nE8W41v8iJHBxlVptEiX3aLvTM
 BWu0ALR3GLetf6uI9voqM84wQpG8aXx6gcn3wGPs8wVLNWU+RG0rAj/DMVbq7AaPpzRQ
 0Of40BqjOh1MxUMeA7l3GShCwpHLLakq2+aujeGD+We6Gg8F4dyEUiuMG59F5Jka1WA8
 zdxxTkWjV2Jcl3nO0UlEqfcAikX2FCQLQowxvqYJtEOyQoFui+m2O6pCUUnXUEeB3iAT
 r+uJ+4kpLxdgFfUhrdlrM4ltRbtTlz+X0Ms8YYqqyZAzm1u0cM5xiWI7R4v81FMizQMY tQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2058.outbound.protection.outlook.com [104.47.33.58])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2phjq23n28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 27 Dec 2018 01:36:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/28zhW78OJWdl1eKI5cXg0MuD2uSYHis1+HSd5ZYYXU=;
 b=X/u0jNMTJXD6zupm3B9hZUYoHxcHJ5tWL4d/4ZzpAaImapei2r/ppNyZjVdrP26khEch3KXxOQiD0t2/9v8+KuP94D20yliIzTnfN1d9hD/sCvw+03chINSwvpSaslLe2UDDYGTG1dPeQX+9AQuu20IvH+wYfnsKZWWAosfTDJ8=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4583.namprd07.prod.outlook.com (52.135.204.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.24; Thu, 27 Dec 2018 09:36:41 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e97e:1c66:94bc:24ef]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e97e:1c66:94bc:24ef%3]) with mapi id 15.20.1471.019; Thu, 27 Dec 2018
 09:36:41 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <hzpeterchen@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v2 5/5] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v2 5/5] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHUmtItEP31Hrx74EuIb6kD4d3L1KWNo02AgAGSJYCAAx9OYA==
Date:   Thu, 27 Dec 2018 09:36:40 +0000
Message-ID: <BYAPR07MB4709F8A00A13390235BA4BE1DDB60@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1545577992-4013-1-git-send-email-pawell@cadence.com>
 <1545577992-4013-6-git-send-email-pawell@cadence.com>
 <CAL411-rj0mRMfPCZOHw04q3s-9oJx7Os9Jz83bO=RgPZKLrB1g@mail.gmail.com>
 <CAL411-omVL2rwoQP6GwKZa9f_1TLBbEAkyLdxNkJZqaQu9cvsA@mail.gmail.com>
In-Reply-To: <CAL411-omVL2rwoQP6GwKZa9f_1TLBbEAkyLdxNkJZqaQu9cvsA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNjgwNzMxYTEtMDliYS0xMWU5LTg3MjgtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDY4MDczMWEyLTA5YmEtMTFlOS04NzI4LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjkwNSIgdD0iMTMxOTAzNzY3ODU5MDY0NjUyIiBoPSJnekRrTGhwQTJ6dHFtWFErMk5BckEySHlmak09IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4583;20:3c3otoZInGAx23D0SP3oSPXtykLdy/2pN9/MbO2FYMDa1MuPZGqpCxklr5OX8VN7q+ZUOAtDHCdMgYhhH3S96whIAUJ+KPKaNaigxfYrhdhByxhiZ7wCdFnQY3M2++V/GkN7NxZjvn/QS/mtHQ0BBR9aqRHPCNa9ivBAiZ0+Z9Kh5Vz8UAMdnDByNI3kYNkmnGiYM3UhCvK916I6E1j5sZ2btH73Bro/5B/Tr8hkb8La4XjBlHIcptgpdyCoBK2e
x-ms-office365-filtering-correlation-id: 703887ff-c301-4d04-2432-08d66bdece95
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4583;
x-ms-traffictypediagnostic: BYAPR07MB4583:
x-microsoft-antispam-prvs: <BYAPR07MB4583E5DEAA57FBEE9CB6EC00DDB60@BYAPR07MB4583.namprd07.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4583;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4583;
x-forefront-prvs: 0899B47777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(366004)(396003)(346002)(36092001)(199004)(189003)(486006)(93886005)(81166006)(102836004)(71200400001)(25786009)(9686003)(86362001)(478600001)(76176011)(7736002)(53936002)(305945005)(106356001)(39060400002)(8936002)(107886003)(81156014)(71190400001)(6506007)(6246003)(4326008)(8676002)(14444005)(1411001)(256004)(476003)(6916009)(446003)(11346002)(7696005)(2906002)(99286004)(26005)(14454004)(186003)(229853002)(3846002)(6116002)(55016002)(68736007)(316002)(97736004)(66066001)(105586002)(6436002)(33656002)(54906003)(74316002)(7416002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4583;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: br81gjVSOxTeBSZswnpR48PjVN1B3apQ2e/mLGFaG4AX/3qszZCv0DFc0nd6lY6LCUa4c7t3cAiKZDgNwi6OPMCb3/DaGqd/Z7wdeC4tunrLxl13U97/IRbLebc7yFgJ4eFODkOqIHSBUeZyxSzJt92opYaK7Ot1gRvqfxOgiXYv5BqlIb3rvdFcys69TtrSifub4eMDs86gLE3FJeQXraJvoM3A/ynoRWiQLCttAdWqF0B04pFFbtT0RjotK74jO9Tw+qmZXCZQcoIceAjqA0ByEfJBZEgvWGcv8DgoP1EHv8wUsI8SDlV+fERFRZzT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703887ff-c301-4d04-2432-08d66bdece95
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2018 09:36:41.0114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4583
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-27_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=843 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812270089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4+ID4gKw0KPj4gPiArICAgICAgIGlmIChyZXQpDQo+PiA+ICsgICAgICAgICAgICAg
ICByZXR1cm4gcmV0Ow0KPj4gPiArDQo+PiA+ICsgICAgICAgc3RhdGUgPSByZWFkbCgmY2Rucy0+
b3RnX3JlZ3MtPnN0cyk7DQo+PiA+ICsgICAgICAgaWYgKE9UR1NUU19PVEdfTlJEWShzdGF0ZSkg
IT0gMCkgew0KPj4gPiArICAgICAgICAgICAgICAgZGV2X2VycihjZG5zLT5kZXYsICJDYWRlbmNl
IFVTQjMgT1RHIGRldmljZSBub3QgcmVhZHlcbiIpOw0KPj4gPiArICAgICAgICAgICAgICAgcmV0
dXJuIC1FTk9ERVY7DQo+PiA+ICsgICAgICAgfQ0KPj4gPiArDQo+PiA+ICsgICAgICAgcmV0ID0g
Y2RuczNfZHJkX3VwZGF0ZV9tb2RlKGNkbnMpOw0KPj4gPiArDQo+Pg0KPj4gQ2FsbGluZyB0aGlz
IGZ1bmN0aW9uLCBpdCBpcyB0aW1lb3V0IGZvciB3YWl0aW5nIE9UR1NUU19YSENJX1JFQURZIGF0
IG90Z3N0cywNCj4+IGRvIHlvdSBrbm93IHBvc3NpYmxlIHJlYXNvbnM/ICBBZnRlciBjb21tZW50
aW5nIG91dCB0aGlzIGZ1bmN0aW9uLCBteQ0KPj4geEhDSSBmdW5jdGlvbg0KPj4gd29ya3MuDQo+
Pg0KPg0KPlBhd2VsLCBzaW5jZSBPVEcgY29tcGxpYW5jZSAoS25vd24gYXMgSE5QL1NSUCkgIGhh
cyBub3QgYmVlbiB1c2VkDQo+d2lkZWx5LCBMaW51eCBrZXJuZWwgZG9lcyBub3QNCj5tYWludGFp
biBpdCBmcm9tIHNvbWUgdGltZSBhZ28gKG1heWJlIDEtMiB5ZWFycykuIEluIHNvZnR3YXJlIGRl
c2lnbiwNCj53ZSBkbyBub3QgbmVlZCB0byBjb25zaWRlciBpdCBmcm9tDQo+aGFyZHdhcmUgcG9p
bnQsIGVnLCBraW5kcyBvZiBPVEcgdGltZXIuIEZvciBkdWFsLXJvbGUgc3dpdGNoIG9uIHRoZQ0K
PmZseSwgIHRocm91Z2ggL3N5cyBpcyBlbm91Z2guDQo+DQo+VGhyb3VnaCB0aGUgZGVidWcsIHdl
IGZpbmQgaXQgbmVlZHMgdG8gd2FpdCAxcyBhZnRlciBzZXR0aW5nIGRlLXNlbGVjdA0KPnRoZSBo
b3N0IG9yIGdhZGdldCBiZWZvcmUgcmVxdWVzdA0KPlhIQ0kgYXQgb3RnX3JlZ3MtPmNtZCwgYW5k
IGVuYWJsZSBmYXN0IHNpbXVsYXRlIGNhbiByZWR1Y2UgZGVsYXkgdG8NCj4yLTNtcy4gV291bGQg
eW91IHBsZWFzZSBoZWxwDQo+dG8gY2hlY2sgd2l0aCB5b3VyIGhhcmR3YXJlIHRlYW0gdGhpcyBi
ZWhhdmlvci4gV2l0aCBiZWxvdyBjaGFuZ2VzLCBJDQo+Y2FuIGdldCBPVEdTVFNfWEhDSV9SRUFE
WSBhdCBvdGdzdHMuDQo+DQo+QEAgLTE0MSw2ICsxNDMsNyBAQCBzdGF0aWMgaW50IGNkbnMzX2Ry
ZF9zd2l0Y2hfaG9zdChzdHJ1Y3QgY2RuczMgKmNkbnMsIGludCBvbikNCj4gICAgICAgICAgICAg
ICAgd3JpdGVsKE9UR0NNRF9IT1NUX0JVU19EUk9QIHwgT1RHQ01EX0RFVl9CVVNfRFJPUCB8DQo+
ICAgICAgICAgICAgICAgICAgICAgICBPVEdDTURfREVWX1BPV0VSX09GRiB8IE9UR0NNRF9IT1NU
X1BPV0VSX09GRiwNCj4gICAgICAgICAgICAgICAgICAgICAgICZjZG5zLT5vdGdfcmVncy0+Y21k
KTsNCj4rICAgICAgICAgICAgICAgdXNsZWVwX3JhbmdlKDMwMDAsIDQwMDApOw0KPiAgICAgICAg
fQ0KPg0KPiAgICAgICAgcmV0dXJuIDA7DQo+QEAgLTE3OCw2ICsxODEsNyBAQCBzdGF0aWMgaW50
IGNkbnMzX2RyZF9zd2l0Y2hfZ2FkZ2V0KHN0cnVjdCBjZG5zMw0KPipjZG5zLCBpbnQgb24pDQo+
ICAgICAgICAgICAgICAgIHdyaXRlbChPVEdDTURfSE9TVF9CVVNfRFJPUCB8IE9UR0NNRF9ERVZf
QlVTX0RST1AgfA0KPiAgICAgICAgICAgICAgICAgICAgICAgT1RHQ01EX0RFVl9QT1dFUl9PRkYg
fCBPVEdDTURfSE9TVF9QT1dFUl9PRkYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAmY2Rucy0+
b3RnX3JlZ3MtPmNtZCk7DQo+KyAgICAgICAgICAgICAgIHVzbGVlcF9yYW5nZSgzMDAwLCA0MDAw
KTsNCj4gICAgICAgIH0NCj4NCj5AQCAtMjk5LDYgKzMwNiw3IEBAIGludCBjZG5zM19kcmRfaW5p
dChzdHJ1Y3QgY2RuczMgKmNkbnMpDQo+ICAgICAgICAgICAgICAgIGNkbnMtPnZlcnNpb24gID0g
Q0ROUzNfQ09OVFJPTExFUl9WMDsNCj4gICAgICAgICAgICAgICAgY2Rucy0+b3RnX3YxX3JlZ3Mg
PSBOVUxMOw0KPiAgICAgICAgICAgICAgICBjZG5zLT5vdGdfcmVncyA9IHJlZ3M7DQo+KyAgICAg
ICAgICAgICAgIHdyaXRlbCgweDEsICZjZG5zLT5vdGdfdjBfcmVncy0+c2ltdWxhdGUpOw0KPiAg
ICAgICAgICAgICAgICBkZXZfaW5mbyhjZG5zLT5kZXYsICJEUkQgdmVyc2lvbiB2MCAoJTA4eClc
biIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJlYWRsKCZjZG5zLT5vdGdfdjBfcmVncy0+
dmVyc2lvbikpOw0KPiAgICAgICAgfSBlbHNlIHsNCg0KSSBoYXZlIGNvbmZpcm1hdGlvbiBmcm9t
IEhXIHRlYW0gdGhhdCB0aW1lIHRoYXQgZHJpdmVyIHNob3VsZCB3YWl0IGFmdGVyIGRlLXNlbGVj
dGluZyBtb2RlIA0KaXMgMi0zbXMgZm9yIHNpbXVsYXRlIG1vZGUuIEl0J3MgdGltZSB3aGVuIEZT
TSBpcyBpbiBEUkRfSF9XQUlUX1ZCVVNfRkFJTC4gDQpEcml2ZXIgY2Fubm90IHJlLWVuYWJsZSB0
aGUgaG9zdC9kZXZpY2UgbW9kZSBiZWZvcmUgdGhpcyB0aW1lIGhhcyBlbGFwc2VkLiANCg0KMyBt
cyBpcyB0aGUgbWF4aW11bSB0aW1lLiBBZGRpdGlvbmFsbHksIHlvdSBjYW4gY29uZmlybSB0aGUg
Y3VycmVudCBGU00gc3RhdGUgYnkgcmVhZGluZyB0aGUNCmhvc3Rfb3RnX3N0YXRlIChiaXQgNToz
KSBvciBkZXZfb3RnX3N0YXRlICgyOjApICBmcm9tIE9UR1NUQVRFIHJlZ2lzdGVyLiANCg0KSWYg
Yml0IDAgaW4gc2ltdWxhdGUgcmVnaXN0ZXIgaXMgY2xlYXJlZCB0aGUgdGltZSBpcyBleGFjdGx5
IDFzLg0KDQpDaGVlcnMsDQpQYXdlbA0KDQo=
