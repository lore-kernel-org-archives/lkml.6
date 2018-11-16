Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA6AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8737A2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="M0SM0IVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8737A2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbeKQFB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 00:01:26 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:50502 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725729AbeKQFB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 00:01:26 -0500
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAGIgVDM009586;
        Fri, 16 Nov 2018 18:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=jan2016.eng;
 bh=stBuVQSZco1RHybSlv5tIffrRTxQ6eO+uoQQF8TcUKk=;
 b=M0SM0IVwm2WrJIR4CDCUQYFDRMxBcj4efgqC8BN/TsfvWVd2z6Ox0SISygfpGwf5CilL
 rELK7OgedSqUsKKtYgTqaLNgqqJb86y5QueHscIyaw4MhXma1XLFHZpS5iVKAkPtDIBv
 iPBZBu9AgHjFcBEa9ezEvjw8DUMp+R1ghs5jsy0ZCxrkiNYBDyu371T3ELiYTA/tSEyZ
 jefi2C4dHwZWiQf4fkm8JZqHK+NPxXro4OGJasl1x5vtoot3AWsHZVCC5WwdH99YkXsk
 20xOOIsG0AP/Z9MUSVs6jRs0dTbj3NmwZavEu4L/3aw0N2sn2SuZ2cl5xBGtKJ3lXP3F rQ== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
        by mx0b-00190b01.pphosted.com with ESMTP id 2nspkc2f0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Nov 2018 18:47:30 +0000
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.0.21/8.16.0.21) with SMTP id wAGIZWCk011896;
        Fri, 16 Nov 2018 13:47:29 -0500
Received: from email.msg.corp.akamai.com ([172.27.25.33])
        by prod-mail-ppoint2.akamai.com with ESMTP id 2nr7j7wrex-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 16 Nov 2018 13:47:27 -0500
Received: from USTX2EX-DAG3MB1.msg.corp.akamai.com (172.27.27.22) by
 USTX2EX-DAG3MB6.msg.corp.akamai.com (172.27.27.28) with Microsoft SMTP Server
 (TLS) id 15.0.1365.1; Fri, 16 Nov 2018 12:46:42 -0600
Received: from USTX2EX-DAG3MB1.msg.corp.akamai.com ([172.27.27.22]) by
 USTX2EX-DAG3MB1.msg.corp.akamai.com ([172.27.27.22]) with mapi id
 15.00.1365.000; Fri, 16 Nov 2018 13:46:36 -0500
From:   "Zhivich, Michael" <mzhivich@akamai.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "Ondrej Mosnacek" <omosnace@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        "kreview@akamai.com" <kreview@akamai.com>
Subject: Re: [PATCH] softirq: don't push timer softirq handling to ksoftirqd
Thread-Topic: [PATCH] softirq: don't push timer softirq handling to ksoftirqd
Thread-Index: AQHUfQWw4FI0On13i06aTw+ZpYHPW6VRaAsAgAFXT4A=
Date:   Fri, 16 Nov 2018 18:46:36 +0000
Message-ID: <6DB365C6-98F6-4C27-B0BE-0833E5D4962E@akamai.com>
References: <20181115170701.4696-1-mzhivich@akamai.com>
 <CALAqxLV0sQaWx837Vrz3hfGdUNSBa+cJWaaL_RpPsgRTMQknuA@mail.gmail.com>
In-Reply-To: <CALAqxLV0sQaWx837Vrz3hfGdUNSBa+cJWaaL_RpPsgRTMQknuA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.19.35.31]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4637CF6BEE0D8946B696A651F386E017@akamai.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-16_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811160163
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-16_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811160165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMTUvMTgsIDEyOjE3IFBNLCAiSm9obiBTdHVsdHoiIDxqb2huLnN0dWx0ekBsaW5hcm8u
b3JnPiB3cm90ZToNCg0KICAgIE9uIFRodSwgTm92IDE1LCAyMDE4IGF0IDk6MDcgQU0sIE1pY2hh
ZWwgWmhpdmljaCA8bXpoaXZpY2hAYWthbWFpLmNvbT4gd3JvdGU6DQogICAgPiBSZXF1aXJlIFRJ
TUVSX1NPRlRJUlEgdG8gYmUgaGFuZGxlZCBpbW1lZGlhdGVseSBpbnN0ZWFkIG9mIGRlbGF5aW5n
IHVudGlsDQogICAgPiBrc29mdGlycWQgcnVucywgdGh1cyBwcmV2ZW50aW5nIHByb2JsZW1zIHdp
dGggcmVhZGluZyBjbG9ja3NvdXJjZXMgdGhhdA0KICAgID4gd3JhcCBvZnRlbiAoZS5nLiBhY3Bp
X3BtKS4NCiAgICA+DQogICAgPiBJZiBhY3BpX3BtIGlzIHVzZWQgYXMgdGhlIGNsb2Nrc291cmNl
IHdhdGNoZG9nLCBhbmQgbWFjaGluZSBpcyB1bmRlciBoZWF2eQ0KICAgID4gbG9hZCwgdGhlIHRp
bWUgcGVyaW9kIGZvciB0aGUgd2F0Y2hkb2cgY2hlY2sgbWF5IGJlIHNpZ25pZmljYW50bHkgbG9u
Z2VyDQogICAgPiB0aGFuIHRoZSByZXF1ZXN0ZWQgMC41IHNlY29uZHMuICBJZiB0aGUgd2F0Y2hk
b2cgY2hlY2sgaXMgZGVsYXllZCBieSAyDQogICAgPiBzZWNvbmRzIChvYnNlcnZlZCBiZWhhdmlv
ciksIHRoZW4gYWNwaV9wbSB0aW1lIGRlbHRhIHdpbGwgYmUNCiAgICA+DQogICAgPiAgICAgMi41
IHNlYyAqIDM1Nzk1NDUgdGlja3Mvc2VjID0gODk0ODg2MyA9IDB4ODg4YzNmDQogICAgPg0KICAg
ID4gd2hpY2ggd2lsbCBiZSB0cmVhdGVkIGFzIG5lZ2F0aXZlIChzaW5jZSBhY3BpX3BtIGlzIG9u
bHkgMjQtYml0cyB3aWRlKSBhbmQNCiAgICA+IHRydW5jYXRlZCB0byAwLiAgVGhpcyBiZWhhdmlv
ciB3aWxsIGNhdXNlIHRzYyB0byBiZSBpbmNvcnJlY3RseSBkZWNsYXJlZA0KICAgID4gdW5zdGFi
bGUgaW4gY2xvY2tzb3VyY2Vfd2F0Y2hkb2coKSwgYXMgaXQgbm8gbG9uZ2VyIGFncmVlcyB3aXRo
IGFjcGlfcG0uDQogICAgPiBJZiB0aGUgY2xvY2tzb3VyY2Ugd2F0Y2hkb2cgY2hlY2sgaXMgZGVs
YXllZCBieSBtb3JlIHRoYW4gNC43IHNlYywgdGhlbiB0aGUNCiAgICA+IGFjcGlfcG0gY2xvY2tz
b3VyY2Ugd2lsbCB3cmFwIGFsdG9nZXRoZXIgYW5kIHByb2R1Y2UgaW5jb3JyZWN0IHRpbWUgZGVs
dGEuDQogICAgPg0KICAgID4gVGhlIGxpa2VseSBjYXVzZSBvZiB0aGlzIGRlbGF5IGlzIHRoYXQg
dGltZXIgaW50ZXJydXB0cyBhcmUgc2VydmljZWQgaW4NCiAgICA+IGtzb2Z0aXJxZCB3aGVuIHRo
ZSBtYWNoaW5lIGlzIHZlcnkgYnVzeS4NCiAgICA+DQogICAgPiBQZXIgTGludXMnIGNvbW1lbnQg
aW4gY29tbWl0IDNjNTM3NzZlMjlmOCAoIk1hcmsgSEkgYW5kIFRBU0tMRVQgc29mdGlycQ0KICAg
ID4gc3luY2hyb25vdXMiKToNCiAgICA+ICAgIC4uLg0KICAgID4gICAgV2Ugc2hvdWxkIHByb2Jh
Ymx5IGFsc28gY29uc2lkZXIgdGhlIHRpbWVyIHNvZnRpcnFzIHRvIGJlIHN5bmNocm9ub3VzDQog
ICAgPiAgICBhbmQgbm90IGJlIGRlbGF5ZWQgdG8ga3NvZnRpcnFkIChzaW5jZSB0aGV5IHdlcmUg
dGhlIGlzc3VlIHdpdGggdGhlDQogICAgPiAgICBlYXJsaWVyIHdhdGNoZG9nIHByb2JsZW1zKSwg
YnV0IHRoYXQgc2hvdWxkIGJlIGRvbmUgYXMgYSBzZXBhcmF0ZSBwYXRjaC4NCiAgICA+ICAgIC4u
Lg0KICAgID4NCiAgICA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgWmhpdmljaCA8bXpoaXZpY2hA
YWthbWFpLmNvbT4NCiAgICA+IC0tLQ0KICAgID4gIGtlcm5lbC9zb2Z0aXJxLmMgfCAzICsrLQ0K
ICAgID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCiAg
ICA+DQogICAgPiBkaWZmIC0tZ2l0IGEva2VybmVsL3NvZnRpcnEuYyBiL2tlcm5lbC9zb2Z0aXJx
LmMNCiAgICA+IGluZGV4IGQyODgxMzMwNmIyYy4uNmQ1MTdjZTBmYmE4IDEwMDY0NA0KICAgID4g
LS0tIGEva2VybmVsL3NvZnRpcnEuYw0KICAgID4gKysrIGIva2VybmVsL3NvZnRpcnEuYw0KICAg
ID4gQEAgLTgyLDcgKzgyLDggQEAgc3RhdGljIHZvaWQgd2FrZXVwX3NvZnRpcnFkKHZvaWQpDQog
ICAgPiAgICogcmlnaHQgbm93LiBMZXQga3NvZnRpcnFkIGhhbmRsZSB0aGlzIGF0IGl0cyBvd24g
cmF0ZSwgdG8gZ2V0IGZhaXJuZXNzLA0KICAgID4gICAqIHVubGVzcyB3ZSdyZSBkb2luZyBzb21l
IG9mIHRoZSBzeW5jaHJvbm91cyBzb2Z0aXJxcy4NCiAgICA+ICAgKi8NCiAgICA+IC0jZGVmaW5l
IFNPRlRJUlFfTk9XX01BU0sgKCgxIDw8IEhJX1NPRlRJUlEpIHwgKDEgPDwgVEFTS0xFVF9TT0ZU
SVJRKSkNCiAgICA+ICsjZGVmaW5lIFNPRlRJUlFfTk9XX01BU0sgXA0KICAgID4gKyAgICAgICAo
KDEgPDwgSElfU09GVElSUSkgfCAoMSA8PCBUQVNLTEVUX1NPRlRJUlEpIHwgKDEgPDwgVElNRVJf
U09GVElSUSkpDQogICAgPiAgc3RhdGljIGJvb2wga3NvZnRpcnFkX3J1bm5pbmcodW5zaWduZWQg
bG9uZyBwZW5kaW5nKQ0KICAgID4gIHsNCiAgICA+ICAgICAgICAgc3RydWN0IHRhc2tfc3RydWN0
ICp0c2sgPSBfX3RoaXNfY3B1X3JlYWQoa3NvZnRpcnFkKTsNCiAgICANCiAgICBUaGFua3Mgc28g
bXVjaCBmb3Igc2VuZGluZyB0aGlzIGFsb25nISBTb3JyeSBJIGRpZG4ndCBnZXQgYmFjayB0byB5
b3VyDQogICAgbWFpbCBlYXJsaWVyIHRoaXMgd2VlaywgSSd2ZSBiZWVuIGF0IFBsdW1iZXJzLg0K
ICAgIA0KICAgIFNvIHdoaWxlIHRoaXMgZG9lcyB0cnkgdG8gYXR0YWNrIHRoZSByZWxpYWJpbGl0
eSBpc3N1ZSB3LyB0aGUNCiAgICBjbG9ja3NvdXJjZSB3YXRjaGRvZyBiZWluZyBkZWxheWVkLCBJ
IHdvcnJ5IHRoaXMgd2lsbCBoYXZlIHRvIG1hbnkNCiAgICBzaWRlLWVmZmVjdHMgZWxzZXdoZXJl
Lg0KICAgIA0KICAgIFdvdWxkIGEgbW9yZSBmb2N1c2VkIGZpeCBiZSB0byBtb3ZlIHRoZSBjbG9j
a3NvdXJjZSB3YXRjaGRvZyBmcm9tIGENCiAgICBub3JtYWwgdGltZXIgdG8gYSBocnRpbWVyPw0K
ICAgIA0KICAgIHRoYW5rcw0KICAgIC1qb2huDQogICAgDQpIaSBKb2huLA0KDQpUaGF0J3MgYW4g
aW50ZXJlc3RpbmcgaWRlYSAtIGl0IHdvdWxkIGdldCBjbG9ja3NvdXJjZSB3YXRjaGRvZyBvdXQg
b2Yga3NvZnRpcnFkLiAgSG93ZXZlciwgY2xvY2tzb3VyY2Ugd2F0Y2hkb2cgaXRlcmF0ZXMgb3Zl
ciBhdmFpbGFibGUgQ1BVcyB0byBjaGVjayB0aGUgVFNDIG9uIGVhY2ggY29yZSAoc2VlIGFkZF90
aW1lcl9vbigpIGNhbGwgaW4gY2xvY2tzb3VyY2Vfd2F0Y2hkb2coKSkuICBJJ20gbm90IHNlZWlu
ZyBhbiBBUEkgdG8gc3RhcnQgYW4gaHJ0aW1lciBvbiBhIHNwZWNpZmljIENQVSAtIGlzIHRoaXMg
cG9zc2libGUgYW5kIEknbSBtaXNzaW5nIGl0PyAgT3Igd291bGQgc29tZXRoaW5nIGxpa2UgdGhp
cyBoYXZlIHRvIGJlIGFkZGVkIHRvIGhydGltZXI/DQoNClRoYW5rcywNCn4gTWljaGFlbA0KDQo=
