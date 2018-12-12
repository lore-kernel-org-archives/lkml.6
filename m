Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582B3C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0379120851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ohTi93g5";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="VgC5O3xp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0379120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbeLLFev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:34:51 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:39562 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726218AbeLLFev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:34:51 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBC5WOTD029443;
        Tue, 11 Dec 2018 21:34:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=S9zWlvdewfSGbraGcFQyxzWCI3hE9ECTOtDtIySWq2I=;
 b=ohTi93g5SwnNA/4rsBWMOXoWxR9ExPKTl3SoR7CMT/txPvlt2EQhx92lF9O7rO0t/M0L
 +4fMFzIAoUlHjsuQ2WZYP2LrEp+eX0/2rNAG9xzNZhS6Erp5lQlu5P8ko4dKt4JwFUc7
 jmUwNRC9Vpa4LgeKeTlKTl02KkTxxZHVkWnlKWMldBLT338G1FXlfrLlENZbF4LVxBJI
 muRVDoA8Q7pKYRVCUATaQv5/DlVvTJ3tYd6Vz24cTZnBP/imLGnvkNz/0GNpNhmRIefy
 bqN1NeVCVK/ed/TrlPo2f0lLiRd0tez3AnjVBlzWcaJvx44FP0o/385MmN7EjBaNUtuW dQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pthombar@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2054.outbound.protection.outlook.com [104.47.37.54])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2p9wg9gnc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 11 Dec 2018 21:34:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9zWlvdewfSGbraGcFQyxzWCI3hE9ECTOtDtIySWq2I=;
 b=VgC5O3xpp35vICTdAioTsXfC0juU3nkhcnJyp/zgKXXMide4AFomB0TaU8J6QUDgeR527dwP/dT5vKJlDMJfq65OEOTqmcOH959meY8Rp+sltAuqWYQPt2ogVHB8EOSCChwms+6opRbfiXyOHPQxnBdG5pOC1Gz8Yd9KH7rk8Cc=
Received: from CO2PR07MB2469.namprd07.prod.outlook.com (10.166.200.139) by
 CO2PR07MB2600.namprd07.prod.outlook.com (10.166.213.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Wed, 12 Dec 2018 05:34:39 +0000
Received: from CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::406a:f22b:dc72:d2e1]) by CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::406a:f22b:dc72:d2e1%9]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 05:34:39 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Jens Axboe <axboe@kernel.dk>, "tj@kernel.org" <tj@kernel.org>,
        "jbacik@fb.com" <jbacik@fb.com>,
        "michaelcallahan@fb.com" <michaelcallahan@fb.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "shli@fb.com" <shli@fb.com>,
        "dennisszhou@gmail.com" <dennisszhou@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alan Douglas <adouglas@cadence.com>,
        Janek Kotas <jank@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>
Subject: RE: [PATCH 1/2] block: add bi_crypto_ctx variable in struct bio
Thread-Topic: [PATCH 1/2] block: add bi_crypto_ctx variable in struct bio
Thread-Index: AQHUkTb45i2sxmeZuk2uLNNdVa5lRKV5isYAgAEKP9A=
Date:   Wed, 12 Dec 2018 05:34:39 +0000
Message-ID: <CO2PR07MB24690B7076BCD94DD79051A0C1A70@CO2PR07MB2469.namprd07.prod.outlook.com>
References: <20181211095001.GA32573@lvlogina.cadence.com>
 <62281c61-de73-a0a3-2ea2-eeea81778eea@kernel.dk>
In-Reply-To: <62281c61-de73-a0a3-2ea2-eeea81778eea@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy05ZDI1ODZkMy1mZGNmLTExZTgtODRkZi0wNGQzYjAyNzc0NGFcYW1lLXRlc3RcOWQyNTg2ZDUtZmRjZi0xMWU4LTg0ZGYtMDRkM2IwMjc3NDRhYm9keS50eHQiIHN6PSIyMTI3IiB0PSIxMzE4OTA2NjQ3ODE0NjUxMzYiIGg9IjNUZ3crTWw2cUkyRjllK2JTcUNxaWYvcERIVT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [14.143.9.161]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2600;20:s59UIBhCir3KNh4lzrzGFmYgR48yJ+thKHP3L1wQpoUsYRuAQNP8xFs4jrX4nR+8ETnxMNPHCKbZDeCn9uFupTjAfDYr7XIBuvIAEzLjy7/5wXvZCoTNzpSFZSG7Wetrakf0B75EQ4lXQDwWWkKRMGOJxXNPOpsyEQoXtF+3cIOGuLECAFMFNhsw8pYfXzkkGPLoJnBVB8mheD4iV4qdtiJBIj3eB/Gk6I1hNklmtRn9CEBGZlvDMlPmokq7ylya
x-ms-office365-filtering-correlation-id: a356df74-bb34-4684-2518-08d65ff382c2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2600;
x-ms-traffictypediagnostic: CO2PR07MB2600:
x-microsoft-antispam-prvs: <CO2PR07MB260084DF573DE7215E73AFD2C1A70@CO2PR07MB2600.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231472)(944501520)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CO2PR07MB2600;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB2600;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(366004)(136003)(36092001)(199004)(189003)(13464003)(7416002)(4326008)(110136005)(25786009)(26005)(345774005)(81166006)(7736002)(55236004)(229853002)(305945005)(102836004)(486006)(316002)(6506007)(68736007)(74316002)(99286004)(7696005)(2906002)(54906003)(14454004)(86362001)(446003)(5660300001)(76176011)(11346002)(476003)(256004)(97736004)(3846002)(71190400001)(66066001)(2501003)(2201001)(71200400001)(9686003)(78486014)(33656002)(6246003)(39060400002)(55016002)(107886003)(106356001)(105586002)(81156014)(186003)(8676002)(14444005)(6116002)(478600001)(6436002)(53936002)(8936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2600;H:CO2PR07MB2469.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Nu2KugJnIzzCgDWzJ2zGwhqBIcSpzYDkB3hwk5hIIDuHyjhg2VBTNPDcVtSgogdUg6ttJySCp/L0siPkCLxZCXDRq/wgVUPh8bjQV+iedHlkYd/MsYx90rIWRuEcihzq6cOIvhjNzwdp3sYkbgnoWi/HABhR5Gpk4jfcMkEW4QVAsi+6ykwHF3cC5n3MdLJh8r/N/5En6bxBwAC69VsMsM4iebA/nOLMXYH+QvO6J5ZGryZd6gbwRfQzx6R0yAwrkJHDbZ8B52EiKuWperDlqeDf0e/c3arwBm02qsfnXG3iHz7Ff/EWZgAcE+dKeJTG
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a356df74-bb34-4684-2518-08d65ff382c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 05:34:39.2645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2600
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812120048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gSmVucywNCg0KVGhhbmsgeW91IGZvciBhIGNvbW1lbnQuDQoNCj4tLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPkZyb206IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4NCj5TZW50
OiBUdWVzZGF5LCBEZWNlbWJlciAxMSwgMjAxOCA3OjA3IFBNDQo+VG86IFBhcnNodXJhbSBSYWp1
IFRob21iYXJlIDxwdGhvbWJhckBjYWRlbmNlLmNvbT47IHRqQGtlcm5lbC5vcmc7DQo+amJhY2lr
QGZiLmNvbTsgbWljaGFlbGNhbGxhaGFuQGZiLmNvbTsgc25pdHplckByZWRoYXQuY29tOw0KPm9z
YW5kb3ZAZmIuY29tOyBrZWl0aC5idXNjaEBpbnRlbC5jb207IG1pbmcubGVpQHJlZGhhdC5jb207
IHNobGlAZmIuY29tOw0KPmRlbm5pc3N6aG91QGdtYWlsLmNvbTsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPkNjOiBBbGFuIERvdWdsYXMgPGFkb3VnbGFzQGNhZGVuY2UuY29tPjsgSmFu
ZWsgS290YXMgPGphbmtAY2FkZW5jZS5jb20+Ow0KPlJhZmFsIENpZXBpZWxhIDxyYWZhbGNAY2Fk
ZW5jZS5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGJsb2NrOiBhZGQgYmlfY3J5cHRv
X2N0eCB2YXJpYWJsZSBpbiBzdHJ1Y3QgYmlvDQo+DQo+RVhURVJOQUwgTUFJTA0KPg0KPg0KPk9u
IDEyLzExLzE4IDI6NTAgQU0sIFBhcnNodXJhbSBUaG9tYmFyZSB3cm90ZToNCj4+IEFkZCB2YXJp
YWJsZSAndm9pZCAqYmlfY3J5cHRfY3R4JyBpbiAnc3RydWN0IGJpbycuIFRoaXMgd2lsbCBiZSB1
c2VkDQo+PiB0byBhc3NvY2lhdGUgYmlvIHdpdGggY3J5cHRvIGNvbmZpZ3VyYXRpb24gb2YgY29u
dHJvbGxlciBzdXBwb3J0aW5nDQo+PiByZWFsIHRpbWUgLyBpbmxpbmUgZW5jcnlwdGlvbi9kZWNy
eXB0aW9uLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFBhcnNodXJhbSBUaG9tYmFyZSA8cHRob21i
YXJAY2FkZW5jZS5jb20+DQo+PiAtLS0NCj4+ICBpbmNsdWRlL2xpbnV4L2Jsa190eXBlcy5oIHwg
ICAgNCArKysrDQo+PiAgMSBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDAgZGVsZXRp
b25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYmxrX3R5cGVzLmggYi9p
bmNsdWRlL2xpbnV4L2Jsa190eXBlcy5oDQo+PiBpbmRleCAxZGNmNjUyLi5iZDc3NjAzIDEwMDY0
NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51eC9ibGtfdHlwZXMuaA0KPj4gKysrIGIvaW5jbHVkZS9s
aW51eC9ibGtfdHlwZXMuaA0KPj4gQEAgLTE4OCw2ICsxODgsMTAgQEAgc3RydWN0IGJpbyB7DQo+
PiAgI2VuZGlmDQo+PiAgCX07DQo+Pg0KPj4gKyNpZmRlZiBDT05GSUdfQkxLX0RFVl9IV19SVF9F
TkNSWVBUSU9ODQo+PiArCXZvaWQgKmJpX2NyeXB0b19jdHg7DQo+PiArI2VuZGlmDQo+PiArDQo+
PiAgCXVuc2lnbmVkIHNob3J0CQliaV92Y250OwkvKiBob3cgbWFueSBiaW9fdmVjJ3MgKi8NCj4+
DQo+PiAgCS8qDQo+DQo+UHJldHR5IHN1cmUgSSBtZW50aW9uZWQgdGhpcyBsYXN0IHRpbWUsIGJ1
dCBpbiBjYXNlIEkgZGlkbid0LCBkb24ndCBhZGQgYmlvIG1lbWJlcnMNCj5mb3IgcmFuZG9tIGRy
aXZlcnMuIENhbiB5b3UgaW1hZ2luZSBob3cgaHVnZSB0aGlzIHRoaW5nIHdvdWxkIGJlIGlmIHdl
IGFsbG93ZWQNCj50aGF0Pw0KPg0KPklmIHlvdSBuZWVkIHBlci1pbyBzdG9yYWdlLCBwdXQgaXQg
aW4gdGhlIHBheWxvYWQgZm9yIHRoZSBibGstbXEgcmVxdWVzdC4gVGhhdCB3YXkNCj55b3UgYXJl
IG9ubHkgYmxvYXRpbmcgeW91ciBvd24gSU8gcmVsYXRlZCBkYXRhIHN0cnVjdHVyZXMsIG5vdCBl
dmVyeW9uZXMuDQpPaywgSSB3aWxsIGxvb2sgaW50byB1c2luZyBwYXlsb2FkIGZvciB0aGUgYmxr
LW1xIHJlcXVlc3QgaW5zdGVhZCBvZiBhZGRpbmcgdmFyaWFibGUgDQppbiBzdHJ1Y3QgYmlvLg0K
SSB0aG91Z2h0IHRoaXMgZmlsZWQgd291bGQgYmUgdXNlZnVsIGluIGVuYWJsaW5nIGlubGluZSBl
bmNyeXB0aW9uIGZvciBvdGhlciB0eXBlIG9mDQpkZXZpY2VzIHRvby4NCj4NCj4tLQ0KPkplbnMg
QXhib2UNCg0KUmVnYXJkcywNClBhcnNodXJhbSBUaG9tYmFyZQ0K
