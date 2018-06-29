Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCC6C6778B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BEB257F2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JeIYMbIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BEB257F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967098AbeF2QgQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:36:16 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39871 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967070AbeF2QgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:36:12 -0400
Received: by mail-io0-f193.google.com with SMTP id e13-v6so8984687iof.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 09:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ukCGltYwtD7YajTlWIOjEevOj1qICTIHzaLGC+IF44g=;
        b=JeIYMbIX3IAluQh6MhELO7TmAfHyd6W5UTGw3TRp98mmofrXYoYtTUtXjEsX6Ja/lq
         AzFWQLQA9opUNjazc24TrHLOeQqIUBty+fE+AMmdg8MNi5Vb8PFN6M+zWbl2VQqqz7KG
         XqUmwT2Po6HofXqvK2C0KMAsyjjp2HvNqI7CqGGTFPAALmXM/GDAZn7Tjw8qiX5v6D05
         kIFhixws/cWz1KdMi+3IfGVUFdfBUdbfZ3B2vnOmkjv5MiD9YLK21PanXHrDwaRD+IsY
         FH96sKlVbvIL+Uxlidq2LSVZwjAmrtRyptb5HeFJI/vP8FoN07z1OAYievrniflL+eZu
         hnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ukCGltYwtD7YajTlWIOjEevOj1qICTIHzaLGC+IF44g=;
        b=GmUuyn6/Tm3zY0WffzfCLLIR4IUaZVNlBLXQIEjeu30JzzlzNEqqUKT469ram+vsjL
         slXsvGgAPvr8x9e660PpENFbC0nOfkc7XulGv8FOGxgiINqBiHHCdz762k2UDeMfQfbT
         6iLXpDmIkegpaG/qk5U7hYBWfKnz8cc/bO/SEE6Xpr7kK71gEsb0/xa51XYanhe2q3Ov
         0NwXVn7XpzUSM6Zg51CWfvT2iNaR7XdAc56kLd3N7GMHGETjzkvc9ky+rXNNmLsVpEQH
         /r73xtnZOXGCDulaBlapDEcNjtST3o3nrezqDtXoFpG4xsyXYcwotcRZB3wvBTZ9VBNW
         26rg==
X-Gm-Message-State: APt69E1ZeuaHy3jWof9CmipK24sSh6Vw/AAnaWQgO7RHMNyo6nlplOHq
        8aG+8RyYSupXOIC99b5Qf3FyBDkQMBb32SlOLvH5KQ==
X-Google-Smtp-Source: AAOMgpe1SW9csFvdGv+80VIVjSOgp82ktPCy4rDxxGN2dKxq3LBu2kI150jfQjseKfH6aCeXYeCHu4NmnWZXjuwGnps=
X-Received: by 2002:a6b:5002:: with SMTP id e2-v6mr13329662iob.31.1530290171709;
 Fri, 29 Jun 2018 09:36:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:9082:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 09:36:10
 -0700 (PDT)
In-Reply-To: <20180629110709.GA17859@arm.com>
References: <cover.1530018818.git.andreyknvl@google.com> <20180628105057.GA26019@e103592.cambridge.arm.com>
 <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com> <20180629110709.GA17859@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 29 Jun 2018 18:36:10 +0200
Message-ID: <CAAeHK+wHd8B2nhat-Z2Y2=s4NVobPG7vjr2CynjFhqPTwQRepQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address sanitizer
To:     Will Deacon <will.deacon@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Jann Horn <jannh@google.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Mark Brand <markbrand@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 1:07 PM, Will Deacon <will.deacon@arm.com> wrote:
> It might not seen sensible, but we could still be relying on this in the
> kernel and so this change would introduce a regression. I think we need
> a way to identify such pointer usage before these patches can seriously be
> considered for mainline inclusion.

Another point that I have here is that KHWASAN is a debugging tool not
meant to be used in production. We're not trying to change the ABI or
something like that (referring to the other HWASAN patchset). We can
fix up the non obvious places where untagging is needed in a case by
case basis with additional patches when testing reveals it.
