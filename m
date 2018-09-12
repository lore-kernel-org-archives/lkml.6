Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0C7C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E72E20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Zc4nmD8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E72E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeILWxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:53:12 -0400
Received: from mail-dm3nam03on0103.outbound.protection.outlook.com ([104.47.41.103]:31331
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727417AbeILWxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiBehmwPyi27BO4zlLbLMLS0MoVsSaTRzoTWuCE4RBQ=;
 b=Zc4nmD8MDyTdF0byI1T62aeZf8iXCwoqOObg98FrDoKfwdgmDQmhzDfAh+d7UkK6rIK01Xho9HYUZoH0uqfmomMrbm5f7bGG5DsUf40VJlZzwvKMODlzKFp+5AyBJnRHXCMcT055CkJIFSDv6zmbxdbrUx+ssP4zEhuecRlC+4Y=
Received: from MWHPR21MB0510.namprd21.prod.outlook.com (10.172.95.140) by
 MWHPR21MB0638.namprd21.prod.outlook.com (10.175.141.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Wed, 12 Sep 2018 17:46:53 +0000
Received: from MWHPR21MB0510.namprd21.prod.outlook.com
 ([fe80::a9a4:7c1a:2713:ad83]) by MWHPR21MB0510.namprd21.prod.outlook.com
 ([fe80::a9a4:7c1a:2713:ad83%7]) with mapi id 15.20.1143.010; Wed, 12 Sep 2018
 17:46:53 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
CC:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 3/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
Thread-Topic: [PATCH 3/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
Thread-Index: AQHUSWAslrWv/zH2WkS0OitWO4yfnaTsrtUAgAAebwCAABFtAIAAD6yA
Date:   Wed, 12 Sep 2018 17:46:53 +0000
Message-ID: <fac5a6f4-3dda-2ec4-81ec-4a4a7ad2a571@microsoft.com>
References: <20180910232615.4068.29155.stgit@localhost.localdomain>
 <20180910234354.4068.65260.stgit@localhost.localdomain>
 <7b96298e-9590-befd-0670-ed0c9fcf53d5@microsoft.com>
 <CAKgT0UdKZVUPBk=rg5kfUuFBpuZQEKPuGw31x5O2nMyuULgi0g@mail.gmail.com>
 <CAPcyv4gEDwp8Xh4_E8RNBC_OqstwhqxkZOpvYjWd_siB4C=BEQ@mail.gmail.com>
In-Reply-To: <CAPcyv4gEDwp8Xh4_E8RNBC_OqstwhqxkZOpvYjWd_siB4C=BEQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0638;6:+Erw1LVILAQZPXK8Agg9OED7i1ntNB1VRZcAfbDZlIYbqgqMFx28351tTJnrTvx9yehXyk26yCxtbFbQ3jXe7/Gin2djfq2l3hbB+ql/+IrsSlvhvWHgapDZ7WLdQhbRRXVzwU5KL+cc2e/kMcplLsUR+r6SkXgbiPybcN4hjYzASFULhvIOu7evE/rUC0CDAnijS2Ynp2fAzTFgbPJ9cWV/xquqUSTRaD5NWynJlxGPYZnytPZPwJRQOrXlTU5FqA5JDAASs6s3CrhHoEiXU0mSlWZgMARpYnNra5p6mJiW2ynJpJkDsIXD1xXis5f7vBk+47asu3hLGxW3RtKTGkT1553Jor6iTf/xDVnLd6qtXmjNjKq7AWOwyFBDq7x/e849VNcY1XMytlbZcwaLO1KomYUD6hIUzl6i01EgV6zi9sIkrVEqJzl5T4Kdfsx/zytDMmi1KjraiMls/moUpg==;5:DX7DL3BYNKXmplYm4KxRRcOqa/il5TvlvsYAhBwanArOGySxS0d2PsUnZEM82X06hIH4yRLrtXTGnOGdebBrahYd85oClkdSIpo+ikKlfVP/0M2pliGYBxOu2q6yn0Fx8OfBIMzug7r3QKP4pGpGqc3mugV2R9LFxjIq1ivUM0E=;7:tnBclubSbHvsk7kPjQCr7LKSDmCUsylQCF4Jcz9IhR16H0Z7RZlaFirHzOMk9AXgQ2T1+haIuYOiL6z1go44c4uMtl7W1KaHzB6Ad1cH6UmireIxsVQKfTzsl8Vughs9dImor+y3P1SF6fXrUE7x8Vdgi94ruXJRl7lrGqvkYAWheOh/eNw0f952KjSuGayxG1LT4T76l1Tnt5KR5GqC8HJ17rIeJ0EGNQ1PQE1y5TxKwp8hDwAE1iBaY9Yr5+DU
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fd873c65-c4f9-4cfa-bb0b-08d618d7b9e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0638;
x-ms-traffictypediagnostic: MWHPR21MB0638:
x-microsoft-antispam-prvs: <MWHPR21MB06387DF84D574E4F3802F7D49D1B0@MWHPR21MB0638.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231344)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:MWHPR21MB0638;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0638;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(72206003)(8676002)(81166006)(53546011)(10090500001)(256004)(10290500003)(478600001)(5660300001)(7416002)(66066001)(3846002)(6116002)(486006)(446003)(6246003)(2616005)(11346002)(14454004)(81156014)(476003)(99286004)(6436002)(6486002)(110136005)(105586002)(54906003)(6512007)(53936002)(5250100002)(8936002)(2900100001)(229853002)(106356001)(2906002)(26005)(102836004)(316002)(186003)(68736007)(6346003)(76176011)(22452003)(7736002)(6506007)(86362001)(305945005)(97736004)(86612001)(31696002)(36756003)(31686004)(4326008)(39060400002)(25786009)(93886005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0638;H:MWHPR21MB0510.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: 9HD5qOlE7WYizcORx45eIggqRwGQXwL7xl3L7GgXuGD5t+SmylAN5NSww4md5VCrgQJfookH+L0W2sowH1BL0aMqjCnByMeBtNgIvkqXM9W0SmYYIGyk83pM/N3o1Dl19jYjOljMCXPKCRg/GWO/8Mshx8lYGO2Hx+z/gOJy/9DvjOFeBIYTdQpo6NiX8rIqcjQGXcywKGZWYEs9sxnBJY/dk4X/6HK6adFJ3wpNbx6nJJKbWfwkOAJDOP80+Eo8QwyEtoIGCuTcBS14rpnFnJMg7wWEWxB09DB6PzBcvRxHPvWWqbhNgFvm7mMI4uJif2dtvU62eKOm3k4+FqmCZpiqIMtCY/DM285X010Q8+s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BC95DA5D70D7B4B9356E05A6683025F@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd873c65-c4f9-4cfa-bb0b-08d618d7b9e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2018 17:46:53.2760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0638
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvMTIvMTggMTI6NTAgUE0sIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gT24gV2VkLCBT
ZXAgMTIsIDIwMTggYXQgODo0OCBBTSwgQWxleGFuZGVyIER1eWNrDQo+IDxhbGV4YW5kZXIuZHV5
Y2tAZ21haWwuY29tPiB3cm90ZToNCj4+IE9uIFdlZCwgU2VwIDEyLCAyMDE4IGF0IDY6NTkgQU0g
UGFzaGEgVGF0YXNoaW4NCj4+IDxQYXZlbC5UYXRhc2hpbkBtaWNyb3NvZnQuY29tPiB3cm90ZToN
Cj4+Pg0KPj4+IEhpIEFsZXgsDQo+Pg0KPj4gSGkgUGF2ZWwsDQo+Pg0KPj4+IFBsZWFzZSByZS1i
YXNlIG9uIGxpbnV4LW5leHQsICBtZW1tYXBfaW5pdF96b25lKCkgaGFzIGJlZW4gdXBkYXRlZCB0
aGVyZQ0KPj4+IGNvbXBhcmVkIHRvIG1haW5saW5lLiBZb3UgbWlnaHQgZXZlbiBmaW5kIGEgd2F5
IHRvIHVuaWZ5IHNvbWUgcGFydHMgb2YNCj4+PiBtZW1tYXBfaW5pdF96b25lIGFuZCBtZW1tYXBf
aW5pdF96b25lX2RldmljZSBhcyBtZW1tYXBfaW5pdF96b25lKCkgaXMgYQ0KPj4+IGxvdCBzaW1w
bGVyIG5vdy4NCj4+DQo+PiBUaGlzIHBhdGNoIGFwcGxpZWQgdG8gdGhlIGxpbnV4LW5leHQgdHJl
ZSB3aXRoIG9ubHkgYSBsaXR0bGUgYml0IG9mDQo+PiBmdXp6LiBJdCBsb29rcyBsaWtlIGl0IGlz
IG1vc3RseSBkdWUgdG8gc29tZSBjb2RlIHlvdSBoYWQgYWRkZWQgYWJvdmUNCj4+IHRoZSBmdW5j
dGlvbiBhcyB3ZWxsLiBJIGhhdmUgdXBkYXRlZCB0aGlzIHBhdGNoIHNvIHRoYXQgaXQgd2lsbCBh
cHBseQ0KPj4gdG8gYm90aCBsaW51eCBhbmQgbGludXgtbmV4dCBieSBqdXN0IG1vdmluZyB0aGUg
bmV3IGZ1bmN0aW9uIHRvDQo+PiB1bmRlcm5lYXRoIG1lbW1hcF9pbml0X3pvbmUgaW5zdGVhZCBv
ZiBhYm92ZSBpdC4NCj4+DQo+Pj4gSSB0aGluayBfX2luaXRfc2luZ2xlX3BhZ2UoKSBzaG91bGQg
c3RheSBsb2NhbCB0byBwYWdlX2FsbG9jLmMgdG8ga2VlcA0KPj4+IHRoZSBpbmxpbmluZyBvcHRp
bWl6YXRpb24uDQo+Pg0KPj4gSSBhZ3JlZS4gSW4gYWRkaXRpb24gaXQgd2lsbCBtYWtlIHB1bGxp
bmcgY29tbW9uIGluaXQgdG9nZXRoZXIgaW50bw0KPj4gb25lIHNwYWNlIGVhc2llci4gSSB3b3Vs
ZCByYXRoZXIgbm90IGhhdmUgdXMgY3JlYXRlIGFuIG9wcG9ydHVuaXR5IGZvcg0KPj4gdGhpbmdz
IHRvIGZ1cnRoZXIgZGl2ZXJnZSBieSBtYWtpbmcgaXQgYXZhaWxhYmxlIGZvciBhbnlib2R5IHRv
IHVzZS4NCj4gDQo+IEknbGwgYnV5IHRoZSBpbmxpbmUgYXJndW1lbnQgZm9yIGtlZXBpbmcgdGhl
IG5ldyByb3V0aW5lIGluDQo+IHBhZ2VfYWxsb2MuYywgYnV0IEkgb3RoZXJ3aXNlIGRvIG5vdCBz
ZWUgdGhlIGRpdmVyZ2VuY2UgZGFuZ2VyIG9yDQo+ICJtYWtpbmcgX19pbml0X3NpbmdsZV9wYWdl
KCkgYXZhaWxhYmxlIGZvciBhbnlib2R5IiBnaXZlbiB0aGUgdGhlDQo+IGRlY2xhcmF0aW9uIGlz
IGxpbWl0ZWQgaW4gc2NvcGUgdG8gYSBtbS8gbG9jYWwgaGVhZGVyIGZpbGUuDQo+IA0KDQpIaSBE
YW4sDQoNCkl0IGlzIG11Y2ggaGFyZGVyIGZvciBjb21waWxlciB0byBkZWNpZGUgdGhhdCBmdW5j
dGlvbiBjYW4gYmUgaW5saW5lZA0Kb25jZSBpdCBpcyBub24tc3RhdGljLiBPZiBjb3Vyc2UsIHdl
IGNhbiBzaW1wbHkgbW92ZSB0aGlzIGZ1bmN0aW9uIHRvIGENCmhlYWRlciBmaWxlLCBhbmQgZGVj
bGFyZSBpdCBpbmxpbmUgdG8gYmVnaW4gd2l0aC4NCg0KQnV0LCBzdGlsbCBfX2luaXRfc2luZ2xl
X3BhZ2UoKSBpcyBzbyBwZXJmb3JtYW5jZSBzZW5zaXRpdmUsIHRoYXQgSSdkDQpsaWtlIHRvIHJl
ZHVjZSBudW1iZXIgb2YgY2FsbGVycyB0byB0aGlzIGZ1bmN0aW9uLCBhbmQga2VlcCBpdCBpbiAu
YyBmaWxlLg0KDQpUaGFuayB5b3UsDQpQYXZlbA==
