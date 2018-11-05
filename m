Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929C1ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7732082A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="g49aASfl";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Ssms6u7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7732082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbeKETEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:04:41 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:33932 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726186AbeKETEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:04:41 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA59bl65008001;
        Mon, 5 Nov 2018 01:44:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=7KIIQ3BDUBWwD9iGndUiHzaEt+kvwhA7Z0fsrKwmMYA=;
 b=g49aASflsNMTjx3TjNJIbSp3ENQVkxltI6jvx8IHVVyUMIEwtvwjy5jHVvXJuVZo5V0W
 z9EG2migvVwazXxu4dZYwifSoEH6ZF/gkHGabwj+gIt9VkCjVKyVsz3k1uYfM9V2T6cv
 j6gEdh2a1PA7bpUfrytTAwjDpZQ24yR6hsW+jwoNrTyQThTfnQ3cSQpmLCnX0vgEyAWS
 rCS4ETHvjmkoScQUtdb/sBnODig4PJGi9og/DNt4p6psFmFUMWb6NGEgb2G2F0lBWRg7
 4SrFA16cl7AW5i4mDeR27rli4qK3OjhK0C7pMLrTSxjg5uM55RrlQTLSo2M+Ttmv/jT6 jg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp0179.outbound.protection.outlook.com [216.32.180.179])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2nh87rr453-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 05 Nov 2018 01:44:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KIIQ3BDUBWwD9iGndUiHzaEt+kvwhA7Z0fsrKwmMYA=;
 b=Ssms6u7yikVZWzzfCVH3HLm69M2q1fkjWUCVwo4Yz2zLJR88t+72YoPADzqsqsWe3fuXPYLqrMY5qDY0pK2vfoGM9iZOQafJhJl8bWxvVy5vm+u5Psq5qcGXD5KJNCG+He4P7Zr3ZephSd5pC7dLx+n6W8106CSoSj+Wf164dG0=
Received: from CY1PR0701MB1664.namprd07.prod.outlook.com (10.163.20.22) by
 CY1PR0701MB2044.namprd07.prod.outlook.com (10.163.142.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 5 Nov 2018 09:44:54 +0000
Received: from CY1PR0701MB1664.namprd07.prod.outlook.com
 ([fe80::59a0:1638:ccd6:ad87]) by CY1PR0701MB1664.namprd07.prod.outlook.com
 ([fe80::59a0:1638:ccd6:ad87%2]) with mapi id 15.20.1294.028; Mon, 5 Nov 2018
 09:44:54 +0000
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Piotr Sroka <piotrs@cadence.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
CC:     Rafal Ciepiela <rafalc@cadence.com>,
        "quentin.schulz@bootlin.com" <quentin.schulz@bootlin.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        Damian Kos <dkos@cadence.com>
Subject: RE: [PATCH v6 0/6] drm: add support for Cadence MHDP DPI/DP bridge.
Thread-Topic: [PATCH v6 0/6] drm: add support for Cadence MHDP DPI/DP bridge.
Thread-Index: AQHUX0/e2PllWSvZiEqVG0HuQ+ejRqVBF/Bw
Date:   Mon, 5 Nov 2018 09:44:53 +0000
Message-ID: <CY1PR0701MB166434BBB71DB76593E0F513CDCA0@CY1PR0701MB1664.namprd07.prod.outlook.com>
References: <1539034953-11274-1-git-send-email-dkos@cadence.com>
In-Reply-To: <1539034953-11274-1-git-send-email-dkos@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZGtvc1xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTcyYjIzNDczLWUwZGYtMTFlOC04NzJkLWE0NGNjOGNjMTI3Y1xhbWUtdGVzdFw3MmIyMzQ3NS1lMGRmLTExZTgtODcyZC1hNDRjYzhjYzEyN2Nib2R5LnR4dCIgc3o9IjYyMTQiIHQ9IjEzMTg1ODg0Njk1MTYxNTk2OSIgaD0iRXpranRNNFZjczhNZ0JscXhrUEYxeWNxekxNPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0701MB2044;20:wcjaCEBXVntvxxgtPdQD3eSVA+Ny44mVVWT/9DZdeiWsXDZLjcw+DZzYkyna1CkHJtZTaELNLKCgU7wNuffAqieR83U0nf0zrjGitY+6/hJaWP8vSHWxLUbs84JXPc5/51oYZl1JMjAvmxFjeEdAD8Z8u7k6PWvcnKv2+JulRSG7m2slXFpJEzsPMSn6LlE27JJ94/Aoz5cYyQmrZ2fZ7mBvl2i1179z+dWhIyto1C0o/jBUBIR5Mtfr0Rw/yM7I
x-ms-office365-filtering-correlation-id: ec682f31-0055-4215-68d1-08d6430356d6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY1PR0701MB2044;
x-ms-traffictypediagnostic: CY1PR0701MB2044:
x-microsoft-antispam-prvs: <CY1PR0701MB2044F2239B4636F8A40E63B1CDCA0@CY1PR0701MB2044.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(217544274631240)(9452136761055)(258649278758335)(31051911155226)(72806322054110)(180628864354917)(7411616537696)(228905959029699)(58145275503218);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY1PR0701MB2044;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB2044;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(136003)(376002)(13464003)(36092001)(189003)(199004)(2900100001)(74316002)(5660300001)(6506007)(99286004)(14454004)(33656002)(53546011)(102836004)(26005)(186003)(486006)(7696005)(97736004)(2906002)(76176011)(478600001)(7416002)(68736007)(11346002)(446003)(9686003)(476003)(105586002)(106356001)(66066001)(107886003)(81166006)(256004)(8676002)(81156014)(14444005)(229853002)(66574009)(55016002)(71200400001)(2201001)(4326008)(53936002)(71190400001)(86362001)(8936002)(305945005)(3846002)(6436002)(6246003)(25786009)(6116002)(110136005)(54906003)(2501003)(316002)(7736002)(21314003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB2044;H:CY1PR0701MB1664.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3XC2gm6T73IRLnV/VSAbtuYiPb4T1zRnhgJ/ZSojsqmOc+HwzDGmc0I4gIjXqB3aP9vOSb/9+XbgG7g7Rs1CVkN7GMBK19LIev30ynUIKcxO1hN1xYpgHhvs/QdfKS5r0KrQwhHRQhfqwZPf6vHoWG3UyWRSapoKZwuRrXxwQaMnrI7qfcjIaYKznnAgNM8hsQTFwE6bxj6mxp2nwjZFzUPYPgVAG5G1aOIMNvZTdFEOzlwpevgHuh85mXSM9CtuYsP6x9iJYVPv93hE74U8DWAzqTBlWR3SRBtGW57vMyAy3GvcHNyAseTvdpCZHrDBvGwP2OP7OfcxTWMUihH5uzopkyhIfWgi1MjrKOcqETc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec682f31-0055-4215-68d1-08d6430356d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 09:44:53.8527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB2044
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811050090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3V5cywNCg0KSSdtIHdvbmRlcmluZyBpZiB0aGlzIHRpbWUgcGF0Y2ggaXMgc28gZ29vZCB0
aGF0IHRoZXJlJ3JlIG5vIGNoYW5nZSByZXF1ZXN0cywgb3IgaXMgaXQgc28gYmFkIHRoYXQgaXQg
d2FzIHJlamVjdGVkIHdpdGhvdXQgYSBjb21tZW50IDogKQ0KUGxlYXNlIGxldCBtZSBrbm93IGlm
IHRoaXMgcGF0Y2ggaXMgYmVpbmcgaW4gcmV2aWV3IG9yIHdhcyByZWplY3RlZCBhbmQsIGlmIHNv
LCB3aGF0IG5lZWRzIHRvIGJlIGNoYW5nZWQuDQoNClJlZ2FyZHMsDQpEYW1pYW4NCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IERhbWlhbiBLb3MgPGRrb3NAY2FkZW5jZS5jb20+
IA0KU2VudDogTW9uZGF5LCBPY3RvYmVyIDgsIDIwMTggMjM6NDINClRvOiBEYXZpZCBBaXJsaWUg
PGFpcmxpZWRAbGludXguaWU+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgTWFy
ayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IEFyY2hpdCBUYW5lamEgPGFyY2hpdHRA
Y29kZWF1cm9yYS5vcmc+OyBBbmRyemVqIEhhamRhIDxhLmhhamRhQHNhbXN1bmcuY29tPjsgTGF1
cmVudCBQaW5jaGFydCA8TGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tPjsgR3VzdGF2
byBQYWRvdmFuIDxndXN0YXZvQHBhZG92YW4ub3JnPjsgTWFhcnRlbiBMYW5raG9yc3QgPG1hYXJ0
ZW4ubGFua2hvcnN0QGxpbnV4LmludGVsLmNvbT47IFNlYW4gUGF1bCA8c2VhbkBwb29ybHkucnVu
PjsgU2FuZHkgSHVhbmcgPGhqY0Byb2NrLWNoaXBzLmNvbT47IEhlaWtvIFN0w7xibmVyIDxoZWlr
b0BzbnRlY2guZGU+OyBRdWVudGluIFNjaHVseiA8cXVlbnRpbi5zY2h1bHpAZnJlZS1lbGVjdHJv
bnMuY29tPjsgRGFtaWFuIEtvcyA8ZGtvc0BjYWRlbmNlLmNvbT47IFBpb3RyIFNyb2thIDxwaW90
cnNAY2FkZW5jZS5jb20+OyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1yb2NrY2hpcEBsaXN0cy5pbmZy
YWRlYWQub3JnDQpDYzogUmFmYWwgQ2llcGllbGEgPHJhZmFsY0BjYWRlbmNlLmNvbT47IHF1ZW50
aW4uc2NodWx6QGJvb3RsaW4uY29tOyBqYmVyZ3NhZ2VsQHRpLmNvbQ0KU3ViamVjdDogW1BBVENI
IHY2IDAvNl0gZHJtOiBhZGQgc3VwcG9ydCBmb3IgQ2FkZW5jZSBNSERQIERQSS9EUCBicmlkZ2Uu
DQoNCkhlbGxvIQ0KDQpUaGlzIGlzIHRoZSBzZXJpZXMgb2YgcGF0Y2hlcyB0aGF0IHdpbGwgYWRk
IHN1cHBvcnQgZm9yIHRoZSBDYWRlbmNlJ3MgRFBJL0RQIGJyaWRnZS4gUGxlYXNlIG5vdGUgdGhh
dCB0aGlzIGlzIGEgcHJlbGltaW5hcnkgdmVyc2lvbiBvZiB0aGUgZHJpdmVyIGFuZCB0aGVyZSB3
aWxsIGJlIG1vcmUgcGF0Y2hlcyBpbiB0aGUgZnV0dXJlIHdpdGggdXBkYXRlcywgZml4ZXMgYW5k
IGltcHJvdmVtZW50cy4NClBsZWFzZSBrZWVwIHRoYXQgaW4gbWluZCB3aGVuIGxvb2tpbmcgYXQg
RklYTUUvVE9ETy9YWFggY29tbWVudHMuDQoNCkluaXRpYWxseSwgTUhEUCBkcml2ZXIgd2FzIGRl
dmVsb3BlZCBhcyBhIERSTSBicmlkZ2UgZHJpdmVyIGFuZCB3YXMgcGxhbmVkIHRvIGJlIHBsYWNl
ZCBpbiBkcml2ZXJzL2dwdS9kcm0vYnJpZGdlL21oZHAuYy4gIEhvd2V2ZXIsIHRoZXJlIHdhcyBh
bHJlYWR5IGEgZHJpdmVyIGZvciBDYWRlbmNlJ3MgRFAgY29udHJvbGxlciBkZXZlbG9wZWQgYnkg
Um9ja0NoaXAsIGJ1dCB0aGF0IGRyaXZlciB1c2VzIHRoZSBkaWZmZXJlbnQgRFJNIGZyYW1ld29y
ayBhbmQgbG9va3MgbGlrZSBhIHBhcnQgb2YgYSBiaWdnZXIgc3lzdGVtLg0KQm90aCBjb250cm9s
bGVycyAoaW5jbHVkaW5nIGZpcm13YXJlKSBhcmUgcXVpdGUgZGlmZmVyZW50IGludGVybmFsbHkg
KE1TVC9GRUMvRFNDIHN1cHBvcnQsIGxpbmsgdHJhaW5pbmcgZG9uZSBieSBkcml2ZXIsIGFkZGl0
aW9uYWwgY29tbWFuZHMsIElSUSdzDQpldGMuKSBidXQgdGhleSBoYXZlIHNpbWlsYXIgcmVnaXN0
ZXIgbWFwLCBleGNlcHQgZm9yIEZyYW1lci9TdHJlYW1lciAod2hpY2ggaXMgbm90aWNlYWJseSBk
aWZmZXJlbnQpLCBzbyB0aGV5IGFwcGVhciBzaW1pbGFyLg0KDQpUaGUgZm9sbG93aW5nIHBhdGNo
ZXMgY29udGFpbjoNCi0gTW92aW5nIGNvbW1vbiBjb2RlIHRvIGRyaXZlcnMvZ3B1L2RybS9icmlk
Z2UvY2Rucy1taGRwLWNvbW1vbi4qIGFuZA0KICBtb2RpZnlpbmcgaXQgYSBiaXQgKG1vc3RseSBu
ZXcgcHJlZml4ZXMgZm9yIGZ1bmN0aW9ucyBhbmQgZGF0YSB0eXBlcykgc28gaXQNCiAgY2FuIGJl
IHVzZWQgYnkgdHdvLCBoaWdoZXIgbGV2ZWwsIGRyaXZlcnMuDQotIE1vZGlmeWluZyBleGlzdGlu
ZyBSb2NrQ2hpcCdzIERQIGRyaXZlciB0byB1c2UgdGhlIGNvbW1vbiBjb2RlIGFmdGVyIGNoYW5n
ZXMNCiAgbWFkZSB0byBpdCAodXNlIHRoZSBuZXcgY2Ruc19taGRwX2RldmljZSBzdHJ1Y3R1cmUg
YW5kIG5ldyBmdW5jdGlvbiBuYW1lcykuDQotIE1vZGlmeWluZyBEUk0gaGVscGVycyBhIGJpdC4g
U29tZSBhcmUgcmVxdWlyZWQgZm9yIG5ldyBkcml2ZXIsIHNvbWUgYXJlDQogIHVwZGF0ZXMgZnJv
bSBEUCAxLjIgdG8gMS4zIG9yIDEuNC4NCi0gQWRkaW5nIGRvY3VtZW50YXRpb24gZm9yIGRldmlj
ZSB0cmVlIGJpbmRpbmdzLg0KLSBBZGRpbmcgcHJlbGltaW5hcnkgQ2FkZW5jZSBEUEkvRFAgYnJp
ZGdlIGRyaXZlci4NCg0KU29tZSBvZiB0aGUgdGhpbmdzIHRoYXQgd2lsbCBiZSBhZGRlZCBsYXRl
ciBvbiBpbmNsdWRlIChidXQgYXJlIG5vdCBsaW1pdGVkDQp0byk6DQotIERTQyBzdXBwb3J0DQot
IEZFQyBzdXBwb3J0DQotIEhEQ1Agc3VwcG9ydA0KDQpDaGFuZ2VzIGluIHYyOg0KLSBBZGRlZCBh
Y3R1YWwgZGVzY3JpcHRpb24gb2Ygd2hhdCB0aGUgcGF0Y2ggY29udGFpbnMsIHdoYXQgaXMgaXQg
Zm9yIGFuZA0KICB3aGF0J3MgZ29pbmcgb24gaGVyZSBpbiBnZW5lcmFsLg0KLSBOZXcgc3RydWN0
dXJlLiBOb3cgd2UgaGF2ZSBvbmUgY29tbW9uIGxvdyBsZXZlbCBkcml2ZXIgKyB0d28gaGlnaCBs
ZXZlbA0KICBkcml2ZXJzIC0gb25lIGZvciBSb2NrQ2hpcCB3aXRoIG1pbmltdW0gY2hhbmdlcyBh
bmQgb25lLCBtb3JlIGdlbmVyYWwsIGZvcg0KICBDYWRlbmNlLg0KLSBEcm9wcGVkIHNvbWUgY2hh
bmdlcyBtYWRlIHRvIERSTSBoZWxwZXJzLg0KLSBVcGRhdGVkIHRoZSBkZXZpY2UgdHJlZSBiaW5k
aW5ncyBkb2N1bWVudC4NCg0KQ2hhbmdlcyBpbiB2MzoNCi0gQ29ycmVjdGVkIGR0LWJpbmRpbmdz
IGRvY3VtZW50DQotIEVuYWJsZWQgc29tZSBjbG9ja3MgYXQgc3RhcnR1cCAoc2luY2UgRlcgZG9l
c24ndCBkbyB0aGF0IGFueW1vcmUpLg0KLSBDaGFuZ2VkIEZpcm13YXJlIGZpbGUgbmFtZSB0byBt
YXRjaCB0aGUgZmlsZSBvbiBMaW51eCBGaXJtd2FyZSByZXBvLg0KLSBBZGRlZCBTU1QgYXVkaW8g
c3VwcG9ydA0KLSBNYWRlIGNvbW1vbiBmdW5jdGlvbnMgKGluIGNkbnMtbWhkcC1jb21tb24uKikg
cHVibGljLg0KDQpDaGFuZ2VzIGluIHY0Og0KLSBGaXhlZCBLY29uZmlnIGluIGRybS9yb2NrY2hp
cA0KLSBGaXhlZCBTaWduZWQtb2Zmcw0KLSBkcF9saW5rX3N0YXR1cygpIGlzIG5vIGxvbmdlciBw
dWJsaWMgc2luY2UgaXQncyB1c2VkIG9ubHkgaW4gZHJtX2RwX2hlbHBlci5jDQotIFJlcGxhY2Vk
IEVYVFJBX0NGTEFHUyB3aXRoIGNjZmxhZ3MteSBpbiBkcm0vcm9ja2NoaXAgTWFrZWZpbGUNCg0K
Q2hhbmdlcyBpbiB2NToNCi0gRml4ZWQgS2NvbmZpZyBpbiBkcm0vcm9ja2NoaXAgYWdhaW4NCi0g
TW92ZWQgY2RuLWRwLXJlZy5oIChjZG5zLW1oZHAtY29tbW9uLmgpIHRvIGluY2x1ZGUvZHJtL2Jy
aWRnZSBpbnN0ZWFkIG9mDQogICAgZHJpdmVycy9ncHUvZHJtL2JyaWRnZS8NCi0gVXBkYXRlZCB0
aGUgbWhkcF92YWxpZGF0ZV9jciBmdW5jdGlvbg0KDQpDaGFuZ2VzIGluIHY2Og0KLSBBZGRlZCBS
ZXZpZXdlZC1ieXMgZm9yIGFscmVhZHkgcmV2aWV3ZWQgcGF0Y2hlcw0KLSBEcm9wcGVkIHBhdGNo
IHY1LTAwMDMgKHRoYXQgbWFkZSBkcF9nZXRfbGFuZV9zdGF0dXMgaGVscGVyIHB1YmxpYykNCi0g
QWRkZWQgcGF0Y2ggd2l0aCBNU1Qgc3VwcG9ydA0KLSBBZGRlZCBwYXRjaCB3aXRoIENhZGVuY2Ug
U0QwODAxIFBIWSBpbml0DQoNCg0KRGFtaWFuIEtvcyAoMik6DQogIGRybS9yb2NrY2hpcDogcHJl
cGFyZSBjb21tb24gY29kZSBmb3IgY2RucyBhbmQgcmsgZHBpL2RwIGRyaXZlcg0KICBkcm0vYnJp
ZGdlOiBhZGQgUEhZIGluaXRpYWxpemF0aW9uIGluIG1oZHA4NTQ2IGRyaXZlci4NCg0KUGlvdHIg
U3Jva2EgKDEpOg0KICBkcm0vYnJpZGdlOiBhZGQgc3VwcG9ydCBmb3IgTVNUIGluIG1oZHA4NTQ2
IGRyaXZlcg0KDQpRdWVudGluIFNjaHVseiAoMyk6DQogIGRybS9kcDogZml4IGxpbmsgcHJvYmlu
ZyBmb3IgZGV2aWNlcyBzdXBwb3J0aW5nIERQIDEuNCsNCiAgZHQtYmluZGluZ3M6IGRybS9icmlk
Z2U6IERvY3VtZW50IENhZGVuY2UgTUhEUCBicmlkZ2UgYmluZGluZ3MNCiAgZHJtOiBicmlkZ2U6
IGFkZCBzdXBwb3J0IGZvciBDYWRlbmNlIE1IRFAgRFBJL0RQIGJyaWRnZQ0KDQogLi4uL2JpbmRp
bmdzL2Rpc3BsYXkvYnJpZGdlL2NkbnMsbWhkcC50eHQgICAgIHwgICA0MyArDQogZHJpdmVycy9n
cHUvZHJtL2JyaWRnZS9LY29uZmlnICAgICAgICAgICAgICAgIHwgICAgOSArDQogZHJpdmVycy9n
cHUvZHJtL2JyaWRnZS9NYWtlZmlsZSAgICAgICAgICAgICAgIHwgICAgMyArDQogZHJpdmVycy9n
cHUvZHJtL2JyaWRnZS9jZG5zLW1oZHAtY29tbW9uLmMgICAgIHwgMTEwNyArKysrKysrKysrKysr
DQogZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9jZG5zLW1oZHAtbXN0LmMgICAgICAgIHwgIDU5NCAr
KysrKysrDQogZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9jZG5zLW1oZHAuYyAgICAgICAgICAgIHwg
MTM3MSArKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvZ3B1L2RybS9icmlkZ2UvY2Rucy1taGRw
LmggICAgICAgICAgICB8ICAyMDkgKysrDQogZHJpdmVycy9ncHUvZHJtL2RybV9kcF9oZWxwZXIu
YyAgICAgICAgICAgICAgIHwgICAzMCArLQ0KIGRyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9LY29u
ZmlnICAgICAgICAgICAgICB8ICAgIDQgKy0NCiBkcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvTWFr
ZWZpbGUgICAgICAgICAgICAgfCAgICAyICstDQogZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL2Nk
bi1kcC1jb3JlLmMgICAgICAgIHwgIDIzNCArLS0NCiBkcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAv
Y2RuLWRwLWNvcmUuaCAgICAgICAgfCAgIDQzICstDQogZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlw
L2Nkbi1kcC1yZWcuYyAgICAgICAgIHwgIDk2OSAtLS0tLS0tLS0tLS0NCiBpbmNsdWRlL2RybS9i
cmlkZ2UvY2Rucy1taGRwLWNicy5oICAgICAgICAgICAgfCAgIDI3ICsNCiAuLi4vZHJtL2JyaWRn
ZS9jZG5zLW1oZHAtY29tbW9uLmggICAgICAgICAgICAgfCAgMTc0ICsrLQ0KIDE1IGZpbGVzIGNo
YW5nZWQsIDM2NjkgaW5zZXJ0aW9ucygrKSwgMTE1MCBkZWxldGlvbnMoLSkgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9icmlkZ2Uv
Y2RucyxtaGRwLnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYnJpZGdl
L2NkbnMtbWhkcC1jb21tb24uYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0v
YnJpZGdlL2NkbnMtbWhkcC1tc3QuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9k
cm0vYnJpZGdlL2NkbnMtbWhkcC5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2Ry
bS9icmlkZ2UvY2Rucy1taGRwLmgNCiBkZWxldGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJt
L3JvY2tjaGlwL2Nkbi1kcC1yZWcuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2RybS9i
cmlkZ2UvY2Rucy1taGRwLWNicy5oDQogcmVuYW1lIGRyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9j
ZG4tZHAtcmVnLmggPT4gaW5jbHVkZS9kcm0vYnJpZGdlL2NkbnMtbWhkcC1jb21tb24uaCAoNzcl
KQ0KDQotLQ0KMi4xNy4xDQoNCg==
