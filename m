Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A11C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6B62086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6B62086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbeK1CrG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:47:06 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:45880 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730013AbeK1CrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:47:05 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-43-TJ7REvOqNcSdFZptTwF23g-1; Tue, 27 Nov 2018 15:48:43 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 27 Nov 2018 15:48:52 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 27 Nov 2018 15:48:52 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Russell King - ARM Linux' <linux@armlinux.org.uk>,
        Rafael David Tinoco <rafael.tinoco@linaro.org>
CC:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] arm: always update thread_info->syscall
Thread-Topic: [PATCH] arm: always update thread_info->syscall
Thread-Index: AQHUhmb52oWCe+dDS0S+Iz4HpqFCoKVjxFTA
Date:   Tue, 27 Nov 2018 15:48:52 +0000
Message-ID: <23ea6d5cbaac4cc3ad60d6184bbd1997@AcuMS.aculab.com>
References: <20181126225335.10477-1-rafael.tinoco@linaro.org>
 <20181126233303.GZ30658@n2100.armlinux.org.uk>
 <20181126234111.GA30658@n2100.armlinux.org.uk>
 <20181126234456.GB30658@n2100.armlinux.org.uk>
 <ad23e3dc-eee0-f9af-2f12-bfd7a14cd546@linaro.org>
 <20181127105620.GD30658@n2100.armlinux.org.uk>
 <20181127153553.GE30658@n2100.armlinux.org.uk>
In-Reply-To: <20181127153553.GE30658@n2100.armlinux.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: TJ7REvOqNcSdFZptTwF23g-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King - ARM Linux
> Sent: 27 November 2018 15:36
...
> There appears to be no documentation at all of this interface, so there
> is no definition of how it is supposed to work or what it is supposed
> to expose beyond what little information is in the original patch:
> 
>   http://lkml.iu.edu/hypermail/linux/kernel/0807.2/0577.html
> 
>    This adds /proc/PID/syscall and /proc/PID/task/TID/syscall magic files.
>    These use task_current_syscall() to show the task's current system call
>    number and argument registers, stack pointer and PC. For a task blocked
>    but not in a syscall, the file shows "-1" in place of the syscall number,
>    followed by only the SP and PC. For a task that's not blocked, it shows
>    "running".

I 'like' the way the columns for sp and pc jump about ...

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

