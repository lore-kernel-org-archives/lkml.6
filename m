Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E2FC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCC921473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q8DXnavL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCC921473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJDDDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 23:03:07 -0400
Received: from mail-cys01nam02on0087.outbound.protection.outlook.com ([104.47.37.87]:30854
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726941AbeJDDDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 23:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAUGrNya9fg7im11XQgoQeU9pdvQ/Qs1vqHwJLzRtTA=;
 b=q8DXnavL6NMYrLVIpP7QdQl7osz+hrEq3gzbj2BzDbd+jYgBrIHXYK5/RDC7eEj1pjh6Tfw/PC/i/7BifKL4tDWM33e+6se/J353SJHYmrj2lVyQiw+xsQK1nB66F8PWrEGgnlcZ/0l9JfEh2csgT60mV9Q8fOQOjwqOtWG1v4U=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1692.namprd12.prod.outlook.com (10.172.40.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.24; Wed, 3 Oct 2018 20:12:32 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.021; Wed, 3 Oct 2018
 20:12:32 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "luto@kernel.org" <luto@kernel.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "jannh@google.com" <jannh@google.com>,
        "dima@arista.com" <dima@arista.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 03/10] arch/x86: Re-arrange RDT init code
Thread-Topic: [RFC PATCH 03/10] arch/x86: Re-arrange RDT init code
Thread-Index: AQHUVDtyokQlIS2+10uA6u2YvHhBgaUMYa6A///02QCAAZYggIAAFbAA
Date:   Wed, 3 Oct 2018 20:12:31 +0000
Message-ID: <7a7fb59a-eeca-47d1-49eb-c78fa289aef3@amd.com>
References: <20180924191841.29111-1-babu.moger@amd.com>
 <20180924191841.29111-4-babu.moger@amd.com>
 <09e1f4dc-7882-9bb4-f5a7-e9e7caafee84@intel.com>
 <ec7ea236-adca-246c-2d2a-56dc68a146f8@amd.com>
 <7c971383-1695-7905-603e-99ff5916f691@intel.com>
In-Reply-To: <7c971383-1695-7905-603e-99ff5916f691@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0058.namprd22.prod.outlook.com
 (2603:10b6:300:12a::20) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1692;20:0TyQG6+c+I0nlp3KasgsMOyAufKw9Cr0SfXYXKYhFrgDowWv8q/+TtG9MjJieRNPeGX06q3419JJm6dE4J+ocmtpvUyKK6Q+KBlDew1t4+2cTOlmRFz6V5bCMgY4aTrANcRuOgoJ5+RnAvgIc8qOgcMK56dTKRqWF9XnYwGQfBVPvBZ867RxO2pkeRo4a962tktKH7o91/pByc8jcA7sN+r9W6JWhogjSHMzvLBAwbgf0K9wCIgF9tlso+b7E10M
x-ms-office365-filtering-correlation-id: 1a6c2c70-c312-4884-7b41-08d6296c8ce0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1692;
x-ms-traffictypediagnostic: DM5PR12MB1692:
x-microsoft-antispam-prvs: <DM5PR12MB1692A1849945779D9A07714095E90@DM5PR12MB1692.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:DM5PR12MB1692;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1692;
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(68736007)(6436002)(6246003)(6486002)(97736004)(53936002)(31686004)(7736002)(6512007)(3846002)(6116002)(105586002)(106356001)(71200400001)(5660300001)(305945005)(110136005)(71190400001)(54906003)(316002)(53546011)(2906002)(6506007)(386003)(25786009)(4326008)(229853002)(7416002)(66066001)(52116002)(8676002)(81156014)(99286004)(81166006)(8936002)(76176011)(11346002)(446003)(93886005)(14454004)(26005)(72206003)(486006)(476003)(2616005)(36756003)(478600001)(102836004)(5250100002)(2501003)(256004)(86362001)(186003)(31696002)(2900100001)(217873002)(2201001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1692;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: E2LsPKQMRHpzhFilu+5DKYjHOEvpoQ0ZQnZ8otDyehfrrrWQeG4BXoW1Fsx+GRtJm8r2zClWL3RTmfQ0LM/btlZd4+mDc98nYVbcqVWUEwcn7cncdKvvEV9uu0wrzDeYUanuMRfN/Ht4PazBWLkRHGlm86UErymd9CZHjDUR0ZgsUUo31GGsfBx1qTDzeRWq5KX9p41VnnQYrgCh3BwZN1O8hLYF27Pgr8tKH6Kq+8sPVOPE3ZTxAmEHT9IYAe3eAGvDVWLcqi9uwxGDa9n3k4TE9JD7U99ra4PgW/GyIXiWFjWIB1TQQ0JgX36/1tDk6nNm+WGrkJx2+SF++0eL05dzIuDXGOrcYJoQEYPXLl8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <872B53ADDB0FB8469ECF7EC2929632C6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6c2c70-c312-4884-7b41-08d6296c8ce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 20:12:31.9982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzAzLzIwMTggMDE6NTQgUE0sIFJlaW5ldHRlIENoYXRyZSB3cm90ZToNCj4gSGkg
QmFidSwNCj4gDQo+IE9uIDEwLzIvMjAxOCA0OjQxIFBNLCBNb2dlciwgQmFidSB3cm90ZToNCj4+
IE9uIDEwLzAyLzIwMTggMDI6MjEgUE0sIFJlaW5ldHRlIENoYXRyZSB3cm90ZToNCj4+PiBPbiA5
LzI0LzIwMTggMTI6MTkgUE0sIE1vZ2VyLCBCYWJ1IHdyb3RlOg0KPj4+PiAgc3RhdGljIGVudW0g
Y3B1aHBfc3RhdGUgcmR0X29ubGluZTsNCj4+Pj4gQEAgLTg2Niw4ICs4NzIsMjIgQEAgc3RhdGlj
IGludCBfX2luaXQgcmR0X2xhdGVfaW5pdCh2b2lkKQ0KPj4+PiAgCXN0cnVjdCByZHRfcmVzb3Vy
Y2UgKnI7DQo+Pj4+ICAJaW50IHN0YXRlLCByZXQ7DQo+Pj4+ICANCj4+Pj4gLQlpZiAoIWdldF9y
ZHRfcmVzb3VyY2VzKCkpDQo+Pj4+ICsJLyogUnVuIHF1aXJrcyBmaXJzdCAqLw0KPj4+PiArCXJk
dF9xdWlya3MoKTsNCj4+Pj4gKw0KPj4+PiArCXJkdF9hbGxvY19jYXBhYmxlID0gZ2V0X3JkdF9h
bGxvY19yZXNvdXJjZXMoKTsNCj4+Pj4gKwlyZHRfbW9uX2NhcGFibGUgPSBnZXRfcmR0X21vbl9y
ZXNvdXJjZXMoKTsNCj4+Pj4gKw0KPj4+PiArCWlmICghKHJkdF9hbGxvY19jYXBhYmxlIHx8IHJk
dF9tb25fY2FwYWJsZSkpIHsNCj4+Pj4gKwkJcHJfaW5mbygiUkRUIGFsbG9jYXRpb24gb3IgbW9u
aXRvcmluZyBub3QgZGV0ZWN0ZWRcbiIpOw0KPj4+DQo+Pj4gVGhpcyBmdW5jdGlvbiBlbmRzIHdp
dGggYSBsb2cgZW50cnkgZm9yIGV2ZXJ5IHJlc291cmNlIGRpc2NvdmVyZWQuIElzDQo+Pj4gdGhp
cyBuZXcgbG9nIGVudHJ5IG5lZWRlZCB0byBpbmRpY2F0ZSB0aGF0IHN1Y2ggcmVzb3VyY2VzIGhh
dmUgbm90IGJlZW4NCj4+PiBmb3VuZD8gQ291bGQgaXQgbm90IGp1c3QgYmUgdGhlIGFic2VuY2Ug
b2YgdGhlIG90aGVyIG1lc3NhZ2U/DQo+Pg0KPj4gQXMgdGhpcyBpcyByZWxhdGl2ZWx5IG5ldyBm
ZWF0dXJlLCBzbyBJIGFkZGVkIHRoaXMgaW5mbyBtZXNzYWdlLiBJdCBoZWxwZWQNCj4+IG1lIGRl
YnVnIHdoYXQgd2VudCB3cm9uZy4gT3RoZXJ3aXNlLCBJIGRvbid0IHNlZSBhbnl0aGluZy4gSSBj
YW4gcmVtb3ZlIGl0DQo+PiBpZiB0aGUgbWVzc2FnZSBpcyB0b28gYW5ub3lpbmcgdG8gdGhlIHVz
ZXIuDQo+IA0KPiBUaGlzIGxvZyBlbnRyeSBpcyBtYWRlIGFmdGVyIGRldGVjdGlvbiBvZiByZXNv
dXJjZXMvZmVhdHVyZXMgc3VwcG9ydGVkDQo+IGJ5IHRoZSBzeXN0ZW0uIEEgdXNlciB3b3VsZCBm
aW5kIG1vcmUgaW5mb3JtYXRpb24gaW4gdGhlDQo+IHByZXNlbmNlL2Fic2VuY2Ugb2YgdGhlIHJl
bGV2YW50IENQVSBmZWF0dXJlIGZsYWdzIGluIC9wcm9jL2NwdWluZm8uDQoNCk9rLiBVbmRlcnN0
b29kLiBJIGhhdmUgZHJvcHBlZCB0aGlzIGxvZyBlbnRyeS4NCg0KPiANCj4gUmVpbmV0dGUNCj4g
DQo=
