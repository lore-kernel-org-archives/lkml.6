Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B15C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032852082B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032852082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeJXA1i convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:27:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45123 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbeJXA1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:27:37 -0400
Received: from [IPv6:2607:fb90:3611:d0a3:6080:aaf0:a987:a514] ([172.58.37.89])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w9NG2vXK3083724
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 23 Oct 2018 09:02:58 -0700
Date:   Tue, 23 Oct 2018 09:02:47 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20181023145351.GA28516@kroah.com>
References: <20181022161905.26589-1-hpa@zytor.com> <20181023145351.GA28516@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH stable v2 1/2] termios, tty/tty_baudrate.c: fix buffer overrun
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-alpha@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        stable@vger.kernel.org
From:   hpa@zytor.com
Message-ID: <DD4A5EC1-E0A8-4DB0-907F-F334C27CE54D@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 23, 2018 7:53:51 AM PDT, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>On Mon, Oct 22, 2018 at 09:19:04AM -0700, H. Peter Anvin (Intel) wrote:
>> From: "H. Peter Anvin" <hpa@zytor.com>
>> 
>> On architectures with CBAUDEX == 0 (Alpha and PowerPC), the code in
>tty_baudrate.c does
>> not do any limit checking on the tty_baudrate[] array, and in fact a
>> buffer overrun is possible on both architectures. Add a limit check
>to
>> prevent that situation.
>> 
>> This will be followed by a much bigger cleanup/simplification patch.
>> 
>> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
>> Requested-by: Cc: Johan Hovold <johan@kernel.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Jiri Slaby <jslaby@suse.com>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
>> Cc: Matt Turner <mattst88@gmail.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Kate Stewart <kstewart@linuxfoundation.org>
>> Cc: Philippe Ombredanne <pombredanne@nexb.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Eugene Syromiatnikov <esyr@redhat.com>
>> Cc: <linux-alpha@vger.kernel.org>
>> Cc: <linux-serial@vger.kernel.org>
>> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
>> Cc: <stable@vger.kernel.org>
>> ---
>>  drivers/tty/tty_baudrate.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
>As I think Al's big termios cleanups are going to be hitting Linus's
>tree soon, do you know how these patches interact with that?
>
>This patch seems like it will not, so I'll be glad to queue that up
>after my first round of patches get merged to Linus later this week,
>but
>the second one worries me.
>
>thanks,
>
>greg k-h

I have been working with Al; we had approached much the same problems but from different directions. Mine ended up being a bit more comprehensive as a result, so I think we're going to end up using my code with Al's reviews.

So bottom line is that it should be all good.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
