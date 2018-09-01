Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04FEC43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598632083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YRZvt/Pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598632083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeIAUr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 16:47:28 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33109 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeIAUr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 16:47:27 -0400
Received: by mail-io0-f193.google.com with SMTP id r196-v6so12848117iod.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 09:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/Tsr3vDIpLpePMr8tzjjRhy5GgE9x6c0piCjIQlHuA=;
        b=YRZvt/PaYm4UdDkPznHyQXF3C8QJKtpoZ19M94flegd6hWaXTfxjxjEDmtyIBxwxE4
         LjGkQVZvqjEYxQwYgxG6ZMNxL+faLWp8YPQiAJrYnNrLInfu0iKiwLqz27kOqZI4hAal
         rzCFgvDZlqnWo4x3PZDFdTsLpHKUP7zbKfR8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/Tsr3vDIpLpePMr8tzjjRhy5GgE9x6c0piCjIQlHuA=;
        b=Ng01ysnlvZYDw4icZQjkB8vfeADuffRGvX5hM3mlvf9X4HTUehOZTO0zp70akLbw3H
         UAy+8liO9scARpyPGvitNgvFfAISWGTptKb6hPxn0vigRXadjb81jWcZasp76E+WX2WN
         tCwPb91VJrRLi+hrIvHOVkPgEGJdPImB3V/rWKOUIQfMQDrqdZs2PQRzy97aEYMjHJIf
         Rb9RayFx7GKzjjRsrKWwi66TDBBG40WMX2IYeJYH8fLrSW/fhnEikLxeVcGcljmeVmar
         zDJ6+FO0VcwM4SdyuZw+cc1gY7mVvVHRQUum/dzUobAfeoVlwPdlrbFxm3caS23quNpI
         aF2w==
X-Gm-Message-State: APzg51CxC0PuOpTGyRiRvmtsskYBBF6VE7I4UPyys2XndrQ2v4aLgx76
        GSGbzwAm90B6mID+bzRXiqNUivMlfIY+EPLbM1w=
X-Google-Smtp-Source: ANB0Vdb0i0WSBLqoNd92xynKnptE4kMxsdKQFqCI7hAjyAfXUv8CM+MPD+v1VpbVGD76MvXUNC/8oY63VRPctt3jbdE=
X-Received: by 2002:a6b:f815:: with SMTP id o21-v6mr16173559ioh.203.1535819694574;
 Sat, 01 Sep 2018 09:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1535753890.git.luto@kernel.org>
In-Reply-To: <cover.1535753890.git.luto@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Sep 2018 09:34:43 -0700
Message-ID: <CA+55aFwJDk27MjGmPH+ECDbMem9R_xuZydaayrzs-KHedr13DQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] x86/pti: Get rid of entry trampolines and add some docs
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 3:21 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> This gets rid of entry trampolines.

Despite my syntactic comment on 2/3, I'd love for this to go in. The
extra indirection through the trampoline is confusing, I think, in
addition to being a performance issue.

              Linus
