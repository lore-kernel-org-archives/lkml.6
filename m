Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D860CC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 01:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6E3217B8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 01:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6E3217B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932199AbeGEBIv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 21:08:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:40715 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753172AbeGEBIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 21:08:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 18:08:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,309,1526367600"; 
   d="scan'208";a="55195318"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga006.jf.intel.com with ESMTP; 04 Jul 2018 18:08:48 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 4 Jul 2018 18:08:48 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 4 Jul 2018 18:08:48 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.100]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.17]) with mapi id 14.03.0319.002;
 Thu, 5 Jul 2018 09:08:46 +0800
From:   "Yang, Bin" <bin.yang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/mm: fix cpu stuck issue in
 __change_page_attr_set_clr
Thread-Topic: [PATCH] x86/mm: fix cpu stuck issue in
 __change_page_attr_set_clr
Thread-Index: AQHUDseZVh/k/cdi3Uy1ChlFZXY9E6R9B+GAgAEOxwCAABo1AIAAGosAgAABdYCAAA8QgIAAP2qAgAC6boA=
Date:   Thu, 5 Jul 2018 01:08:45 +0000
Message-ID: <E0B0C3E3-5AA5-4AEC-A11A-B55040A007C3@intel.com>
References: <1530180340-18593-1-git-send-email-bin.yang@intel.com>
 <alpine.DEB.2.21.1807031442030.1601@nanos.tec.linutronix.de>
 <0131cecd5d0456c2a109f4b8bdbfe558389671dd.camel@intel.com>
 <alpine.DEB.2.21.1807040849520.1816@nanos.tec.linutronix.de>
 <3224aae1d09788aba687fd7bd9e088f233016fc8.camel@intel.com>
 <alpine.DEB.2.21.1807041119260.1816@nanos.tec.linutronix.de>
 <34a76fad5c43c11ce8ceb491537b453d8053bdb2.camel@intel.com>
 <alpine.DEB.2.21.1807041221110.1816@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1807041221110.1816@nanos.tec.linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/f.26.0.170902
x-originating-ip: [10.239.200.247]
Content-Type: text/plain; charset="utf-8"
Content-ID: <42267E9A5DC3B94A8DE70805A7C26D20@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB3aGF0IG15IG5ldyBwYXRjaCB0cmllcyB0byBpbXByb3ZlLg0KDQpPbiAwNC8wNy8y
MDE4LCAxMDowMiBQTSwgIlRob21hcyBHbGVpeG5lciIgPHRnbHhAbGludXRyb25peC5kZT4gd3Jv
dGU6DQoNCiAgICAgIFRoZSBjaGVjayBsb29wIGl0c2VsZiBpcyBzdHVwaWQgYXMgd2VsbC4gSW5z
dGVhZCBvZiBsb29waW5nIGluIDRLIHN0ZXBzDQogICAgICB0aGUgdGhpbmcgY2FuIGJlIHJld3Jp
dHRlbiB0byBjaGVjayBmb3Igb3ZlcmxhcHBpbmcgcmFuZ2VzIGFuZCB0aGVuIGNoZWNrDQogICAg
ICBleHBsaWNpdGVseSBmb3IgdGhvc2UuIElmIHRoZXJlIGlzIG5vIG92ZXJsYXAgaW4gdGhlIGZp
cnN0IHBsYWNlIHRoZQ0KICAgICAgd2hvbGUgbG9vcCB0aGluZyBjYW4gYmUgYXZvaWRlZCwgYnV0
IHRoYXQncyBhIHB1cmUgb3B0aW1pemF0aW9uIGFuZCBuZWVkcw0KICAgICAgbW9yZSB0aG91Z2h0
IHRoYW4gdGhlIHN0cmFpZ2h0IGZvcndhcmQgYW5kIG9idmlvdXMgc29sdXRpb24gdG8gdGhlDQog
ICAgICBwcm9ibGVtIGF0IGhhbmQuDQoNCg==
