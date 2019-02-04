Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69240C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3810D2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0dcrraQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbfBDRSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:18:00 -0500
Received: from mail-eopbgr720089.outbound.protection.outlook.com ([40.107.72.89]:4736
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727650AbfBDRSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nNEQWHb01P6Vmx8Ufq/ujj39yZbaiRvDmcIq34+CXM=;
 b=0dcrraQW0XlEgKFwxfjIY2b+yOki5Q0m49F6BKMsCca5UduIt1rKIEZonVggVHa25D7BlXwKAx7LWtO0ZBqSYMRPYpOCTuaisg+fbiLjX2GOO7jpcEgNDeG6iEpzFU3Kq+li2OI3JDt+EuG8+3IBrxOVbVbA1h9AOH9MzwGXduE=
Received: from SN6PR12MB2688.namprd12.prod.outlook.com (52.135.103.29) by
 SN6PR12MB2637.namprd12.prod.outlook.com (52.135.103.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 17:17:57 +0000
Received: from SN6PR12MB2688.namprd12.prod.outlook.com
 ([fe80::2cbf:7ce2:83f5:851c]) by SN6PR12MB2688.namprd12.prod.outlook.com
 ([fe80::2cbf:7ce2:83f5:851c%5]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 17:17:57 +0000
From:   "Singh, Brijesh" <brijesh.singh@amd.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
CC:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH 0/2] KVM: SVM: move the SEV command handling into a
 separate file
Thread-Topic: [PATCH 0/2] KVM: SVM: move the SEV command handling into a
 separate file
Thread-Index: AQHUuk3H4gJB1J4DqUi+VYhv1rGmf6XLQRAAgASldoA=
Date:   Mon, 4 Feb 2019 17:17:57 +0000
Message-ID: <82b462cf-6e94-0e59-2b98-01cc5acd6ede@amd.com>
References: <20190201164654.3888-1-brijesh.singh@amd.com>
 <20190201182040.GD12454@linux.intel.com>
In-Reply-To: <20190201182040.GD12454@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0079.namprd05.prod.outlook.com
 (2603:10b6:803:22::17) To SN6PR12MB2688.namprd12.prod.outlook.com
 (2603:10b6:805:6f::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2637;20:n6O85WE9sgBxSAPzHReskMwEpPa6Emxauy3oT2NI48xX+JyV3ZZFG7aIxg47C/MaQBqm8O3YxtKdm7Rfw+q8tG70GAIcuLag89NpFaqnzyMg4cavG7WbeY3E3ncxQnxDG2KTAABXbMB42oTidzt+fZ25s1xZPK04ksO2/HXuhxXNLChYBAQ2FKQjTwfTzfnMwQnRLMxZBhT6HDiJgBk4zPbohC+yf3glsaCDCVtDliyS/NuFgHGfteNkAAEr9PpG
x-ms-office365-filtering-correlation-id: e3f7811f-3a21-4365-ed6b-08d68ac4b4b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2637;
x-ms-traffictypediagnostic: SN6PR12MB2637:
x-microsoft-antispam-prvs: <SN6PR12MB263779507A527AAD867785D6E56D0@SN6PR12MB2637.namprd12.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(366004)(136003)(376002)(199004)(189003)(478600001)(2906002)(31686004)(76176011)(14454004)(71190400001)(71200400001)(66066001)(4744005)(52116002)(106356001)(99286004)(54906003)(229853002)(97736004)(316002)(105586002)(256004)(7736002)(53546011)(6486002)(6506007)(386003)(6246003)(305945005)(86362001)(102836004)(68736007)(6436002)(3846002)(6116002)(6512007)(8936002)(476003)(6916009)(36756003)(2616005)(26005)(53936002)(186003)(81156014)(81166006)(8676002)(4326008)(25786009)(31696002)(486006)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2637;H:SN6PR12MB2688.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j7tlpmZyTZfp9H8/LqFtsncIT6m9nhEzgS0WwZhUuqR6k/3aj/C6fZqjJ0vy2NDPP10ycacGbDtP+6W5Xhie4L4JSszerOWMiif6OY7F1/szQ8yb6qQYehG0fwL3AbBu6FfmjeFOmD+lIhInJNN2w6S78FUzyNaQLTSjH+QCmteR3VcdSiwfLwoQqFKrMBk03jPbuhvz7OvnxYuvLqjC8yptClwnEa6XkbRFqbH/avh0VYkMDj6t30+JHI4baQ5ErK8lJaoeHWeufMAeQAXeu+zdJrdAFPlSRCvaXvahl6QnFvJSnDMlGH8QKu/hEmMfnHUA8dQs28MNiQgoUHFbp0LJuIyoFnH9Kwr+fXlE5SuQbPfzpe0PAjNT6yHDuduBy6LSOM07EgY+YSWn2LU7CcvtTyZFGDSprApHbaoiRj4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <965CB03B1175C144AD6ECB3D1D89D9C2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f7811f-3a21-4365-ed6b-08d68ac4b4b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 17:17:56.6667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2637
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIvMS8xOSAxMjoyMCBQTSwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToNCj4gT24g
RnJpLCBGZWIgMDEsIDIwMTkgYXQgMDQ6NDc6MTJQTSArMDAwMCwgU2luZ2gsIEJyaWplc2ggd3Jv
dGU6DQo+PiBzdm0uYyBpcyBwcmV0dHkgaHVnZSwgYmVmb3JlIHdlIGFkZCBtb3JlIFNFViBzcGVj
aWZpYyBjb21tYW5kcyAoZS5nIFNFVi1FUywNCj4+IFNFVi1NaWdyYXRpb24gZXRjKSBsZXRzIG1v
dmUgdGhlIFNFViBjb21tYW5kIGhhbmRsaW5nIGludG8gYSBzZXBhcmF0ZSBmaWxlLg0KPj4gVGhl
cmUgaXMgbm8gbG9naWNhbCBjaGFuZ2VzIGluIHRoaXMgc2VyaWVzLg0KPiANCj4gQW55IHJlYXNv
biBub3QgdG8gY3JlYXRlIGFyY2gveDg2L2t2bS9zdm0vIGJlZm9yZSBpbnRyb2R1Y2luZyBzZXYu
Yz8NCj4gDQoNClRoZXJlIGFyZSBzZXZlcmFsIGZlYXR1cmVzIGluIHN2bS5jIHRoYXQgY2FuIGJl
IG1vdmVkIHRvIGRpZmZlcmVudA0KZmlsZXMsIFNFViBiaXRzIGFyZSBqdXN0IHRoZSBzdGFydC4g
SSB3YXMgdGhpbmtpbmcgdGhhdCB3ZSBjcmVhdGUNCnN2bSBkaXJlY3RvcnkgYWZ0ZXIgZmVhdHVy
ZXMgYXJlIHNlcGFyYXRlZCBpbiBkaWZmZXJlbnQgZmlsZXMgcmF0aGVyDQp0aGFuIGNyZWF0aW5n
IHRoZSBkaXJlY3RvcnkgZmlyc3QuIEhhdmluZyBzYWlkIHNvLCBJIGFtIG5vdCBvcHBvc2UNCnRv
IGNyZWF0aW5nIGRpcmVjdG9yeSBmaXJzdCB0aGVuIG1vdmluZyB0aGUgY29kZSBpbiBhIHNlcGFy
YXRlIGZpbGUuDQoNClBhb2xvLCBSYWRpbQ0KDQp0aG91Z2h0cyA/DQoNCnRoYW5rcw0K
