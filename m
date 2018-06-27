Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E472CC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B47E26966
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B47E26966
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753312AbeF0H2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:28:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:22448 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752240AbeF0H2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:28:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 00:28:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,278,1526367600"; 
   d="scan'208";a="61744431"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jun 2018 00:28:03 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 27 Jun 2018 00:28:02 -0700
Received: from orsmsx111.amr.corp.intel.com ([169.254.12.50]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.44]) with mapi id 14.03.0319.002;
 Wed, 27 Jun 2018 00:28:02 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Dave Young <dyoung@redhat.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: RE: [PATCH] efi: Free existing memory map before installing new
 memory map
Thread-Topic: [PATCH] efi: Free existing memory map before installing new
 memory map
Thread-Index: AQHUDPc2R4ZR/m4foUijQgjP6VqzEKRyvjQAgADFEhCAAKGWgP//jMeQ
Date:   Wed, 27 Jun 2018 07:28:01 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F4605BAD9@ORSMSX111.amr.corp.intel.com>
References: <1529980892-11833-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu-_tQsYMUMp4NGrEkRrbFGJvE=vJVciaO6TEAC_u5bmfQ@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F4605BA0F@ORSMSX111.amr.corp.intel.com>
 <CAKv+Gu982OPp73Tg5Rru3+1ymq6_P8XpFPROQPdZMSUDdwEOmw@mail.gmail.com>
In-Reply-To: <CAKv+Gu982OPp73Tg5Rru3+1ymq6_P8XpFPROQPdZMSUDdwEOmw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzVlODZjODctOGZhMy00M2ZkLWIxNzUtNWY3MGFmOTM1MmUyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicjlOOGdBOE9vRzRsVGY0N2tIOW5RYjhKTkJjNHdzMytDRFVcL2d4dFhhS01lYUlNbFpXeFRyeEJkcWozME03a3QifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEFsc28sIGNvdWxkIHlvdSBwbGVhc2UgY2xhcmlmeSBpZiB0aGVyZSBpcyBhbnkgc3BlY2lm
aWMgcmVhc29uIHdoeQ0KPiA+IG1lbW9yeSBhbGxvY2F0ZWQgdXNpbmcgbWVtYmxvY2tfcmVzZXJ2
ZSgpIHNob3VsZG4ndCBiZSBmcmVlZC4gSSBtZWFuLA0KPiA+IG5vdCB3aXRoIG1lbWJsb2NrX2Zy
ZWUoKSBidXQgSSB0aGluayB3ZSBjb3VsZCBtYWtlIGl0IF9hdmFpbGFibGVfDQo+ID4gdXNpbmcg
ZnJlZV9ib290bWVtKCkgKG9yIHNvbWV0aGluZyBzaW1pbGFyLCBwbGVhc2UgY29ycmVjdCBtZSBp
ZiB0aGlzIGlzIG5vdA0KPiB0aGUgcmlnaHQgQVBJKS4NCj4gDQo+IE9uIGFybTY0LCB0aGUgbWVt
b3J5IG1hcCBpcyBwcm92aWRlZCB0byB0aGUgY29yZSBrZXJuZWwgYnkgdGhlIHN0dWIsIGFuZCBh
ZnRlcg0KPiBrZXhlYywgYSBwb2ludGVyIHRvIHRoZSBzYW1lIG1lbW9yeSBtYXAgd2lsbCBiZSBw
YXNzZWQgdG8gdGhlIG5leHQga2VybmVsLiBTbw0KPiB0aGUga2VybmVsIGRvZXMgbm90ICdvd24n
IHRoYXQgYWxsb2NhdGlvbiwgYW5kIGl0IHNob3VsZCBub3QgZnJlZSBpdCBvciBvdmVyd3JpdGUN
Cj4gaXQuDQoNClRoYW5rcyBmb3IgdGhlIHJlcGx5LiBJdCBjb25maXJtcyB0aGF0IHRoZSBpc3N1
ZSBpcyBvbmx5IG9uIHg4NiBzeXN0ZW1zLg0KSSBzZWUgdGhhdCBhcm02NCBkb2Vzbid0IGNhbGwg
ZWZpX21lbW1hcF9hbGxvYygpIGFuZCBoZW5jZSB0aGVyZSBpcyBubyBjb25jZXB0IA0Kb2YgYWxs
b2NhdGluZyBtZW1vcnkgZm9yIG5ldyBtZW1vcnkgbWFwIGFuZCBpbnN0YWxsaW5nIGl0IChzbyBu
byBtZW1vcnkgbGVhaykuDQoNClJlZ2FyZHMsDQpTYWkNCg==
