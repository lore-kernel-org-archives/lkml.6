Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4EDECDFB1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 03:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935A52086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 03:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935A52086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aspeedtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeGPECA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 00:02:00 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:57809 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeGPEB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 00:01:59 -0400
X-Greylist: delayed 1875 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jul 2018 00:01:57 EDT
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2])
        by twspam01.aspeedtech.com with ESMTP id w6G36Y5v092450
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 11:06:34 +0800 (CST)
        (envelope-from gary_hsu@aspeedtech.com)
Received: from mail.aspeedtech.com (twmbx02.aspeed.com [192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id w6G36SFB092436;
        Mon, 16 Jul 2018 11:06:28 +0800 (CST)
        (envelope-from gary_hsu@aspeedtech.com)
Received: from TWMBX01.aspeed.com (192.168.0.23) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.620.29; Mon, 16 Jul
 2018 11:05:26 +0800
Received: from TWMBX01.aspeed.com (192.168.0.23) by TWMBX01.aspeed.com
 (192.168.0.23) with Microsoft SMTP Server (TLS) id 15.0.620.29; Mon, 16 Jul
 2018 11:05:51 +0800
Received: from TWMBX01.aspeed.com ([fe80::157a:4af5:bbf4:5dbb]) by
 TWMBX01.aspeed.com ([fe80::157a:4af5:bbf4:5dbb%12]) with mapi id
 15.00.0620.020; Mon, 16 Jul 2018 11:05:51 +0800
From:   Gary Hsu <gary_hsu@aspeedtech.com>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "james.feist@linux.intel.com" <james.feist@linux.intel.com>,
        "vernon.mauery@linux.intel.com" <vernon.mauery@linux.intel.com>,
        "Benjamin Fair" <benjaminfair@google.com>,
        Patrick Venture <venture@google.com>,
        "Ryan Chen" <ryan_chen@aspeedtech.com>
Subject: RE: [PATCH] i2c: aspeed: Improve driver to support multi-master use
 cases stably
Thread-Topic: [PATCH] i2c: aspeed: Improve driver to support multi-master
 use cases stably
Thread-Index: AQHUGs4pYZmTV0v6jUONZuXHvtz+7qSM7oWAgAALlwCABDPtcA==
Date:   Mon, 16 Jul 2018 03:05:50 +0000
Message-ID: <a84da5d076924f40b1c836fe8b9d0844@TWMBX01.aspeed.com>
References: <20180626165812.4141-1-jae.hyun.yoo@linux.intel.com>
 <CAFd5g45z--ucXf-So517tgrayZT6x2TGvaUvaDF7zeRNn7CPXw@mail.gmail.com>
 <e51471e6-0f8a-bffc-34c8-1e74239fdbcf@linux.intel.com>
 <CAFd5g47j_h4ZrT8Eg1FZ8sAj5ekCUH20jUVub75ozdkg8_YW7Q@mail.gmail.com>
 <921b1ab7-9c9f-0aeb-da89-5a1a27d009f0@linux.intel.com>
 <d3f10fc1-635b-3a5d-a967-2816eac005fc@linux.intel.com>
 <CAFd5g47zdPdqqjVJtNHtFk+jKgciKbMcEH9M-W9rL4DgLM5hkg@mail.gmail.com>
 <b8232faa-58f5-f3a5-d12a-3f326cf1d03d@linux.intel.com>
In-Reply-To: <b8232faa-58f5-f3a5-d12a-3f326cf1d03d@linux.intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.0.80]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DKIM-Results: twmbx02.aspeed.com; dkim=none;
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com w6G36SFB092436
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFlLA0KDQpJbiBvcmlnaW5hbGx5LCB3ZSByZXNlcnZlZCB0aGVzZSByZWdpc3RlciBiaXRz
IGZvciBkZWJ1ZyBwdXJwb3NlLiBCdXQgZm9yIHNvbWUgZXJyb3IgaGFuZGxpbmcgY2FzZSwgd2Ug
Zm91bmQgaXQgaXMgYWxzbyB1c2VmdWwgdG8gaGVscCB0byBjbGFyaWZ5IHNvbWUgZXJyb3IgY29u
ZGl0aW9ucy4gU28gZHJpdmVyIGFsc28gY2FuIHVzZSB0aGVzZSBmaWVsZHMgaW5mb3JtYXRpb24g
dG8gY2hlY2sgc29tZXRoaW5nLg0KQXMgZm9yIGhvdyBkcml2ZXIgdXNlIHRoZXNlIGluZm9ybWF0
aW9uIGluIHRoZWlyIGNvZGUsIEkgaGF2ZSBubyBjb21tZW50LiBJIGRvbuKAmXQgdW5kZXJzdGFu
ZCB0aGUgZHJpdmVyLiBCdXQgdGhlc2UgaW5mb3JtYXRpb24gaXMgdGhlIHJlYWwgY29udHJvbGxl
ciBzdGF0ZSwgaXQgaGFkIG5vIHByb2JsZW0gdG8gdXNlIGluZm9ybWF0aW9uLg0KDQpCZXN0IFJl
Z2FyZHMsDQoNCuiosemmpeeWhyBHYXJ5IEhzdQ0KDQrkv6HpqYrnp5HmioDogqHku73mnInpmZDl
hazlj7gNCkFTUEVFRCBUZWNobm9sb2d5IEluYy4NCg0KMkYsTm8uMTUsSW5kdXN0cnkgRWFzdCBS
b2FkIDQuLEhzaW5jaHUgU2NpZW5jZSBQYXJrLCBIc2luY2h1IENpdHkgMzAwNzcsIFRhaXdhbg0K
5paw56u556eR5a245ZyS5Y2A5bel5qWt5p2x5Zub6LevIDE1IOiZnyAyRg0KDQpUZWwgOiA4ODYt
My01Nzg5NTY4IGV4dDo4MDcNCkZheCA6IDg4Ni0zLTU3ODk1ODYNCldlYiA6IGh0dHA6Ly93d3cu
YXNwZWVkdGVjaC5jb20NCg0KKioqKioqKioqKioqKiBFbWFpbCBDb25maWRlbnRpYWxpdHkgTm90
aWNlICoqKioqKioqKioqKioqKioqKioqDQrlhY3osqzogbLmmI46DQrlm6Dmh4nlgIvkurros4fm
lpnkv53orbfms5Xmlr3ooYws5pys5L+h5Lu2KOaIluWFtumZhOS7tinlj6/og73ljIXlkKvmqZ/l
r4bos4foqIrvvIzkuKblj5fms5Xlvovkv53orbfjgILlpoIg5Y+w56uv6Z2e5oyH5a6a5LmL5pS2
5Lu26ICF77yM6KuL5Lul6Zu75a2Q6YO15Lu26YCa55+l5pys6Zu75a2Q6YO15Lu25LmL55m86YCB
6ICFLCDkuKboq4vnq4vljbPliKrpmaTmnKzpm7vlrZDpg7Xku7blj4rlhbbpmYTku7blkozpirfm
r4DmiYDmnInopIfljbDku7bjgILorJ3orJ3mgqjnmoTlkIjkvZwhDQoNCkRJU0NMQUlNRVI6DQpU
aGlzIG1lc3NhZ2UgKGFuZCBhbnkgYXR0YWNobWVudHMpIG1heSBjb250YWluIGxlZ2FsbHkgcHJp
dmlsZWdlZCBhbmQvb3Igb3RoZXIgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uLiBJZiB5b3UgaGF2
ZSByZWNlaXZlZCBpdCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJlcGx5
IGUtbWFpbCBhbmQgaW1tZWRpYXRlbHkgZGVsZXRlIHRoZSBlLW1haWwgYW5kIGFueSBhdHRhY2ht
ZW50cyB3aXRob3V0IGNvcHlpbmcgb3IgZGlzY2xvc2luZyB0aGUgY29udGVudHMuIFRoYW5rIHlv
dS4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEphZSBIeXVuIFlvbyBbbWFp
bHRvOmphZS5oeXVuLnlvb0BsaW51eC5pbnRlbC5jb21dIA0KU2VudDogU2F0dXJkYXksIEp1bHkg
MTQsIDIwMTggMjo1NCBBTQ0KVG86IEJyZW5kYW4gSGlnZ2lucyA8YnJlbmRhbmhpZ2dpbnNAZ29v
Z2xlLmNvbT4NCkNjOiBCZW5qYW1pbiBIZXJyZW5zY2htaWR0IDxiZW5oQGtlcm5lbC5jcmFzaGlu
Zy5vcmc+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsgQW5kcmV3IEplZmZlcnkgPGFu
ZHJld0Bhai5pZC5hdT47IGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5vcmc7IE9wZW5CTUMgTWFpbGxp
c3QgPG9wZW5ibWNAbGlzdHMub3psYWJzLm9yZz47IExpbnV4IEFSTSA8bGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmc7IExp
bnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBq
YW1lcy5mZWlzdEBsaW51eC5pbnRlbC5jb207IHZlcm5vbi5tYXVlcnlAbGludXguaW50ZWwuY29t
OyBCZW5qYW1pbiBGYWlyIDxiZW5qYW1pbmZhaXJAZ29vZ2xlLmNvbT47IFBhdHJpY2sgVmVudHVy
ZSA8dmVudHVyZUBnb29nbGUuY29tPjsgR2FyeSBIc3UgPGdhcnlfaHN1QGFzcGVlZHRlY2guY29t
PjsgUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVkdGVjaC5jb20+DQpTdWJqZWN0OiBSZTogW1BB
VENIXSBpMmM6IGFzcGVlZDogSW1wcm92ZSBkcml2ZXIgdG8gc3VwcG9ydCBtdWx0aS1tYXN0ZXIg
dXNlIGNhc2VzIHN0YWJseQ0KDQpPbiA3LzEzLzIwMTggMTE6MTIgQU0sIEJyZW5kYW4gSGlnZ2lu
cyB3cm90ZToNCj4gT24gRnJpLCBKdWwgMTMsIDIwMTggYXQgMTA6MjIgQU0gSmFlIEh5dW4gWW9v
IA0KPiA8amFlLmh5dW4ueW9vQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gT24gNy8x
Mi8yMDE4IDExOjIxIEFNLCBKYWUgSHl1biBZb28gd3JvdGU6DQo+Pj4gT24gNy8xMi8yMDE4IDI6
MzMgQU0sIEJyZW5kYW4gSGlnZ2lucyB3cm90ZToNCj4+Pj4gT24gV2VkLCBKdW4gMjcsIDIwMTgg
YXQgMTA6NTUgQU0gSmFlIEh5dW4gWW9vIA0KPj4+PiA8amFlLmh5dW4ueW9vQGxpbnV4LmludGVs
LmNvbT4gd3JvdGU6DQo+IDxzbmlwPg0KPj4+PiA8c25pcD4NCj4+Pj4+Pj4gKyAgICAgICBmb3Ig
KDs7KSB7DQo+Pj4+Pj4+ICsgICAgICAgICAgICAgICBpZiAoIShyZWFkbChidXMtPmJhc2UgKyBB
U1BFRURfSTJDX0NNRF9SRUcpICYNCj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIChBU1BF
RURfSTJDRF9CVVNfQlVTWV9TVFMgfA0KPj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgIEFT
UEVFRF9JMkNEX1hGRVJfTU9ERV9TVFNfTUFTSykpKQ0KPj4+Pj4+DQo+Pj4+Pj4gSXMgdXNpbmcg
dGhlIFRyYW5zZmVyIE1vZGUgU3RhdGUgTWFjaGluZSBiaXRzIG5lY2Vzc2FyeT8gVGhlIA0KPj4+
Pj4+IGRvY3VtZW50YXRpb24gbWFya3MgaXQgYXMgImZvciBkZWJ1Z2dpbmcgcHVycG9zZSBvbmx5
LCIgc28gDQo+Pj4+Pj4gcmVseWluZyBvbiBpdCBtYWtlcyBtZSBuZXJ2b3VzLg0KPj4+Pj4+DQo+
Pj4+Pg0KPj4+Pj4gQXMgeW91IHNhaWQsIHRoZSBkb2N1bWVudGF0aW9uIG1hcmtzIGl0IGFzICJm
b3IgZGVidWdnaW5nIHB1cnBvc2Ugb25seS4iDQo+Pj4+PiBidXQgQVNQRUVEIGFsc28gdXNlcyB0
aGlzIHdheSBpbiB0aGVpciBTREsgY29kZSBiZWNhdXNlIGl0J3MgdGhlIA0KPj4+Pj4gYmVzdCB3
YXkgZm9yIGNoZWNraW5nIGJ1cyBidXN5IHN0YXR1cyB3aGljaCBjYW4gY292ZXIgYm90aCBzaW5n
bGUgDQo+Pj4+PiBhbmQgbXVsdGktbWFzdGVyIHVzZSBjYXNlcy4NCj4+Pj4+DQo+Pj4+DQo+Pj4+
IFdlbGwsIGl0IHdvdWxkIGFsc28gYmUgcmVhbGx5IG5pY2UgdG8gaGF2ZSBhY2Nlc3MgdG8gdGhp
cyBiaXQgaWYgDQo+Pj4+IHNvbWVvbmUgd2FudHMgdG8gaW1wbGVtZW50IE1DVFAuIENvdWxkIHdl
IG1heWJlIGNoZWNrIHdpdGggQXNwZWVkIA0KPj4+PiB3aGF0IHRoZW0gbWVhbnQgYnkgImZvciBk
ZWJ1Z2dpbmcgcHVycG9zZXMgb25seSIgYW5kIGRvY3VtZW50IGl0IA0KPj4+PiBoZXJlPyBJdCBt
YWtlcyBtZSBuZXJ2b3VzIHRvIHJlbHkgb24gZGVidWdnaW5nIGZ1bmN0aW9uYWxpdHkgZm9yIA0K
Pj4+PiBub3JtYWwgdXNhZ2UuDQo+Pj4+DQo+Pj4NCj4+PiBPa2F5LCBJJ2xsIGNoZWNrIGl0IHdp
dGggQXNwZWVkLiBXaWxsIGxldCB5b3Uga25vdyB0aGVpciByZXNwb25zZS4NCj4+Pg0KPj4NCj4+
IEkndmUgY2hlY2tlZCBpdCB3aXRoIEdhcnkgSHN1IDxnYXJ5X2hzdUBhc3BlZWR0ZWNoLmNvbT4g
YW5kIGhlIA0KPj4gY29uZmlybWVkIHRoYXQgdGhlIGJpdHMgcmVmbGVjdCByZWFsIGluZm9ybWF0
aW9uIGFuZCBnb29kIHRvIGJlIHVzZWQgDQo+PiBpbiBwcmFjdGljYWwgY29kZS4NCj4gDQo+IEh1
aC4gRm9yIG15IG93biBlZGlmaWNhdGlvbiwgY291bGQgeW91IGFzayB0aGVtIHdoeSB0aGV5IHNh
aWQgImZvciANCj4gZGVidWdnaW5nIHB1cnBvc2Ugb25seSIgaW4gdGhlIGRvY3VtZW50YXRpb24/
IEkgYW0ganVzdCByZWFsbHkgY3VyaW91cyANCj4gd2hhdCB0aGV5IG1lYW50IGJ5IHRoYXQuIEkg
d291bGQgYmUgc2F0aXNmaWVkIGlmIHlvdSBqdXN0IENDJ2VkIG1lIG9uIA0KPiB5b3VyIGVtYWls
IHRocmVhZCB3aXRoIEdhcnksIGFuZCBJIGNhbiBhc2sgaGltIG15c2VsZi4NCj4gDQoNCkkndmUg
YWxyZWFkeSBDQydlZCBHYXJ5IGFuZCBSeWFuIGluIHRoaXMgdGhyZWFkLg0KDQpIaSBHYXJ5LA0K
DQpDYW4geW91IGV4cGxhaW4gd2h5IHRoZSBkb2N1bWVudGF0aW9uIHNheXMgdGhhdCB0aGUgYml0
IGZpZWxkIGlzICdmb3IgZGVidWdnaW5nIHB1cnBvc2Ugb25seSc/IEFueSBwbGFuIHRvIGNoYW5n
ZSB0aGUgZGVzY3JpcHRpb24/DQoNClRoYW5rcywNCg0KSmFlDQoNCj4+DQo+PiBJJ2xsIGFkZCBh
IGNvbW1lbnQgbGlrZSBiZWxvdzoNCj4+DQo+PiAvKg0KPj4gICAgKiBUaGlzIGlzIG1hcmtlZCBh
cyAnZm9yIGRlYnVnZ2luZyBwdXJwb3NlIG9ubHknIGluIGRhdGFzaGVldCBidXQNCj4+ICAgICog
QVNQRUVEIGNvbmZpcm1lZCB0aGF0IHRoaXMgcmVmbGVjdHMgcmVhbCBpbmZvcm1hdGlvbiBhbmQg
Z29vZA0KPj4gICAgKiB0byBiZSB1c2VkIGluIHByYWN0aWNhbCBjb2RlLg0KPj4gICAgKi8NCj4+
DQo+PiBJcyBpdCBhY2NlcHRhYmxlIHRoZW4/DQo+IA0KPiBZZWFoLCB0aGF0J3MgZmluZS4NCj4g
DQo+IDxzbmlwPg0KPiANCj4gQ2hlZXJzDQo+IA0K
