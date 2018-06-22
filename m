Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BA8C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C938243E9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFW/MGmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C938243E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933644AbeFVOoC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932752AbeFVOoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:44:01 -0400
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0504243EA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 14:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529678641;
        bh=ZkLqmeu2Y1QB+HsnAWu68umZ11V/oCejOZjq3XE7gFE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CFW/MGmMzWw5EkeNWEKn2kPpDm5ahT5zRpxxSBOzUS5xKkO/MR6qURpYk432TcjyD
         3Q//MbNQu5bbrLUBxXPiXnUO9vZ7y0rdG8OorbkHqGh5oRQKwdFqOR3aIggSP5gGO5
         6zuscTds+gG/OdbIBINxPIBcK2X1YARYMcKB7mkw=
Received: by mail-wm0-f41.google.com with SMTP id v16-v6so2494764wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 07:44:00 -0700 (PDT)
X-Gm-Message-State: APt69E2zOO8zYlgHxVp8F9F2ixkIdB2FyrwF3+GBxEa9Q5S/Cb9j6Ylj
        iN+NF4od1pbnGRKGB3jHX2UktLP5JGfIbnwxMyopWg==
X-Google-Smtp-Source: ADUXVKLtjOkm580aHKbcncQUlbqtqq4M77+MIbxs2fjCYatA7KfG5H/e9C8XGYaYQnwNhVzulv7+nZcpkmfvz2G1pxA=
X-Received: by 2002:a1c:f30f:: with SMTP id q15-v6mr1880126wmq.36.1529678639477;
 Fri, 22 Jun 2018 07:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180621211754.12757-1-h.peter.anvin@intel.com> <20180621211754.12757-7-h.peter.anvin@intel.com>
In-Reply-To: <20180621211754.12757-7-h.peter.anvin@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 Jun 2018 07:43:47 -0700
X-Gmail-Original-Message-ID: <CALCETrV-cmjyFmuf-AdrdZU4J1Gq88cEC3JLKme3oxm9Jy_PMQ@mail.gmail.com>
Message-ID: <CALCETrV-cmjyFmuf-AdrdZU4J1Gq88cEC3JLKme3oxm9Jy_PMQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] x86/tls,ptrace: provide regset access to the GDT
To:     "H. Peter Anvin" <h.peter.anvin@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 2:18 PM H. Peter Anvin, Intel
<h.peter.anvin@intel.com> wrote:
>
> From: "H. Peter Anvin" <hpa@linux.intel.com>
>
> Provide access to the user-visible part of the GDT via a regset in
> ptrace().  Note that we already provide a regset for the TLS area part
> of the GDT; these can trivially be unified by looking at the contents
> of the regset structure, especially since the TLS area is the only
> user-modifiable part of the GDT.

This seems reasonable, although I'm not sure I see the point of making
REGSET_GDT writable.  (I see the point of making the LDT writable, but
that's a different story.)

> +static int gdt_get(struct task_struct *target,
> +                  const struct user_regset *regset,
> +                  unsigned int pos, unsigned int count,
> +                  void *kbuf, void __user *ubuf)
> +{
> +       struct desc_struct gdt_copy[GDT_LAST_USER + 1];
> +       const struct desc_struct *p;
> +       struct user_desc udesc;
> +       unsigned int index, endindex;
> +       int err;
> +
> +       if (pos % sizeof(struct user_desc))
> +               return -EINVAL;
> +
> +       /* Get a snapshot of the GDT from an arbitrary CPU */
> +       memcpy(gdt_copy, get_current_gdt_ro(), sizeof(gdt_copy));
> +
> +       /* Copy over the TLS area */
> +       memcpy(&gdt_copy[GDT_ENTRY_TLS_MIN], target->thread.tls_array,
> +              sizeof(target->thread.tls_array));
> +
> +       /* Descriptor zero is never accessible */
> +       memset(&gdt_copy[0], 0, sizeof(gdt_copy[0]));

I think you should also mask out all system segments and all RPL != 3 segments.

> +static int gdt_active(struct task_struct  *target,
> +                     const struct user_regset *regset)
> +{
> +       (void)target;
> +       return GDT_LAST_USER + 1;
> +}

I can't find the code, if any, that calls ->active.  But, if it
exists, is the result exposed to user space at all?  If so, I think
this should return the maximum theoretical size of the GDT.

> +       [REGSET_GDT] = {
> +               .core_note_type = NT_X86_GDT,
> +               .n = LDT_ENTRIES, /* Theoretical maximum */
> +               .size = sizeof(struct user_desc),
> +               .align = sizeof(struct user_desc),
> +               .active = gdt_active,
> +               .get = gdt_get, .set = regset_gdt_set

As above, barring a reason why it's useful, I think that removing .set
would make sense.

--Andy
