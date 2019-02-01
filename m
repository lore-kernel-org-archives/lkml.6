Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3991C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06D2218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfBAX3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:29:01 -0500
Received: from mga07.intel.com ([134.134.136.100]:62297 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbfBAX3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:29:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 15:29:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,550,1539673200"; 
   d="scan'208";a="140900530"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga004.fm.intel.com with ESMTP; 01 Feb 2019 15:28:59 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.210]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.11]) with mapi id 14.03.0415.000;
 Fri, 1 Feb 2019 15:28:58 -0800
From:   "Brown, Aaron F" <aaron.f.brown@intel.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [PATCH] e1000e: fix cyclic resets at link up with active tx
Thread-Topic: [PATCH] e1000e: fix cyclic resets at link up with active tx
Thread-Index: AQHUrA36STgAdegvDUGbeBsMRWZuiqXLs0TQ
Date:   Fri, 1 Feb 2019 23:28:57 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96621259@ORSMSX103.amr.corp.intel.com>
References: <154747257030.250168.12931902291381446144.stgit@buzz>
In-Reply-To: <154747257030.250168.12931902291381446144.stgit@buzz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbmV0ZGV2LW93bmVyQHZn
ZXIua2VybmVsLm9yZyBbbWFpbHRvOm5ldGRldi0NCj4gb3duZXJAdmdlci5rZXJuZWwub3JnXSBP
biBCZWhhbGYgT2YgS29uc3RhbnRpbiBLaGxlYm5pa292DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFy
eSAxNCwgMjAxOSA1OjMwIEFNDQo+IFRvOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBpbnRlbC13
aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgS2lyc2hlciwNCj4gSmVmZnJleSBUIDxqZWZmcmV5
LnQua2lyc2hlckBpbnRlbC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+DQo+IFN1YmplY3Q6IFtQQVRD
SF0gZTEwMDBlOiBmaXggY3ljbGljIHJlc2V0cyBhdCBsaW5rIHVwIHdpdGggYWN0aXZlIHR4DQo+
IA0KPiBJJ20gc2VlaW5nIHNlcmllcyBvZiBlMTAwMGUgcmVzZXRzIChzb21ldGltZXMgZW5kbGVz
cykgYXQgc3lzdGVtIGJvb3QNCj4gaWYgc29tZXRoaW5nIGdlbmVyYXRlcyB0eCB0cmFmZmljIGF0
IHRoaXMgdGltZS4gSW4gbXkgY2FzZSB0aGlzIGlzDQo+IG5ldGNvbnNvbGUgd2hvIHNlbmRzIG1l
c3NhZ2UgImUxMDAwZSAwMDAwOjAyOjAwLjA6IFNvbWUgQ1BVIEMtc3RhdGVzDQo+IGhhdmUgYmVl
biBkaXNhYmxlZCBpbiBvcmRlciB0byBlbmFibGUganVtYm8gZnJhbWVzIiBmcm9tIGUxMDAwZSBp
dHNlbGYuDQo+IEFzIHJlc3VsdCBlMTAwMF93YXRjaGRvZ190YXNrIHNlZXMgdXNlZCB0eCBidWZm
ZXIgd2hpbGUgY2FycmllciBpcyBvZmYNCj4gYW5kIHN0YXJ0IHRoaXMgcmVzZXQgY3ljbGUgYWdh
aW4uDQo+IA0KPiBbICAgMTcuNzk0MzU5XSBlMTAwMGU6IGV0aDEgTklDIExpbmsgaXMgVXAgMTAw
MCBNYnBzIEZ1bGwgRHVwbGV4LCBGbG93DQo+IENvbnRyb2w6IE5vbmUNCj4gWyAgIDE3Ljc5NDcx
NF0gSVB2NjogQUREUkNPTkYoTkVUREVWX0NIQU5HRSk6IGV0aDE6IGxpbmsgYmVjb21lcyByZWFk
eQ0KPiBbICAgMjIuOTM2NDU1XSBlMTAwMGUgMDAwMDowMjowMC4wIGV0aDE6IGNoYW5naW5nIE1U
VSBmcm9tIDE1MDAgdG8gOTAwMA0KPiBbICAgMjMuMDMzMzM2XSBlMTAwMGUgMDAwMDowMjowMC4w
OiBTb21lIENQVSBDLXN0YXRlcyBoYXZlIGJlZW4gZGlzYWJsZWQgaW4NCj4gb3JkZXIgdG8gZW5h
YmxlIGp1bWJvIGZyYW1lcw0KPiBbICAgMjYuMTAyMzY0XSBlMTAwMGU6IGV0aDEgTklDIExpbmsg
aXMgVXAgMTAwMCBNYnBzIEZ1bGwgRHVwbGV4LCBGbG93DQo+IENvbnRyb2w6IE5vbmUNCj4gWyAg
IDI3LjE3NDQ5NV0gODAyMXE6IDgwMi4xUSBWTEFOIFN1cHBvcnQgdjEuOA0KPiBbICAgMjcuMTc0
NTEzXSA4MDIxcTogYWRkaW5nIFZMQU4gMCB0byBIVyBmaWx0ZXIgb24gZGV2aWNlIGV0aDENCj4g
WyAgIDMwLjY3MTcyNF0gY2dyb3VwOiBjZ3JvdXA6IGRpc2FibGluZyBjZ3JvdXAyIHNvY2tldCBt
YXRjaGluZyBkdWUgdG8NCj4gbmV0X3ByaW8gb3IgbmV0X2NscyBhY3RpdmF0aW9uDQo+IFsgICAz
MC44OTg1NjRdIG5ldHBvbGw6IG5ldGNvbnNvbGU6IGxvY2FsIHBvcnQgNjY2Ng0KPiBbICAgMzAu
ODk4NTY2XSBuZXRwb2xsOiBuZXRjb25zb2xlOiBsb2NhbCBJUHY2IGFkZHJlc3MNCj4gMmEwMjo2
Yjg6MDo4MGI6YmVhZTpjNWZmOmZlMjg6MjNmOA0KPiBbICAgMzAuODk4NTY3XSBuZXRwb2xsOiBu
ZXRjb25zb2xlOiBpbnRlcmZhY2UgJ2V0aDEnDQo+IFsgICAzMC44OTg1NjhdIG5ldHBvbGw6IG5l
dGNvbnNvbGU6IHJlbW90ZSBwb3J0IDY2NjYNCj4gWyAgIDMwLjg5ODU2OF0gbmV0cG9sbDogbmV0
Y29uc29sZTogcmVtb3RlIElQdjYgYWRkcmVzcw0KPiAyYTAyOjZiODpiMDAwOjYwNWM6ZTYxZDoy
ZGZmOmZlMDM6Mzc5MA0KPiBbICAgMzAuODk4NTY5XSBuZXRwb2xsOiBuZXRjb25zb2xlOiByZW1v
dGUgZXRoZXJuZXQgYWRkcmVzcyBiMDphODo2ZTpmNDpmZjpjMA0KPiBbICAgMzAuOTE3NzQ3XSBj
b25zb2xlIFtuZXRjb24wXSBlbmFibGVkDQo+IFsgICAzMC45MTc3NDldIG5ldGNvbnNvbGU6IG5l
dHdvcmsgbG9nZ2luZyBzdGFydGVkDQo+IFsgICAzMS40NTMzNTNdIGUxMDAwZSAwMDAwOjAyOjAw
LjA6IFNvbWUgQ1BVIEMtc3RhdGVzIGhhdmUgYmVlbiBkaXNhYmxlZCBpbg0KPiBvcmRlciB0byBl
bmFibGUganVtYm8gZnJhbWVzDQo+IFsgICAzNC4xODU3MzBdIGUxMDAwZSAwMDAwOjAyOjAwLjA6
IFNvbWUgQ1BVIEMtc3RhdGVzIGhhdmUgYmVlbiBkaXNhYmxlZCBpbg0KPiBvcmRlciB0byBlbmFi
bGUganVtYm8gZnJhbWVzDQo+IFsgICAzNC4zMjE4NDBdIGUxMDAwZSAwMDAwOjAyOjAwLjA6IFNv
bWUgQ1BVIEMtc3RhdGVzIGhhdmUgYmVlbiBkaXNhYmxlZCBpbg0KPiBvcmRlciB0byBlbmFibGUg
anVtYm8gZnJhbWVzDQo+IFsgICAzNC40NjU4MjJdIGUxMDAwZSAwMDAwOjAyOjAwLjA6IFNvbWUg
Q1BVIEMtc3RhdGVzIGhhdmUgYmVlbiBkaXNhYmxlZCBpbg0KPiBvcmRlciB0byBlbmFibGUganVt
Ym8gZnJhbWVzDQo+IFsgICAzNC41OTc0MjNdIGUxMDAwZSAwMDAwOjAyOjAwLjA6IFNvbWUgQ1BV
IEMtc3RhdGVzIGhhdmUgYmVlbiBkaXNhYmxlZCBpbg0KPiBvcmRlciB0byBlbmFibGUganVtYm8g
ZnJhbWVzDQo+IFsgICAzNC43NDU0MTddIGUxMDAwZSAwMDAwOjAyOjAwLjA6IFNvbWUgQ1BVIEMt
c3RhdGVzIGhhdmUgYmVlbiBkaXNhYmxlZCBpbg0KPiBvcmRlciB0byBlbmFibGUganVtYm8gZnJh
bWVzDQo+IFsgICAzNC44NzczNTZdIGUxMDAwZSAwMDAwOjAyOjAwLjA6IFNvbWUgQ1BVIEMtc3Rh
dGVzIGhhdmUgYmVlbiBkaXNhYmxlZCBpbg0KPiBvcmRlciB0byBlbmFibGUganVtYm8gZnJhbWVz
DQo+IFsgICAzNS4wMDU0NDFdIGUxMDAwZSAwMDAwOjAyOjAwLjA6IFNvbWUgQ1BVIEMtc3RhdGVz
IGhhdmUgYmVlbiBkaXNhYmxlZCBpbg0KPiBvcmRlciB0byBlbmFibGUganVtYm8gZnJhbWVzDQo+
IFsgICAzNS4xNTczNzZdIGUxMDAwZSAwMDAwOjAyOjAwLjA6IFNvbWUgQ1BVIEMtc3RhdGVzIGhh
dmUgYmVlbiBkaXNhYmxlZCBpbg0KPiBvcmRlciB0byBlbmFibGUganVtYm8gZnJhbWVzDQo+IFsg
ICAzNS4yODkzNjJdIGUxMDAwZSAwMDAwOjAyOjAwLjA6IFNvbWUgQ1BVIEMtc3RhdGVzIGhhdmUg
YmVlbiBkaXNhYmxlZCBpbg0KPiBvcmRlciB0byBlbmFibGUganVtYm8gZnJhbWVzDQo+IFsgICAz
NS40MTc0NDFdIGUxMDAwZSAwMDAwOjAyOjAwLjA6IFNvbWUgQ1BVIEMtc3RhdGVzIGhhdmUgYmVl
biBkaXNhYmxlZCBpbg0KPiBvcmRlciB0byBlbmFibGUganVtYm8gZnJhbWVzDQo+IFsgICAzNy43
OTAzNDJdIGUxMDAwZTogZXRoMSBOSUMgTGluayBpcyBVcCAxMDAwIE1icHMgRnVsbCBEdXBsZXgs
IEZsb3cNCj4gQ29udHJvbDogTm9uZQ0KPiANCj4gVGhpcyBwYXRjaCBmbHVzaGVzIHR4IGJ1ZmZl
cnMgb25seSBvbmNlIHdoZW4gY2FycmllciBpcyBvZmYNCj4gcmF0aGVyIHRoYW4gYXQgZWFjaCB3
YXRjaGRvZyBpdGVyYXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLb25zdGFudGluIEtobGVi
bmlrb3YgPGtobGVibmlrb3ZAeWFuZGV4LXRlYW0ucnU+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvZTEwMDBlL25ldGRldi5jIHwgICAxNSArKysrKystLS0tLS0tLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQoNClRlc3Rl
ZC1ieTogQWFyb24gQnJvd24gPGFhcm9uLmYuYnJvd25AaW50ZWwuY29tPg0K
