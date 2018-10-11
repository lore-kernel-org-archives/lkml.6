Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D76C67837
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A096320841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TxnoQPmZ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="JIxUKAK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A096320841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeJLFl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:41:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60870 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbeJLFl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:41:59 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BM8pwj009983;
        Thu, 11 Oct 2018 15:12:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=LF4JfvNVT9dqa3fXfsb+e9OeYfo94FyWAxwiLXqRoEY=;
 b=TxnoQPmZUuLllGXj3Mb8nKeYNUCuscNauVd/BmTKEn/AU6+6curzUC9sZDtM7RUTDjHM
 8BgYUJJubsa27t5zl+Jl1DU3ff29TvAAaPKlQrkBfkVPYvDF+n2gegB6fbdXNqcSpmF6
 XhanxWcomJsrfTW4hkTo86z7amkv+onB04A= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n2e8br5qx-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 11 Oct 2018 15:12:30 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.32) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 11 Oct 2018 18:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LF4JfvNVT9dqa3fXfsb+e9OeYfo94FyWAxwiLXqRoEY=;
 b=JIxUKAK5rP6F00R5Lzjnoen8psr1oz2WkxzDIV/pkVFK3e0qs70+kJkp+lIi6dau9Yv71T0LBlHzUqzQfPojmkLvwVE1Auf/YVzXvKblxJoqUrXBfgwSEZOBHNIjR/LBfFSVmnlJlBtjUKF+sh4CGrSVWB3xnsqUl/74s71Cs48=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1862.namprd15.prod.outlook.com (10.174.54.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Thu, 11 Oct 2018 22:12:26 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::2d43:ae9a:18c0:ac8b]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::2d43:ae9a:18c0:ac8b%3]) with mapi id 15.20.1207.029; Thu, 11 Oct 2018
 22:12:26 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
        "Justin.Lee1@Dell.com" <Justin.Lee1@Dell.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH v2 1/2] net/ncsi: Add NCSI Broadcom OEM command
Thread-Topic: [PATCH v2 1/2] net/ncsi: Add NCSI Broadcom OEM command
Thread-Index: AQHUX/hgmJR+lXcp9Uqf0jSFOwduF6UX5pcAgAJDGwA=
Date:   Thu, 11 Oct 2018 22:12:26 +0000
Message-ID: <65877506-90AD-4383-955E-23ED94E5337F@fb.com>
References: <20181009174806.404791-1-vijaykhemka@fb.com>
 <7893ec3aa673b6009d00df1646b2820be2fc33a6.camel@mendozajonas.com>
In-Reply-To: <7893ec3aa673b6009d00df1646b2820be2fc33a6.camel@mendozajonas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::4:ba75]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1862;20:AK5WCiKF/DjFzCqEBW8rzXPJN5yDb4M+u7v8xOMZub2tFHRGVzSwCa/GNgZ5JQI6DZqi0pj3XKbatdcK6wRf6rS8ww762Kslew7xjt0jvtnVht/1okdMxGbT+PUs0OaxNbSfo4fqeSLTL5s6wLKyQhynlYVl4lleF8hTGuujtaE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fd3037a2-8924-4efc-52d4-08d62fc6a0b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1862;
x-ms-traffictypediagnostic: CY4PR15MB1862:
x-microsoft-antispam-prvs: <CY4PR15MB1862D571E7BED5704A49364EDDE10@CY4PR15MB1862.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991066);SRVR:CY4PR15MB1862;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1862;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(136003)(199004)(189003)(43544003)(2201001)(68736007)(86362001)(11346002)(305945005)(7736002)(5250100002)(106356001)(446003)(6246003)(102836004)(486006)(99286004)(229853002)(186003)(476003)(2616005)(97736004)(8676002)(478600001)(8936002)(2501003)(71190400001)(71200400001)(36756003)(14454004)(6436002)(316002)(25786009)(4326008)(6506007)(6116002)(105586002)(81166006)(83716004)(76176011)(2900100001)(81156014)(33656002)(6512007)(82746002)(5660300001)(6486002)(46003)(53936002)(54906003)(2906002)(256004)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1862;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5js1jJqiHtlbuXw+jxA0wvZ16YaVaJWobAqSU/BcmMn+i+B+jRtE6yVUnyPP+o+uQV5lRa1p5gCvPapmQPX99cevIXpblMQV7P32cwUGD7xdkkhpy7Ot4JgnBwS4/1ckkbvbj4xb2PSVy9ppuAjJpCLj1JPmuorSojn781oQdoqD3dtF/6D6zQGN0NQtV4GTNIXpytsfk9akeri/MJ3CTazaeT39jgn3HBfSGbEnORACpbvCAb1ejSUBPYxfchQFtHkXViidJXmDnxvSEw/Cp9AqN1uZcdT3x/EqYuADZdYHdzI0uFv5ljV2fIhGqsw1SGvb1+MkEgPf0TERErW1gQ1bYyJ12wFV+iC5IDCJvGM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <19F45637A1EFCE44847350B5BD47721D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3037a2-8924-4efc-52d4-08d62fc6a0b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 22:12:26.4368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1862
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIFNhbSwNCkkgd2lsbCB0YWtlIGNhcmUgb2YgdGhpcyBhbmQgZ2VuZXJhdGUgbmV3IHBh
dGNoLg0KDQpSZWdhcmRzDQotVmlqYXkNCg0K77u/T24gMTAvOS8xOCwgOTo0MCBQTSwgIlNhbXVl
bCBNZW5kb3phLUpvbmFzIiA8c2FtQG1lbmRvemFqb25hcy5jb20+IHdyb3RlOg0KDQogICAgT24g
VHVlLCAyMDE4LTEwLTA5IGF0IDEwOjQ4IC0wNzAwLCBWaWpheSBLaGVta2Egd3JvdGU6DQogICAg
PiBUaGlzIHBhdGNoIGFkZHMgT0VNIEJyb2FkY29tIGNvbW1hbmRzIGFuZCByZXNwb25zZSBoYW5k
bGluZy4gSXQgYWxzbw0KICAgID4gZGVmaW5lcyBPRU0gR2V0IE1BQyBBZGRyZXNzIGhhbmRsZXIg
dG8gZ2V0IGFuZCBjb25maWd1cmUgdGhlIGRldmljZS4NCiAgICA+IA0KICAgID4gbmNzaV9vZW1f
Z21hX2hhbmRsZXJfYmNtOiBUaGlzIGhhbmRsZXIgc2VuZCBOQ1NJIGJyb2FkY29tIGNvbW1hbmQg
Zm9yDQogICAgPiBnZXR0aW5nIG1hYyBhZGRyZXNzLg0KICAgID4gbmNzaV9yc3BfaGFuZGxlcl9v
ZW1fYmNtOiBUaGlzIGhhbmRsZXMgcmVzcG9uc2UgcmVjZWl2ZWQgZm9yIGFsbA0KICAgID4gYnJv
YWRjb20gT0VNIGNvbW1hbmRzLg0KICAgID4gbmNzaV9yc3BfaGFuZGxlcl9vZW1fYmNtX2dtYTog
VGhpcyBoYW5kbGVzIGdldCBtYWMgYWRkcmVzcyByZXNwb25zZSBhbmQNCiAgICA+IHNldCBpdCB0
byBkZXZpY2UuDQogICAgPiANCiAgICA+IFNpZ25lZC1vZmYtYnk6IFZpamF5IEtoZW1rYSA8dmlq
YXlraGVta2FAZmIuY29tPg0KICAgID4gLS0tDQogICAgPiAgbmV0L25jc2kvS2NvbmZpZyAgICAg
ICB8ICA2ICsrKysNCiAgICA+ICBuZXQvbmNzaS9pbnRlcm5hbC5oICAgIHwgIDggKysrKysNCiAg
ICA+ICBuZXQvbmNzaS9uY3NpLW1hbmFnZS5jIHwgNzAgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystDQogICAgPiAgbmV0L25jc2kvbmNzaS1wa3QuaCAgICB8ICA4ICsr
KysrDQogICAgPiAgbmV0L25jc2kvbmNzaS1yc3AuYyAgICB8IDQwICsrKysrKysrKysrKysrKysr
KysrKysrLQ0KICAgID4gIDUgZmlsZXMgY2hhbmdlZCwgMTMwIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQogICAgPiANCiAgICANCiAgICA8c25pcD4NCiAgICANCiAgICA+ICBzdGF0aWMg
dm9pZCBuY3NpX2NvbmZpZ3VyZV9jaGFubmVsKHN0cnVjdCBuY3NpX2Rldl9wcml2ICpuZHApDQog
ICAgPiAgew0KICAgID4gIAlzdHJ1Y3QgbmNzaV9kZXYgKm5kID0gJm5kcC0+bmRldjsNCiAgICA+
IEBAIC02NDMsOSArNjc2LDEwIEBAIHN0YXRpYyB2b2lkIG5jc2lfY29uZmlndXJlX2NoYW5uZWwo
c3RydWN0IG5jc2lfZGV2X3ByaXYgKm5kcCkNCiAgICA+ICAJc3RydWN0IG5jc2lfY2hhbm5lbCAq
bmMgPSBuZHAtPmFjdGl2ZV9jaGFubmVsOw0KICAgID4gIAlzdHJ1Y3QgbmNzaV9jaGFubmVsICpo
b3RfbmMgPSBOVUxMOw0KICAgID4gIAlzdHJ1Y3QgbmNzaV9jbWRfYXJnIG5jYTsNCiAgICA+ICsJ
c3RydWN0IG5jc2lfb2VtX2dtYV9oYW5kbGVyICpuY2ggPSBOVUxMOw0KICAgID4gIAl1bnNpZ25l
ZCBjaGFyIGluZGV4Ow0KICAgID4gIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KICAgID4gLQlpbnQg
cmV0Ow0KICAgID4gKwlpbnQgcmV0LCBpOw0KICAgID4gIA0KICAgIA0KICAgIEkganVzdCBub3Rp
Y2VkIHRoYXQgaWYgQ09ORklHX05DU0lfT0VNX0NNRF9HRVRfTUFDIGlzIG5vdCBzZXQgdGhlbiB0
aGlzDQogICAgZ2VuZXJhdGVzIHVudXNlZCB2YXJpYWJsZSB3YXJuaW5ncyBmb3IgaSBhbmQgbmNo
LiBPdGhlcndpc2UgYWxsIGxvb2tpbmcgZ29vZCENCiAgICANCiAgICBSZWdhcmRzLA0KICAgIFNh
bQ0KICAgIA0KICAgIA0KICAgIA0KDQo=
