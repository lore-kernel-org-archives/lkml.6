Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36E3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4740A208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRE7LoY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4740A208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeH1GAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 02:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbeH1GAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 02:00:17 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04771208E2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 02:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535422257;
        bh=5CJJHfcAZW8REeog+oDO9i7nO14p2bHvh6amRPWb8L4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=CRE7LoY89y8//P37jcGmAFl1yFbqX7BiQ3ZkxcMu8UPEeTEmLV5zNEem4TGmuf3ib
         NpKnhEQF8DYIJ8kAoSnqpyikQ4GPkLdzaY8xClilfMNGx4Rl3YbO/EtaLfTh3x+LVM
         sKqBh5Tsul6Vkyg3h0MGvnX2BeMLi+dumoJlh7ks=
Received: by mail-wr1-f43.google.com with SMTP id w11-v6so30297wrc.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 19:10:56 -0700 (PDT)
X-Gm-Message-State: APzg51BTWtVHmSb0G8HfDPnz87mP87Tj2STHwFcixuMw50PWI29HwFsa
        CDoJKu9eK58rwvxUvD1QQIj44E0bLruQozZ+YWjXJw==
X-Google-Smtp-Source: ANB0VdaUcDoONMPqT93wXP3qBM91CrhHxCQm1O/EiDtUPkSasP8HDqz0HPxrM5+c4PPn0vzLNLMUn+ccNK4QBGZcn7c=
X-Received: by 2002:adf:c554:: with SMTP id s20-v6mr10085666wrf.46.1535422255449;
 Mon, 27 Aug 2018 19:10:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 19:10:35 -0700 (PDT)
In-Reply-To: <7e33326ecf792c1a2297d162735b3e63ac185ad0.camel@surriel.com>
References: <c7ee1ee7a1b8d17743f7c3680ea5d2c32bf3e897.1535410956.git.luto@kernel.org>
 <7e33326ecf792c1a2297d162735b3e63ac185ad0.camel@surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 27 Aug 2018 19:10:35 -0700
X-Gmail-Original-Message-ID: <CALCETrUMeV=P89msPuVuiWEw-MdZQZ9t0rTMgY8P91Q8tQvnXQ@mail.gmail.com>
Message-ID: <CALCETrUMeV=P89msPuVuiWEw-MdZQZ9t0rTMgY8P91Q8tQvnXQ@mail.gmail.com>
Subject: Re: [PATCH] x86/nmi: Fix some races in NMI uaccess
To:     Rik van Riel <riel@surriel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 6:31 PM, Rik van Riel <riel@surriel.com> wrote:
> On Mon, 2018-08-27 at 16:04 -0700, Andy Lutomirski wrote:
>
>> +++ b/arch/x86/mm/tlb.c
>> @@ -345,6 +345,9 @@ void switch_mm_irqs_off(struct mm_struct *prev,
>> struct mm_struct *next,
>>                */
>>               trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH,
>> TLB_FLUSH_ALL);
>>       } else {
>> +             /* Let NMI code know that CR3 may not match
>> expectations. */
>
> I don't get it. This is in the "ASID is up to date, do not
> need a TLB flush" path.
>
> In what case do we have a TLB that is fully up to date, but
> a CR3 that does not match expectations?
>
> Doesn't the CR3 check in nmi_uaccess_ok already catch the
> window of time where the CR3 has already been switched over
> to that of the next task?
>
> What is special about this path wrt nmi_uaccess_ok that is
> not also true for the need_flush branch right above it?
>
> What am I missing?

Nothing.  My patch is buggy.  ETOLITTLESLEEP.

I could drop this part of the patch entirely.  Or I could drop the
loaded_mm->pgd == __va(read_cr3_pa() check and instead make sure that
loaded_mm is NULL at any point at which loaded_mm might not match CR3.
The latter will be faster in any (hypothetical) virtualization
environment where CR3 reads trap.  I don't know if we have any such
cases where perf works and we care about performance, though.

--Andy
