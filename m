Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB04C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5414021916
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5414021916
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbeHFOzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:55:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:63409 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbeHFOzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:55:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 05:46:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="60224545"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga007.fm.intel.com with ESMTP; 06 Aug 2018 05:44:47 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 6 Aug 2018 05:44:46 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.124]) with mapi id 14.03.0319.002;
 Mon, 6 Aug 2018 20:44:44 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [PATCH v3 2/2] virtio_balloon: replace oom notifier with
 shrinker
Thread-Topic: [PATCH v3 2/2] virtio_balloon: replace oom notifier with
 shrinker
Thread-Index: AQHUKwiIDee4cjzfrU+xxAdAaZxPKaStafKAgAUXbID//4McgIAAqoJw
Date:   Mon, 6 Aug 2018 12:44:42 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7397222E8@SHSMSX101.ccr.corp.intel.com>
References: <1533285146-25212-1-git-send-email-wei.w.wang@intel.com>
 <1533285146-25212-3-git-send-email-wei.w.wang@intel.com>
 <16c56ee5-eef7-dd5f-f2b6-e3c11df2765c@i-love.sakura.ne.jp>
 <5B681B41.6070205@intel.com>
 <c8d25019-1990-f0dd-c83d-e4def5b5f7fe@i-love.sakura.ne.jp>
In-Reply-To: <c8d25019-1990-f0dd-c83d-e4def5b5f7fe@i-love.sakura.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWY2M2I2YzktZmU3Ni00ZjM2LWE3ZTAtODY4ZGQ0YzUwMmM2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiKzlhYWcyV3JSdkRZOVwvRVY4cHVnNlhLY0dGUE93WFg4aU5iYXVaWThPbFkrXC9nRCtQV0RuQXdGK0k0U1hFV1dwIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uZGF5LCBBdWd1c3QgNiwgMjAxOCA2OjI5IFBNLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMTgvMDgvMDYgMTg6NTYsIFdlaSBXYW5nIHdyb3RlOg0KPiA+IE9uIDA4LzAzLzIwMTgg
MDg6MTEgUE0sIFRldHN1byBIYW5kYSB3cm90ZToNCj4gPj4gT24gMjAxOC8wOC8wMyAxNzozMiwg
V2VpIFdhbmcgd3JvdGU6DQo+ID4+PiArc3RhdGljIGludCB2aXJ0aW9fYmFsbG9vbl9yZWdpc3Rl
cl9zaHJpbmtlcihzdHJ1Y3QgdmlydGlvX2JhbGxvb24NCj4gPj4+ICsqdmIpIHsNCj4gPj4+ICvC
oMKgwqAgdmItPnNocmlua2VyLnNjYW5fb2JqZWN0cyA9IHZpcnRpb19iYWxsb29uX3Nocmlua2Vy
X3NjYW47DQo+ID4+PiArwqDCoMKgIHZiLT5zaHJpbmtlci5jb3VudF9vYmplY3RzID0gdmlydGlv
X2JhbGxvb25fc2hyaW5rZXJfY291bnQ7DQo+ID4+PiArwqDCoMKgIHZiLT5zaHJpbmtlci5iYXRj
aCA9IDA7DQo+ID4+PiArwqDCoMKgIHZiLT5zaHJpbmtlci5zZWVrcyA9IERFRkFVTFRfU0VFS1M7
DQo+ID4+IFdoeSBmbGFncyBmaWVsZCBpcyBub3Qgc2V0PyBJZiB2YiBpcyBhbGxvY2F0ZWQgYnkg
a21hbGxvYyhHRlBfS0VSTkVMKQ0KPiA+PiBhbmQgaXMgbm93aGVyZSB6ZXJvLWNsZWFyZWQsIEtB
U0FOIHdvdWxkIGNvbXBsYWluIGl0Lg0KPiA+DQo+ID4gQ291bGQgeW91IHBvaW50IHdoZXJlIGlu
IHRoZSBjb2RlIHRoYXQgd291bGQgY29tcGxhaW4gaXQ/DQo+ID4gSSBvbmx5IHNlZSB0d28gc2hy
aW5rZXIgZmxhZ3MgKE5VTUFfQVdBUkUgYW5kIE1FTUNHX0FXQVJFKSwgYW5kDQo+IHRoZXkgc2Vl
bSBub3QgcmVsYXRlZCB0byB0aGF0Lg0KPiANCj4gV2hlcmUgaXMgdmItPnNocmlua2VyLmZsYWdz
IGluaXRpYWxpemVkPw0KDQpJcyB0aGF0IG1hbmRhdG9yeSB0byBiZSBpbml0aWFsaXplZD8gSSBm
aW5kIGl0J3Mgbm90IGluaXRpYWxpemVkIGluIG1vc3Qgc2hyaW5rZXJzIChlLmcuIHpzX3JlZ2lz
dGVyX3Nocmlua2VyLCBodWdlX3plcm9fcGFnZV9zaHJpbmtlcikuDQoNCkJlc3QsDQpXZWkNCg==
