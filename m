Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522C0C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4344240B0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Se8s3NdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4344240B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754010AbeGEPBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:01:30 -0400
Received: from mail-eopbgr690135.outbound.protection.outlook.com ([40.107.69.135]:22560
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753617AbeGEPB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kgAYYhGb1nFJMEouAN+qkwGLOwZHqpF9XkGXbhR/kk=;
 b=Se8s3NdFwPsq3RZDl8KQPjdTXVdglSMCmS/EW+FvE5BfTQfHjaNKbETNiwtaN43UymgWHmNU5ZaWdSgPG/EJndBLnTQFb3AykK3VKgZZSIVj8BXLN8UfA4++EBtXcDfvad1Ty8eBSY9zqYZbgwiWPBpRVkbNpg9IMpZHYygTAK0=
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) by
 MW2PR2101MB1130.namprd21.prod.outlook.com (52.132.146.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.6; Thu, 5 Jul 2018 15:01:26 +0000
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::948d:3fab:e048:bb9b]) by MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::948d:3fab:e048:bb9b%2]) with mapi id 15.20.0952.008; Thu, 5 Jul 2018
 15:01:26 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH 1/1] X86/Hyper-V:: Fix the circular dependency in IPI
 enlightenment.
Thread-Topic: [PATCH 1/1] X86/Hyper-V:: Fix the circular dependency in IPI
 enlightenment.
Thread-Index: AQHUEyH9R1sw7hnGhUy3uKImudYi5KR/PNWAgAF9s6A=
Date:   Thu, 5 Jul 2018 15:01:26 +0000
Message-ID: <MW2PR2101MB111396005B0F5572C92B4CD7A0400@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180703230155.15160-1-kys@linuxonhyperv.com>
 <20180704161039.GA23658@gmail.com>
In-Reply-To: <20180704161039.GA23658@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:a888:e24c:cce5:d4ed]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1130;7:k0jfNZiZnKPVmwjmeCZ/aB6TRIVC/LOpXFqZtzyo4XMn/soDHDQsUiJQFbp9STGQOBMIf7VPj+DHmlZOhXjX3wTNaXHUp4a+GXka5yLXr7YrAVj+O14kaSXZANlNBzONaah5rpHTJK7SuO2KWMTsltaPDHN+o4IkwKMEkcudF/RrNEPxkkIwziy0/D1V6rawNmMIlqWLaaEoh71pawW5O4ZKx80+HMsN7br+tdCLWIln0b1iQN1OsR8eemK5I8MG
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cb1066a4-5ac1-42cd-a710-08d5e2882e46
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:MW2PR2101MB1130;
x-ms-traffictypediagnostic: MW2PR2101MB1130:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB113037C004B09122618C727DA0400@MW2PR2101MB1130.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231280)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1130;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1130;
x-forefront-prvs: 0724FCD4CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(376002)(396003)(39860400002)(199004)(189003)(13464003)(7416002)(6916009)(186003)(46003)(8936002)(53936002)(102836004)(10090500001)(5250100002)(8676002)(2906002)(2900100001)(6436002)(97736004)(7736002)(5660300001)(478600001)(10290500003)(14444005)(256004)(305945005)(81156014)(81166006)(14454004)(229853002)(486006)(55016002)(76176011)(9686003)(7696005)(6506007)(53546011)(8990500004)(74316002)(86362001)(476003)(6116002)(54906003)(446003)(11346002)(33656002)(4326008)(68736007)(22452003)(6246003)(99286004)(106356001)(25786009)(105586002)(316002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1130;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fW8EjAjpDsPbcCT+0HHu28pwxv3t7iInKuDUcOUX7qAqxuSd+kBw7Wv0cH+cjvJgmmxI7TcJmvTjEl0+KIlzReZ7Mri6CXPzpPJ5oNjDDIA2W6bMM5ExgWFtzyWimVVanWvgwrKvN9rxi4hDVq28sHRsy/epvzFd2waj4QrK/NbCVjTu3u1WwI7hgY+PaYOBm6p4iMABpC5hezETT8P0qce4pZbHebjoeZIuhu2MdqpVn9Uro1wMdp/5qYiB5iVwMp3Epk9/QdvF/uQZLo4dWcoj8HAldy+rpG+JuFSrHIqcEt8u4onxvyjYVpT8f+SQPz+mVI5OduGfWgZc1MqS0h+saveYAFUt/K7Upu7OJow=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1066a4-5ac1-42cd-a710-08d5e2882e46
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2018 15:01:26.1074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW5nbyBNb2xuYXIgPG1p
bmdvLmtlcm5lbC5vcmdAZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgSW5nbyBNb2xuYXINCj4gU2Vu
dDogV2VkbmVzZGF5LCBKdWx5IDQsIDIwMTggOToxMSBBTQ0KPiBUbzogS1kgU3Jpbml2YXNhbiA8
a3lzQG1pY3Jvc29mdC5jb20+DQo+IENjOiB4ODZAa2VybmVsLm9yZzsgZ3JlZ2toQGxpbnV4Zm91
bmRhdGlvbi5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZlbEBsaW51
eGRyaXZlcnByb2plY3Qub3JnOyBvbGFmQGFlcGZsZS5kZTsNCj4gYXB3QGNhbm9uaWNhbC5jb207
IGphc293YW5nQHJlZGhhdC5jb207IHRnbHhAbGludXRyb25peC5kZTsNCj4gaHBhQHp5dG9yLmNv
bTsgU3RlcGhlbiBIZW1taW5nZXIgPHN0aGVtbWluQG1pY3Jvc29mdC5jb20+OyBNaWNoYWVsDQo+
IEtlbGxleSAoRU9TRykgPE1pY2hhZWwuSC5LZWxsZXlAbWljcm9zb2Z0LmNvbT47IHZrdXpuZXRz
QHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzFdIFg4Ni9IeXBlci1WOjogRml4
IHRoZSBjaXJjdWxhciBkZXBlbmRlbmN5IGluIElQSQ0KPiBlbmxpZ2h0ZW5tZW50Lg0KPiANCj4g
DQo+ICoga3lzQGxpbnV4b25oeXBlcnYuY29tIDxreXNAbGludXhvbmh5cGVydi5jb20+IHdyb3Rl
Og0KPiANCj4gPiBGcm9tOiAiSy4gWS4gU3Jpbml2YXNhbiIgPGt5c0BtaWNyb3NvZnQuY29tPg0K
PiA+DQo+ID4gVGhlIElQSSBoeXBlcmNhbGxzIGRlcGVuZCBvbiBiZWluZyBhYmxlIHRvIG1hcCB0
aGUgTGludXggbm90aW9uIG9mIENQVSBJRA0KPiA+IHRvIHRoZSBoeXBlcnZpc29yJ3Mgbm90aW9u
IG9mIHRoZSBDUFUgSUQuIFRoZSBhcnJheSBodl92cF9pbmRleFtdIHByb3ZpZGVzDQo+ID4gdGhp
cyBtYXBwaW5nLiBDb2RlIGZvciBwb3B1bGF0aW5nIHRoaXMgYXJyYXkgZGVwZW5kcyBvbiB0aGUg
SVBJDQo+IGZ1bmN0aW9uYWxpdHkuDQo+ID4gQnJlYWsgdGhpcyBjaXJjdWxhciBkZXBlbmRlbmN5
Lg0KPiA+DQo+ID4gRml4ZXM6IDY4YmI3YmZiNzk4NSAoIlg4Ni9IeXBlci1WOiBFbmFibGUgSVBJ
IGVubGlnaHRlbm1lbnRzIikNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEsuIFkuIFNyaW5pdmFz
YW4gPGt5c0BtaWNyb3NvZnQuY29tPg0KPiA+IFRlc3RlZC1ieTogTWljaGFlbCBLZWxsZXkgPG1p
a2VsbGV5QG1pY3Jvc29mdC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gveDg2L2h5cGVydi9odl9h
cGljLmMgICAgICAgfCA1ICsrKysrDQo+ID4gIGFyY2gveDg2L2h5cGVydi9odl9pbml0LmMgICAg
ICAgfCA1ICsrKystDQo+ID4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL21zaHlwZXJ2LmggfCAyICsr
DQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gVWdoLCB0aGlzIHBhdGNoIHdhc24ndCBldmVuIGJ1aWxkIHRlc3RlZCwgb24gNjQtYml0
IGFsbHllcy9hbGxtb2Rjb25maWc6DQo+IA0KPiAgYXJjaC94ODYvaHlwZXJ2L2h2X2FwaWMuYzog
SW4gZnVuY3Rpb24g4oCYX19zZW5kX2lwaV9tYXNr4oCZOg0KPiAgYXJjaC94ODYvaHlwZXJ2L2h2
X2FwaWMuYzoxNzE6NDogZXJyb3I6IGxhYmVsIOKAmGlwaV9tYXNrX2RvbmXigJkgdXNlZCBidXQg
bm90DQo+IGRlZmluZWQNCj4gIHNjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MzE3OiByZWNpcGUgZm9y
IHRhcmdldCAnYXJjaC94ODYvaHlwZXJ2L2h2X2FwaWMubycNCj4gZmFpbGVkDQo+ICBtYWtlWzJd
OiAqKiogW2FyY2gveDg2L2h5cGVydi9odl9hcGljLm9dIEVycm9yIDENCg0KU29ycnkgSW5nby4g
SSBoYWQgYSBjbGVhbiBidWlsZCBvbiB0aGUgbGludXgtbmV4dCB0cmVlICh0YWc6IG5leHQtMjAx
ODA3MDIpIHRoYXQNCkkgdXNlZCB0byBiYXNlIHRoaXMgcGF0Y2guIFdoYXQgd2FzIHRoZSB0cmVl
IHlvdSBhcHBsaWVkIHRoZSBwYXRjaCB0bz8NCg0KUmVnYXJkcywNCg0KSy4gWQ0KDQo+IA0KPiBU
aGFua3MsDQo+IA0KPiAJSW5nbw0K
