Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729DCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393CF20685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="glH1iuYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfAJUyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:54:46 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36380 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbfAJUyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:54:46 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so5322505pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 12:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=chBp/UJxnNpR33iIZVktfED5fzc5gbgR9UsUskuYUtU=;
        b=glH1iuYZk6oVDfYbYSwfvuDH7AgwH48SrUC5v93H6iTKUxdAo9ygM/PJGD8KoROHfb
         WUm6pwqVvp3IYVwNLwmQNl+1/68HyQugfMrfxVZGy476GhPXvjJLuREYwISYRoTuLMkI
         w08ptM+ju0X/qIPfSck3AhvnD2y7mEDcOMFj216ZcF8XgNSlD1yd86bhZkUnOd3dfdBQ
         HWDJnHRcZTLat4wqT/ejwfv1umsu5xg3PR5P55zo6SZrAFHDJOKQqDATTjac+r6uwiSy
         UNS2/ieAKUQlkbrwBT02TTvDNpq8I+J2XI9exKaNGukzkHtarMxIPu6M3LPLcYx3QgMg
         fmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:in-reply-to:cc:from:to
         :message-id:mime-version:content-transfer-encoding;
        bh=chBp/UJxnNpR33iIZVktfED5fzc5gbgR9UsUskuYUtU=;
        b=FdxVmX5t7/rsVBU0LxLypFzVrQbV4Z+QrXVAbJB2XZ87Jgdc+S/cYtYO5fgELVWI7F
         B0lyuHpQ1XlMe370aGuVsEpR3ZYhhMzSl5PZo7tKUvO94fnBSp/Qh1O4a5hXV2ybW5ot
         5pDaobP/OphuGExPvZZYTVZ5I+D41MgEejO64k0LdctN/aa5FvP8tMBSggMMvo+rIxmV
         BhEARe+zCMLEPe9hefzfNmoU8/dH1TN3xr7av9n2QvqWBQvj+LOhSY9f8Ho2k958EH+q
         HW9zyJDi4KGZESNK35at24By+K3UFkniXXnh3DCAWzGLRKJxnwXOt6vdfqBLMyJlJg9c
         2XKw==
X-Gm-Message-State: AJcUukf/dAdJllk4tujMojLTtxFH0udCkrPLRfkOpo0jQ2utZOMoVDo4
        DZUtvMWwfHQi76a9qBBwAa8BxA==
X-Google-Smtp-Source: ALg8bN5RBxFmh1I+e/aFlQnq1tmywMaJAYiUv558ldgWbIsEutV3BYGgnwlr0K+qGgwBFqIEyXU3Tg==
X-Received: by 2002:a63:955a:: with SMTP id t26mr10889818pgn.449.1547153684841;
        Thu, 10 Jan 2019 12:54:44 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 125sm98192116pfg.39.2019.01.10.12.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 12:54:44 -0800 (PST)
Date:   Thu, 10 Jan 2019 12:54:44 -0800 (PST)
X-Google-Original-Date: Thu, 10 Jan 2019 12:54:42 PST (-0800)
Subject:     Re: [PATCH] tty/serial: emit CR before NL in RISC-V SBL console
In-Reply-To: <mvm7efcedop.fsf@suse.de>
In-Reply-To: <CAAhSdy0suSgKpdz+NUrXzS9Ozp75hMC6ovW4yLf5s0KYJwwocw@mail.gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        aou@eecs.berkeley.edu, atish.patra@wdc.com,
        Christoph Hellwig <hch@infradead.org>, robh@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     schwab@suse.de, anup@brainfault.org
Message-ID: <mhng-e8479556-154c-443f-9d41-dc182aafa2ae@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 07:26:46 PST (-0800), schwab@suse.de wrote:
> On Jan 10 2019, Anup Patel <anup@brainfault.org> wrote:
>
>> Instead of doing '\n' handling here, we should do it in BBL or
>> OpenSBI (i.e. SBI runtime firmware) otherwise all users of
>> SBI_CONSOLE_PUTCHAR (namely, Linux, FreeBSD,
>> FreeRTOS, U-Boot S-mode, etc) will endup having '\n'
>> handling.
>
> I don't think the serial driver should do NLCR handling on its own,
> without being instructed by the tty layer.  Since the earlycon does not
> have a tty layer, it needs to handle it explicitly.

I think it's best if we have the SBI interfaces be defined to be bit-exact.  It
does mean that everyone who uses the interfaces needs to do this handling, but
I think that's actually a feature because it'll be subtly different everywhere.

This also has the advantage of being compatible with what we currently do in
BBL and what we current expect in Linux everywhere but this earlycon driver
(and will do assuming we merge this patch).

On Thu, 10 Jan 2019 08:17:07 PST (-0800), anup@brainfault.org wrote:
> On Thu, Jan 10, 2019 at 8:56 PM Andreas Schwab <schwab@suse.de> wrote:
>>
>> On Jan 10 2019, Anup Patel <anup@brainfault.org> wrote:
>>
>> > Instead of doing '\n' handling here, we should do it in BBL or
>> > OpenSBI (i.e. SBI runtime firmware) otherwise all users of
>> > SBI_CONSOLE_PUTCHAR (namely, Linux, FreeBSD,
>> > FreeRTOS, U-Boot S-mode, etc) will endup having '\n'
>> > handling.
>>
>> I don't think the serial driver should do NLCR handling on its own,
>> without being instructed by the tty layer.  Since the earlycon does not
>> have a tty layer, it needs to handle it explicitly.
>
> I tried to investigate more. What you suggest is correct
> but we should use uart_console_write() API.
>
> Instead of explicitly doing NLCR here, we should do
> something as follows:
>
> static void sbi_putc(struct uart_port *port, int c)
> {
>     sbi_console_putchar(c);
> }
>
> static void sbi_console_write(struct console *con,
>                                                const char *s, unsigned n)
> {
>     struct earlycon_device *dev = con->data;
>     uart_console_write(&dev->port, s, n, sbi_putc);
> }
>
> The uart_console_write() does the NLCR handling.

That does look cleaner.  I'll expect a v2 :)
