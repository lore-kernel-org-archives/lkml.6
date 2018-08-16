Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F6CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AD9208E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0AlZAkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AD9208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387521AbeHPEuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 00:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbeHPEuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 00:50:01 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F605208E5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 01:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534384504;
        bh=oataPW0xsz541UBVQnFcTyY7H4mr7x8BSqHkeai5ASw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=i0AlZAkQnJmMCGTO6C6bfrdDXUksfItU48RXnsUP0yozxcsOe3Qx6pvx6soKOdOfe
         nJfTimZ7wd5TigItDEAvGwZrWJGKgOUTzAh0dbcuozsWxvUi4e7YiZ9V5IrSVjhSgD
         /Cj74lsEy/xT1/PYJIw0+t8RvzMIgSuw8gMAPAIg=
Received: by mail-wr1-f42.google.com with SMTP id h10-v6so2662019wre.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 18:55:04 -0700 (PDT)
X-Gm-Message-State: AOUpUlH7JaXQcNb882wdmISF09LwtoM+lMZWLw3JD7FJOuPSMgrMTsFc
        vKHM2FaoDYi+hBnndHSiwaxn2nLm7OHVyRzlPkRfdg==
X-Google-Smtp-Source: AA+uWPyVAS5dNEGbcad885XqWZU13tTd8twk0+ZDaf333eF5wnfWALCje8KSUxrTzfRkZkU0mkDwxO3L14J+EsN5CDU=
X-Received: by 2002:adf:eec9:: with SMTP id a9-v6mr18390596wrp.21.1534384502615;
 Wed, 15 Aug 2018 18:55:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 18:54:42 -0700 (PDT)
In-Reply-To: <20180716190337.26133-3-riel@surriel.com>
References: <20180716190337.26133-1-riel@surriel.com> <20180716190337.26133-3-riel@surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 15 Aug 2018 18:54:42 -0700
X-Gmail-Original-Message-ID: <CALCETrWhb4CU8BfjdYBe+QJ8CVa4pzAr3ME+HBe4=6y=Pi9pFQ@mail.gmail.com>
Message-ID: <CALCETrWhb4CU8BfjdYBe+QJ8CVa4pzAr3ME+HBe4=6y=Pi9pFQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] x86,tlb: leave lazy TLB mode at page table free time
To:     Rik van Riel <riel@surriel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 12:03 PM, Rik van Riel <riel@surriel.com> wrote:
> Andy discovered that speculative memory accesses while in lazy
> TLB mode can crash a system, when a CPU tries to dereference a
> speculative access using memory contents that used to be valid
> page table memory, but have since been reused for something else
> and point into la-la land.

Hi Rik-

I was looking through this, and I see:

> -static void tlb_remove_table_one(void *table)
> +static void tlb_remove_table_one(void *table, struct mmu_gather *tlb)
>  {
>         /*
>          * This isn't an RCU grace period and hence the page-tables cannot be
> @@ -344,7 +348,7 @@ static void tlb_remove_table_one(void *table)
>          * It is however sufficient for software page-table walkers that rely on
>          * IRQ disabling. See the comment near struct mmu_table_batch.
>          */
> -       smp_call_function(tlb_remove_table_smp_sync, NULL, 1);
> +       smp_call_function(tlb_remove_table_smp_sync, tlb->mm, 1);
>         __tlb_remove_table(table);
>  }

But tlb_remove_table() doesn't always call tlb_remove_table_one().  Do
the other paths through tlb_remove_table() do the right thing?

--Andy
