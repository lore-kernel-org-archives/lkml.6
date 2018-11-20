Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C5FC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7AE2080F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BPLJ7SmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7AE2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbeKUHp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:45:27 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41529 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeKUHp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:45:27 -0500
Received: by mail-yw1-f65.google.com with SMTP id f65so1362822ywc.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 13:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7MTTKf+Xmgc1NDVDg/0c4qismRxbrIPZnukJOiiF86c=;
        b=BPLJ7SmZ5nmatGH1z2u8e+Ge2moBYO9pb88TW7Kf7J3Qb4MqAUgAnFLOStUw20ioJV
         fOHCNpGnXRfKA0xcDcKo16np4/D6dzbxI++dsI1+cc/8wTI0v1KgjgJUKQ7n57Gt5GpS
         tHawfKg107FFJoLpzZ7AH5t29EpA+aGtdvtwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7MTTKf+Xmgc1NDVDg/0c4qismRxbrIPZnukJOiiF86c=;
        b=ZVnoXvtiywGH04NCDw7vVVW82MXBK900P0Xj1xbSKJxxcxeR3GYVWLhawVuughXCfJ
         LSk9/Ql4urw6qQhIavLIENC6MnUwB++zFM5TWd3AEIFCc4yy5cksTpcR7e2KoDqeKgVh
         S8TXZ/az78mmseCnioxSV+fcVOSQwkIInS7Og5jewv9jnatIvOmJbR9WIy8qg/ckW6LW
         fM/vrftA3tsAZLAYsTHJjtb8ow/9wJXvLqZc6jf1iJcGgmNhLle07XhohH5JYKSfCruM
         SaYyOR91aZR0ja0fj0LSyfj0I5HP4fx0/Rx5akzXYVrAzh9x5A3BpLZnwARla8ZskXZ9
         BLIg==
X-Gm-Message-State: AGRZ1gIo2dRaq5xF2CtZX7qb+T6Vf0uMUE850YTS9M5TV7w0CRS6AfU/
        rpiewKY2CqzmAf/ZzwkbVva3AUHsHtQ=
X-Google-Smtp-Source: AJdET5eWfTt69q56zfmwSGKLJGNIYgVtgdidvMzcYTdX/odYFGfpI04wayc3uflEt0Wj1JfqKcjuUA==
X-Received: by 2002:a0d:f404:: with SMTP id d4-v6mr3863481ywf.486.1542748458193;
        Tue, 20 Nov 2018 13:14:18 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id t4-v6sm3576942ywd.83.2018.11.20.13.14.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 13:14:15 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id z2-v6so1349854ybj.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 13:14:15 -0800 (PST)
X-Received: by 2002:a25:ac8e:: with SMTP id x14-v6mr3806610ybi.141.1542748454813;
 Tue, 20 Nov 2018 13:14:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 20 Nov 2018 13:14:14
 -0800 (PST)
In-Reply-To: <0e5fd8bc-0b18-ea88-ed95-ec81a44d0783@intel.com>
References: <20181026195146.9C7C1136@viggo.jf.intel.com> <0e5fd8bc-0b18-ea88-ed95-ec81a44d0783@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 20 Nov 2018 13:14:14 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLbWT62xHk1jVCeo8nrqCj9ECSqGpEFWKXP6qd5jxiRpw@mail.gmail.com>
Message-ID: <CAGXu5jLbWT62xHk1jVCeo8nrqCj9ECSqGpEFWKXP6qd5jxiRpw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/pkeys: copy pkey state at fork()
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Daniel Micay <danielmicay@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 12:59 PM, Dave Hansen <dave.hansen@intel.com> wrote:
> On 10/26/18 12:51 PM, Dave Hansen wrote:
> ...
>> The result is that, after a fork(), the child's pkey state ends up
>> looking like it does after an execve(), which is totally wrong.  pkeys
>> that are already allocated can be allocated again, for instance.
>
> One thing I omitted.  This was very nicely discovered and reported by
> danielmicay@gmail.com.  Thanks, Daniel!

Thread ping. Is there a v2 of this, or can this go in as-is? Looks good to me:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
