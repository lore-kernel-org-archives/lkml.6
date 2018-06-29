Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ABEC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EA527EE5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EG7p425C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EA527EE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030387AbeF2VCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:02:01 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39742 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936446AbeF2VB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:01:57 -0400
Received: by mail-it0-f65.google.com with SMTP id p185-v6so4662314itp.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 14:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGSlN+qX5Kufyj48i3qEIjpPixV+WFdwxxqcrVwezDA=;
        b=EG7p425CFWWF2fOgjmh6FrJgJEerpUDV411bZ+eIzPuL56f6pW+aUD+dZPQdYb13b0
         tHE8Mx0IgGJm8k2RABgkBtXZa9opDa3LlZbKHC7TgXWC2i/Pic07IP05KgGrvzsIkaLp
         Awmq/gE21EGKN6n1qPfn2Pf6PUN1WxuBkPQxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGSlN+qX5Kufyj48i3qEIjpPixV+WFdwxxqcrVwezDA=;
        b=AO/57Vf2AC1o+kPgfpjodNek8I3thKi7coaTE/LhdQ+SH6XOVjKXtjcYCgUA8GF6rp
         6CjsSWevwoI5FPPsNp1l3yJH0UV5Exqnt9d9NZj5rzTU9YFuNVTnfnxHG9lL4tgniypa
         5vCoolGWiMUNB2ItLBjy0HK6Fp1wG2kx4QMUAlDDfmL903xW/LlIUdcebCZNI+r5p1Sk
         c/QVbe0ShimPtvA66ndfOYqLQWzGLlLKAbKg4KK4+sKCLDhwOokQWShBUjVWiTiRqqAa
         8eNaEXwZqg9kLiRNM/5bevKj6j/lAz2YbdJLg6jwjzWJKF4gSkQ5AU80FjRB0YUWdWSk
         cPMQ==
X-Gm-Message-State: APt69E32XYFUjS0WTKvJxtLjyI48+YeqFIPYDLXBiO/+tYvNHUq2175q
        L7wk9aHw29XyhD90rga5B/cXzInQ5incnuKLNkI=
X-Google-Smtp-Source: AAOMgpflXHx6ipaA8BqNsQ1kwlnp+Bp8s9/KMWCoCRs0hwG+RUsnUzZnje8HikVUUaMHZxAyug1icPjxF8ui8m7Fw9g=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr13369452jas.72.1530306117131;
 Fri, 29 Jun 2018 14:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <99169786-61dd-b19c-ac81-84bcd0a67de4@lwfinger.net>
In-Reply-To: <99169786-61dd-b19c-ac81-84bcd0a67de4@lwfinger.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Jun 2018 14:01:46 -0700
Message-ID: <CA+55aFzZ7PND2Xvz9wB1jaCmp0rBMTSmJtKiFwSeOWy9iLSd8Q@mail.gmail.com>
Subject: Re: [Update] Regression in 4.18 - 32-bit PowerPC crashes on boot -
 bisected to commit 1d40a5ea01d5
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 1:42 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> I have more information regarding this BUG. Line 700 of page-flags.h is the
> macro PAGE_TYPE_OPS(Table, table). For further debugging, I manually expanded
> the macro, and found that the bug line is VM_BUG_ON_PAGE(!PageTable(page), page)
> in routine __ClearPageTable(), which is called from pgtable_page_dtor() in
> include/linux/mm.h. I also added a printk call to PageTable() that logs
> page->page_type. The routine was called twice. The first had page_type of
> 0xfffffbff, which would have been expected for a . The second call had
> 0xffffffff, which led to the BUG.

So it looks to me like the tear-down of the page tables first found a
page that is indeed a page table, and cleared the page table bit
(well, it set it - the bits are reversed).

Then it took an exception (that "interrupt: 700") and that causes
do_exit() again, and it tries to free the same page table - and now
it's no longer marked as a page table, because it already went through
the __ClearPageTable() dance once.

So on the second path through, it catches that "the bit already said
it wasn't a page table" and does the BUG.

But the real question is what the problem was the *first* time around.
I assume that has scrolled off the screen? This part:

  _exception_pkey+0x58/0x128
  ret_from_except_full+0x0/0x4
  --- interrupt: 700 at free_pgd_range+0x19c/0x30c
       LR = free_pgd_range+0x19c/0x30c
  free_pgtables+0xa/0xb
  exit_mnap+0xf4/0x16c
  mmput+0x64/0xf0

Does reverting that commit 1d40a5ea01d5 make everything work for you?
Because if so, judging by the deafening silence on this so far, I
think that's what we should do.

That said, can some ppc person who knows the 32-bit ppc code and maybe
knows what that "interrupt: 700" means talk about that oddity in the
trace, please?

                    Linus
