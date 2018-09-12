Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4D9C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC4720880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="imaKk4x8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC4720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeILSsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:48:46 -0400
Received: from mail-eopbgr680132.outbound.protection.outlook.com ([40.107.68.132]:44690
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726606AbeILSsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKAz/nIxTVcXRGlL5uXv50xnjisS00cr3BMfe/DjPTs=;
 b=imaKk4x8eNAIejdOSndTeZo2EbKJTOkQLqhYLCRGMKmUmjYMVQauqc86bjNZ3drGo3tRwd/NwZf6OSDo1gQ4QTwcLJGgVhCc7sj6HexoJ/ZLigOG8+jBJTb/iWzHrUOdnrYeUsZ1/Jo4zlPZ12pxPUXc0sEu0R+7Qcb20GdWVlM=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0827.namprd21.prod.outlook.com (10.173.172.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Wed, 12 Sep 2018 13:44:08 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1164.006; Wed, 12 Sep 2018
 13:44:08 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC:     "mhocko@suse.com" <mhocko@suse.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 4/4] nvdimm: Trigger the device probe on a cpu local to
 the device
Thread-Topic: [PATCH 4/4] nvdimm: Trigger the device probe on a cpu local to
 the device
Thread-Index: AQHUSWAqqzRsVougSUGPItU+UH7awqTsqpgA
Date:   Wed, 12 Sep 2018 13:44:08 +0000
Message-ID: <3b308b65-ab45-9922-abae-b4c25117e388@microsoft.com>
References: <20180910232615.4068.29155.stgit@localhost.localdomain>
 <20180910234400.4068.15541.stgit@localhost.localdomain>
In-Reply-To: <20180910234400.4068.15541.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0827;6:tfA3rphGfjTPybTtyoIoyZE6IvmYKddej2GHkJNr9LGz7DbBh3MPkqNul2himSaIL437YoKfmYEdeYyS6TyJ779aIiZ3ANOoA2CZCm0yo1CT27d0BT3bjLVi74HB66XfUhyL3d13sW+O2LQB9Miw+M7iUQMD2sK3fS0/NN8Wdayg7xP5XWA9XKMqzkrt+lkFM2QmUn1aVk+zRJID77fa0kRgP4CjPse1FyP2UDEeTMLfkTZs9wELGmaowzj+OdfklE0G+LZn41etMrzM3EY2nqnxWjmiNmR+4AY1ypsagVg06bhVWFiFGhSkXECu1z7Z3dwRfZX3MNSsdR68PMFDw+fCmKLVfjBbVMiOzbV7NWutuQMjfCTUbB1j4fRdoG/N5LTLlaXGgtjiJH7eIR8m9t07wBak7cbur/t6wYGZpuAgZ7sMJGzPsWg42SKJAofjcix4DOu9o/FkIFWiV9jKCA==;5:XGQ3Dyx7hKL5BOI8/joZ/fW/dRVwGEzMfSkQPTS8AkQd68zGp3Y9A7oXmnPVDdke3Brc08LVXThsDlAb7/15MPVktShdqFQVZtRY26Ve/FcLvkeSdRorS4y51PSIMQi/RgJKThgOErQYrKnV+NMohgFjFk7N5WmUr3D5GKm2kWg=;7:/ncG/R7KmDyzD6F3uxcb2xYsocBK7oEQJGeC4CKsbWN6o8v9DlZsFdXYc+/Aw7pkzNz0Wd8lTqXQdtDVnV8S2R1KYKpdW+gGD5p2cVPefPAnDIJXBIxwnRyFz2+2xlX0e45FuNrhfwAbsBz4X/E+JhoR8J5VnTlQwMUz3cRRzktKEWxBnPv8i8hQ4DPtEps1TZQbsotClk7ttiNsU02gdrAoZM9lY+97y0utXBwdhmUAd+PKagn9laOU4KYDvw+J
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 64175674-3e81-4d6f-ee09-08d618b5d057
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0827;
x-ms-traffictypediagnostic: DM5PR21MB0827:
x-microsoft-antispam-prvs: <DM5PR21MB082752417FD7E6EB6B1AE3A49D1B0@DM5PR21MB0827.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:DM5PR21MB0827;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0827;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(376002)(39860400002)(366004)(199004)(189003)(5660300001)(6116002)(3846002)(22452003)(102836004)(6346003)(53546011)(6506007)(26005)(31686004)(8936002)(36756003)(72206003)(486006)(81156014)(81166006)(446003)(256004)(186003)(76176011)(54906003)(110136005)(316002)(99286004)(105586002)(106356001)(2616005)(476003)(11346002)(6512007)(86612001)(25786009)(2900100001)(86362001)(4326008)(68736007)(39060400002)(31696002)(53936002)(7416002)(8676002)(305945005)(2201001)(6436002)(6246003)(2906002)(7736002)(229853002)(66066001)(10290500003)(478600001)(10090500001)(6486002)(14454004)(5250100002)(2501003)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0827;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: nmuTU3NTZKOEqAEvP+1cy/7yGvwP8rLrUMDKF1yauSWopAro5XdvHa0TGHasrjh/HbsUsFHC5Y3F84EiBg4rwNrM1WsWA6iis31H4Js/c52lR7SWRsxsh8lh3KF1jCZhfJidHkqi85OP6ggSekfxmbKjpjDi4R14nHou1JYBkgGZhulqCQVYp3bQZX1/okwS4NBb6ljVFA8ixXDZZO4TKpyeFa4X0TgTNH/hYAcArb/XzcUSqXfCt2M+kbRnkHZXAFC5r/tXn7jw69i+slV7Ej6Zo7lHc0BcVGjqI+VbX4rXdaDiz3FtU2PxoUhFNxr9uL7wEeId5bWWwtjlUQwTjAbLe3zqbCwtO6UObWf3uDU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <159C8E5CA49F674ABDCD724B6EFCE6FF@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64175674-3e81-4d6f-ee09-08d618b5d057
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2018 13:44:08.0502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0827
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvMTAvMTggNzo0NCBQTSwgQWxleGFuZGVyIER1eWNrIHdyb3RlOg0KPiBGcm9tOiBB
bGV4YW5kZXIgRHV5Y2sgPGFsZXhhbmRlci5oLmR1eWNrQGludGVsLmNvbT4NCj4gDQo+IFRoaXMg
cGF0Y2ggaXMgYmFzZWQgb2ZmIG9mIHRoZSBwY2lfY2FsbF9wcm9iZSBmdW5jdGlvbiB1c2VkIHRv
IGluaXRpYWxpemUNCj4gUENJIGRldmljZXMuIFRoZSBnZW5lcmFsIGlkZWEgaGVyZSBpcyB0byBt
b3ZlIHRoZSBwcm9iZSBjYWxsIHRvIGEgbG9jYXRpb24NCj4gdGhhdCBpcyBsb2NhbCB0byB0aGUg
bWVtb3J5IGJlaW5nIGluaXRpYWxpemVkLiBCeSBkb2luZyB0aGlzIHdlIGNhbiBzaGF2ZQ0KPiBz
aWduaWZpY2FudCB0aW1lIG9mZiBvZiB0aGUgdG90YWwgdGltZSBuZWVkZWQgZm9yIGluaXRpYWxp
emF0aW9uLg0KPiANCj4gV2l0aCB0aGlzIHBhdGNoIGFwcGxpZWQgSSBzZWUgYSBzaWduaWZpY2Fu
dCByZWR1Y3Rpb24gaW4gb3ZlcmFsbCBpbml0IHRpbWUNCj4gYXMgd2l0aG91dCBpdCB0aGUgaW5p
dCB2YXJpZWQgYmV0d2VlbiAyMyBhbmQgMzcgc2Vjb25kcyB0byBpbml0aWFsaXplIGEgM0dCDQo+
IG5vZGUuIFdpdGggdGhpcyBwYXRjaCBhcHBsaWVkIHRoZSB2YXJpYW5jZSBpcyBvbmx5IGJldHdl
ZW4gMjMgYW5kIDI2DQo+IHNlY29uZHMgdG8gaW5pdGlhbGl6ZSBlYWNoIG5vZGUuDQo+IA0KPiBJ
IGhvcGUgdG8gcmVmaW5lIHRoaXMgZnVydGhlciBpbiB0aGUgZnV0dXJlIGJ5IGNvbWJpbmluZyB0
aGlzIGxvZ2ljIGludG8NCj4gdGhlIGFzeW5jX3NjaGVkdWxlX2RvbWFpbiBjb2RlIHRoYXQgaXMg
YWxyZWFkeSBpbiB1c2UuIEJ5IGRvaW5nIHRoYXQgaXQNCj4gd291bGQgbGlrZWx5IG1ha2UgdGhp
cyBmdW5jdGlvbmFsaXR5IHJlZHVuZGFudC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRl
ciBEdXljayA8YWxleGFuZGVyLmguZHV5Y2tAaW50ZWwuY29tPg0KDQpMb29rcyBnb29kIHRvIG1l
LiBUaGUgcHJldmlvdXMgZmFzdCBydW5zIHdlcmUgYmVjYXVzZSB0aGVyZSB3ZSB3ZXJlDQpnZXR0
aW5nIGx1Y2t5IGFuZCBleGVjdXRlZCBpbiB0aGUgcmlnaHQgbGF0ZW5jeSBncm91cHMsIHJpZ2h0
PyBOb3csIHdlDQpib3VuZCB0aGUgZXhlY3V0aW9uIHRpbWUgdG8gYmUgYWx3YXlzIGZhc3QuDQoN
ClJldmlld2VkLWJ5OiBQYXZlbCBUYXRhc2hpbiA8cGF2ZWwudGF0YXNoaW5AbWljcm9zb2Z0LmNv
bT4NCg0KVGhhbmsgeW91LA0KUGF2ZWw=
