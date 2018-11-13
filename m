Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C70C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063182245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F5H9p2CB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063182245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbeKMO76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:59:58 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41615 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMO76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:59:58 -0500
Received: by mail-yb1-f193.google.com with SMTP id t13-v6so4874786ybb.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 21:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FvoxaL5IX6xFyIgg+DraAWBYw51fAM6f932xRqvLFV4=;
        b=F5H9p2CBEcv/eepjN2q3jRoY7qgBoyqCLvZgKviBdssfjtaxXInESgn9FN2bB/7m66
         W12ygP4U/J6avKrAPvEH+0WmjI8XlAe3fCyl7gh+lNC/BC58sJ1aehUZif8KfB097B4a
         b2KSxc+xo6xdK8un5s5Gvra67JSeYpkY3agJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FvoxaL5IX6xFyIgg+DraAWBYw51fAM6f932xRqvLFV4=;
        b=DLAC43wObVf6+palgqYAJu1GV65/C1Lpk9/XvNexPHAGlubpF9WPcLHjnmoFU0YKkr
         95NfJ0g2Vq/EL1QHA/pAr9VQiJjWyyq+717j8IEvS4xC7AwlJkMBrqGJ/LFrgFInV38f
         g38caChamL7LVDkyuFuR7LqE8W3+j1GBabzEnbt29lmW8fS2SSuqMHqNFRLVuQlTOOFa
         jpb9FIuD0bBri+PPrljnEF1zLPPVDzfAWrEbD9yFDVl96zHUYQU3wNfJfochZ5xarFgJ
         UyGOXiIVBvJK7eZJQy7PS6oT42o416DjsDdrwVrlN2VeTjzlb8SkGuSUFt7x2/TjGwTO
         A+kw==
X-Gm-Message-State: AGRZ1gKgiC1BOIy4CT0W9nxcAtBTPn3Ql5PTDD/V92NQeHUkuDFcBmHd
        bffsd8kD3MgWxU135VxEYAmlpX7KJfo=
X-Google-Smtp-Source: AJdET5e2likLmiLTAhQUKTaM4r0fYXq0hX/CnjUhUCaCk2MxcCZfFABlkbzmQnIOWypbD2xJ0mRMWA==
X-Received: by 2002:a25:504e:: with SMTP id e75-v6mr3623463ybb.41.1542085416424;
        Mon, 12 Nov 2018 21:03:36 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id m189-v6sm1174091ywm.73.2018.11.12.21.03.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 21:03:35 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id 131-v6so4851523ybe.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 21:03:35 -0800 (PST)
X-Received: by 2002:a25:ac8e:: with SMTP id x14-v6mr3784060ybi.141.1542085414562;
 Mon, 12 Nov 2018 21:03:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Mon, 12 Nov 2018 21:03:33
 -0800 (PST)
In-Reply-To: <20181112155248.4dde2613979f4c176565629e@linux-foundation.org>
References: <20181112160931.GA28463@redhat.com> <20181112160956.GA28472@redhat.com>
 <20181112155248.4dde2613979f4c176565629e@linux-foundation.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 12 Nov 2018 23:03:33 -0600
X-Gmail-Original-Message-ID: <CAGXu5jJtyz890i9+gwaDFzojp_k9AB0z0_JHQNoFae69uQ5Ghw@mail.gmail.com>
Message-ID: <CAGXu5jJtyz890i9+gwaDFzojp_k9AB0z0_JHQNoFae69uQ5Ghw@mail.gmail.com>
Subject: Re: [PATCH 2/2] exec: increase BINPRM_BUF_SIZE to 256
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 5:52 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Mon, 12 Nov 2018 17:09:56 +0100 Oleg Nesterov <oleg@redhat.com> wrote:
>
>> Large enterprise clients often times run applications out of networked
>> file systems where the IT mandated layout of project volumes can end up
>> leading to paths that are longer than 128 characters. Bumping this up to
>> the next order of two solves this problem in all but the most egregious
>> case while still fitting into a 512b slab.
>>
>> ...
>>
>> --- a/include/uapi/linux/binfmts.h
>> +++ b/include/uapi/linux/binfmts.h
>> @@ -16,6 +16,6 @@ struct pt_regs;
>>  #define MAX_ARG_STRINGS 0x7FFFFFFF
>>
>>  /* sizeof(linux_binprm->buf) */
>> -#define BINPRM_BUF_SIZE 128
>> +#define BINPRM_BUF_SIZE 256

This comment needs updating too:

fs/exec.c: * Check permissions, then read the first 128 (BINPRM_BUF_SIZE) bytes

>>  #endif /* _UAPI_LINUX_BINFMTS_H */
>
> It does seem a rather silly restriction, and it's tempting to suggest
> reworking the code so that linux_binprm.buf is dynamically sized to
> accommodate even ludicrously large strings.
>
> But obviously 128 bytes has been enough for all this time, so that's
> going too far.  However it would be basically cost-free to increase
> BINPRM_BUF_SIZE up to the point where sizeof(struct linux_binprm) ==
> PAGE_SIZE?

Yeah, and this might be a useful detail included in a comment above
the #define...

Regardless:

Acked-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
