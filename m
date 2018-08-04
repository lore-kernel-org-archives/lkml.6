Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900B0C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 10:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476A3217CD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 10:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476A3217CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=torlan.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeHDMD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 08:03:58 -0400
Received: from forward100j.mail.yandex.net ([5.45.198.240]:41415 "EHLO
        forward100j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726576AbeHDMD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 08:03:57 -0400
Received: from mxback1j.mail.yandex.net (mxback1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10a])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id 3F7415D86903;
        Sat,  4 Aug 2018 13:03:43 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ZgFeUbaMP1-3gWqNvtl;
        Sat, 04 Aug 2018 13:03:43 +0300
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id E88htQpck2-3fMCj9VM;
        Sat, 04 Aug 2018 13:03:42 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: LVM snapshot broke between 4.14 and 4.16
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>,
        Zdenek Kabelac <zkabelac@redhat.com>
References: <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
 <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
 <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
 <d76415de-2056-c7d6-cc88-b896deaa8ead@torlan.ru>
 <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
 <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
 <20180803133102.GA3092@redhat.com> <20180803152034.GD32066@thunk.org>
 <20180803183932.GA3258@redhat.com>
 <CA+55aFwGGjs_imFFkEPJ4g99Kseam=4Qppv4G6Q=ZfZXdzF7Vw@mail.gmail.com>
 <20180803190617.GA4498@redhat.com>
 <CA+55aFzSM6qhZpM4CCpRNR_LWNCbLyRtQQ3hnPwnRrBdDkwWUw@mail.gmail.com>
From:   WGH <wgh@torlan.ru>
Openpgp: preference=signencrypt
Message-ID: <a5feeaa7-e043-3987-cf23-4090e3eeec4a@torlan.ru>
Date:   Sat, 4 Aug 2018 13:01:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFzSM6qhZpM4CCpRNR_LWNCbLyRtQQ3hnPwnRrBdDkwWUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 10:22 PM, Linus Torvalds wrote:
> And in fact, maybe the right thing to do is to not revert the original
> commit entirely, but instead just weaken it a lot. Turn the "you did a
> write request on a RO disk" into a WARN_ON_ONCE() instead of a hard
> error.
>
> Something like the attached patch.
>
> WGH, do you build your own kernels? Does this attached (untested)
> patch make things work for you? It should give a big warning, but let
> the old behavior through..

The patch works for me.

However, there's no text messsage in the kernel log, just a traceback. I
think that's because WARN_ONCE is supposed to take condition as a first
argument.

