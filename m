Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F5CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FA32064D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Sg0CfFr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00FA32064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbeIXUvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:51:38 -0400
Received: from mail-eopbgr710090.outbound.protection.outlook.com ([40.107.71.90]:26752
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732952AbeIXUvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZXiIuAW9fkcWQJ9GaPe/hNbGbywc8hN+7xKhIk2XDM=;
 b=Sg0CfFr7HSk7ODtxZFbEUbLV2aLYb9pIfmJAj/UUXIqRwtFrzqTjl4ad/UuKeNsAiCHY3ITsNf1gFsifLiBrgSrARLSq+jzrNYiczCnDYJfN/wjXBkV8GvxIv/yD3Z2l+XK9BVVZUF0SJ8CLPAb93DBE543OmgUoDkP+u1+omUU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.5; Mon, 24 Sep 2018 14:48:54 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefan Raspl <stefan.raspl@de.ibm.com>,
        Stefan Raspl <raspl@linux.vnet.ibm.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 40/76] tools/kvm_stat: fix handling of invalid
 paths in debugfs provider
Thread-Topic: [PATCH AUTOSEL 4.18 40/76] tools/kvm_stat: fix handling of
 invalid paths in debugfs provider
Thread-Index: AQHUVBWmoAlCDeTGSkKMuKR+phrnIQ==
Date:   Mon, 24 Sep 2018 14:48:26 +0000
Message-ID: <20180924144751.164410-39-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:ggsyZ7R5vo6YAjDmzcz3oqb7pV52jd/iStjlyPMchl4vCkunRSnAoPD46D9nbhaPCdrdgct/N7RppPfFOLQUm1jft+ytub4trEr/VOpk7Ym3NCoLn9yQzNG3dMqOVMmzKfFkZ91sEOAksT0WpDeGzuUTPd9laTdVv0Y5xu5b2/BDa4lZS2QDfvvi5fXxVW7i/omQinxInZ+H4QnFHeMlNMgf3LDHiRFMXYf8slMhC+k82n7Cxuaq5PijJmVoQL07aXghsHu81kZzF96xR0LR1paCCWPCC+XE528N6svwrHdJxukOcyI2uCC7lcg3SPFHaGrIsKsfMMzfyV5C/T83Y15bsuR/SXxsql+6XNcfpFuzID/kbqy7L39spD+MaZRJ6SM9fpNJH4oFQ/TZkYG50BN3ZrC4LrC8UvQ5bSMy7/d66SY/Qct8mVz4ildvZgWKG+So42UlNGcbcea1XLYIeg==;5:rWlCw5LJBhScId5eY/LH4yGqk2H4Y1eyOtqZ4Ty4hd4Idp8HlSFL7zj/E/tpXHkJUUwjZL/9cnfQqRs3OO51A/nwSpuLQdWgp6A36ss7IynlL+nIdj+CWrBbkVbm+DUFFjHPOtHlqNog1aV2RycFzj/nyoTEHfYoVD/TPCJY79c=;7:CvwUtBcC5Dmo96powZ6oP04h8FQW5sZ8SLm9sgZrG3TYi5UgVO82N35N4NpBUHllEKz6VDl/G/P0qrX9/KhJ8S5DIXlbylLvKdKenyOy4unrKbDcahIlq+yU7dZVEFIKdO5TIRpzGWHkPgXYTG/SM2WtMThp6tgzLmrXHrgrhewR3giJrs9BnISmaMuXMFrD0bgkuIp2p1nnzmcLAvmfL15T025HPMwcIr1Z6r85Nm/oUwR/yAJCm163RgvG4THf
x-ms-office365-filtering-correlation-id: 0dfff33a-fb07-4e7a-3f69-08d6222cd989
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0855FF858FEBF808D744F22EFB170@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190383065149520)(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(486006)(81166006)(6436002)(110136005)(54906003)(10290500003)(6666003)(86362001)(446003)(575784001)(6486002)(68736007)(2900100001)(86612001)(476003)(6512007)(1076002)(2616005)(305945005)(81156014)(105586002)(10090500001)(14454004)(71200400001)(106356001)(316002)(7736002)(71190400001)(478600001)(11346002)(6116002)(8936002)(5660300001)(3846002)(72206003)(97736004)(8676002)(6506007)(25786009)(36756003)(66066001)(2906002)(5250100002)(76176011)(26005)(14444005)(217873002)(107886003)(186003)(256004)(102836004)(22452003)(2501003)(99286004)(53936002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: k13EqoJ/78LWhZcOUu0wgspQPjNJhsIq2iXLWFOcq0Gy5fMlJMlf6waaiGAMdApOLDNSC7KvxIVlta3DvFPhUNaq22tFe2HFOr8RqIBkkLr3AL123GQQprNHKNR6OebgkpNFnggiYSfTUpj5s/XlpNhvjYs9o9vB2N0ivu1njeDjeyT/gTV9UcAlWWNSe4uw/h+AfKOAgqdjzMrz3BVCUAY/oEqGC39HXl6XeGgVHvUFcSf5hbMWfwRY24bXKPDs0P8UCwivJgj8wPw9FFhDMSkonqvJ3dP71PNgW5v8RxAO4d5ZgCpVlIo2WAFTPupkWSGeyM9m17VdiGjAycJf9VKfWWTifTphwwVdTaQGDHY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B89E9D2B44BB654982C88CF64268B03A@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfff33a-fb07-4e7a-3f69-08d6222cd989
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:26.7092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3RlZmFuIFJhc3BsIDxzdGVmYW4ucmFzcGxAZGUuaWJtLmNvbT4NCg0KWyBVcHN0cmVh
bSBjb21taXQgNjE3YzY2YjlmMjM2ZDIwZjExY2VjYmIzZjQ1ZTZkNTY3NWIyZmFlMSBdDQoNCldo
ZW4gZmlsdGVyaW5nIGJ5IGd1ZXN0LCBrdm1fc3RhdCBkaXNwbGF5cyBnYXJiYWdlIHdoZW4gdGhl
IGd1ZXN0IGlzDQpkZXN0cm95ZWQgLSBzZWUgc2FtcGxlIG91dHB1dCBiZWxvdy4NCldlIGFkZCBj
b2RlIHRvIHJlbW92ZSB0aGUgaW52YWxpZCBwYXRocyBmcm9tIHRoZSBwcm92aWRlcnMsIHNvIGF0
IGxlYXN0DQpubyBtb3JlIGdhcmJhZ2UgaXMgZGlzcGxheWVkLg0KSGVyZSdzIGEgc2FtcGxlIG91
dHB1dCB0byBpbGx1c3RyYXRlOg0KDQogIGt2bSBzdGF0aXN0aWNzIC0gcGlkIDEzOTg2IChmb28p
DQoNCiAgIEV2ZW50ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBUb3Rh
bCAlVG90YWwgQ3VyQXZnL3MNCiAgIGRpYWdub3NlXzI1OCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAtMiAgICAwLjAgICAgICAgIDANCiAgIGRlbGl2ZXJfcHJvZ3JhbV9pbnRl
cnJ1cHRpb24gICAgICAgICAgICAgICAgICAgICAtMyAgICAwLjAgICAgICAgIDANCiAgIGRpYWdu
b3NlXzMwOCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtNCAgICAwLjAgICAg
ICAgIDANCiAgIGhhbHRfcG9sbF9pbnZhbGlkICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC05MSAgICAwLjAgICAgICAgLTYNCiAgIGRlbGl2ZXJfc2VydmljZV9zaWduYWwgICAgICAgICAg
ICAgICAgICAgICAgICAgLTI0NCAgICAwLjAgICAgICAtMTYNCiAgIGhhbHRfc3VjY2Vzc2Z1bF9w
b2xsICAgICAgICAgICAgICAgICAgICAgICAgICAgLTI1MCAgICAwLjEgICAgICAtMTcNCiAgIGV4
aXRfcGVpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLTI4NSAgICAwLjEg
ICAgICAtMTkNCiAgIGV4aXRfZXh0ZXJuYWxfcmVxdWVzdCAgICAgICAgICAgICAgICAgICAgICAg
ICAgLTMxMiAgICAwLjEgICAgICAtMjENCiAgIGRpYWdub3NlXzljICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgLTMyOCAgICAwLjEgICAgICAtMjINCiAgIHVzZXJzcGFjZV9oYW5k
bGVkICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLTcxMyAgICAwLjEgICAgICAtNDcNCiAg
IGhhbHRfYXR0ZW1wdGVkX3BvbGwgICAgICAgICAgICAgICAgICAgICAgICAgICAgLTkzOSAgICAw
LjIgICAgICAtNjINCiAgIGRlbGl2ZXJfZW1lcmdlbmN5X3NpZ25hbCAgICAgICAgICAgICAgICAg
ICAgICAtMzEyNiAgICAwLjYgICAgIC0yMDgNCiAgIGhhbHRfd2FrZXVwICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAtNzE5OSAgICAxLjUgICAgIC00ODENCiAgIGV4aXRfd2FpdF9z
dGF0ZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtNzM3OSAgICAxLjUgICAgIC00OTMN
CiAgIGRpYWdub3NlXzUwMCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC01NjQ5OSAg
IDExLjUgICAgLTM3NTcNCiAgIGV4aXRfbnVsbCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIC04NTQ5MSAgIDE3LjQgICAgLTU2ODUNCiAgIGRpYWdub3NlXzQ0ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgLTEzMzMwMCAgIDI3LjEgICAgLTg4NzQNCiAgIGV4aXRfaW5z
dHJ1Y3Rpb24gICAgICAgICAgICAgICAgICAgICAgICAgICAgLTE5NTg5OCAgIDM5LjggICAtMTMw
MzcNCiAgIFRvdGFsICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLTQ5MjA2
Mw0KDQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gUmFzcGwgPHJhc3BsQGxpbnV4LnZuZXQuaWJtLmNv
bT4NClNpZ25lZC1vZmYtYnk6IFJhZGltIEtyxI1tw6HFmSA8cmtyY21hckByZWRoYXQuY29tPg0K
U2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29t
Pg0KLS0tDQogdG9vbHMva3ZtL2t2bV9zdGF0L2t2bV9zdGF0IHwgOCArKysrKysrKw0KIDEgZmls
ZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL3Rvb2xzL2t2bS9rdm1f
c3RhdC9rdm1fc3RhdCBiL3Rvb2xzL2t2bS9rdm1fc3RhdC9rdm1fc3RhdA0KaW5kZXggZTEwYjkw
YTg5MTdhLi5iOWU4ZDBkZWYxYWIgMTAwNzU1DQotLS0gYS90b29scy9rdm0va3ZtX3N0YXQva3Zt
X3N0YXQNCisrKyBiL3Rvb2xzL2t2bS9rdm1fc3RhdC9rdm1fc3RhdA0KQEAgLTc2Niw2ICs3NjYs
MTMgQEAgY2xhc3MgRGVidWdmc1Byb3ZpZGVyKFByb3ZpZGVyKToNCiAgICAgICAgICAgICBzZWxm
LmRvX3JlYWQgPSBUcnVlDQogICAgICAgICBzZWxmLnJlc2V0KCkNCiANCisgICAgZGVmIF92ZXJp
ZnlfcGF0aHMoc2VsZik6DQorICAgICAgICAiIiJSZW1vdmUgaW52YWxpZCBwYXRocyIiIg0KKyAg
ICAgICAgZm9yIHBhdGggaW4gc2VsZi5wYXRoczoNCisgICAgICAgICAgICBpZiBub3Qgb3MucGF0
aC5leGlzdHMob3MucGF0aC5qb2luKFBBVEhfREVCVUdGU19LVk0sIHBhdGgpKToNCisgICAgICAg
ICAgICAgICAgc2VsZi5wYXRocy5yZW1vdmUocGF0aCkNCisgICAgICAgICAgICAgICAgY29udGlu
dWUNCisNCiAgICAgZGVmIHJlYWQoc2VsZiwgcmVzZXQ9MCwgYnlfZ3Vlc3Q9MCk6DQogICAgICAg
ICAiIiJSZXR1cm5zIGEgZGljdCB3aXRoIGZvcm1hdDonZmlsZSBuYW1lIC8gZmllbGQgLT4gY3Vy
cmVudCB2YWx1ZScuDQogDQpAQCAtNzgwLDYgKzc4Nyw3IEBAIGNsYXNzIERlYnVnZnNQcm92aWRl
cihQcm92aWRlcik6DQogICAgICAgICAjIElmIG5vIGRlYnVnZnMgZmlsdGVyaW5nIHN1cHBvcnQg
aXMgYXZhaWxhYmxlLCB0aGVuIGRvbid0IHJlYWQuDQogICAgICAgICBpZiBub3Qgc2VsZi5kb19y
ZWFkOg0KICAgICAgICAgICAgIHJldHVybiByZXN1bHRzDQorICAgICAgICBzZWxmLl92ZXJpZnlf
cGF0aHMoKQ0KIA0KICAgICAgICAgcGF0aHMgPSBzZWxmLnBhdGhzDQogICAgICAgICBpZiBzZWxm
Ll9waWQgPT0gMDoNCi0tIA0KMi4xNy4xDQo=
