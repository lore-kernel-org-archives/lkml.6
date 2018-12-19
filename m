Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF67C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C3F21850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeLSJee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:34:34 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:39641 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeLSJee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:34:34 -0500
Received: by mail-vk1-f196.google.com with SMTP id s184so2704399vkd.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 01:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kP4OYl/UGkDtH+eqiFuSPtZX1q5lXfw/UbogbL4CDMw=;
        b=MfG+ZEBJVF4w6HprgpYUXs9xMMxKEeXR3kaRr03nLkYK49ZycLSr+pAh6t7yP8Sejj
         K4rNQA7fXBUIWZEqaERWulWvkiCH2oX0Cytezu7BkXtq1qr7u3OvElDzIT23Re21jc3H
         W06HXdvYcjIFTn0HApgDb5+pljiUE80RzmTAC822EcOw9k8E8MERTjXWK3dg+CiOwrga
         lBNOzjjpLmnO3mz/psK6TZ5nBvEx0hpcltmPVnB2OGqIczIXyM1LC3U92zbB5ptR7Gar
         kYT/d9lGelXENX6i4HM+cCWb50jXby380eArcp43ud6E5p3jSeqq0Jrww+Ho3/dAYkLw
         e1Lw==
X-Gm-Message-State: AA+aEWZHIhg17FshTjEmRP4FixawkKRY5uhUEsQj0xqNAywD+KjrPdSf
        jF6FaGtYsBQVTFGYaCuJiGpROi/UVGzdK/rX/Jk=
X-Google-Smtp-Source: AFSGD/VNviDAL364I4qilN3gd+HZ+xShXYt0JXWIC4RjXBqosx+LsQMk0NG43D+eWpbrHQah4IEf8GF9Vrm77xKqIS0=
X-Received: by 2002:a1f:a414:: with SMTP id n20mr7018302vke.83.1545212072782;
 Wed, 19 Dec 2018 01:34:32 -0800 (PST)
MIME-Version: 1.0
References: <20181207165011.31497-1-geert@linux-m68k.org> <CAMuHMdXj67QnqeMHGr_TiEaJr6gUw5qzWFvaJvoVkm89Kiuq_Q@mail.gmail.com>
 <87o99pmib8.fsf@igel.home> <87a7l4rnb3.fsf@igel.home> <875zvsrlq4.fsf@igel.home>
In-Reply-To: <875zvsrlq4.fsf@igel.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Dec 2018 10:34:19 +0100
Message-ID: <CAMuHMdWvDohdrgDwgCBGt17Q7k1Wi=DJ2o-XSEO5vKDwH8OJnw@mail.gmail.com>
Subject: Re: [PATCH v3] m68k: Fix memblock-related crashes
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     rppt@linux.ibm.com, Michael Schmitz <schmitzmic@gmail.com>,
        Sam Creasey <sammy@sammy.net>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Mon, Dec 17, 2018 at 8:34 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Dez 17 2018, Andreas Schwab <schwab@linux-m68k.org> wrote:
> > On Dez 13 2018, Andreas Schwab <schwab@linux-m68k.org> wrote:
> >> I'm now getting this Oops:
> >>
> >> [   65.390000] Unable to handle kernel NULL pointer dereference at virtual address (ptrval)
> >> [   65.390000] Oops: 00000000
> >> [   65.390000] Modules linked in: nls_iso8859_1 nls_cp437 vfat fat virtio_rng virtio_blk virtio_ring virtio xfs btrfs xor zlib_deflate raid6_pq libcrc32c reiserfs squashfs fuse dm_snapshot dm_bufio dm_mod binfmt_misc loop sg
> >> [   65.390000] PC: [<00211544>] blk_throtl_bio+0x10e/0x592
> >
> > And the crash does not occur when I revert commit 1008a11590.
>
> That is not true, so this is an unrelated bug.

Thank you.

So I'll queue my patch as a late fix for v4.20.
Sun-3 can be fixed when someone can test Mike's suggestion.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
