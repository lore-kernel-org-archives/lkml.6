Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C80C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F07B2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyODl0fw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F07B2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeJJVk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:40:27 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45595 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJJVk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:40:27 -0400
Received: by mail-qt1-f194.google.com with SMTP id e10-v6so5775430qtq.12;
        Wed, 10 Oct 2018 07:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=o0T2TmV6crCtyVy6hBkmVctjbws1EKETNgH0JZEpJq8=;
        b=YyODl0fwwIY1ceKhGqq8rGRi2g0o5SjRj6XWi3ONVggaPpZDvKdy/0ikDgyuyxbq8g
         NhpIQ4ajP9e+frJG4LZfZEpqPThuVfI2k0y6sCLWcdJpBLk/eQlbZiKEWKSP4FdOPaUo
         rX5FEwqVh/J4Lh6tXu39jgpQGieM/UaqYPcbOEmLGk1d2TGTACvPDjdmM72triY0wqgw
         obR0qFnUyScptYaTCEJ86WeC/ldQrtn/tWwCxkozBBfVLsAfGFF9O4O7rwt6Mw711xyc
         h+r4uYDC7uEHK4fp0OHNI6fyRogvcpDFzGjwTtUhti9K1aqKRVLEnNKJ/BSv5sjL+LqW
         eQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=o0T2TmV6crCtyVy6hBkmVctjbws1EKETNgH0JZEpJq8=;
        b=t4uqS9Jd2M1+YKklkeqZyhQH3DCFl8P8WNQNrV7wfa6eX3vgcYmyIuYlsIDtdddeSY
         oJTX4rI4vjnh3+MT0W+GiG71vdKJhry/XxX/3+pLE29FH0dtkRjTD0DFzmdBDIYzkoUJ
         5UwCcJKn/D0dP/f4YzpyfCo6mLDMhiOONUxDM4tGGshY1VDfeZT4iaShS2ISeyhVoLju
         eahp+XZuKia8JHfUUPOreoL1vYUi5VJe7fBqcXyJVOjui6BIbKCbwVJ/oyW22QZWlL1t
         qHyb/C0CwTzc2A9LN3JXquUQB0YtCYMihCr5XsohKNUEHPCvk896JL2FET+uWkntaDL6
         6LCQ==
X-Gm-Message-State: ABuFfohr9cfrpYnG0QbE72rYNTi7FKDCH7Et/VXnvGPGuQml3DmXiAn5
        ryiFHsLEPif81TgtCboG8ECZ2ot9QD4fKqrz5+0=
X-Google-Smtp-Source: ACcGV6226BVdh0ZaPCA5fqWNk8GC+c5LD6ZVB290ivsAQVWBml/u52KI9mlznsvISc+cFqb05z5c1oo8GKmLFyVN8uk=
X-Received: by 2002:ac8:2bf0:: with SMTP id n45-v6mr28359765qtn.152.1539181083472;
 Wed, 10 Oct 2018 07:18:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:524f:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 07:18:02
 -0700 (PDT)
In-Reply-To: <20181010141017.GA2881@asgard.redhat.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180724173957.GA22106@yury-thinkpad> <20181010141017.GA2881@asgard.redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 10 Oct 2018 16:18:02 +0200
X-Google-Sender-Auth: N9STCFFW8Mf7_bk3zldBY_o_r_8
Message-ID: <CAK8P3a2svZe6FHoNzjkizwwDZfRQ4Y7qpX0y4m6T56uo8n4gVQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     Yury Norov <ynorov@caviumnetworks.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Adam Borowski <kilobyte@angband.pl>,
        Alexander Graf <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Pavel Machek <pavel@ucw.cz>,
        Palmer Dabbelt <palmer@sifive.com>,
        Wookey <wookey@wookware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18, Eugene Syromiatnikov <esyr@redhat.com> wrote:
> On Tue, Jul 24, 2018 at 08:39:57PM +0300, Yury Norov wrote:
>> Hi all,
>>
>> + Pavel Machek, Palmer Dabbelt, Wookey.
>>
>> On Wed, May 16, 2018 at 11:18:45AM +0300, Yury Norov wrote:
>> > This series enables AARCH64 with ILP32 mode.
>> >
>> > As supporting work, it introduces ARCH_32BIT_OFF_T configuration
>> > option that is enabled for existing 32-bit architectures but disabled
>> > for new arches (so 64-bit off_t userspace type is used by new
>> > userspace).
>> > Also it deprecates getrlimit and setrlimit syscalls prior to prlimit64.
>> >
>> > Based on kernel v4.16. Tested with LTP, glibc testsuite, trinity,
>> > lmbench,
>> > CPUSpec.
>
>> This is the update of the series based on 4.17 kernel
>> https://github.com/norov/linux/tree/ilp32-4.17
>
> Hello.
>
> I have some questions regarding AArch64 ILP32 implementation for which I
> failed to find an answer myself:
>  * How ptrace() tracer is supposed to distinguish between ILP32 and LP64
>    tracees? For MIPS N32 and x32 this is possible based on syscall
>    number, but for AArch64 ILP32 I do not see such a sign. There's also
>    ARM_ip is employed for signalling entering/exiting, I wonder whether
>    it's possible to employ it also for signalling tracee's personality.

Don't know.

>  * What's the reasoning behind capping syscall arguments to 32 bit? x32
>    and MIPS N32 do not have such a restriction (and do not need special
>    wrappers for syscalls that pass 64-bit values as a result, except
>    when they do,  as it is the case for preadv2 on x32); moreover, that
>    would lead to insurmountable difficulties for AArch64 ILP32 tracers
>    that try to trace LP64 tracees, as it would be impossible to pass
>    64-bit addresses to process_vm_{read,write} or ptrace PEEK/POKE.

The idea is to keep the syscall entry points as similar as possible
between arm (aarch32) emulation and aarch64-ilp32 mode when
you have a kernel that supports both.

      Arnd
