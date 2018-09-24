Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8A2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CDA2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="L1GA3yB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CDA2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbeIXUwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:51 -0400
Received: from mail-sn1nam01on0093.outbound.protection.outlook.com ([104.47.32.93]:29512
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729888AbeIXUws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QX2Rhu32MZqMW8U6HDL4F7cpymxAc4bGztBJ0r1/Sw=;
 b=L1GA3yB1fcoEpMmOBlcYqdFNEPMTL4tCySRPBmgnlps9FQm/6YWF8rfLNjRLR+J15+0CnfUD+A5P941um3tnasyT1aeFP65gFks3V7Ex/UyVYyJchjMZp0dMm8hn1cgUeefH6Q6asGLwGTTuEdWQXhv74j3Z82eGoy++ta6gBws=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefan Raspl <stefan.raspl@de.ibm.com>,
        Stefan Raspl <raspl@linux.vnet.ibm.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 19/36] tools/kvm_stat: fix handling of invalid
 paths in debugfs provider
Thread-Topic: [PATCH AUTOSEL 4.14 19/36] tools/kvm_stat: fix handling of
 invalid paths in debugfs provider
Thread-Index: AQHUVBW9O0XcL03fq02oLSQPNPuGRw==
Date:   Mon, 24 Sep 2018 14:49:04 +0000
Message-ID: <20180924144851.164533-19-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:10MaRUJCrFTuYsFhsJ5XayDqWzModPihRiMKGttUODPzaEhRpI0rqiN5PDKPf/Ae0/yV74iJL7a/dsjY+KrvPcT7Au2ORFty1mOo3+d6qUkZbtAWJTBhG6M9L8gcsf7H+qP5k/Zgy+YyW6gXieLY/hi90sN1cdvrt7XydXQma8LDaNDtn02sUC77Qmb1FLo/4yY5cpONfpnt8q8jxtBU4FDavWmwqzCBeAoUlWgy6eswvRH6YN0sZPIwZevnq25oc/ol6igQ2GEG07qHHQa5N4s7HadEIlvqv0d2fI1n/nfmB1CclToZR+sdzrvNff+b6s2bbC1yd5GxLlwf0pXAKNiSFzJd7a7EQ9vM5JVlWa+amYIvr1Slts/Liaq80isoapegRsweZjoeWMtv9FU0usPU3HnP7vU87ZpUCCGNNVN61JpQZ8apM3fFxCEsieXI48oc5ZBfyXgGoe5AKOepWw==;5:kP2PY+uU6xPbEikfFInMRRht73HVdl39/cvgfriwkP3cbLbdjeI+SXc/yxsKxvWjS32wNF+KvyutOdVA24HdRiuaGmy7T+g0EnxJ2eRKKGXeCw3FbtJy6hr7sIm8SjSXx/86c8FsJdmqyozWmYSeCj/hSzetY6f+1ZX7z1s0Dsc=;7:i8kYGH7+fVzU7PBkDdHEMD4JKO61W4JGJx1IRYDm9hJxv+Bqz2UD2Qs+Y26E7yhejQ+F3cO5wBckciA5iRjczf0PkOhX5ihE7kWIM6o8uUkNUt7wovnEAqsdXhZ72I+t1A9XDrAxzQl0aijZB2o66ZQvcM5XXANlPed8LXIh2yDDN3E0WPrXHlYcnZiegjz1AUALiXzSFKo0lR4F10oeaWdHAqaLET21cjBHiPV0hgTcDwHRYV1oKaNgbgsM9bU2
x-ms-office365-filtering-correlation-id: 000f3f24-1d13-4641-6f2c-08d6222d0a39
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0470ECCFCBFB2631DA51714FFB170@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190383065149520)(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(26005)(97736004)(53936002)(14444005)(25786009)(1076002)(76176011)(99286004)(102836004)(186003)(6666003)(4326008)(3846002)(110136005)(107886003)(86362001)(5660300001)(6116002)(72206003)(575784001)(54906003)(478600001)(8676002)(217873002)(86612001)(256004)(14454004)(10290500003)(316002)(6486002)(6436002)(106356001)(486006)(105586002)(446003)(6506007)(11346002)(476003)(10090500001)(2616005)(2501003)(5250100002)(71190400001)(68736007)(66066001)(81156014)(71200400001)(22452003)(7736002)(305945005)(2900100001)(8936002)(6512007)(81166006)(36756003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: d5EnQuycYs+kPB7j4BHltDRDkA3scThU5yNu6945BN+jhV//63KkkFbSOeh9MWT89wESJFxchqgHhjq3vJj0/HZS3R9rQNPWHnjSwsfAv/171KANt3/bMjWTl8Nvye0al5WKzAijA718OzfxqVuTSgX4qTf6JhEqme8HXtjPO2xgAaQ9oisegJ4N5zMvXmrzXTuP1Y7NuJsQ+jY+IDdyiMKfsQ4kMcuyx1x7kdOMPgSyRgJEKKKMOWxK15xah3L04EB4KrbOEoa2c8pwZL2XAtHx7xRkl3Ny8i2h4gkyjmg+dBL3GpGGtiz/gJw9F+EXNvLjD39ina1XzMVXIi9YdnlID072KSJiuwQ+EzewTMw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F22065AC8E0EC409B301E7340CE1A16@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000f3f24-1d13-4641-6f2c-08d6222d0a39
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:04.8426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
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
c3RhdC9rdm1fc3RhdCBiL3Rvb2xzL2t2bS9rdm1fc3RhdC9rdm1fc3RhdA0KaW5kZXggNDBjZjY0
YzdhYzNiLi5jMGQ2NTNkMzZjMGYgMTAwNzU1DQotLS0gYS90b29scy9rdm0va3ZtX3N0YXQva3Zt
X3N0YXQNCisrKyBiL3Rvb2xzL2t2bS9rdm1fc3RhdC9rdm1fc3RhdA0KQEAgLTczMSw2ICs3MzEs
MTMgQEAgY2xhc3MgRGVidWdmc1Byb3ZpZGVyKFByb3ZpZGVyKToNCiAgICAgICAgICAgICBzZWxm
LmRvX3JlYWQgPSBUcnVlDQogICAgICAgICBzZWxmLnJlc2V0KCkNCiANCisgICAgZGVmIF92ZXJp
ZnlfcGF0aHMoc2VsZik6DQorICAgICAgICAiIiJSZW1vdmUgaW52YWxpZCBwYXRocyIiIg0KKyAg
ICAgICAgZm9yIHBhdGggaW4gc2VsZi5wYXRoczoNCisgICAgICAgICAgICBpZiBub3Qgb3MucGF0
aC5leGlzdHMob3MucGF0aC5qb2luKFBBVEhfREVCVUdGU19LVk0sIHBhdGgpKToNCisgICAgICAg
ICAgICAgICAgc2VsZi5wYXRocy5yZW1vdmUocGF0aCkNCisgICAgICAgICAgICAgICAgY29udGlu
dWUNCisNCiAgICAgZGVmIHJlYWQoc2VsZiwgcmVzZXQ9MCwgYnlfZ3Vlc3Q9MCk6DQogICAgICAg
ICAiIiJSZXR1cm5zIGEgZGljdCB3aXRoIGZvcm1hdDonZmlsZSBuYW1lIC8gZmllbGQgLT4gY3Vy
cmVudCB2YWx1ZScuDQogDQpAQCAtNzQ1LDYgKzc1Miw3IEBAIGNsYXNzIERlYnVnZnNQcm92aWRl
cihQcm92aWRlcik6DQogICAgICAgICAjIElmIG5vIGRlYnVnZnMgZmlsdGVyaW5nIHN1cHBvcnQg
aXMgYXZhaWxhYmxlLCB0aGVuIGRvbid0IHJlYWQuDQogICAgICAgICBpZiBub3Qgc2VsZi5kb19y
ZWFkOg0KICAgICAgICAgICAgIHJldHVybiByZXN1bHRzDQorICAgICAgICBzZWxmLl92ZXJpZnlf
cGF0aHMoKQ0KIA0KICAgICAgICAgcGF0aHMgPSBzZWxmLnBhdGhzDQogICAgICAgICBpZiBzZWxm
Ll9waWQgPT0gMDoNCi0tIA0KMi4xNy4xDQo=
