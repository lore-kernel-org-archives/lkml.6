Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDE6C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B51A20657
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MGlmwzGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B51A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbeH2WcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:32:09 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:47320 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeH2WcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:32:07 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0B80710C05B0;
        Wed, 29 Aug 2018 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535567638; bh=rPs8CSmnvIQBPse6oAl4TGnZi05VA0MJE8CAKgRjcS4=;
        h=From:To:CC:Subject:Date:From;
        b=MGlmwzGv7Dx4SbN2p7l1uT105spKrKRk6p94rnrz0Nv0WBSk2bERUpsfNMDuMaEGS
         Je73cbNXpmORA/B25zkOJBzpBJMeHK9Fg0mDRU8V0gJbZPP8n9gedq56LinyVvixR9
         Akf+0Os+k+7rXMYpjDH6qRGQy1mrufr6qRFVQQqNaoHl66Q+vAq1vPuqgEeaQFe36R
         r8rN5oJZS5S4pgFRxM6/ehVjSGVZCkTx7dhw+TGcoSQ6GK+DU6enhKD9qkylrM/NAb
         ULUOdQm5sWgtfN01A0RUShjyVOu/ouJw5RQySQC1EJE0sLZlQZ/+/xqmHwTIy52HD4
         otZtSy3lF0lvg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8F74942D2;
        Wed, 29 Aug 2018 11:33:57 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 29 Aug 2018 11:33:57 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Wed,
 29 Aug 2018 20:33:54 +0200
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Thread-Topic: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Thread-Index: AQHUP8bWpY6ZRO7qfEeDcvF8FJVDUg==
Date:   Wed, 29 Aug 2018 18:33:53 +0000
Message-ID: <1535567633.4465.23.camel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.36]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F67F572A3C91854BB3BC28E3C8138643@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3V5cywNClNpbmNlIHY0LjE5LXJjMSB3ZSBhcmUgZ2V0dGluZyBhIHNlcmlvdXMgcmVncmVz
c2lvbiBvbiBwbGF0Zm9ybXMgd2l0aCBBUkMgYXJjaGl0ZWN0dXJlLg0KVGhlIGtlcm5lbCBoYXZl
IGJlY29tZSB1bnN0YWJsZSBhbmQgc3BvbnRhbmVvdXNseSBjcmFzaGVzIG9uIExUUCB0ZXN0cyBl
eGVjdXRpb24gLyBJTyB0ZXN0cyBvcg0KZXZlbiBvbiBib290Lg0KDQpJIGRvbid0IGtub3cgZXhh
Y3RseSB3aGF0IGJyZWFrcyBidXQgYmlzZWN0IGNsZWFybHkgYXNzaWduIHRoZSBibGFtZSB0byB0
aGlzIGNvbW1pdDoNCjg0YzY1OTExMDNkYiAoImxvY2tpbmcvYXRvbWljcywgYXNtLWdlbmVyaWMv
Yml0b3BzL2xvY2suaDogUmV3cml0ZSB1c2luZyBhdG9taWNfZmV0Y2hfKigpIikNCmh0dHBzOi8v
Z2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9jb21taXQvODRjNjU5MTEwM2RiZWFmMzkzYTA5MmEz
ZmM3YjA5NTEwODI1ZjZiOQ0KDQpSZXZlcnRpbmcgdGhlIGNvbW1pdCBzb2x2ZXMgdGhpcyBwcm9i
bGVtLg0KDQpJIHRlc3RlZCB2NC4xOS1yYzEgb24gQVJNICh3YW5kYm9hcmQsIGkubXg2LCAzMmJp
dCwgcXVhcmQgY29yZSwgQVJNdjcpIHdoaWNoIHVzZXMgc2FtZQ0KZ2VuZXJpYyBiaXRvcHMgaW1w
bGVtZW50YXRpb24gYW5kIGl0IHdvcmtzIGZpbmUuDQoNCkRvIHlvdSBoYXZlIGFueSBpZGVhcyB3
aGF0IHdlbnQgd3Jvbmc/DQotLSANCiBFdWdlbml5IFBhbHRzZXY=
