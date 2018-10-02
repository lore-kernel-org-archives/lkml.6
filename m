Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D25C65BA7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54458206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperecomputing.com header.i=@amperecomputing.com header.b="WTkrElLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54458206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amperecomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeJCGcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 02:32:42 -0400
Received: from mail-eopbgr700136.outbound.protection.outlook.com ([40.107.70.136]:61953
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725976AbeJCGcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 02:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amperecomputing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YENjHTEtxR+i++IdWKao3N//K7rJDwu6vSsF3866yb0=;
 b=WTkrElLJvdZi7Va+IJDzMqX2eoyYNjnFu4wv1g8/EZDPJS8OPMX14NZX9lh2MCP3voThIhX6UkxGvddrcI+kw6UhhOoe2qErIujOoDSCn8c2HbHQgXyw0x0qUlYcQRTHwku2CG1CFs1vjn8w84Uw2+rpu/n+SwidF6Kz6/hq8ms=
Received: from SN1PR0101MB1567.prod.exchangelabs.com (10.163.128.25) by
 SN1PR0101MB1566.prod.exchangelabs.com (10.163.128.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Tue, 2 Oct 2018 23:46:47 +0000
Received: from SN1PR0101MB1567.prod.exchangelabs.com
 ([fe80::ec7f:209a:3446:f7fc]) by SN1PR0101MB1567.prod.exchangelabs.com
 ([fe80::ec7f:209a:3446:f7fc%2]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 23:46:45 +0000
From:   Hoan Tran <hoan.tran@amperecomputing.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Will Deacon <will.deacon@arm.com>,
        Tai Nguyen <ttnguyen@amperecomputing.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Open Source Submission <patches@amperecomputing.com>
Subject: Re: [PATCH v2] perf: xgene: Add CPU hotplug support
Thread-Topic: [PATCH v2] perf: xgene: Add CPU hotplug support
Thread-Index: AQHUUEjL6iCB7dX6uku+nmQs71SmF6UL6oiAgADJPQA=
Date:   Tue, 2 Oct 2018 23:46:45 +0000
Message-ID: <5B51DDE7-B248-474D-8787-8127E73D82B1@amperecomputing.com>
References: <1537382649-17266-1-git-send-email-hoan.tran@amperecomputing.com>
 <20181002114627.omsungd77lfmbqfj@lakrids.cambridge.arm.com>
In-Reply-To: <20181002114627.omsungd77lfmbqfj@lakrids.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hoan.tran@amperecomputing.com; 
x-originating-ip: [4.28.13.142]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR0101MB1566;6:2afvdIDXQnbZ3DehZthup79DZlUH0BqHgFHIPTEOdBeCm94uO4vN7vhkGhMXnIPOdz1j62k733S1e6QOTy9djMUhIIM6K9tlsstXV2lsjW0JXseyKb4ASTsHBufQVZjw46oQKoAnPCXJF2DDtQ4Ornx/Bp6iY8vajb+SlDoYOD7R/Lzw2gT5xvap09cy4lvdp1okMRdf7qATc4dCJjkFOR8h+lw+1mzn1DR+QkN9Pdl+I5F7Tu6IVRCU6bRl4N7RCUN9XnjhuB+wAeiH3ecpiGNWwgh61j46pOzQD6Mu6L62ySUs0hIrU2t3lqylxlbAItXeSfYG71g4TbOk08mkjXDkjfgicG2rmWUKbEmjcop8EJDT8FYf+FQwwQBD1NitfBgZg9JRratNCuXmexwljUxJ5qq9iBvIpISlnvu+v0Ytq06XWPCG6PvD+pY533va6OXNykMPjbaRjwyU3M1Igw==;5:cwl7B5Lo8mg6Higr+z0NQOGOrazk7YDk0mbrMKi7FHcDoRMqtW8xng2kvPaxoHPWxu0wOdB0SIa/1vayr3pF/kRa2Aoc6dg54oYdoxOY/O1bBYNjzm3m83lRkOpxNS+9viKYBOdkqF+Vsfw7aQ8LwaEBsgNxdu+NCBG0PgKmbO4=;7:hw4nUJxGhuPTXcctWXVboJSp6wdt8j/bMEXD5wbPElCuplNEENSrZB7JJjMCL0EBtOIrXh3doZ/cL0Iq/SNrVMALpgbuJJWoFufcVMjz6y6TpSGk9g4OoT3FMN3Gk6tCV2wgR7qgguUVZwdEs//eDT/iIRt/DWpbkhLMG9ylB8+IpXLjTN0EHFlOp1Ggtsl4IbdNzW3ho6yHEEUE7HbGFRDaiIZ12IolJHt3s6DAhFr3eUeaUonjD12+Hc5sk7/R
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(346002)(366004)(39840400004)(136003)(396003)(376002)(189003)(199004)(5660300001)(107886003)(3846002)(6916009)(6116002)(97736004)(6246003)(256004)(14444005)(5250100002)(33656002)(36756003)(106356001)(105586002)(2906002)(486006)(44832011)(2900100001)(11346002)(446003)(2616005)(229853002)(14454004)(476003)(86362001)(478600001)(82746002)(53936002)(6486002)(316002)(186003)(102836004)(6436002)(26005)(6512007)(71200400001)(8676002)(99286004)(81156014)(81166006)(305945005)(8936002)(76176011)(68736007)(83716004)(25786009)(6506007)(4326008)(53546011)(71190400001)(7736002)(66066001)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR0101MB1566;H:SN1PR0101MB1567.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 82352734-25f9-45b0-12c0-08d628c14fdb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR0101MB1566;
x-ms-traffictypediagnostic: SN1PR0101MB1566:
x-microsoft-antispam-prvs: <SN1PR0101MB1566EA0A644C004948531564E4E80@SN1PR0101MB1566.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(209352067349851)(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991048);SRVR:SN1PR0101MB1566;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0101MB1566;
x-forefront-prvs: 0813C68E65
received-spf: None (protection.outlook.com: amperecomputing.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: 1DR9TQNpz7gMt98r/bXRAOHMDjZ5IAv+u4cdWDU3qc+vLDTHkKFDHSjeHNkSqNi/qcL/Nv15miZz2kEM8RY34tGOnJ9VX/sF3Q5SrWIjQvLd4ru/7MNcArkx+p3pkjWIFhiKjaysOaPokqlT9f0XpZQ0FaX33MDGO1GY+aCvydStJb+73TFmAXyXtqGyZpunaSPEmJZIQ2O4/DAgqziYdseY9TKnC3heB6cfp2AuQEbt8RG40LtukjX6XMqHUexxSmkQLtJEezLGsZocHEvUBCQfdGoxpUInS/casaDxVInO7UUncrPtTv0EGa8eTH+/3k9DlsATL6UQdmFLl6824wPHPDX8HB9I23L47/PGimU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D5C8ACD75BF364DA579FCF8C236EBBF@prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82352734-25f9-45b0-12c0-08d628c14fdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 23:46:45.0872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0101MB1566
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaywNCg0KPiBPbiBPY3QgMiwgMjAxOCwgYXQgNDo0NiBBTSwgTWFyayBSdXRsYW5kIDxt
YXJrLnJ1dGxhbmRAYXJtLmNvbT4gd3JvdGU6DQo+IA0KPiBbTk9USUNFOiBUaGlzIGVtYWlsIG9y
aWdpbmF0ZWQgZnJvbSBhbiBleHRlcm5hbCBzZW5kZXIuIFBsZWFzZSBiZSBtaW5kZnVsIG9mIHNh
ZmUgZW1haWwgaGFuZGxpbmcgYW5kIHByb3ByaWV0YXJ5IGluZm9ybWF0aW9uIHByb3RlY3Rpb24g
cHJhY3RpY2VzLl0gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQo+IA0KPiBIaSBIb2FuLA0KPiANCj4gT24gV2VkLCBTZXAgMTks
IDIwMTggYXQgMDY6NDQ6MzBQTSArMDAwMCwgSG9hbiBUcmFuIHdyb3RlOg0KPj4gVGhpcyBwYXRj
aCBhZGRzIENQVSBob3RwbHVnIHN1cHBvcnQgd2hlcmUgdGhlIFBNVSBtaWdyYXRlcyB0aGUgY29u
dGV4dCB0bw0KPj4gYW5vdGhlciBvbmxpbmUgQ1BVIHdoZW4gaXRzIENQVSBpcyBvZmZsaW5lLg0K
Pj4gDQo+PiBJdCBmaXhlcyB0aGUgYmVsb3cgaXNzdWUgd2hlcmUgdGhlIHVzZXIgZG9lcyBvZmZs
aW5lIHRoZSBDUFUgd2hpY2ggaXMgYXNzaWduZWQNCj4+IHRvIHRoaXMgUE1VLg0KPj4gDQo+PiBB
c3N1bWluZywgQ1BVMCBpcyBhc3NpZ25lZCBmb3IgdGhpcyBQTVUuIFdoZW4gdGhlIHVzZXIgZG9l
cyBvZmZsaW5lIENQVTANCj4+IFtyb290QChub25lKSB+XSMgZWNobyAwID4gL3N5cy9kZXZpY2Vz
L3N5c3RlbS9jcHUvY3B1MC9vbmxpbmUNCj4+IFRoaXMgUE1VIGRvZXMgbm90IHdvcmsgYW55bW9y
ZSBhbmQgc2hvd3MgdGhlIGJlbG93IGVycm9yLg0KPj4gW3Jvb3RAKG5vbmUpIH5dIyBwZXJmIHN0
YXQgLWEgLWUgbDNjMC9jeWNsZS1jb3VudC8sbDNjMC93cml0ZS8gc2xlZXAgMQ0KPj4gRXJyb3I6
DQo+PiBUaGUgc3lzX3BlcmZfZXZlbnRfb3BlbigpIHN5c2NhbGwgcmV0dXJuZWQgd2l0aCAxOSAo
Tm8gc3VjaCBkZXZpY2UpIGZvciBldmVudCAobDNjMC9jeWNsZS1jb3VudC8pLg0KPj4gL2Jpbi9k
bWVzZyBtYXkgcHJvdmlkZSBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KPj4gTm8gQ09ORklHX1BF
UkZfRVZFTlRTPXkga2VybmVsIHN1cHBvcnQgY29uZmlndXJlZD8NCj4+IA0KPj4gV2l0aCB0aGlz
IHBhdGNoLCB3aGVuIENQVTAgaXMgb2ZmbGluZSwgUE1VIG1pZ3JhdGVzIHRvIGFub3RoZXIgb25s
aW5lIENQVSBhbmQNCj4+IHdvcmtzIG9uIHRoYXQgQ1BVLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5
OiBIb2FuIFRyYW4gPGhvYW4udHJhbkBhbXBlcmVjb21wdXRpbmcuY29tPg0KPj4gLS0tDQo+PiB2
MjoNCj4+ICogUmVtb3ZlIHRoZSBjcHVocCBpbnN0YW5jZSB3aGVuIHVucmVnaXN0ZXJpbmcgdGhl
IFBNVQ0KPiANCj4gVW5mb3J0dW5hdGVseSwgdGhpcyBoYXMgY29tZSB0aHJvdWdoIHdoaXRlc3Bh
ZS1kYW1hZ2VkLCB3aXRoIGENCj4gZGlzY2xhaW1lciBpbiB0aGUgZm9vdGVyLg0KPiANCj4gQ291
bGQgeW91IHBsZWFzZSByZXNlbmQgd2l0aCB0aG9zZSB0d28gZGV0YWlscyBmaXhlZD8NCg0KSeKA
mWxsIGZpeCBpdCBhbmQgc2VuZCB5b3UgYW5vdGhlciB2ZXJzaW9uIGxhdGVyLg0KDQpUaGFua3Mg
YW5kIFJlZ2FyZHMNCkhvYW4NCg0KPiANCj4gVGhhbmtzLA0KPiBNYXJrLg0KDQo=
