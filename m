Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F5BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1402421523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="lkOd2vwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1402421523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbeITLmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 07:42:22 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:33962 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731240AbeITLmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 07:42:21 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 9D62F5C00AC;
        Thu, 20 Sep 2018 08:00:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537423237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yss7WDeE6N1JOpb05H6mEzme9tKsi5DrbdtsDlW0LMU=;
        b=lkOd2vwO+pYMMeEm/grWR1HCxQhTuO0bUSWqUVHKbPaNNwxC6bM8lijxmJvzsGj4/COy5d
        qPeeQsbnlxED6FmQTP6rPRTCuXrMJV+01nui8xsuVcB72Q+ttoJ6/TeJapL51KdwjsSGj3
        qLS+ZyTaRXTxGWjS7FeiV08cZcNWq8Y=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Sep 2018 23:00:37 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Compiler Attributes: naked can be shared
In-Reply-To: <CANiq72kS_w7p3Xe9cDCjCA9j1u-zQ1-C4ZX7N8G+AbP4u7SG8w@mail.gmail.com>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
 <20180918165542.4691-3-miguel.ojeda.sandonis@gmail.com>
 <20180918173428.GA21591@kroah.com>
 <CANiq72=ZU61EaoWm2N4G1SZF0QUvzquULo50uEvDRU-hitOJVQ@mail.gmail.com>
 <20180919211458.GA8757@kroah.com>
 <CANiq72kS_w7p3Xe9cDCjCA9j1u-zQ1-C4ZX7N8G+AbP4u7SG8w@mail.gmail.com>
Message-ID: <6837090afde15cd5ee155dbfabb0d556@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.09.2018 16:00, Miguel Ojeda wrote:
> On Wed, Sep 19, 2018 at 11:14 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Tue, Sep 18, 2018 at 08:56:04PM +0200, Miguel Ojeda wrote:
>>> Hi Greg,
>>>
>>
>>> Since Linus/Andrew/you
>>> didn't comment on whether you wanted or not this for 4.19, we are
>>> assuming they would go in for 4.20. However, Stefan/Nick/... wanted
>>> this for 4.19 instead, they asked me to extract these patches two
>>> separately for 4.19. I let them comment further on the status of Clang
>>> on arm32.
>>
>> If these do not fix a regression, I don't see how they would be ready
>> for 4.19-final.

Clang on arm32 worked with v4.18 when using multi_v7_defconfig -CONFIG_EFI.

With 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually
exclusive") it broke on v4.19-rc1. IMHO this is a regression and we should
consider this two patches as a fix for it.


> 
> Ok, I will wait a bit to send v5 until this is sorted out.
> 
> [CC'd Nick, Stefan, Arnd: I just noticed the Reviewed-by/... lines
> were not picked as CC].

Oh yeah thanks, really did not notice the discussion around v2 until
you CC'd me now.

--
Stefan

> 
>>
>>> I am going to send a v5 of the entire series without these two
>>> patches, based on -rc4 (or -next, which one do you prefer? I would say
>>> these patches should be applied early in the -next branches, so that
>>> everyone is ready for the change, given it "touches" every translation
>>> unit).
>>
>> That's up to whomever takes these into their tree for linux-next
>> inclusion.  If you are about to break everything, then you might
>> consider changing your patches so they do not do that :)
>>
> 
> Well, the series shouldn't break anything (famous last words :), even
> if everyone includes those headers. So, in theory, they *could* be
> applied anywhere, anytime; but given they are global changes...
> 
> Cheers,
> Miguel
