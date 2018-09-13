Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EFBC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B3320882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="EskcY5sK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B3320882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbeIMLvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 07:51:33 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:62993 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbeIMLvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 07:51:33 -0400
X-IronPort-AV: E=Sophos;i="5.53,368,1531810800"; 
   d="scan'208";a="17066808"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Sep 2018 23:43:27 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 12 Sep 2018 23:43:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pAMEFca2YgL4q1duY1aXBeRTJV/oNmYG+3VuJy5Ebg=;
 b=EskcY5sKCrmmqJhDgz1PU0/S9hdIB3K4aOy3kPJxsiwrXwiinbKr2sG3+HcES071LrxohtWo455qPrjRv7vLlpqH3WCkgYupd6PK9QiJ4/TMmDOQTcoblXAmhbKmE4W9QmGj8ZS8r8PcghbfAkB7QNpi9geivw6K0HBFvmHNY0E=
Received: from DM2PR11MB0105.namprd11.prod.outlook.com (10.160.26.155) by
 DM2PR11MB0206.namprd11.prod.outlook.com (10.160.132.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Thu, 13 Sep 2018 06:43:24 +0000
Received: from DM2PR11MB0105.namprd11.prod.outlook.com
 ([fe80::3438:f537:f7cc:363c]) by DM2PR11MB0105.namprd11.prod.outlook.com
 ([fe80::3438:f537:f7cc:363c%6]) with mapi id 15.20.1101.020; Thu, 13 Sep 2018
 06:43:22 +0000
From:   <Wesley.Sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <Kurt.Schwemmer@microchip.com>,
        <logang@deltatee.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] switchtec: Remove immediate status check after submit a MRPC
 command
Thread-Topic: [PATCH] switchtec: Remove immediate status check after submit a
 MRPC command
Thread-Index: AdRLK8VCX4N/ED4pQPmLZk4LCv9U4Q==
Date:   Thu, 13 Sep 2018 06:43:21 +0000
Message-ID: <DM2PR11MB0105EC547AFBB2DFA9D05A17951A0@DM2PR11MB0105.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Wesley.Sheng@microchip.com; 
x-originating-ip: [211.144.195.220]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR11MB0206;6:tx0VIQPNGNz3DFCszv/ukDIfYhrhZ3xIJwlrhhqQ2+ldAryPKHfqZOjbCRw1z52xT8/GLdIhPcGBB6te2PI9/UIUWiBZ8jUufttdx4sq7uNPhGb41H8JxdhKz01IdSZw4bpt+mcREmXoLiSYi44VGeWVAmf1KHRggCtaf/p8JS4JRm/dK2BZuCjlwc6bl37S/UF3mXyJ09J2XqFl4uusMi3Fw/CZ8nN3yusifAoDGJD0VM/yM+nro6T4kQSe5fzDUV7LeiAq2o+hsgy+vy0t9ckwlqf6E2tq9yBVbOSiE/OVkke3mGPwgasivJ2Ogkft76BlGhJWEgu63sV8EplblUgAWEVWZ4p/yb5bPZmsx535uwJLQ0cQOPdbuSExZWL3ledTnJiB7KlOD5naA2XcOdByFrCXNu+egEWaCKqedUtpTJrh2+SM2hlpXVKBlvtvukKQQoTveTp1ejBWH5cWog==;5:IsW63Qqip7p93wVNz94njdLviKpWqK3MiVrqsWnRk5tzkWh8JuoGKK+riscEdjXwmZwa6WqOdCZWS7AK2s2lCdYxkXZUNg36Rde68xkGm25TEvlaH985M/L7AMLD6jqVRssRWyrW9rrUThUaOgawjLROXaQ86ifg1vuQ2NFIapg=;7:Ns/WPQoF7EUq9Zpa6bbq3jA+SclFihSvd7nvDPgt+DEeLmNUO72DQ8rphAApnoZSrJ4wmp86sVp2Bic9FBgoWZIysrmM6m89qZnLclMMzs47qupvZy3QIDTtW/oRAGACnvUhrNJ8enaVBfgB7OVNgwgGAi1COoOpTBf8HSlAXsuDxh8dG6PZ/MqKUxGWPu5R7uo8aAGWbqU0Po3w65oPKGEVtpCgMWJQEIkS5B3O9Q7yk7dSKh2J5Ds3PnbOXZtv
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(136003)(396003)(199004)(189003)(486006)(2906002)(68736007)(8936002)(86362001)(316002)(5660300001)(81166006)(99286004)(5250100002)(8676002)(6116002)(2501003)(3846002)(54906003)(7696005)(81156014)(106356001)(33656002)(105586002)(186003)(110136005)(9686003)(25786009)(72206003)(2900100001)(478600001)(74316002)(66066001)(102836004)(476003)(55016002)(305945005)(14454004)(26005)(6436002)(97736004)(7736002)(4326008)(6506007)(14444005)(1857600001)(53936002)(256004)(14773001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR11MB0206;H:DM2PR11MB0105.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 44a6ea29-0927-4a3c-812d-08d6194432ca
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM2PR11MB0206;
x-ms-traffictypediagnostic: DM2PR11MB0206:
x-microsoft-antispam-prvs: <DM2PR11MB02066F7CA2D5952B9ED027B5951A0@DM2PR11MB0206.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:DM2PR11MB0206;BCL:0;PCL:0;RULEID:;SRVR:DM2PR11MB0206;
x-forefront-prvs: 07943272E1
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mVOIglzay+M93Ey9Vs3PBkEXn/EkEcJyDepsc0wfV027Kt2CGfz1dYwbEZOJHdPOjlxEsfmeVigrbwcXdpLZxNaXo7JQgGf4xIWmwb9kc7X7pz+2VHq0W/ZU83ZSKw+yv3n99gQRb/484dTSg83SCx3HB8k8ygfPI2LGUTWzTV+4wH5SxZLEz8066Nyeh24nP1qmzt8EtKxFQ3LDU14lIPmNfIUDBEFp71TZF2wP6f+wTIPNRyAFb141ivzfQbeL/+ixpExiTR4g+ZwVvkVSGyijw0JdmdGqwyHGFVYwzxLgereYTEfw4p/03UmuIdxC+GzgFxw0XnZGk8F7KxcaJmhfRupBiEMQ0YO4lPQseMU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a6ea29-0927-4a3c-812d-08d6194432ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2018 06:43:21.7804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR11MB0206
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogV2VzbGV5IFNoZW5nIDxXZXNsZXkuU2hlbmdAbWljcm9jaGlwLmNvbT4NCg0KQWZ0ZXIg
c3VibWl0IGEgRmlybXdhcmUgRG93bmxvYWQgKERvd25sb2FkIHN1Yi1jb21tYW5kKQ0KTVJQQyBj
b21tYW5kLCBzd2l0Y2h0ZWMgZmlybXdhcmUgcmVmdXNlcyB0byByZXNwb25zZQ0KYW55IG1hbmFn
ZW1lbnQgRVAncyBCQVIgYWNjZXNzIHVudGlsIGN1cnJlbnQgZmxhc2gNCnByb2dyYW1taW5nIGZp
bmlzaGVkLg0KDQpEdXJpbmcgdGhpcyB0aW1lLCBhIFJFQUQgVExQIHRvIHRoZSBnYXMgYXJlYSBp
biB0aGUgQkFSIG9mDQp0aGUgbWFuYWdlbWVudCBFUCB3aWxsIGNvbXBsZXRlIHdpdGggc2lnbmlm
aWNhbnQgZGVsYXkgbGlrZQ0KbW9yZSB0aGFuIDEwbXMuDQoNCkl0J3MgYSBzd2l0Y2h0ZWMgZmly
bXdhcmUgbGltaXRhdGlvbiB0aGF0IFJFQUQgcmVxdWVzdHMNCmNhbm5vdCBnZXQgcHJvbXB0IHNl
cnZpY2UgZHVyaW5nIGZpcm13YXJlIGRvd25sb2FkLg0KDQpUaGUgZGVsYXllZCBjb21wbGV0aW9u
IG9mIFJFQUQgVExQIHdvdWxkIGJlIGEgcHJvYmxlbSBvbg0Kc29tZSBzeXN0ZW0gd2hpY2ggaXMg
c2Vuc2l0aXZlIHRvIFJFQUQgdGltZW91dC4NCg0KQ3VycmVudCBkcml2ZXIgY2hlY2sgc3RhdHVz
IGltbWVkaWF0ZWx5IGFmdGVyIHN1Ym1pdCBhDQpNUlBDIGNvbW1hbmQsIHdoaWNoIHRyaWdnZXJz
IFJFQUQgVExQIHRvIHRoZSBnYXMgYXJlYSBpbg0KdGhlIEJBUiBvZiB0aGUgbWFuYWdlbWVudCBF
UC4gQWxzbywgb3RoZXIgcHJvY2Vzc2VzIG9yDQpmdW5jdGlvbnMsIGxpa2UgTlRCLCB3b3VsZCBh
bHNvIHRyaWdnZXIgUkVBRCBUTFAgYnkgYWNjZXNzaW5nDQp0aGUgR0FTLg0KDQpUbyBhdm9pZCB0
aGlzLCB0aGUgaW1tZWRpYXRlIGNoZWNrIG9mIHN0YXR1cyBpcyByZW1vdmVkDQppbiB0aGlzIHBh
dGNoLCBhbmQgZHJpdmVyIGRlbGF5cyB0aGUgc3RhdHVzIGNoZWNrIHRvIHRoZQ0Kb2NjdXJyZW5j
ZSBvZiBNU0l4IG9yIE1SUEMgdGltZW91dC4gSW4gdGhlIG1lYW53aGlsZSwgdXNlcg0KbXVzdCBu
b3QgaW5pdGlhdGUgYW55IGdhcyBhY2Nlc3MgZHVyaW5nIGEgZmlybXdhcmUgZG93bmxvYWQuDQoN
CkFsc28sIGFueSBwcm9jZXNzIHRoYXQgaXNzdWVzIE1SUEMgY29tbWFuZCB3aWxsIGJlIGFmZmVj
dGVkDQpieSB0aGUgZGVsYXkgaW4gdGhpcyBwYXRjaC4NCg0KSG93ZXZlciwgdGhpcyBpcyBvbmx5
IGEgc29mdHdhcmUgd29ya2Fyb3VuZCB0byB0aGUgUkVBRA0KaXNzdWUgaW4gZmlybXdhcmUgZG93
bmxvYWQuIEEgY29tcGxldGUgZml4IG9mIHRoaXMgc2hvdWxkDQpoYXBwZW4gaW4gZmlybXdhcmUu
DQoNCk5vdGU6IEZvciBOVEIgZnVuY3Rpb24sIHRoZSBtZW1vcnkgd2luZG93IGFjY2VzcyBpcyBo
YW5kbGVkDQpieSBzd2l0Y2h0ZWMgaGFyZHdhcmUuIFNvIGl0J3Mgbm90IGFmZmVjdGVkIGJ5IHRo
aXMgZmlybXdhcmUNCmxpbWl0YXRpb24uIEJ1dCB0aGUgR0FTIGFjY2Vzc2VzLCBsaWtlIGZvciBk
b29yYmVsbCByZWdpc3RlcnMsDQppbiB0aGUgTlRCIGZ1bmN0aW9uIGFyZSBhZmZlY3RlZCBieSB0
aGlzIGZpcm13YXJlIGxpbWl0YXRpb24uDQoNClNpZ25lZC1vZmYtYnk6IEtlbHZpbiBDYW8gPEtl
bHZpbi5DYW9AbWljcm9jaGlwLmNvbT4NCi0tLQ0KIGRyaXZlcnMvcGNpL3N3aXRjaC9zd2l0Y2h0
ZWMuYyB8IDQgLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvc3dpdGNoL3N3aXRjaHRlYy5jIGIvZHJpdmVycy9wY2kvc3dpdGNo
L3N3aXRjaHRlYy5jDQppbmRleCA0NTkxZjE1Li5iNzU5MjI4IDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9wY2kvc3dpdGNoL3N3aXRjaHRlYy5jDQorKysgYi9kcml2ZXJzL3BjaS9zd2l0Y2gvc3dpdGNo
dGVjLmMNCkBAIC0xNDIsMTAgKzE0Miw2IEBAIHN0YXRpYyB2b2lkIG1ycGNfY21kX3N1Ym1pdChz
dHJ1Y3Qgc3dpdGNodGVjX2RldiAqc3RkZXYpDQogCQkgICAgc3R1c2VyLT5kYXRhLCBzdHVzZXIt
PmRhdGFfbGVuKTsNCiAJaW93cml0ZTMyKHN0dXNlci0+Y21kLCAmc3RkZXYtPm1taW9fbXJwYy0+
Y21kKTsNCiANCi0Jc3R1c2VyLT5zdGF0dXMgPSBpb3JlYWQzMigmc3RkZXYtPm1taW9fbXJwYy0+
c3RhdHVzKTsNCi0JaWYgKHN0dXNlci0+c3RhdHVzICE9IFNXSVRDSFRFQ19NUlBDX1NUQVRVU19J
TlBST0dSRVNTKQ0KLQkJbXJwY19jb21wbGV0ZV9jbWQoc3RkZXYpOw0KLQ0KIAlzY2hlZHVsZV9k
ZWxheWVkX3dvcmsoJnN0ZGV2LT5tcnBjX3RpbWVvdXQsDQogCQkJICAgICAgbXNlY3NfdG9famlm
Zmllcyg1MDApKTsNCiB9DQotLSANCjIuNy40DQo=
