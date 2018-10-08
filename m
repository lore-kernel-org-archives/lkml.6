Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7846C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1D92087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1D92087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeJHXOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:14:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37171 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbeJHXOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:14:00 -0400
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w98G1A7q671449
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 8 Oct 2018 09:01:10 -0700
Subject: Re: [PATCH stable v2 1/2] arch/alpha, termios: implement BOTHER,
 IBSHIFT and termios2
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Tobias Klausmann <klausman@schwarzvogel.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-alpha@vger.kernel.org, linux-serial@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, stable@vger.kernel.org
References: <20181008040620.1248277-1-hpa@zytor.com>
 <20181008040620.1248277-2-hpa@zytor.com> <20181008153840.GD3332@localhost>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <96b760ca-1faa-8bf7-5616-c16bfcf75ec4@zytor.com>
Date:   Mon, 8 Oct 2018 09:01:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181008153840.GD3332@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/18 8:38 AM, Johan Hovold wrote:
> On Sun, Oct 07, 2018 at 09:06:19PM -0700, H. Peter Anvin wrote:
>> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
>>
>> Alpha has had c_ispeed and c_ospeed, but still set speeds in c_cflags
>> using arbitrary flags. Because BOTHER is not defined, the general
>> Linux code doesn't allow setting arbitrary baud rates, and because
>> CBAUDEX == 0, we can have an array overrun of the baud_rate[] table in
>> drivers/tty/tty_baudrate.c if (c_cflags & CBAUD) == 037.
>>
>> Resolve both problems by #defining BOTHER to 037 on Alpha.
>>
>> However, userspace still needs to know if setting BOTHER is actually
>> safe given legacy kernels (does anyone actually care about that on
>> Alpha anymore?), so enable the TCGETS2/TCSETS*2 ioctls on Alpha, even
>> though they use the same structure. Define struct termios2 just for
>> compatibility; it is the exact same structure as struct termios. In a
>> future patchset, this will be cleaned up so the uapi headers are
>> usable from libc.
> 
> Is this really needed? By defining BOTHER (and IBSHIFT which you forgot
> to mention here) you are enabling arbitrary rates also through TCSETS on
> alpha, right?
> 

Yes, it's needed, not because the old ioctls won't work on NEW kernels, but
because Alpha is so far behind the times, *and* the OLD kernels are severely
broken if we pass BOTHER to them, we need a new ioctl number so we can
guarantee that we won't do anything that user space doesn't intend; this is
actually made far worse because if I read the code correctly, the kernel will
still report back BOTHER and the speed field set on a legacy kernel in
response to TCGETS, but the values will be completely bogus.

This means that glibc will need a workaround for Alpha only, and the new ioctl
numbers handles support for it.  gcc should be able to fold the code together,
since it should be able to detect that multiple branches of execution are
otherwise identical.

To micro-optimize, we could define TERMIOS_OLD as (CBAUDEX ? 8 : 0) in a
future (non-stable) patch.

We don't need to worry about it on PowerPC because PowerPC implemented this so
long ago, before the current glibc support threshold.

	-hpa

