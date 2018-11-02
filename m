Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B375CC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653C620657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SvW0RgOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653C620657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeKCBNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:13:15 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45056 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeKCBNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:13:14 -0400
Received: by mail-lf1-f68.google.com with SMTP id b20so1661220lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 09:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nCwZs6Bfos9PO44MFQbBS84Lh4BmDzogIsp8qZX3l+M=;
        b=SvW0RgOQfy2S4QDyxf+xamrG+27zN1HOhUY7yQxeGlzhwvHzguH1KxCiJpRJFdS9vq
         PSEjdtO+CXUN0BXZowRh7iSLUvf/zbsBJq8i2Hpc+JMA943EDqqVWLB12IIaqkQPYchH
         78Cq4SS+Sa4ttXz83lq7CYhBP//xA8fFyz4wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nCwZs6Bfos9PO44MFQbBS84Lh4BmDzogIsp8qZX3l+M=;
        b=Y1sZW+OhwkT/9IEew4g4lAeFHRjgYBMdkFqC8dQWEXAoMN/rarfcJUdWYqNLzQRMNd
         PvR6Wq1SVEBqpuSewwFf2QfG6PInsgJUJPOjcvYanMKCMhYICiszi9Y/jLD7Vy+nLLxZ
         Fz+lqbSk1ID/TAPysd7xxdGc4lUbiQ8P2F/060avtMl7+r/4Y1NBMjyk8NGfnET31DfW
         k612HQ3yN+2HhCzb2aDAVua7XW3WRHKoglGIHDUQ4elj+ddewCQmaJzfXoK6TzOmjyGf
         E69aesprP09n8c9NkOySvdximjvZ2W+pZVk0Tml3Hs9xY5JDi08/sfcbEuUMTFD5R1xa
         mHTg==
X-Gm-Message-State: AGRZ1gJhE3pd+4q6Nemtac9tXK8a5/3tXT4411SjkAbfrKFbZ+4Wp9Is
        2tgjux4nCxY7U681VR6nE8THdLc/ZhkfSg==
X-Google-Smtp-Source: AJdET5eAarjnr41MUZ81fW6MGosvQ4kQ6X4L2QS92sJx+Ciz84EaYFhP+xxgXC5vq62c5iZsd8ndbg==
X-Received: by 2002:a19:c18d:: with SMTP id r135mr6624259lff.59.1541174737566;
        Fri, 02 Nov 2018 09:05:37 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id u26-v6sm1495853lji.85.2018.11.02.09.05.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 09:05:34 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id t22-v6so2199640lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 09:05:33 -0700 (PDT)
X-Received: by 2002:a2e:874e:: with SMTP id q14-v6mr5432299ljj.120.1541174733203;
 Fri, 02 Nov 2018 09:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <1541164962-28533-1-git-send-email-will.deacon@arm.com>
 <20181102145638.gehn7eszv22lelh6@kshutemo-mobl1> <CAG48ez38PmTKPq_UQ4q39bwtWmb7epyet3-iSvt5b7JfwmCniw@mail.gmail.com>
 <20181102152516.dkqpeubxh6c3phl2@kshutemo-mobl1>
In-Reply-To: <20181102152516.dkqpeubxh6c3phl2@kshutemo-mobl1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Nov 2018 09:05:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTM5588YwhAYQiH7fCu0itRjHYJZ8WaG1y_bx=6JUhtQ@mail.gmail.com>
Message-ID: <CAHk-=wjTM5588YwhAYQiH7fCu0itRjHYJZ8WaG1y_bx=6JUhtQ@mail.gmail.com>
Subject: Re: [PATCH] mremap: properly flush TLB before releasing the page
To:     kirill@shutemov.name
Cc:     Jann Horn <jannh@google.com>, will.deacon@arm.com,
        Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        mhocko@kernel.org, hughd@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 8:25 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> I wounder if it would be cheaper to fix this by taking i_mmap_lock_write()
> unconditionally in mremap() path rather than do a lot of flushing.

That wouldn't help. Think anonymous pages and try_to_free() rmap walk.
So then I think we'd have to take the anonvma lock or something.

And it's not like we are likely to even do any more flushes, really.
We don't flush for each page, only for each page table. So every 512
pages or so.

                     Linus
