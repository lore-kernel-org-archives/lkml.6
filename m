Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC09C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD17A2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Lp8smTN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfBEQxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:53:44 -0500
Received: from mail-eopbgr1320135.outbound.protection.outlook.com ([40.107.132.135]:32800
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725952AbfBEQxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RL2ZYwD2OZ91RrUfuHrj7FMb1xEKe4M5rjTkx9Y5kzk=;
 b=Lp8smTN76XxE0ZJW68Tg6bN6wy/8aHdf/WwQqIqtWn5FH5aAawDhPY85gNTg7P4eXDBRd7xv4nqMObNE4I9Gn2Aj7Fp0D8Kj+aTj4mE67BFK6mzJN+pNui646igcyVyvGcPbfbHR/dLJx1XQFw09aWcMx0jXO9TRZ1sPBcf34mo=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0186.APCP153.PROD.OUTLOOK.COM (10.170.187.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.5; Tue, 5 Feb 2019 16:53:36 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1622.006; Tue, 5 Feb 2019
 16:53:36 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] libnvdimm/dimm: Add a no-BLK quirk based on NVDIMM family
Thread-Topic: [PATCH] libnvdimm/dimm: Add a no-BLK quirk based on NVDIMM
 family
Thread-Index: AQHUu+TohgnD5hWBBUGGy2lRJKF6bKXOWb4AgAABhxCAABYTAIACWocA
Date:   Tue, 5 Feb 2019 16:53:36 +0000
Message-ID: <PU1P153MB0169997F36D28D8EA80923CFBF6E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <154915640488.3541628.4947340559510114602.stgit@dwillia2-desk3.amr.corp.intel.com>
 <PU1P153MB0169BD9237F2DC1FA64721BABF6C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4h0B0sBMjiAC=Tk=Mu58A4vZ5F9yUPQsXqf5jyYF37VCw@mail.gmail.com>
 <PU1P153MB0169F7C111EEC5890D3F840ABF6C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4iMau=fvOfubDvK=cg5v5287TvXqBCm=p8nqbz2es6YEg@mail.gmail.com>
In-Reply-To: <CAPcyv4iMau=fvOfubDvK=cg5v5287TvXqBCm=p8nqbz2es6YEg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-05T16:53:33.7411935Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=71b3c79b-66d4-46dc-9a62-287b4f98e12a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2601:600:a280:1760:5896:cf8a:cefe:fd7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0186;6:Qtc5Bbj37CbJuosp/HfmIA5NTXlK77Y2n5aEWJDCAElLOBBDIwCFWZNqN5pqFllpExxe9ZJmo+2SOShFTIfdaMNJ6Jm1i7/b8LotJTnZV4PT2n9hijZT/fzx0viOuB+/VM37Ofgf1AUPVfBKGdXbdcbrNSUbVA467/9n5tPnLKbrQMHH2H0QDMhNj+1KBba3LOpdffLmHGyCZKOHCNCqfbvkyc4YSxe2q2ZpfZTqsrKXB463yBBxHyYjkBKKfB8TO2iJpvDnTqWWdn3zMDQj1Kvs9kVhjmfkhkVGM2erqFNDe5nv6SKBpOdhe0qynP/Ne1lN18gS4zgFZ7YMsGNoNl7D67Na+e196hTLPB0V4yMKfh2uKz04UhoaLAK9TF+GMZXdOCLRUHJ5OObG0O+xBm8qsCotYkZ70VEoWjfj7CTsAqeoWo1L0XP94kmaQwUcBS3jsrB42MddhibdXRgWaA==;5:kRDiQP/Lq+x2VHYZU5XtckzjanlGok5laNzDsjTv1AWByq6gXgP3df6Z98KmUWkrDasUhSQbORUJsYfoPeZXWxtsnBGO32ggFobgn0YMpHn3Ihsli4zZyRWdo72FAXiX6zqOoahMByn4ElDPcdNIHuwZBS00+Tk2PwlbevTnNbnoGDIwpf+Ph0nDq9684N0GUCueUwqj57TKR6tcMhrRTw==;7:K9GWPEVD/2XvTok5cJztwqOjlWXyJrlA5KjAy1ybk40rSsdJwXspXDWXZbuyPB1UD4tvh1xHnwTDskA9CZV+MArIWWn4S6cz5NBpaEWv1u5/7jLaNXgi0XzWidvcfdl3wxDpsvjBv+IfHPnAP13M2Q==
x-ms-office365-filtering-correlation-id: d557f711-b849-4cd2-a014-08d68b8a78bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600126)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0186;
x-ms-traffictypediagnostic: PU1P153MB0186:
x-microsoft-antispam-prvs: <PU1P153MB0186E267CDCBADA5BCBCE50BBF6E0@PU1P153MB0186.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(136003)(376002)(396003)(189003)(51914003)(199004)(6116002)(93886005)(10090500001)(68736007)(229853002)(2906002)(6346003)(46003)(25786009)(53936002)(10290500003)(6246003)(102836004)(54906003)(86612001)(316002)(8990500004)(22452003)(86362001)(486006)(107886003)(6506007)(105586002)(6436002)(55016002)(256004)(476003)(9686003)(97736004)(81156014)(6916009)(8676002)(11346002)(106356001)(14444005)(8936002)(14454004)(186003)(81166006)(446003)(76176011)(478600001)(74316002)(305945005)(4326008)(71190400001)(71200400001)(99286004)(7696005)(33656002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0186;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q5jXj9FqWzlqRKb1xoC/+UeH7u/2jZoPvP0AQkcL4fpgqztFbrAQ2qVuN+pogz6NCW7m8guqTL09T4ZbtklSqG3p/ek/VCPfnpjlqERyOi3xX2fc3b8Ro5RBmTnlOt/nESh+ZXAviG3jlPkZuuEK/WLLxvhCP+sUVq8FitFW7+m0Zv4DhaDQSOe+9tqZmE4YfBkF162DZtdG7Cm7ySsj0xb3DgkuwfKI9pI7K2lriCeYV02rUsViEg5Es7mEchv/eEOj3lGx8wkfByxqPw1jEc1TfU0Q7JEhJWEOyYDRiVJIY6rZ/nHJ0YMvxG6qJcv3kUCruPJBN8ElN2pMOEvldafv/yMPpyt/mYwwWwG/yeIF8F3CT1ydCdIGgUD03akTXnNJ8tZV/FhR5VBeQZVXHEfpGK4ljGY6gBSaXQo4Or0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d557f711-b849-4cd2-a014-08d68b8a78bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 16:53:36.2688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0186
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gU2VudDog
U3VuZGF5LCBGZWJydWFyeSAzLCAyMDE5IDExOjE0IEFNDQo+ID4gLi4uDQo+ID4gQXMgSSB1bmRl
cnN0YW5kLCB0aGUgZXNzZW5jZSBvZiB0aGUgaXNzdWUgaXM6IEh5cGVyLVYgZW11bGF0ZXMgdGhl
DQo+ID4gbGFiZWwgbWVjaGFuaXNtIChpLmUuIGl0IHN1cHBvcnRzIF9MU0kgYW5kIExTUiksIGJ1
dCBkb2Vzbid0IGRvIGl0DQo+ID4gcmlnaHQgKGkuZS4gaXQgZG9lc24ndCBzdXBwb3J0IF9MU1cp
Lg0KPiA+DQo+ID4gVG8gbWFuYWdlIHRoZSBuYW1lc3BhY2VzLCBMaW51eCBjYW4gY2hvb3NlIHRv
IHVzZSBsYWJlbCBvciBub3QuDQo+ID4NCj4gPiBJZiBfTFNJL19MU1IgYXJlIHN1cHBvcnRlZCwg
TGludXggYXNzdW1lcyBfTFNXIGlzIHN1cHBvcnRlZCBhcyB3ZWxsDQo+ID4gYW5kIGNob29zZXMg
dG8gdXNlIGxhYmVsIChpLmUuIHRoZSBsYWJlbCBtb2RlKSwgYnV0IHNpbmNlIEh5cGVyLVYgZG9l
c24ndA0KPiA+IHN1cHBvcnQgX0xTVywgTGludXggZmFpbHMgdG8gY2hhbmdlIHRoZSBuYW1lc3Bh
Y2UgY29uZmlndXJhdGlvbi4NCj4NCj4gTm8sIHRoYXQncyBub3QgcXVpdGUgcmlnaHQuIFRoZSBy
ZWFzb24gTGludXggZG9lcyBub3Qgc2VlIHRoZSBmc2RheA0KPiBtb2RlIGNvbmZpZ3VyYXRpb24g
aXMgZHVlIHRvIHRoZSBtaXNzaW5nICJhZGRyZXNzIGFic3RyYWN0aW9uIEdVSUQiIGluDQo+IHRo
ZSBsYWJlbCBwcm9kdWNlZCB0aGUgZGVmYXVsdCBIeXBlci1WIGNvbmZpZ3VyYXRpb24uDQpIaSBE
YW4sDQpEbyB5b3UgbWVhbiBOVkRJTU1fREFYX0dVSUQ/DQoNCj4gSW4gbGFiZWwtbGVzcyBtb2Rl
IHRoZXJlIGlzIG5vICJhZGRyZXNzIGFic3RyYWN0aW9uIEdVSUQiIHRvIHZhbGlkYXRlIHNvDQo+
IGl0IGZhbGxzIGJhY2sgdG8ganVzdCB1c2luZyB0aGUgaW5mby1ibG9jayBkaXJlY3RseS4NCklu
IHRoZSBjYXNlIG9mIG5vdCB1c2luZyBsYWJlbCBzdG9yYWdlIGFyZWEsIGFzIEkgdW5kZXJzdGFu
ZCB0aGUgaW5mby1ibG9jaw0KcmVzaWRlcyBpbiByZWd1bGFyIGRhdGEgc3RvcmFnZSBhcmVhLiBD
YW4geW91IHBsZWFzZSB0ZWxsIG1lIHdoZXJlIGV4YWN0bHkNCnRoZSBpbmZvLWJsb2NrIGlzIGFu
ZCBob3cgaXRzIGxvY2F0aW9uIGlzIGRlY2lkZWQ/DQpBbmQgSSBzdXBwb3NlIHRoZSBpbmZvLWJs
b2NrIGNvbnRhaW5zIHRoZSBOVkRJTU1fREFYX0dVSUQ/DQoNCkknbSBhc2tpbmcgYmVjYXVzZSBJ
IGZvdW5kIEkgbG9zZSB+NTAwTUJ5dGVzIG9mIHRoZSAzMkdCeXRlcyBIeXBlci1WDQpOVkRJTU0g
ZGV2aWNlLCB3aGVuIHRoZSBuYW1lc3BhY2UgaXMgaW4gZnNkYXggbW9kZS4gV2hlbiBpdCdzIGlu
DQpyYXcgbW9kZSwgSSdtIGFibGUgdG8gdXNlIGFsbCBvZiB0aGUgMzJHQiBzcGFjZS4NCg0KPiBU
aGUgX0xTVyBpc3N1ZSBpcyBpZiB5b3Ugd2FudGVkIHRvIHJlY29uZmlndXJlIGEgcmF3IG5hbWVz
cGFjZSB0bw0KPiBmc2RheCBtb2RlLiBUaGUgY3VycmVudCBmbG93IHRyaWVzIHRvIGRlbGV0ZSB0
aGUgbGFiZWwsIGJ1dCB0aGF0J3MNCj4gb25seSBmb3IgcmVjb25maWd1cmF0aW9uLCBub3QgdGhl
IGluaXRpYWwgYm9vdC11cCBjYXNlIHRoYXQgaXMNCj4gY3VycmVudGx5IGZhaWxpbmcuIFRoZSBk
ZWxldGlvbiB3b3VsZCBmYWlsIG9uIGZpbmRpbmcgbm8gbGFiZWwtd3JpdGUNCj4gY2FwYWJpbGl0
eSwgYnV0IHRvIGJlIGNsZWFyIHRoZSBib290LXVwIGNhc2UgZG9lcyBub3QgcGVyZm9ybSBhbnkN
Cj4gd3JpdGVzLg0KVGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24hDQoNCj4gPiBJbiBVYnVudHUg
MTkuMDQgKDQuMTgpLCB0aGUga2VybmVsIGlzIG5vdCBhd2FyZSBvZiBIeXBlci1WIF9MU0kvX0xT
Uiwgc28NCj4gPiB0aGUgY3JlYXRlZCBuYW1lc3BhY2UgaXMgaW4gImxhYmVsLWxlc3MiIG1vZGUs
IGFuZCBoZW5jZSBjYW4ndCBiZSB1c2VkDQo+ID4gd2l0aCB0aGUgbGlibnZkaW1tLXBlbmRpbmcg
YnJhbmNoICsgdGhpcyBwYXRjaCwgdW5sZXNzIHdlIGFkZCBhIHF1aXJrDQo+ID4gaW4gTGludXgg
dG8gZXhwbGljaXRseSBub3QgdXNlIHRoZSBsYWJlbC4NCj4gPg0KPiA+IEkgYWdyZWUgaWRlYWxs
eSBIeXBlci1WIHNob3VsZCBoaWRlIHRoZSBsYWJlbCBjYXBhYmlsaXR5LCBhbmQgSSdsbCByZXF1
ZXN0DQo+ID4gSHlwZXItViB0ZWFtIHRvIGRvIHRoYXQuIEkgaG9wZSBIeXBlci1WIGd1eXMgYXJl
IHN0aWxsIGFibGUgdG8gZG8gdGhhdA0KPiA+IGluIHRpbWUgc28gd2Ugd29uJ3QgbmVlZCBhIHF1
aXJrIGluIExpbnV4IGtlcm5lbC4NCj4NCj4gQWZ0ZXIgc29tZSBtb3JlIHRob3VnaHQsIHRoZSAi
bm8gcmVncmVzc2lvbnMiIHJ1bGUgbWVhbnMgdGhhdCBMaW51eA0KPiBzaG91bGQgc2hpcCBhIHF1
aXJrIGZvciB0aGlzIGJ5IGRlZmF1bHQuIEkgdGhpbmsgYSBnb29kIGhldXJpc3RpYyBpcw0KPiB0
byBkaXNhYmxlIGxhYmVsIHN1cHBvcnQgYnkgZGVmYXVsdCBpZiBubyBfTFNXIG1ldGhvZCBpcyBk
ZXRlY3RlZC4gQW4NCj4gb3B0LWluIGNhbiBiZSBzcGVjaWZpZWQgdG8gYWNjZXB0ICJyZWFkLW9u
bHkiIGNvbmZpZ3VyYXRpb25zLCBidXQNCj4gdGhhdCdzIGFuIGV4Y2VwdGlvbmFsIGNhc2UuIEkn
bGwgc2VuZCBhIHBhdGNoIGZvciB0aGlzLg0KPg0KPiA+IEJUVywgSSBzdXBwb3NlIFdpbmRvd3Mg
Vk0gc2hvdWxkIGJlIGluICJsYWJlbC1sZXNzIiBtb2RlLg0KPg0KPiBJIGV4cGVjdCBXaW5kb3dz
IG1hbmRhdGVzIGxhYmVsZWQgb3BlcmF0aW9uLiBUaGlzIGxhYmVsLWxlc3MgY29uY2VwdA0KPiB3
YXMgc29tZXRoaW5nIExpbnV4IHNoaXBwZWQgaW4gYWR2YW5jZSBvZiBhIHNwZWNpZmljYXRpb24g
YmVpbmcNCj4gcmF0aWZpZWQgYW5kIHRvIHN1cHBvcnQgZWFybHkgTlZESU1NcyB0aGF0IGRvbid0
IGFkdmVydGlzZSBsYWJlbA0KPiBzcGFjZS4NClNpbmNlIEh5cGVyLVYgTlZESU1NIGRvZXNuJ3Qg
c3VwcG9ydCBfTFNXLCBJTU8gV2luZG93cyBWTQ0KY2FuJ3QgdXBkYXRlIHRoZSBMU0kgYXJlYSBl
aXRoZXIsIHNvIEkgZ3Vlc3MgV2luZG93cyBWTSBjYW4ndCB1c2UNCmxhYmVsIGVpdGhlciwganVz
dCBsaWtlIExpbnV4IFZNPyBJIGd1ZXNzIFdpbmRvd3MgVk0gYWxzbyBzdG9yZXMgYW4NCiJpbmZv
IGJsb2NrIiB3aGVuIHRoZSBuYW1lc3BhY2UgaXMgaW4gZGF4IG1vZGUsIGp1c3QgbGlrZSBMaW51
eCBWTT8NCg0KQlRXLCBpdCBsb29rcyB0aGUgZGF4IG1vZGUgY29uZmlndXJhdGlvbiBpbiBMaW51
eCBWTSBpcyBpbmNvbXBhdGlibGUNCndpdGggdGhhdCBpbiBXaW5kb3dzIFZNKD8pIFdoZW4gSSBj
cmVhdGUgYSBEQVgtZW5hYmxlZCBOVEZTIHBhcnRpdGlvbg0KaW4gV2luZG93cyBWTSBpbiB0aGUg
c2FtZSBIeXBlci1WIE5WRElNTSwgV2luZG93cyBWTSBpcyBhYmxlIHRvDQp1c2UgYWxsIG9mIHRo
ZSAzMkdCIHNwYWNlIChBcyBJIG1lbnRpb25lZCBhYm92ZSwgaW4gTGludXggSSBsb3NlIH41MDBN
QikuDQpBbmQgdGhlICJkYXgiIG1vZGUgbmFtZXNwYWNlIGNyZWF0ZWQgaW4gV2luZG93cyBWTSBp
cyBkZXRlY3RlZA0KYXMgInJhdyIsIGFuZCB2aWNlIHZlcnNlIChJIHRoaW5rKS4NCg0KSSdtIHRy
eWluZyB0byB1bmRlcnN0YW5kIHdoeSBJIGxvc2UgfjUwME1CIGluIExpbnV4IGRheCBtb2RlLg0K
WW91ciBpbnNpZ2h0cyBhcmUgYXBwcmVjaWF0ZWQhDQoNClRoYW5rcywNCi0tRGV4dWFuDQo=
