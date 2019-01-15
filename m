Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE7AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BACD20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="I6Z0RGMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389302AbfAOTWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:22:42 -0500
Received: from mail-eopbgr690134.outbound.protection.outlook.com ([40.107.69.134]:21536
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729633AbfAOTWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbwdLynnZRjDMMo1n6cxSnm4F/tXmCmoQURod6fuel0=;
 b=I6Z0RGMh/WFDtORcaSHsOGyGJzkqrmCV6ctid47Mn0RW3xtZ5HmqZZn64XJrWCSWtgCFx9X2hB5SPi+Gr2P2baRGi48GJ/zS5hC9+32aiJCKza8F1uJJ0rpBxP8LzCz78h6es+aEOil5Mg2KwOowUwLilgrdZ84hkFODimcjI34=
Received: from DM5PR21MB0140.namprd21.prod.outlook.com (10.173.173.15) by
 DM5PR21MB0748.namprd21.prod.outlook.com (10.173.172.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.1; Tue, 15 Jan 2019 19:22:38 +0000
Received: from DM5PR21MB0140.namprd21.prod.outlook.com
 ([fe80::9df0:5a3b:d34b:d743]) by DM5PR21MB0140.namprd21.prod.outlook.com
 ([fe80::9df0:5a3b:d34b:d743%8]) with mapi id 15.20.1558.000; Tue, 15 Jan 2019
 19:22:38 +0000
From:   Pavel Shilovskiy <pshilov@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Steven French <Steven.French@microsoft.com>
Subject: RE: [PATCH 4.20 14/57] CIFS: Do not hide EINTR after sending network
 packets
Thread-Topic: [PATCH 4.20 14/57] CIFS: Do not hide EINTR after sending network
 packets
Thread-Index: AQHUrPGCvdkgU4wjYEmugh+fAURZnqWwtIwQ
Date:   Tue, 15 Jan 2019 19:22:38 +0000
Message-ID: <DM5PR21MB01406D74FDA02D9311CDF4B4B6810@DM5PR21MB0140.namprd21.prod.outlook.com>
References: <20190115154910.734892368@linuxfoundation.org>
 <20190115154911.514830122@linuxfoundation.org>
In-Reply-To: <20190115154911.514830122@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:8:ffcc:aaf2:f39b:be02]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0748;6:UFwuUWEm6ObkPSxdw+JLUABho9nArR7wuFiw+3tDIoMsA9Tm/gX7wXDQ80L0qeCXLh5mUb9JSLeHhSWTtpGrZae6NSEflFU155EqWVBxXFOJEiGh+qC+Lrw/u4Nh3z4lnqOCJ0Cc1JFo05Cz/FajiDYo6xpg4QkGBpuYU6qzRHkxepVXUc+cHMh9pIONgTpz1chsBkI7hvs2BUL6Nbn3eU7bM7ad2AoV4L4bH+hQKDl3kVXhJJmGTRRMpymgTRIl0O5VY/C6FzeLqkUI1BDM8mm2X9LBLmQzzl8JgZVCGHawlrGDmfuMxKa9wj5/8pH2otrE8SHJvHyJz4mHj3tyBQqBOBOseMih2/8+aPeuajFu4hl4+5CETZVAWxHuiXXxQM2OeKX92ZqXPfUeX2SPp076AMN0dMkHTb5Ojq0F0eXmxKhgw3VJFFC7Pd6b0i+GU0yD+snbWDasCVYxLnmPOg==;5:FqOrsY+4zYCv3OoeIc7VB9oABE6/BDEix3ZFh1MgNHutzq+sVgaXqcK5LQlBHePyPi6XQqQKqE3YHejoTEEKe8iGXHUdMoQv2gMmXFf9l2udzc6c6yQgCrVEYDQY8X6yz6aT1SbXIeBJfgS9IMk1RKW1HE4Vz5fgJqytIGxCSyM5a/fvTM/tu0OieL0W3UfoSD7RSO4uX2NNs1ye1GcplQ==;7:I72FaAUn3LW9KLTGqJF3StArdKaxBgq9/TY4GssEXcIpvnD6NXV3WXtshkW6losvWbOBYEEaw8B7xqZd9Jvi+e03MG/dDOCVpaXK6HXqZxAqJe2X/V01q1GZdqfI/LIEdAzUE0E886L8sDUBK13UsQ==
x-ms-office365-filtering-correlation-id: dcf354fd-e91f-4ed1-c3c1-08d67b1ecfe6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR21MB0748;
x-ms-traffictypediagnostic: DM5PR21MB0748:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pshilov@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB07486F2958896A8F3FC6AD47B6810@DM5PR21MB0748.namprd21.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(39860400002)(396003)(189003)(199004)(13464003)(76176011)(14454004)(22452003)(305945005)(8936002)(74316002)(81166006)(8990500004)(81156014)(7696005)(229853002)(25786009)(2906002)(14444005)(86612001)(256004)(86362001)(106356001)(46003)(486006)(476003)(105586002)(71200400001)(2501003)(10090500001)(71190400001)(11346002)(446003)(7736002)(68736007)(33656002)(9686003)(54906003)(6506007)(102836004)(97736004)(478600001)(6436002)(107886003)(53936002)(5660300001)(316002)(99286004)(186003)(10290500003)(6246003)(55016002)(53546011)(4326008)(8676002)(6116002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0748;H:DM5PR21MB0140.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2tAgLiPh0huC4E6AOulUNY2NQpSRi7f9BE21SYOrpckBa6cCLAOlLuXaCfMGoZQ17U36aIHpog3NhUu1FmlSbBVLM74Ry/yMftW32B0DKvNgm0EnvYw/W1UzydKWR8S1dnwQZv2W/8YQewtb4Od0Z7H7sZTp3nf/5VctazB8qw3r2HLywIbnfdC/zQhTmB7vGXY0qQ9IeFGj8lrG4+gIdcAt/xrNWbp95r+DzaCKuXkg2Cdkx+jQQ2Zy7WgGL9D5s59L/LxOAwY8MIeB/O8KZq08m3pxUhTS5A7TGkMhHFWu+p44rVZvKJG2blFf08hhDcRnWqvNvrBMBYlprQRx1Pm7sKPMOCHkkQ2rbJiPb+3mGTxen4T/mClQ5ODgUGgwUi/VRR6Ct7D3xwwQIKvi/DXmf+sXMr9NF5Edd8VPj2k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf354fd-e91f-4ed1-c3c1-08d67b1ecfe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 19:22:38.5605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0748
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KSSBhbSB3b25kZXJpbmcgaWYgaXQgaXMgcG9zc2libGUgdG8gaW5jbHVkZSBl
eGFjdCBzdGFibGUga2VybmVsIHZlcnNpb24gKGUuZy4gNC4yMC4zIGluIHRoaXMgY2FzZSkgaW4g
dGhlIGVtYWlsLiBUaGlzIHdvdWxkIGhlbHAgdG8gcXVpY2tseSB1bmRlcnN0YW5kIHdoaWNoIGtl
cm5lbCB2ZXJzaW9uIHNob3VsZCBiZSBpbnN0YWxsZWQgaW4gb3JkZXIgdG8gZ2V0IHRoZSBmaXgu
DQoNCkJlc3QgcmVnYXJkcywNClBhdmVsIFNoaWxvdnNreQ0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz4gDQpTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDE1LCAyMDE5IDg6MzYgQU0NClRvOiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZz47IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc7IFBhdmVsIFNoaWxv
dnNraXkgPHBzaGlsb3ZAbWljcm9zb2Z0LmNvbT47IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5l
bC5vcmc+OyBTdGV2ZW4gRnJlbmNoIDxTdGV2ZW4uRnJlbmNoQG1pY3Jvc29mdC5jb20+DQpTdWJq
ZWN0OiBbUEFUQ0ggNC4yMCAxNC81N10gQ0lGUzogRG8gbm90IGhpZGUgRUlOVFIgYWZ0ZXIgc2Vu
ZGluZyBuZXR3b3JrIHBhY2tldHMNCg0KNC4yMC1zdGFibGUgcmV2aWV3IHBhdGNoLiAgSWYgYW55
b25lIGhhcyBhbnkgb2JqZWN0aW9ucywgcGxlYXNlIGxldCBtZSBrbm93Lg0KDQotLS0tLS0tLS0t
LS0tLS0tLS0NCg0KRnJvbTogUGF2ZWwgU2hpbG92c2t5IDxwc2hpbG92QG1pY3Jvc29mdC5jb20+
DQoNCmNvbW1pdCBlZTEzOTE5YzJlOGQxZjkwNGUwMzVhZDRiNDIzOTAyOWE4OTk0MTMxIHVwc3Ry
ZWFtLg0KDQpDdXJyZW50bHkgd2UgaGlkZSBFSU5UUiBjb2RlIHJldHVybmVkIGZyb20gc29ja19z
ZW5kbXNnKCkgYW5kIHJldHVybiAwIGluc3RlYWQuIFRoaXMgbWFrZXMgYSBjYWxsZXIgdGhpbmsg
dGhhdCB3ZSBzdWNjZXNzZnVsbHkgY29tcGxldGVkIHRoZSBuZXR3b3JrIG9wZXJhdGlvbiB3aGlj
aCBpcyBub3QgdHJ1ZS4gRml4IHRoaXMgYnkgcHJvcGVybHkgcmV0dXJuaW5nIEVJTlRSIHRvIGNh
bGxlcnMuDQoNCkNjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6IFBh
dmVsIFNoaWxvdnNreSA8cHNoaWxvdkBtaWNyb3NvZnQuY29tPg0KUmV2aWV3ZWQtYnk6IEplZmYg
TGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBTdGV2ZSBGcmVuY2gg
PHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBHcmVnIEtyb2FoLUhhcnRt
YW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KDQotLS0NCiBmcy9jaWZzL3RyYW5zcG9y
dC5jIHwgICAgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KDQotLS0gYS9mcy9jaWZzL3RyYW5zcG9ydC5jDQorKysgYi9mcy9jaWZzL3RyYW5zcG9y
dC5jDQpAQCAtMzg1LDcgKzM4NSw3IEBAIHNtYmRfZG9uZToNCiAJaWYgKHJjIDwgMCAmJiByYyAh
PSAtRUlOVFIpDQogCQljaWZzX2RiZyhWRlMsICJFcnJvciAlZCBzZW5kaW5nIGRhdGEgb24gc29j
a2V0IHRvIHNlcnZlclxuIiwNCiAJCQkgcmMpOw0KLQllbHNlDQorCWVsc2UgaWYgKHJjID4gMCkN
CiAJCXJjID0gMDsNCiANCiAJcmV0dXJuIHJjOw0KDQoNCg==
