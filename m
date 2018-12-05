Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24763C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A4F214C1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A4F214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeLER63 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:58:29 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:56366 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbeLER63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:58:29 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id CAE3A149B5; Wed,  5 Dec 2018 17:58:26 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Abel <rabel@robertabel.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] auxdisplay: charlcd: fix x/y command parsing
References: <20181205135247.7964-1-mans@mansr.com>
        <CANiq72=Xg--8vG0+JLsPykOUfXpo89R2H-pBLuMROnQjMui7qA@mail.gmail.com>
Date:   Wed, 05 Dec 2018 17:58:26 +0000
In-Reply-To: <CANiq72=Xg--8vG0+JLsPykOUfXpo89R2H-pBLuMROnQjMui7qA@mail.gmail.com>
        (Miguel Ojeda's message of "Wed, 5 Dec 2018 17:47:31 +0100")
Message-ID: <yw1xr2evkg8t.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> Hi Mans,
>
> [CC'ing a few people involved previously on this]
>
> On Wed, Dec 5, 2018 at 2:53 PM Mans Rullgard <mans@mansr.com> wrote:
>>
>> Commit b34050fadb86 ("auxdisplay: charlcd: Fix and clean up handling of
>> x/y commands") fixed some problems by rewriting the parsing code,
>> but also broke things further by removing the check for a complete
>> command before attempting to parse it.  As a result, parsing is
>> terminated at the first x or y character.
>
> Why is it necessary to check for ";" to be exactly at the end? Or, in
> other words, what requires it?
>
> If the syntax supported by parse_xy() is wrong for some reason, we
> should fix that (instead of adding a check before calling it).

Suppose the command "\e[Lx0y0;" is written to the device.  The
charlcd_write_char() function adds one character at a time to the escape
sequence buffer.  Once the 'L' has been seen, it calls
handle_lcd_special_code() after each additional character is added.  On
encountering the 'x' this function will attempt to parse the command
using parse_xy(), which fails since it is incomplete.  It is nonetheless
reported as processed, and the escape sequence is flushed.  The
remainder of the command (i.e. "0y0;") is then displayed as text.

Since parse_xy() can never return success (true) unless there is a
semicolon, it is pointless to call it until we have seen one.  With the
characters being added to the buffer one by one, it is enough to check
for semicolon at the end.

BTW, the parsing of this command has been broken since 3.2-rc1 due to
commit 129957069e6a.

-- 
Måns Rullgård
