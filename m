Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6731C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E8A28055
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E8A28055
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936733AbeF2P0R convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:26:17 -0400
Received: from smtp-out4.electric.net ([192.162.216.182]:63001 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936716AbeF2P0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:26:16 -0400
Received: from 1fYvHT-0006Zw-Ua by out4b.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fYvHk-0007mZ-WB; Fri, 29 Jun 2018 08:26:08 -0700
Received: by emcmailer; Fri, 29 Jun 2018 08:26:08 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out4b.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fYvHT-0006Zw-Ua; Fri, 29 Jun 2018 08:25:51 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri,
 29 Jun 2018 16:27:30 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 29 Jun 2018 16:27:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Catalin Marinas' <catalin.marinas@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
CC:     Mark Rutland <Mark.Rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Will Deacon <Will.Deacon@arm.com>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        "Ramana Radhakrishnan" <ramana.radhakrishnan@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>, nd <nd@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kostya Serebryany <kcc@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: RE: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
Thread-Topic: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
Thread-Index: AQHUDu9rbN4071fNIk6NG/U94gtPMqR3XI1A
Date:   Fri, 29 Jun 2018 15:27:30 +0000
Message-ID: <a53c13e0cff941aa85f023b0f29346af@AcuMS.aculab.com>
References: <cover.1529507994.git.andreyknvl@google.com>
 <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
 <0cef1643-a523-98e7-95e2-9ec595137642@arm.com>
 <20180627171757.amucnh5znld45cpc@armageddon.cambridge.arm.com>
 <20180628061758.j6bytsaj5jk4aocg@ltop.local>
 <20180628102741.vk6vphfinlj3lvhv@armageddon.cambridge.arm.com>
 <20180628104610.czsnq4w3lfhxrn53@ltop.local>
 <20180628144858.2fu7kq56cxhp2kpg@armageddon.cambridge.arm.com>
In-Reply-To: <20180628144858.2fu7kq56cxhp2kpg@armageddon.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS:  TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas
> Sent: 28 June 2018 15:49
...
> >
> > Mmmm yes.
> > I tend to favor a sort of opposite approach. When we have an address
> > that must not be dereferenced as-such (and sometimes when the address
> > can be from both __user & __kernel space) I prefer to use a ulong
> > which will force the use of the required operation before being
> > able to do any sort of dereferencing and this won't need horrible
> > casts with __force (it, of course, all depends on the full context).
> 
> I agree. That's what the kernel uses in functions like get_user_pages()
> which take ulong as an argument. Similarly mmap() and friends don't
> expect the pointer to be dereferenced, hence the ulong argument. The
> interesting part that the man page (and the C library header
> declaration) shows such address argument as void *. We could add a
> syscall wrapper in the arch code, only that it doesn't feel consistent
> with the "rule" that ulong addresses are not actually tagged pointers.

For most modern calling conventions it would make sense to put 'user'
addresses (and physical ones from that matter) into a structure.
That way you get much stronger typing from C itself.

The patch would, of course, be huge!

	David

