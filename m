Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E55C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 01:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B9321782
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 01:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Y9i5DOku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B9321782
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbeHDDCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 23:02:17 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:25816 "EHLO
        rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731959AbeHDDCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 23:02:17 -0400
X-Greylist: delayed 562 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Aug 2018 23:02:16 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=612; q=dns/txt; s=iport;
  t=1533344617; x=1534554217;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i+8AVuM633G7eRYKqNPFYQQrerSU+gCdN93m7BrkLAg=;
  b=Y9i5DOkuMnF+oZAS2PYShUafic8VAW/D5ES34nH+T2st1g4HAZJESx/h
   ku12vIeMk5hNjSkZcrHX7AewZmpF9euVQeHI9i1Ods9s5YKcd6SGuYBt2
   013jRhH2d1Tv+LAcftilSbyUPTfi+XGuiTh3Y6YBJO0xjRhGils8dJKkN
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DRAACB+GRb/4sNJK1cGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYNOgWIoCoN0iAmMRoINgzuSI4F6C4RsAheCdyE0GAECAQE?=
 =?us-ascii?q?CAQECbSiFNwEFIxFFEAIBCBgCAiYCAgIwFRACBAENBYUgsTSBLopTgQuHfhe?=
 =?us-ascii?q?BQT+BEoMShH6DAYJVApotCQKPQoE8AYxcK5IEAhEUgSQdOIFScBWDJJBTb48?=
 =?us-ascii?q?JgRsBAQ?=
X-IronPort-AV: E=Sophos;i="5.51,441,1526342400"; 
   d="scan'208";a="430236787"
Received: from alln-core-6.cisco.com ([173.36.13.139])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Aug 2018 00:54:16 +0000
Received: from XCH-ALN-020.cisco.com (xch-aln-020.cisco.com [173.36.7.30])
        by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id w740sGkt015365
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Sat, 4 Aug 2018 00:54:16 GMT
Received: from xch-rcd-012.cisco.com (173.37.102.22) by XCH-ALN-020.cisco.com
 (173.36.7.30) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 3 Aug
 2018 19:54:16 -0500
Received: from xch-rcd-012.cisco.com ([173.37.102.22]) by
 XCH-RCD-012.cisco.com ([173.37.102.22]) with mapi id 15.00.1320.000; Fri, 3
 Aug 2018 19:54:15 -0500
From:   "Govindarajulu Varadarajan (gvaradar)" <gvaradar@cisco.com>
To:     "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>,
        "_govind@gmx.com" <_govind@gmx.com>,
        "Christian Benvenuti (benve)" <benve@cisco.com>,
        "Parvi Kaustubhi (pkaustub)" <pkaustub@cisco.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: cisco: enic: Replace GFP_ATOMIC with GFP_KERNEL
Thread-Topic: [PATCH] net: cisco: enic: Replace GFP_ATOMIC with GFP_KERNEL
Thread-Index: AQHUK42q4On1LPy0O0elj9HXJYNlKQ==
Date:   Sat, 4 Aug 2018 00:54:15 +0000
Message-ID: <4fefa848e281ffa5380eddee1b77553b48b0da09.camel@cisco.com>
References: <20180804004009.18928-1-baijiaju1990@gmail.com>
In-Reply-To: <20180804004009.18928-1-baijiaju1990@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.155.164.154]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6938C1B122002541960DCE584C01181A@emea.cisco.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-SMTP-Client: 173.36.7.30, xch-aln-020.cisco.com
X-Outbound-Node: alln-core-6.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDE4LTA4LTA0IGF0IDA4OjQwICswODAwLCBKaWEtSnUgQmFpIHdyb3RlOg0KPiB2
bmljX2Rldl9yZWdpc3RlcigpLCB2bmljX3JxX2FsbG9jX2J1ZnMoKSBhbmQgdm5pY193cV9hbGxv
Y19idWZzKCkgDQo+IGFyZSBuZXZlciBjYWxsZWQgaW4gYXRvbWljIGNvbnRleHQuDQo+IFRoZXkg
Y2FsbCBremFsbG9jKCkgd2l0aCBHRlBfQVRPTUlDLCB3aGljaCBpcyBub3QgbmVjZXNzYXJ5Lg0K
PiBHRlBfQVRPTUlDIGNhbiBiZSByZXBsYWNlZCB3aXRoIEdGUF9LRVJORUwuDQo+IA0KPiBUaGlz
IGlzIGZvdW5kIGJ5IGEgc3RhdGljIGFuYWx5c2lzIHRvb2wgbmFtZWQgRENOUyB3cml0dGVuIGJ5
IG15c2VsZi4NCg0KTG9va3MgZ29vZCB0byBtZS4gVGhhbmtzIHlvdS4NCg0KQWNrZWQtYnk6IEdv
dmluZGFyYWp1bHUgVmFyYWRhcmFqYW4gPGd2YXJhZGFyQGNpc2NvLmNvbT4NCg==
