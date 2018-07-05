Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E27AC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7EA240E9
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7EA240E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeGEFs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:48:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:33698 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752077AbeGEFs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:48:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 22:48:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,310,1526367600"; 
   d="scan'208";a="213546507"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga004.jf.intel.com with ESMTP; 04 Jul 2018 22:48:56 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 4 Jul 2018 22:48:56 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.100]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.57]) with mapi id 14.03.0319.002;
 Thu, 5 Jul 2018 13:48:54 +0800
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
Thread-Index: AQHUDseZVh/k/cdi3Uy1ChlFZXY9E6R9B+GAgAEOxwCAABo1AIAAGosAgAABdYCAAA8QgIAAP2qAgAC6boCAAEkLgIAABTsA
Date:   Thu, 5 Jul 2018 05:48:54 +0000
Message-ID: <404E7043-0ADB-4A40-9A07-EBE33F26C8CB@intel.com>
References: <1530180340-18593-1-git-send-email-bin.yang@intel.com>
 <alpine.DEB.2.21.1807031442030.1601@nanos.tec.linutronix.de>
 <0131cecd5d0456c2a109f4b8bdbfe558389671dd.camel@intel.com>
 <alpine.DEB.2.21.1807040849520.1816@nanos.tec.linutronix.de>
 <3224aae1d09788aba687fd7bd9e088f233016fc8.camel@intel.com>
 <alpine.DEB.2.21.1807041119260.1816@nanos.tec.linutronix.de>
 <34a76fad5c43c11ce8ceb491537b453d8053bdb2.camel@intel.com>
 <alpine.DEB.2.21.1807041221110.1816@nanos.tec.linutronix.de>
 <E0B0C3E3-5AA5-4AEC-A11A-B55040A007C3@intel.com>
 <alpine.DEB.2.21.1807050708320.1579@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1807050708320.1579@nanos.tec.linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/f.26.0.170902
x-originating-ip: [10.239.200.247]
Content-Type: text/plain; charset="utf-8"
Content-ID: <026DFEBBD79EFB43B0CE1C2CCD42CCB5@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgZm9yIHRoZSBtaXN1bmRlcnN0YW5kaW5nLiBJIG1lYW4gSSB3aWxsIGltcHJvdmUgdGhl
IGNoZWNrIGxvb3AgaW4gcGF0Y2ggdjIuIA0KSSBqdXN0IHN1Ym1pdHRlZCBwYXRjaCB2Mi4gVGhh
bmtzIGluIGFkdmFuY2UgZm9yIHlvdXIga2luZCByZXZpZXcuDQoNClRoYW5rcywNCkJpbg0KDQoN
Ck9uIDA1LzA3LzIwMTgsIDE6MzAgUE0sICJUaG9tYXMgR2xlaXhuZXIiIDx0Z2x4QGxpbnV0cm9u
aXguZGU+IHdyb3RlOg0KDQogICAgU29ycnksIEkgZG9uJ3Qgc2VlIGluIHdoaWNoIHdheSB5b3Vy
IHBhdGNoIHdvdWxkIGltcHJvdmUgdGhlIGNoZWNrIGxvb3AuDQoNCg==
