Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99FEC43145
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDD6275BD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDD6275BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935018AbeF1PD0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:03:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:62024 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932522AbeF1PDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:03:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 08:03:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,284,1526367600"; 
   d="scan'208";a="241415657"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jun 2018 08:02:43 -0700
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 28 Jun 2018 08:02:43 -0700
Received: from lcsmsx154.ger.corp.intel.com (10.186.165.229) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 28 Jun 2018 08:02:43 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.94]) by
 LCSMSX154.ger.corp.intel.com ([169.254.7.135]) with mapi id 14.03.0319.002;
 Thu, 28 Jun 2018 18:02:41 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alan Cox <alan@linux.intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v7] tpm: separate cmd_ready/go_idle from runtime_pm
Thread-Topic: [PATCH v7] tpm: separate cmd_ready/go_idle from runtime_pm
Thread-Index: AQHUC/10xIwob4M80Eit0g6kz8euiKRw97kAgAABmYCAAg95gIABGJUAgAB58yCAAOLbgIAASgCg
Date:   Thu, 28 Jun 2018 15:02:39 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D95729D@hasmsx108.ger.corp.intel.com>
References: <20180624205202.6597-1-tomas.winkler@intel.com>
         <19b4282d625e04bb391f497419283a191bca610d.camel@linux.intel.com>
         <cb7ecb912486ee3e504de7c0918d667ebd370080.camel@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9D954923@hasmsx108.ger.corp.intel.com>
         <5c50d7fa2bf495f26443bd2da2e15df34c3d23f7.camel@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9D956753@hasmsx108.ger.corp.intel.com>
 <722fe86b2651d2616fa9bf43d9f8b1322f4c868b.camel@linux.intel.com>
In-Reply-To: <722fe86b2651d2616fa9bf43d9f8b1322f4c868b.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGM3M2YyNzctODIwMC00N2Y4LWE1ODktZTNkZWVhMjk2ZDg4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZHExWVpvMW9WV1JnRiszV0dsaWRmY1l3OGZ3bzJjd2ExdFNYMExhSEJxdGw2dzlNQU9DZlRyWk9oZ0dwemZBQiJ9
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.12.116.158]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gDQo+IE9uIFdlZCwgMjAxOC0wNi0yNyBhdCAyMToxMyArMDAwMCwgV2lua2xlciwgVG9t
YXMgd3JvdGU6DQo+ID4gVmVyeSB3ZWxsLCBJIHdpbGwgcmVtb3ZlIHRoZSBORVNURUQgZmxhZy4g
IHRob3VnaCBJIGhhdmUgZmVlbGluZyB5b3UNCj4gPiBhcmUgc2hvb3RpbmcgZnJvbSB0aGUgaGlw
IHlvdSBkaWRuJ3QgcmVhbGx5IHJlYWQgdGhlIGNvZGUuDQo+ID4gUGxlYXNlIHRoZXJlIGFueW9u
ZSB3aG8gY2FuIHJldmlldyB0aGUgY29kZT8NCj4gDQo+IEFza2luZyB0byBjaGFuZ2UgYSBtaW5v
ciB0aGluZyBpbiBhIHBhdGNoIGRvZXMgbm90IHJlYWxseSBmaXQgaW50byB0aGF0IHByb2ZpbGUu
DQo+IEkndmUgZXZlbiB0cmllZCB0aGUgcGF0Y2ggYSBmZXcgdGltZXMgaW4gaXQgc2VlbXMgdG8g
d29yayBqdXN0IGZpbmUuIFlvdSBhcmUNCj4gbWFraW5nIGEgYmlnIGRlYWwgb3V0IG9mIG5vdGhp
bmcuDQoNCkkgY2Fubm90IGFncmVlIHdpdGggeW91IGJ1dCBJIHdpbGwgc3VibWl0IGEgbmV3IHBh
dGNoLCBJIGdvdCB0aXJlZCB0byBleHBsYWluaW5nIGl0LiAgDQpOZWVkIHRvIHByb2dyZXNzIHdp
dGggaXQgZmluYWxseSwgdHBtIGlzIGZhaWxpbmcgdG8gcHJvYmUgb24gdGhvc2UgcGxhdGZvcm1z
IHNpbmNlIDQuMTYuDQoNClRoYW5rcw0KVG9tYXMuDQoNCg==
