Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA7AC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEF0214F0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="FtHDgPF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEF0214F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933824AbeGFRZw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:25:52 -0400
Received: from alln-iport-5.cisco.com ([173.37.142.92]:27359 "EHLO
        alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932834AbeGFRZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:25:51 -0400
X-Greylist: delayed 567 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Jul 2018 13:25:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1992; q=dns/txt; s=iport;
  t=1530897951; x=1532107551;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1pgSJ37zrJeHoIAH4YJTipKpG0nHoUOXpM7HabqvPZ0=;
  b=FtHDgPF3Q8/TFychLz2z8BGTVSpj5hWnrvs+cYpeknS0MlKAeAsuKPZM
   rkLxqamnWxkE+R7h+1WnCzn7b8tgUhNgkGPkUCJS/LpaIE3lpJC4zsmz4
   f8DnlmZVh1R20IX4SGYaZ8eo73zsKITlf3TDdIgetD6OefYzvktqvdJ3v
   c=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AcAgDM+T5b/4YNJK1cGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYNJgWEoCoNwiASMNYFlIoM4kXiBeguEbAIXghYhNBgBAgE?=
 =?us-ascii?q?BAgEBAm0ohTcBBSMRRRACAQgYAgImAgICMBUQAgQOBYMgggCpJIIciE+BOoE?=
 =?us-ascii?q?Lh2KBVj+BDycMglyHezGCJAKZTwkCjyCNWJFkAhETAYEkHTiBUnAVZQGCPpB?=
 =?us-ascii?q?Sb444gRoBAQ?=
X-IronPort-AV: E=Sophos;i="5.51,317,1526342400"; 
   d="scan'208";a="138990730"
Received: from alln-core-12.cisco.com ([173.36.13.134])
  by alln-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 17:16:24 +0000
Received: from XCH-RTP-001.cisco.com (xch-rtp-001.cisco.com [64.101.220.141])
        by alln-core-12.cisco.com (8.14.5/8.14.5) with ESMTP id w66HGNvX008238
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 6 Jul 2018 17:16:23 GMT
Received: from xch-rtp-001.cisco.com (64.101.220.141) by XCH-RTP-001.cisco.com
 (64.101.220.141) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 6 Jul
 2018 13:16:22 -0400
Received: from xch-rtp-001.cisco.com ([64.101.220.141]) by
 XCH-RTP-001.cisco.com ([64.101.220.141]) with mapi id 15.00.1320.000; Fri, 6
 Jul 2018 13:16:22 -0400
From:   "Nikunj Kela (nkela)" <nkela@cisco.com>
To:     Will Deacon <will.deacon@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        "xe-kernel@external.cisco.com" <xe-kernel@external.cisco.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: add ARM64-specific support for flatmem
Thread-Topic: [PATCH v2] arm64: add ARM64-specific support for flatmem
Thread-Index: AQHUFUsZiijVNzwhgEadqe/tuBgDDaSCr8aAgAAC0QA=
Date:   Fri, 6 Jul 2018 17:16:22 +0000
Message-ID: <F20899F9-18BB-4842-A40D-456776B78579@cisco.com>
References: <20180706170215.56116-1-nkela@cisco.com>
 <20180706170617.GB4961@arm.com>
In-Reply-To: <20180706170617.GB4961@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.41.48.64]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8616769D761CA84CAAC0DB15F74835D7@emea.cisco.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBtaWdodCBiZSB3cm9uZyBidXQgSSB3YXMgdW5kZXIgdGhlIGltcHJlc3Npb24gdGhhdCBTcGFy
c2UgbWVtb3J5IGlzIG9ubHkgb2YgdXNlIG9uIE5VTUEgc3lzdGVtcyBvciBzeXN0ZW1zIHN1cHBv
cnRpbmcgaG90IHBsdWdnYWJsZSBtZW1vcnkuIHRoZSBOT0RFX0RBVEEoKSBtYWNybyBuZWVkcyB0
byBiZSBzd2l0Y2hlZCBvbiBOVU1BLCBidXQgbm90IG9uIEZMQVRNRU0uIEkgYm9ycm93ZWQgdGhp
cyBkZXBlbmRlbmN5IGZyb20geDg2IEtjb25maWcuIElmIHRoaXMgaXMgbm90IG5lZWRlZCwgSSB3
aWxsIHJlbW92ZSBpdC4NCg0KVGhhbmtzLA0KLU5pa3Vuag0KDQpPbiA3LzYvMTgsIDEwOjA1IEFN
LCAiV2lsbCBEZWFjb24iIDx3aWxsLmRlYWNvbkBhcm0uY29tPiB3cm90ZToNCg0KICAgIE9uIEZy
aSwgSnVsIDA2LCAyMDE4IGF0IDEwOjAyOjE1QU0gLTA3MDAsIE5pa3VuaiBLZWxhIHdyb3RlOg0K
ICAgID4gRmxhdG1lbSBpcyB1c2VmdWwgaW4gcmVkdWNpbmcga2VybmVsIG1lbW9yeSB1c2FnZS4N
CiAgICA+IE9uZSB1c2VjYXNlIGlzIGluIGtkdW1wIGtlcm5lbC4gV2UgYXJlIGFibGUgdG8gc2F2
ZQ0KICAgID4gfjE0TSBieSBtb3ZpbmcgdG8gZmxhdG1lbSBzY2hlbWUuDQogICAgPiANCiAgICA+
IENjOiB4ZS1rZXJuZWxAZXh0ZXJuYWwuY2lzY28uY29tDQogICAgPiBDYzogTmlrdW5qIEtlbGEg
PG5rZWxhQGNpc2NvLmNvbT4NCiAgICA+IFNpZ25lZC1vZmYtYnk6IE5pa3VuaiBLZWxhIDxua2Vs
YUBjaXNjby5jb20+DQogICAgPiAtLS0NCiAgICA+ICBhcmNoL2FybTY0L0tjb25maWcgfCA0ICsr
KysNCiAgICA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQogICAgPiANCiAgICA+
IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L0tjb25maWcgYi9hcmNoL2FybTY0L0tjb25maWcNCiAg
ICA+IGluZGV4IDQyYzA5MGMuLjk2YWI5YTcgMTAwNjQ0DQogICAgPiAtLS0gYS9hcmNoL2FybTY0
L0tjb25maWcNCiAgICA+ICsrKyBiL2FyY2gvYXJtNjQvS2NvbmZpZw0KICAgID4gQEAgLTc3NSw2
ICs3NzUsMTAgQEAgY29uZmlnIEFSQ0hfU1BBUlNFTUVNX0RFRkFVTFQNCiAgICA+ICBjb25maWcg
QVJDSF9TRUxFQ1RfTUVNT1JZX01PREVMDQogICAgPiAgCWRlZl9ib29sIEFSQ0hfU1BBUlNFTUVN
X0VOQUJMRQ0KICAgID4gIA0KICAgID4gK2NvbmZpZyBBUkNIX0ZMQVRNRU1fRU5BQkxFDQogICAg
PiArCWRlZl9ib29sIHkNCiAgICA+ICsJZGVwZW5kcyBvbiAhTlVNQQ0KICAgIA0KICAgIEkgc3Rp
bGwgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHRoaXMgaGFzIHRvIGRvIHdpdGggTlVNQS4gU1BBUlNF
TUVNIGlzIHN0aWxsDQogICAgZ29pbmcgdG8gYmUgd2hhdCB5b3Ugd2FudCBvbiBhIG5vbi1OVU1B
IHN5c3RlbSB3aXRoIGxhcmdlIGhvbGVzIGluIHRoZQ0KICAgIHBoeXNpY2FsIG1lbW9yeSBtYXAs
IG5vPw0KICAgIA0KICAgIFdpbGwNCiAgICANCg0K
