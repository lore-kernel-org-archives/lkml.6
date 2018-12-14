Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1353FC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B9520866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B9520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbeLNJMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:12:07 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:6518 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726344AbeLNJMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:12:07 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 1258016206174;
        Fri, 14 Dec 2018 17:12:03 +0800 (CST)
Received: from DGGEMM423-HUB.china.huawei.com (10.1.198.40) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 14 Dec 2018 17:12:03 +0800
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.137]) by
 dggemm423-hub.china.huawei.com ([10.1.198.40]) with mapi id 14.03.0415.000;
 Fri, 14 Dec 2018 17:11:53 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     liangshengjun <liangshengjun@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc3: gadget: fix miss isoc issue introduced by
 IRQ latency
Thread-Topic: [PATCH] usb: dwc3: gadget: fix miss isoc issue introduced by
 IRQ latency
Thread-Index: AQHUk4cxG7ymgFtVv0SioeUwSrP51KV9Z1sAgACKuZA=
Date:   Fri, 14 Dec 2018 09:11:52 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED24E20BE5@dggemm526-mbx.china.huawei.com>
References: <1544805179-2248-1-git-send-email-prime.zeng@hisilicon.com>
 <87efaklcd1.fsf@linux.intel.com>
In-Reply-To: <87efaklcd1.fsf@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.222.15]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRmVsaXBlIEJhbGJpIFttYWlsdG86
YmFsYmlAa2VybmVsLm9yZ10NCj5TZW50OiBGcmlkYXksIERlY2VtYmVyIDE0LCAyMDE4IDQ6NTIg
UE0NCj5UbzogWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT4NCj5DYzogbGlh
bmdzaGVuZ2p1biA8bGlhbmdzaGVuZ2p1bkBoaXNpbGljb24uY29tPjsgWmVuZ3RhbyAoQikNCj48
cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsgR3JlZyBLcm9haC1IYXJ0bWFuDQo+PGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnPjsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsNCj5saW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSF0gdXNiOiBkd2MzOiBn
YWRnZXQ6IGZpeCBtaXNzIGlzb2MgaXNzdWUgaW50cm9kdWNlZCBieQ0KPklSUSBsYXRlbmN5DQo+
DQo+KiBQR1AgU2lnbmVkIGJ5IGFuIHVua25vd24ga2V5DQo+DQo+WmVuZyBUYW8gPHByaW1lLnpl
bmdAaGlzaWxpY29uLmNvbT4gd3JpdGVzOg0KPg0KPj4gSWYgaXQncyBhIGJ1c3kgc3lzdGVtLCBz
b21lIHRpbWVzIHdoZW4gd2Ugc3RhcnQgYW4gaXNvYyB0cmFuc2ZlciwgdGhlDQo+PiBmcmFtZW51
bWJlciBnZXQgZnJvbSB0aGUgZXZlbnQgYnVmZmVyIG1heSBiZSBhbHJlYWR5IGVsYXNwZWQsIGlu
IHRoaXMNCj4+IGNhc2UsIHdlIHdpbGwgZ2V0IGFsbCB0aGUgcGFja2V0cyBkcm9wcGVkIGR1ZSB0
byBtaXNzIGlzb2MuIEFuZCB3ZQ0KPj4gdHVybiBpbnRvIHRyYW5zZmVyIG5vdGhpbmcsIHRvIGZp
eCB0aGlzIGlzc3VlLCB3ZSBuZWVkIHRvIGZpeCB0aGUNCj4+IGZyYW1lbnVtYmVyIHRvIG1ha2Ug
c3VyZSB0aGF0IGl0J3Mgbm90IG91dCBvZiBkYXRlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExp
YW5nIFNoZW5nanVuIDxsaWFuZ3NoZW5nanVuQGhpc2lsaWNvbi5jb20+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBaZW5nIFRhbyA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPg0KPg0KPlRoZXJlJ3MgYSBw
YXRjaCBnb2luZyB1cHN0cmVhbSBhbHJlYWR5IGRvaW5nIHRoaXM6DQo+DQo+aHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYmFsYmkvdXNiLmdpdC9jb21taXQv
P2gNCj49bmV4dCZpZD1kNTM3MDEwNjdmMDQ4YjhiMTE2MzVlOTY0YjZkM2JkOWEyNDhjNjIyDQo+
DQoNClNvcnJ5LCBJIHRoaW5rIEkgbWlzc2VkIHRvIHVwZGF0ZSB0byB0aGUgbGF0ZXN0IHZlcnNp
b24uIEJ1dCBJIHRoaW5rIG15IA0KcGF0Y2ggaXMgbW9yZSBlZmZpY2llbnQuIEJlY2F1c2UgSSBq
dXN0IHN5bmMgdGhlIGZyYW1lIGZyb20gdGhlIEhXLCBpdA0KIHdvbid0IGZhaWwgYW5kIHRoZXJl
IGlzIG5vIG5lZWQgdG8gZXh0cmEgdHJpZXMuDQoNCldoYXQgZG8geW91IHRoaW5rIGFib3V0IGl0
Pw0KDQpSZWdhcmRzDQpaZW5ndGFvDQo+LS0NCj5iYWxiaQ0KPg0KPiogVW5rbm93biBLZXkNCj4q
IDB4RTExQTk5MDYNCg==
