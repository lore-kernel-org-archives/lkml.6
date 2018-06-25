Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A89C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E3626043
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E3626043
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965100AbeFYSyV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 14:54:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:8687 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964861AbeFYSyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 14:54:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 11:54:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,271,1526367600"; 
   d="scan'208";a="235485969"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga005.jf.intel.com with ESMTP; 25 Jun 2018 11:54:18 -0700
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 25 Jun 2018 11:54:17 -0700
Received: from hasmsx112.ger.corp.intel.com (10.184.198.40) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 25 Jun 2018 11:54:17 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.94]) by
 HASMSX112.ger.corp.intel.com ([169.254.11.94]) with mapi id 14.03.0319.002;
 Mon, 25 Jun 2018 21:54:14 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v6] tpm: separate cmd_ready/go_idle from runtime_pm
Thread-Topic: [PATCH v6] tpm: separate cmd_ready/go_idle from runtime_pm
Thread-Index: AQHT/qWAvuZRuvUvB0qACxkSGWcwoaRmLekAgABIo+CABFFDAIAAV/SggAX72oCAAFIioA==
Date:   Mon, 25 Jun 2018 18:54:13 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9539B6@hasmsx108.ger.corp.intel.com>
References: <20180607212040.30989-1-tomas.winkler@intel.com>
         <20180618180406.GA20697@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9D94EA09@hasmsx108.ger.corp.intel.com>
         <20180621161958.GA11859@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9D9516CE@hasmsx108.ger.corp.intel.com>
 <7f90a0d8846650ce1e1d2598d980ab84da11cc70.camel@linux.intel.com>
In-Reply-To: <7f90a0d8846650ce1e1d2598d980ab84da11cc70.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzdjZjYyNGQtZTllOC00YmRjLWJmYjUtZTg5NWEyY2FiMzViIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoib0U0QXNTV01nNkxGUjFsNHRob2hZajY1OFVRcUI1ZzY4eVRoUE9zRk41Zmpic1hXcGRQT2hCcGNmYjA3R3JMMSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.252.28.198]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiBPbiBUaHUsIDIwMTgtMDYtMjEgYXQgMTg6NDAgKzAwMDAsIFdpbmtsZXIsIFRvbWFz
IHdyb3RlOg0KPiA+IEkganVzdCB3YW50ZWQgdG8gbWFrZSBzdXJlIHRoYXQgJ1JBVycgbm90IHVz
ZWQgaW4gdGhlIGFwaSBkaXJlY3RseSwgaXQNCj4gPiB3aWxsIGJyZWFrIHRoZSBmbG93LCBkbyBo
YXZlIGFueSBzdWdnZXN0aW9uIHRvIG1ha2UgaXQgb2J2aW91cy4NCj4gDQo+IFdlIHdpbGwgbG9v
ayBhdCBlYWNoIGNvZGUgcmV2aWV3IGFzIGZvciBhbnkgb3RoZXIgcGVhY2Ugb2YgY29kZSBob3cg
dGhpcyBmbGFnDQo+IGlzIHVzZWQgYW5kIG1ha2UgZGVjaXNpb25zIGF0IHRoYXQgcG9pbnQgd2hh
dCBpcyBsZWdpdCB1c2UgYW5kIHdoYXQgaXMgbm90Lg0KDQpUaGlzIGlzIG5vdCBhYm91dCBjb2Rl
IHJldmlldywgdGhlcmUgaXMgYSBkZXNpZ24gZGVjaXNpb24gdG8gaGlkZSBpdCwgdGhpcyBpcyB0
aGUgQVBJLg0KUGxlYXNlIHJlY29uc2lkZXIuDQpUaGFua3MNClRvbWFzDQoNCg0K
