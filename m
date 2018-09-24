Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47451ECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70D720C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N+BYSaUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70D720C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeIYCCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:02:48 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:43462 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeIYCCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:02:48 -0400
Received: by mail-yb1-f195.google.com with SMTP id w80-v6so8770834ybe.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HEfJ7G02Dh/HdHqkVULQHxgQjlYXw3pAnaC5MmE6dWY=;
        b=N+BYSaUhxs/uCuQNkEUVt4IHSkoA2Z4fPUZw67aLVW9jtzb25AfrEOyNIDTBl7vvjM
         9ZaWRScd5V0GWL3KGtyprvLwxcVoIkK6VywtGBF51ahWsHReg0GF5UALLpRXOxI99r/9
         dtD/hf5lnNWcpjqm7JdD7iFoAV2x9J87jAc90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HEfJ7G02Dh/HdHqkVULQHxgQjlYXw3pAnaC5MmE6dWY=;
        b=cf6Cfkl0+JYgg5oLtbhdAbv22W6o3KxcuLSP75CrFU5gs8nu7h4pRbsG3nUbxrJ/5N
         wCwnFZUUnsdiy3Xk+BSLrVlDsKWfX4HlVZCJJB6Fzcv54FibxCeLmJrQBmLAJJkmwghj
         lnM7snB2QdnKfVQTgLrg0StRfuMFp8f+FRL3gxW5WgDvUys/yvg1/j0aZ3eGD5EeZe4k
         xHnRV7rkIgJqAaWFHMFU1BDl3syflZgsQL2q0QC4hBWLXb8UfraDmd8yQrvzRdMNElUk
         2XM7OUkWZpmdbeZGBrx0TKSIBLSC7GfZd0w/n5rjb9KOIbzh35POGKqcUsxZLHIws80g
         RtWA==
X-Gm-Message-State: ABuFfoiPVPtq9Lq8Q2NaBYhPWSh39jagQFe2IQDJZ1M+hTexxWRFTFt4
        VE6s1FGPoyn26wc48Wp+mgdgGemxOq0=
X-Google-Smtp-Source: ACcGV60zlbNc6P2+CrcLvDaUEoxhOnRJjlwniTDwVRDDxHk9lju5MdzQmS6vb1iX5b/VzpHjzN8HjA==
X-Received: by 2002:a25:9705:: with SMTP id d5-v6mr221240ybo.408.1537819135901;
        Mon, 24 Sep 2018 12:58:55 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id w6-v6sm97897ywg.3.2018.09.24.12.58.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 12:58:54 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id z143-v6so8376892ywa.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:58:53 -0700 (PDT)
X-Received: by 2002:a81:1194:: with SMTP id 142-v6mr224407ywr.168.1537819133209;
 Mon, 24 Sep 2018 12:58:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 12:58:51
 -0700 (PDT)
In-Reply-To: <1537815484.19013.48.camel@intel.com>
References: <1536874298-23492-1-git-send-email-rick.p.edgecombe@intel.com>
 <1536874298-23492-3-git-send-email-rick.p.edgecombe@intel.com>
 <CAGXu5jJ9nZYbVn5xdi7nsMJRD6ScLeWP2DWjrD8yEfwi-XXcRw@mail.gmail.com> <1537815484.19013.48.camel@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 24 Sep 2018 12:58:51 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKho6Ui0sP6-4FN=i6zZ1+gXcd9Zyctqhvg+4r1cz-Mqw@mail.gmail.com>
Message-ID: <CAGXu5jKho6Ui0sP6-4FN=i6zZ1+gXcd9Zyctqhvg+4r1cz-Mqw@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] x86/modules: Increase randomization for modules
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jannh@google.com" <jannh@google.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 11:57 AM, Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
> On Fri, 2018-09-21 at 12:05 -0700, Kees Cook wrote:
>> On Thu, Sep 13, 2018 at 2:31 PM, Rick Edgecombe
>> <rick.p.edgecombe@intel.com> wrote:
>> I would find this much more readable as:
>> static unsigned long get_module_vmalloc_start(void)
>> {
>>        unsigned long addr = MODULES_VADDR;
>>
>>        if (kaslr_randomize_base())
>>               addr += get_module_load_offset();
>>
>>        if (kaslr_randomize_each_module())
>>                addr += get_modules_rand_len();
>>
>>        return addr;
>> }
> Thanks, that looks better.
>
>>
>> >  void *module_alloc(unsigned long size)
>> >  {
>> > @@ -84,16 +201,18 @@ void *module_alloc(unsigned long size)
>> >         if (PAGE_ALIGN(size) > MODULES_LEN)
>> >                 return NULL;
>> >
>> > -       p = __vmalloc_node_range(size, MODULE_ALIGN,
>> > -                                   MODULES_VADDR +
>> > get_module_load_offset(),
>> > -                                   MODULES_END, GFP_KERNEL,
>> > -                                   PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
>> > -                                   __builtin_return_address(0));
>> > +       p = try_module_randomize_each(size);
>> > +
>> > +       if (!p)
>> > +               p = __vmalloc_node_range(size, MODULE_ALIGN,
>> > +                               get_module_vmalloc_start(), MODULES_END,
>> > +                               GFP_KERNEL, PAGE_KERNEL_EXEC, 0,
>> > +                               NUMA_NO_NODE, __builtin_return_address(0));
>> Instead of having two open-coded __vmalloc_node_range() calls left in
>> this after the change, can this be done in terms of a call to
>> try_module_alloc() instead? I see they're slightly different, but it
>> might be nice for making the two paths share more code.
> Not sure what you mean. Across the whole change, there is one call
> to __vmalloc_node_range, and one to __vmalloc_node_try_addr.

I guess I meant the vmalloc calls -- one for node_range and one for
node_try_addr. I was wondering if the logic could be combined in some
way so that the __vmalloc_node_range() could be made in terms of the
the helper that try_module_randomize_each() uses. But this could just
be me hoping for nice-to-read changes. ;)

-Kees

-- 
Kees Cook
Pixel Security
