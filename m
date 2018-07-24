Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D02ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F6320875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qa086obT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F6320875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388423AbeGXDlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:41:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388321AbeGXDlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:41:14 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C71CD20882
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 02:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532399825;
        bh=RC2xsBB/HbwLbQZDynpvHVAJd8ZIZrwPVFGsEu8N9HE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=qa086obTBmeaykO5obk6ro+svk+jN5UYlw/lbKiD9QYPf4oxeEZ6Uu+u7op2gweBk
         r+3uEwkeDHCo8xQJ1moS4UQDy4/bZw/7D44n9dtO0+DpTgO0YkCxaaZrhfyvuKUXjH
         EAhnXU1gY9X7K4WkWQ/Vr07NdapN9nMuO3BuQWtE=
Received: by mail-wr1-f42.google.com with SMTP id b15-v6so2512730wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 19:37:04 -0700 (PDT)
X-Gm-Message-State: AOUpUlFP+BjX3dDEw3HTJUK8W1h98fakRpoFxrkCaWe9FoMuKzUbEs+0
        DyCSKbkGzhxVyF3SJbnjHhZFTd2RO3fUNAs7gSjCmA==
X-Google-Smtp-Source: AAOMgpdcwndanvfDee6+xVeiPf8s434mU9j99nilED5E1VIcnYHM5UK2lLlHJDPIMjb9FiV/YcKhx44MSwB7tFNTjBw=
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr10241701wra.120.1532399823270;
 Mon, 23 Jul 2018 19:37:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 19:36:42
 -0700 (PDT)
In-Reply-To: <854ac759-efec-3e35-59a9-8da35b2b5156@linux.intel.com>
References: <cover.1532281180.git.luto@kernel.org> <38b5a24f3c9f519dd7dc98171eb3a3c669fff48c.1532281180.git.luto@kernel.org>
 <854ac759-efec-3e35-59a9-8da35b2b5156@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 23 Jul 2018 19:36:42 -0700
X-Gmail-Original-Message-ID: <CALCETrVZHsvfXA18w2M2LKfEc6fHVEzgS-Jg9uT=k9Qw7cw69g@mail.gmail.com>
Message-ID: <CALCETrVZHsvfXA18w2M2LKfEc6fHVEzgS-Jg9uT=k9Qw7cw69g@mail.gmail.com>
Subject: Re: [RFC 1/2] x86/entry/64: Use the TSS sp2 slot for rsp_scratch
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 5:38 AM, Dave Hansen
<dave.hansen@linux.intel.com> wrote:
> On 07/22/2018 10:45 AM, Andy Lutomirski wrote:
>> +     /*
>> +      * sp2 is scratch space used by the SYSCALL64 handler.  Linux does
>> +      * not use rung 2, so sp2 is not otherwise needed.
>> +      */
>>       u64                     sp2;
>
> Could we call out the actual thing that we use this slot for, and the
> symbol name so folks can find the corresponding code that does this?
> While I know the spot in entry_64 you're talking about, it might not be
> patently obvious to everyone, and it's also a bit more challenging to
> grep for than normal C code.
>
> Maybe:
>
>         /*
>          * Since Linux does not use ring 2, the 'sp2' slot is unused.
>          * entry_SYSCALL_64 uses this as scratch space to stash the user
>          * %RSP value.
>          */

I'll improve this for v2.
