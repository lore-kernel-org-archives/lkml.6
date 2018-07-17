Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95AFECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CBE206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSfc9KRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CBE206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbeGQWEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:04:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729742AbeGQWEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:04:34 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED2FC20835
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 21:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531863001;
        bh=vhzNjPZPH7URPqYqI6QDcxV7h7klUk6Hf2qBzSiEoHE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=NSfc9KRtDK3J5zF6VjHNhH4UTykZy1jAefYlij+dZ4y76rQfpwq6vVe8IBCG0R0CA
         B773183wuwq5zb7xDtFhU7WUgtr//ThTDNnKAHXrExvpILhI9Rt09tkYylfb6+NH8Q
         2kgNmRQq1/fD9CqQ0cansb8KbpbKrLJ5XZBNcehY=
Received: by mail-wr1-f52.google.com with SMTP id g6-v6so2602048wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:30:00 -0700 (PDT)
X-Gm-Message-State: AOUpUlFuEqO/MdjZF9/F5KqrCvN4Bqnk+zKv7QPchmpaAZFJ/miaNVct
        t2JDJqjA5RUhJafLasbUE1VNit3kOGFy4rX/rG1+JA==
X-Google-Smtp-Source: AAOMgper8QeXdCGsY60b+GNPqZSHlohsSVBCPxgeh6W4hLuqLtnfaZPdceqKEcZrwwk100snnZYeBUs77nqbuMdBd80=
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr2539343wra.120.1531862999454;
 Tue, 17 Jul 2018 14:29:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 14:29:38
 -0700 (PDT)
In-Reply-To: <FF977B78-140F-4787-AA57-0EA934017D85@surriel.com>
References: <20180716190337.26133-1-riel@surriel.com> <20180716190337.26133-5-riel@surriel.com>
 <CALCETrUMntRe_LYX5wj9YD4xZ+84QExK+ZNb3yxEBDEKa7nePQ@mail.gmail.com> <FF977B78-140F-4787-AA57-0EA934017D85@surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 17 Jul 2018 14:29:38 -0700
X-Gmail-Original-Message-ID: <CALCETrXtpGPm2Hgm3R=p1ezvNQi==jhQWw5ee9K+H2avNNGsUg@mail.gmail.com>
Message-ID: <CALCETrXtpGPm2Hgm3R=p1ezvNQi==jhQWw5ee9K+H2avNNGsUg@mail.gmail.com>
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
To:     Rik van Riel <riel@surriel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 1:16 PM, Rik van Riel <riel@surriel.com> wrote:
> Can I skip both the cr4 and let switches when the TLB contents
> are no longer valid and got reloaded?
>
> If the TLB contents are still valid, either because we never went
> into lazy TLB mode, or because no invalidates happened while
> we were lazy, we immediately return.
>
> The cr4 and ldt reloads only happen if the TLB was invalidated
> while we were in lazy TLB mode.

Yes, since the only events that would change the LDT or the required
CR4 value will unconditionally broadcast to every CPU in mm_cpumask
regardless of whether they're lazy.  The interesting case is that you
go lazy, you miss an invalidation IPI because you were lazy, then you
go unlazy, notice the tlb_gen change, and flush.  If this happens, you
know that you only missed a page table update and not an LDT update or
a CR4 update, because the latter would have sent the IPI even though
you were lazy.  So you should skip the CR4 and LDT updates.

I suppose a different approach would be to fix the issue below and to
try to track when the LDT actually needs reloading.  But that latter
part seems a bit complicated for minimal gain.

(Do you believe me?  If not, please argue back!)

>> Hmm.  load_mm_cr4() should bypass itself when mm == &init_mm.  Want to
>> fix that part or should I?
>
> I would be happy to send in a patch for this, and one for
> the above optimization you pointed out.
>

Yes please!
