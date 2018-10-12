Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705D3C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D66C20865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nm0L5HCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D66C20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeJMCaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 22:30:18 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36296 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeJMCaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 22:30:18 -0400
Received: by mail-yb1-f194.google.com with SMTP id 5-v6so5307587ybf.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 11:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ng2L27+kqckUIzZZmjjZ7l5TLIFksEymtlPTUrjBE6U=;
        b=nm0L5HCZuI/vWOBoJk2diV7DF75mnmvijFxiUBRTnK/OH07VQZymoHS+w0LsJQscxE
         OxX1XeUEqJloRF/Wf5fK+RvQU4VqlX6e+Jd/L9i8JgqA4C1cwpGWQ9/DuDM/wbzwV0do
         7qBlhsnGbM9d7knX8tCjpRL0H9EffetU1nTHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ng2L27+kqckUIzZZmjjZ7l5TLIFksEymtlPTUrjBE6U=;
        b=qIZ4w/nVO4e2voqaz2cobcer1T89fk7Tt0ML5vy6oh98eMukuuv0TVFdVFbxTA4mWl
         ciX9Hn8vwRtD8xlEY9IpL7M/2VL25hePT1QE5vFfNuWwRG9+FY8a4A4f1nkc0hteuiEF
         3ML7CNrXqWicTpGRuur5owYHqR+HM5toadPIv6c+AQZjAJzw0P7I3PfrBCxGGXhxElA6
         +KXO3+fWCAXdkqEYBtQ4STI7kpzONqMnl2HAflJRqJW9w5ACCxXd65/mbnMNrLb6P5J7
         /y6KjeTkjwJTbDpHRrWOfVWWShW8B2qqcPf2FYKhf0TuK387yarhNTqHljYVgrfSlyAZ
         tK4g==
X-Gm-Message-State: ABuFfoghI49He2H5tEtvAdV6SHrO5M9kVFvaOIA7HoiN2RTBKhOsdm90
        byq26kaTO5+jS6TOpb81BNYMnjLipLM=
X-Google-Smtp-Source: ACcGV63Q2yAb2YuKKZYzF/aYF5AUA6sPn2WVcl6d7/xm383U4SEm/tS+HszZJc6gCP9qX5RNg21l0A==
X-Received: by 2002:a25:5987:: with SMTP id n129-v6mr3894734ybb.50.1539370583661;
        Fri, 12 Oct 2018 11:56:23 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id q1-v6sm461820ywa.92.2018.10.12.11.56.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 11:56:22 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 184-v6so5304385ybg.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 11:56:21 -0700 (PDT)
X-Received: by 2002:a25:2395:: with SMTP id j143-v6mr3948870ybj.137.1539370581360;
 Fri, 12 Oct 2018 11:56:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 11:56:19
 -0700 (PDT)
In-Reply-To: <20181012104744.GA105548@gmail.com>
References: <20181012131444.605564b5@canb.auug.org.au> <CAGXu5jKVnDhu5sv+K+W=AWg0BqtTfoK9=1m6u-0dpDxP9ow74Q@mail.gmail.com>
 <20181012104744.GA105548@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 12 Oct 2018 11:56:19 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+5uKbSMoPS55vhn2qPauddr16COTsJSTki346-JC+gFw@mail.gmail.com>
Message-ID: <CAGXu5j+5uKbSMoPS55vhn2qPauddr16COTsJSTki346-JC+gFw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the tip tree with Linus' tree
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@elte.hu>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 3:47 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Kees Cook <keescook@chromium.org> wrote:
>
>> On Thu, Oct 11, 2018 at 7:14 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> > Hi all,
>> >
>> > Today's linux-next merge of the tip tree got a conflict in:
>> >
>> >   arch/x86/mm/pgtable.c
>> >
>> > between commit:
>> >
>> >   184d47f0fd36 ("x86/mm: Avoid VLA in pgd_alloc()")
>> >
>> > from Linus' tree and commit:
>> >
>> >   1be3f247c288 ("x86/mm: Avoid VLA in pgd_alloc()")
>> >
>> > from the tip tree.
>> >
>> > I fixed it up (I used the version from Linus' tree) and can carry the
>> > fix as necessary. This is now fixed as far as linux-next is concerned,
>> > but any non trivial conflicts should be mentioned to your upstream
>> > maintainer when your tree is submitted for merging.  You may also want
>> > to consider cooperating with the maintainer of the conflicting tree to
>> > minimise any particularly complex conflicts.
>
> This is the correct resolution, thanks Stephen!
>
>> Ingo, it looks like that commit needs to be split up again ... Linus's
>> tree still needs the fix for the fix?
>
> -next still had the old commit, I've now refreshed tip:auto-latest so the
> conflict should go away in the next iteration.
>
> Linus's tree has the correct fix.

Ah! Gotcha, okay. I had it backwards. Thanks for checking!

-Kees

-- 
Kees Cook
Pixel Security
