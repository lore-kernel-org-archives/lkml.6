Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55800ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E3F208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YWmaA0as"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E3F208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbeIOGsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:37 -0400
Received: from mail-eopbgr720090.outbound.protection.outlook.com ([40.107.72.90]:59680
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728718AbeIOGse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1s7zsQ9IMSZZ5RvZNPLuZrpO8cmArpjoHPxFPYHmnU=;
 b=YWmaA0asZS9Rp0T9qxzL1nN+gALCeEJK7Cv1Mbi0PP62YPqzTwFaMVC3NWKoJSlPPIXNR3KLW5gDay0uxLftRWw85sofBGR/Ow/2a58X6tDkyUOxQ2WvswmtlzZSwBFrcQGmOrv/p3/ifubnbc99o+u9alPhoKmGiVufRBWTay8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:31:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Shaoyun Liu <Shaoyun.Liu@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 65/92] drm/amdkfd: Fix kernel queue 64 bit
 doorbell offset calculation
Thread-Topic: [PATCH AUTOSEL 4.18 65/92] drm/amdkfd: Fix kernel queue 64 bit
 doorbell offset calculation
Thread-Index: AQHUTJOy7oeF9QsZvU6UEPyYF/vIIg==
Date:   Sat, 15 Sep 2018 01:30:34 +0000
Message-ID: <20180915012944.179481-64-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:Iv6hqvLflQFC0EskA/MOSOmKhrB+oYz5QPKmVy15/ASYZhz2WRKzBPclfcLGbKa8YbdSAx9FPvpcH+zYmywWil2wGgzrGEzvNrVbea+ZZUW6htiukcvtsd/EgWbb6EfjFGdgicUHmuRdaVyjLm8SO2LHbO+JrXdkLYVdb3jfkldwloEXMeVxbVnqNDRJsDR4ZQSH7EmJ+LshuPTjBuQWyHHupiGkgToNmlyJi1kHiURY6VEs1MZCentaNjh96B0hyNvYJ9J8pS3K0YOMxYq4bcDaV77eaKniso6J+ycbbZwuiRgwf4Q8roNN10RT66fD4uUWd1KN3gcn+GvWdHtFw+OmS49FuLdzsZ1RUEOlJYLoW2Qbk95CI80Ed9TYTT+cTSwa0K0oYXoTLloJnykrTVSGVhZkfMVlikYzZ2trPCBytmMNRT/HW7xRbOxK+5Sn3PDeE01jrABpjTU5X9i26A==;5:6ltMv2VPAoo+z8UjBGlWdT3m/1unYol0Ori7+U614dHJuTyWjkZjiyMikvDu5DjQ1IU/lcJum7tCFrZ7f1NU2eoqVvUHEMrq54C2swxfMLRZOvLPY0dUH/uegyVaMkqjyKG7vq7o4wqdV+giNpZArgNcaMKmHgP4/3yclkV81BE=;7:sWlig8GFJYjGrkw0E0mDF2Xc9l3yX2c680xC7x+PUsEw/5M2qpdjax/GWt7hg1UFybUuUI8K+zBjqyxL59uzIHeXl+2NTHZbXy/Q75t2BwQS6S3JxCXbwLVvZ4zLy5WWYV5QJ3rLwPzVjJ1St4DpbEqMVD8iz7wc6repAUYsmDEMQ1DA8Gb1BlyN8k9jSSFUpVrBJ04XO3jcbC3K6EfSIYtLmLwyow8tLOaRRNkrlnMOyYUDENTl6y+s5733g3Sc
x-ms-office365-filtering-correlation-id: f895b0c6-b423-4d1a-75bd-08d61aaaf77c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB04702DB569A0BEB89DC60C71FB180@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(14444005)(6506007)(2501003)(2906002)(6486002)(6436002)(5250100002)(99286004)(486006)(14454004)(81156014)(26005)(81166006)(8936002)(6346003)(102836004)(8676002)(186003)(2616005)(476003)(446003)(10290500003)(11346002)(97736004)(478600001)(72206003)(10090500001)(105586002)(217873002)(36756003)(106356001)(22452003)(316002)(256004)(5660300001)(54906003)(110136005)(3846002)(6116002)(25786009)(66066001)(107886003)(4326008)(86362001)(2900100001)(39060400002)(68736007)(6512007)(53936002)(86612001)(76176011)(1076002)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: oe24xZGPfI3o90PitEb1Ckf4YBookJd0bJ6tY9mEb7EJm8VUai/KTozI3YPcABbIJgSK6Ik1YBA7uPhu6u5KJZ7irH5it2DTQNxj+6DM4gG5NxtbtzqPSgWOcXnLpiNm4kCHeyCoGtzHXCxy6uEaFChYkmFW+FloXZ8xdodio4cCXLnbPIvcvjr+Reeg9bgTLrytjb/qY1gI7n6pF+lly7eF+EGJvGrNE/x9KDDNmP2dToBPlGtLtcZefpTnRqBJY2vKWqzVyjUjDAuMsSoD28V1TRRQbmDpgj++O8eYQ6yYzz0vkf1dc+YgIp/HsXqfAqpi4fGEvRL6GZnlZk0mQVpRd1P0YaAieBFatSeYLlU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1518C90666030B47BB6A0B139FD6C9DF@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f895b0c6-b423-4d1a-75bd-08d61aaaf77c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:34.6824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU2hhb3l1biBMaXUgPFNoYW95dW4uTGl1QGFtZC5jb20+DQoNClsgVXBzdHJlYW0gY29t
bWl0IDk1MWRmNmQ5Y2ZkMDdmMjA1ZjE5MDViZjNiMjdkOTk0NjEyZTA2MTQgXQ0KDQpUaGUgYml0
bWFwIGluZGV4IGNhbGN1bGF0aW9uIHNob3VsZCByZXZlcnNlIHRoZSBsb2dpYyB1c2VkIG9uIGFs
bG9jYXRpb24NCnNvIGl0IHdpbGwgY2xlYXIgdGhlIHNhbWUgYml0IHVzZWQgb24gYWxsb2NhdGlv
bg0KDQpTaWduZWQtb2ZmLWJ5OiBTaGFveXVuIExpdSA8U2hhb3l1bi5MaXVAYW1kLmNvbT4NClJl
dmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NClNpZ25l
ZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KQWNrZWQt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NClNpZ25lZC1v
ZmYtYnk6IE9kZWQgR2FiYmF5IDxvZGVkLmdhYmJheUBnbWFpbC5jb20+DQpTaWduZWQtb2ZmLWJ5
OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZG9vcmJlbGwuYyB8IDkgKysrKystLS0tDQogMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kb29yYmVsbC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2Rvb3JiZWxsLmMNCmluZGV4IGMzNzQ0ZDg5MzUyYy4uZWJl
NzliZjAwMTQ1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2Rv
b3JiZWxsLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kb29yYmVsbC5j
DQpAQCAtMTg4LDkgKzE4OCw5IEBAIHZvaWQgX19pb21lbSAqa2ZkX2dldF9rZXJuZWxfZG9vcmJl
bGwoc3RydWN0IGtmZF9kZXYgKmtmZCwNCiAJKmRvb3JiZWxsX29mZiA9IGtmZC0+ZG9vcmJlbGxf
aWRfb2Zmc2V0ICsgaW54Ow0KIA0KIAlwcl9kZWJ1ZygiR2V0IGtlcm5lbCBxdWV1ZSBkb29yYmVs
bFxuIg0KLQkJCSAiICAgICBkb29yYmVsbCBvZmZzZXQgICA9PSAweCUwOFhcbiINCi0JCQkgIiAg
ICAga2VybmVsIGFkZHJlc3MgICAgPT0gJXBcbiIsDQotCQkqZG9vcmJlbGxfb2ZmLCAoa2ZkLT5k
b29yYmVsbF9rZXJuZWxfcHRyICsgaW54KSk7DQorCQkJIiAgICAgZG9vcmJlbGwgb2Zmc2V0ICAg
PT0gMHglMDhYXG4iDQorCQkJIiAgICAgZG9vcmJlbGwgaW5kZXggICAgPT0gMHgleFxuIiwNCisJ
CSpkb29yYmVsbF9vZmYsIGlueCk7DQogDQogCXJldHVybiBrZmQtPmRvb3JiZWxsX2tlcm5lbF9w
dHIgKyBpbng7DQogfQ0KQEAgLTE5OSw3ICsxOTksOCBAQCB2b2lkIGtmZF9yZWxlYXNlX2tlcm5l
bF9kb29yYmVsbChzdHJ1Y3Qga2ZkX2RldiAqa2ZkLCB1MzIgX19pb21lbSAqZGJfYWRkcikNCiB7
DQogCXVuc2lnbmVkIGludCBpbng7DQogDQotCWlueCA9ICh1bnNpZ25lZCBpbnQpKGRiX2FkZHIg
LSBrZmQtPmRvb3JiZWxsX2tlcm5lbF9wdHIpOw0KKwlpbnggPSAodW5zaWduZWQgaW50KShkYl9h
ZGRyIC0ga2ZkLT5kb29yYmVsbF9rZXJuZWxfcHRyKQ0KKwkJKiBzaXplb2YodTMyKSAvIGtmZC0+
ZGV2aWNlX2luZm8tPmRvb3JiZWxsX3NpemU7DQogDQogCW11dGV4X2xvY2soJmtmZC0+ZG9vcmJl
bGxfbXV0ZXgpOw0KIAlfX2NsZWFyX2JpdChpbngsIGtmZC0+ZG9vcmJlbGxfYXZhaWxhYmxlX2lu
ZGV4KTsNCi0tIA0KMi4xNy4xDQo=
