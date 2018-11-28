Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EF3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0B0205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="RJL0wVdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0B0205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbeK2E7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:59:46 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:45006 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728341AbeK2E7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:59:46 -0500
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.27/8.16.0.27) with SMTP id wASHubqQ011088;
        Wed, 28 Nov 2018 17:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=jan2016.eng;
 bh=zENIJlbhMglC7hfmVHKZgwsGcTyyoZ+EjBn5IRoHecA=;
 b=RJL0wVdvp0HzM01wm4nZi6coTExkW5r02r8m29QDmx/zTpgNYVCp1JmcF+o/MSRlbrHm
 sDoFVqUp+DiT5vUF/SwOSju3RFrpIrXiZGmXykspdOsOZpYYF2YQhgsQ4Qp6oyxrcD01
 /mfPdNMZo9z6Q0O+X8PTBmmMzxKXnkV1AbH3inINNi/AMPnkj+nsTK5uUQ1qpmWYWQQG
 BiC3RxdOVqOBJEn1bJcwmbajpoBYExVLOjkyD1YqbSrSrVGYX5LtOIt2+nyDkoZhlUas
 SohLObwCktvTU4ucNe5NEkO4ieUa1bs8za48ELCP8uZIG/O/fI3FpKGqv5hcX5SphpYS 3w== 
Received: from prod-mail-ppoint4 (a96-6-114-87.deploy.static.akamaitechnologies.com [96.6.114.87] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 2p1v4bgpe7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Nov 2018 17:56:56 +0000
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.16.0.21/8.16.0.21) with SMTP id wASHoWCA001258;
        Wed, 28 Nov 2018 12:56:55 -0500
Received: from email.msg.corp.akamai.com ([172.27.25.33])
        by prod-mail-ppoint4.akamai.com with ESMTP id 2ny2v31b6a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 28 Nov 2018 12:56:55 -0500
Received: from USTX2EX-DAG3MB1.msg.corp.akamai.com (172.27.27.22) by
 ustx2ex-dag3mb5.msg.corp.akamai.com (172.27.27.27) with Microsoft SMTP Server
 (TLS) id 15.0.1365.1; Wed, 28 Nov 2018 12:56:54 -0500
Received: from USTX2EX-DAG3MB1.msg.corp.akamai.com ([172.27.27.22]) by
 USTX2EX-DAG3MB1.msg.corp.akamai.com ([172.27.27.22]) with mapi id
 15.00.1365.000; Wed, 28 Nov 2018 12:56:54 -0500
From:   "Zhivich, Michael" <mzhivich@akamai.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Ondrej Mosnacek" <omosnace@redhat.com>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        John Stultz <john.stultz@linaro.org>,
        "kreview@akamai.com" <kreview@akamai.com>,
        "Jason Wessel" <jason.wessel@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [kreview] [PATCH] softirq: don't push timer softirq handling to
 ksoftirqd
Thread-Topic: [kreview] [PATCH] softirq: don't push timer softirq handling to
 ksoftirqd
Thread-Index: AQHUfQWw4FI0On13i06aTw+ZpYHPW6VRaAsAgAFXT4CAEvaZAP//138A
Date:   Wed, 28 Nov 2018 17:56:54 +0000
Message-ID: <C3130484-33F2-4B05-99C7-35B4E6923E39@akamai.com>
References: <20181115170701.4696-1-mzhivich@akamai.com>
 <CALAqxLV0sQaWx837Vrz3hfGdUNSBa+cJWaaL_RpPsgRTMQknuA@mail.gmail.com>
 <6DB365C6-98F6-4C27-B0BE-0833E5D4962E@akamai.com>
 <alpine.DEB.2.21.1811281616570.1532@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1811281616570.1532@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.19.32.120]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0F368EB660011418ED55FE7F4ED6DDA@akamai.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-28_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811280155
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-28_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811280156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjgvMTgsIDEwOjIyIEFNLCAiVGhvbWFzIEdsZWl4bmVyIiA8dGdseEBsaW51dHJvbml4
LmRlPiB3cm90ZToNCg0KICAgIE1pY2hhZWwsDQogICAgDQogICAgT24gRnJpLCAxNiBOb3YgMjAx
OCwgWmhpdmljaCwgTWljaGFlbCB3cm90ZToNCiAgICA+IE9uIDExLzE1LzE4LCAxMjoxNyBQTSwg
IkpvaG4gU3R1bHR6IiA8am9obi5zdHVsdHpAbGluYXJvLm9yZz4gd3JvdGU6DQogICAgPiAgICAg
V291bGQgYSBtb3JlIGZvY3VzZWQgZml4IGJlIHRvIG1vdmUgdGhlIGNsb2Nrc291cmNlIHdhdGNo
ZG9nIGZyb20gYQ0KICAgID4gICAgIG5vcm1hbCB0aW1lciB0byBhIGhydGltZXI/DQogICAgPiAg
ICAgDQogICAgPiBUaGF0J3MgYW4gaW50ZXJlc3RpbmcgaWRlYSAtIGl0IHdvdWxkIGdldCBjbG9j
a3NvdXJjZSB3YXRjaGRvZyBvdXQgb2YNCiAgICA+IGtzb2Z0aXJxZC4gIEhvd2V2ZXIsIGNsb2Nr
c291cmNlIHdhdGNoZG9nIGl0ZXJhdGVzIG92ZXIgYXZhaWxhYmxlIENQVXMgdG8NCiAgICA+IGNo
ZWNrIHRoZSBUU0Mgb24gZWFjaCBjb3JlIChzZWUgYWRkX3RpbWVyX29uKCkgY2FsbCBpbg0KICAg
ID4gY2xvY2tzb3VyY2Vfd2F0Y2hkb2coKSkuICBJJ20gbm90IHNlZWluZyBhbiBBUEkgdG8gc3Rh
cnQgYW4gaHJ0aW1lciBvbiBhDQogICAgPiBzcGVjaWZpYyBDUFUgLSBpcyB0aGlzIHBvc3NpYmxl
IGFuZCBJJ20gbWlzc2luZyBpdD8gIE9yIHdvdWxkIHNvbWV0aGluZw0KICAgID4gbGlrZSB0aGlz
IGhhdmUgdG8gYmUgYWRkZWQgdG8gaHJ0aW1lcj8NCiAgICANCiAgICBJdCdzIHN1cmVseSBhbiBp
bnRlcmVzdGluZyBpZGVhLCBidXQgaXQncyBub3QgdHJpdmlhbC4NCiAgICANCiAgICBUaGVyZSBp
cyBubyB3YXkgdG8gcmVsaWFibHkgcXVldWUgaHJ0aW1lcnMgcmVtb3RlIHdoZW4gaGlnaCByZXNv
bHV0aW9uIG1vZGUNCiAgICBpcyBlbmFibGVkLiBJdCBvbmx5IHdvcmtzIHdoZW4gdGhlIHRvIGJl
IHF1ZXVlZCB0aW1lciBpcyBub3QgdGhlIGZpcnN0IHRvDQogICAgZXhwaXJlIG9uZS4gSWYgaXQg
ZW5kcyB1cCBiZWluZyB0aGUgZmlyc3QgdG8gZXhwaXJlIHRpbWVyLCB0aGVuIHRoZXJlIGlzDQog
ICAgY3VycmVudGx5IG5vIHdheSB0byByZWFybSB0aGUgcmVtb3RlIHBlciBjcHUgY2xvY2tldmVu
dCBkZXZpY2UgYmVjYXVzZSBpdCdzDQogICAgbm90IHJlbW90ZWx5IGFjY2VzaWJsZS4NCiAgICAN
CiAgICBJdCB3b3VsZCBuZWVkIGFuIFNNUCBmdW5jdGlvbiBjYWxsLCBidXQgdGhhdCBuZWVkcyB0
byBiZSBhc3luY2hyb25vdXMgZHVlDQogICAgdG8gbG9ja2luZy9pbnRlcnJ1cHQgZGlzYWJsZWQg
Y29uc3RyYWludHMuIE1heWJlIC4uLg0KICAgIA0KICAgIFRoYW5rcywNCiAgICANCiAgICAJdGds
eA0KDQogICAgDQpUaG9tYXMsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrIC0gaXQgZG9lcyBz
b3VuZCB0cmlja3kgdG8gZ2V0IHJpZ2h0LiAgSSdsbCBzcGVuZCBzb21lIG1vcmUgdGltZSB0aGlu
a2luZyBhYm91dCBpdC4NCg0KTXkgb3JpZ2luYWwgcGF0Y2ggdHJpZXMgdG8gZW5zdXJlIHRoYXQg
dGltZXIgc29mdGlycXMgYXJlIHNlcnZpY2VkIGltbWVkaWF0ZWx5LCBub3QgcHVudGVkIHRvIGtz
b2Z0aXJxZC4gIEl0IGlzIHBlcmhhcHMgdG9vIGhlYXZ5LWhhbmRlZCAoYWxsIHNvZnRpcnFzIHdp
bGwgZ2V0IHNlcnZpY2VkIGlmIGEgdGltZXIgc29mdGlycSBmaXJlZCksIGJ1dCBJIGltYWdpbmUg
dGhlIGNsb2Nrc291cmNlIHdhdGNoZG9nIGlzIG5vdCB0aGUgb25seSB0aW1lciB0aGF0IGRvZXNu
J3Qgd2FudCB0byBiZSBhcmJpdHJhcmlseSBkZWxheWVkIHdoZW4gdGhlIG1hY2hpbmUgaXMgYnVz
eS4NCg0KV291bGQgaXQgbWFrZSBzZW5zZSB0byBtb2RpZnkgdGhlIHBhdGNoIHN1Y2ggdGhhdCBv
bmx5IHRpbWVyIHNvZnRpcnFzIGFyZSBzZXJ2aWNlZCBpbW1lZGlhdGVseSBpZiBmaXJlZD8gIE9y
IGFyZSBtb3N0IHRpbWVycyB0aGF0IHJlcXVpcmUgcHJlY2lzaW9uIHdha2V1cHMgdXNpbmcgaHJ0
aW1lciBmcmFtZXdvcms/DQoNClRoYW5rcywNCn4gTWljaGFlbA0KDQoNCg==
