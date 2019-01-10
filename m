Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962D7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5778620665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F2LZhLAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfAJV7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:59:32 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45253 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfAJV7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:59:32 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so11085880ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 13:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TlBEbWJPRxW5ErqdsgMFn18xJNa8zguibIlrpYIe8GE=;
        b=F2LZhLAoZnai3Q/v7fqXciTy8NtdW1LrmXu1KcpK9bQSVTukW+I9Mw0wK2XcWeA9e+
         RVI6eeeDM1+p8dJs4yLa7J8+GdgociTJLV6U/KCmP4VUU9Vq83aqthiREo2n7NIy8u6k
         T8BgPlRn/3ksKc7fBjzS7SBQFWfgmrHc8MZTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TlBEbWJPRxW5ErqdsgMFn18xJNa8zguibIlrpYIe8GE=;
        b=pgC0TKVIqJuT1JvSI1RXUN7pq1Tc3vJMqYO2VMwIVYf8Nr+WnF6Nyxbec1QVaE1l8n
         FyeZwJdhQX3hd+fKX0MaOZMz1ItF0Iqrjb4Adv0/ef4HTMJzdT4GCMWJ+r79/LmCZjD/
         r0kgEsEqCILwlRtUT9IFe3nBJQXdKo7aKzVX9V4iizXq9SP6wiS1a7PHbFNrSMIiJnEr
         G3ks6ECOwsDmhgAZiiRfNykg+N6kE2DbS1B4jtV1Oe4BwBLAIp08olDlLvqjlAoU1s0b
         e/gP8KMGf0Qt8G4fsc8qtAvBCDT9PNj3WjOBDWJe7OgjJvPEHLnu1UD48Aqk+n0UvKDJ
         fuhw==
X-Gm-Message-State: AJcUukfACR6fEyL5Mrp+yOodJk2tXZO5ll/5FmpODmlcXSbpUTr8Eyw6
        rzndoQlF2dSdWcw9StINPYVFxG1StoU=
X-Google-Smtp-Source: ALg8bN5b1Hm+/uNY4h0prxLbD7LzYaMHC8M/lpTQLmreAE+nyaKx6QiCjrYngIU+2gm59KDZxeSl+A==
X-Received: by 2002:a2e:5356:: with SMTP id t22-v6mr6686535ljd.26.1547157569680;
        Thu, 10 Jan 2019 13:59:29 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id g3-v6sm15701863lje.50.2019.01.10.13.59.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 13:59:28 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id k19-v6so11093384lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 13:59:28 -0800 (PST)
X-Received: by 2002:a2e:310a:: with SMTP id x10-v6mr7603918ljx.6.1547157568146;
 Thu, 10 Jan 2019 13:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20190108044336.GB27534@dastard> <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com>
 <20190109022430.GE27534@dastard> <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm>
 <20190109043906.GF27534@dastard> <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com>
 <20190110004424.GH27534@dastard> <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
 <CALCETrWxwaBUYMg=aLySJByMgXzuzV4gHS0n6O6Oet2Jm6SAbw@mail.gmail.com>
 <20190110144711.GV6310@bombadil.infradead.org> <20190110214427.GK27534@dastard>
In-Reply-To: <20190110214427.GK27534@dastard>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jan 2019 13:59:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wheEc=K19yJjr4_rkNVxVmyxmbeOoDpwiuNUHZsR-BFBw@mail.gmail.com>
Message-ID: <CAHk-=wheEc=K19yJjr4_rkNVxVmyxmbeOoDpwiuNUHZsR-BFBw@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 1:44 PM Dave Chinner <david@fromorbit.com> wrote:
>
> GUP does page fault on user buffer which is a mmapped region of same
> file. page fault sets up for buffered IO, tries to take rwsem for
> write, deadlocks.
>
> Most of the schemes we come up with fall down at this point - you
> can't hold a lock over gup that is also used in the buffered IO
> path. That's why XFS (and now ext4) have the IOLOCK and MMAPLOCK
> for truncation serialisation - we can't lock out both read()/write()
> and mmap IO paths with the same lock...

Side note: a somewhat similar version of is true even in the absence
of GUP and dio, for the case of doing a mmap of a file, and then
reading or writing from the mapped region into the file itself.

There are "interesting" locking scenarios wrt just holding the page
locked, and trying to then fill that page with information with just a
regular "copy_from_user()".

Page fault -> try to read the file -> oops, the page we're trying to
read from is locked because we're trying to write to it.

So we have that odd dance in generic_perform_write() which does

 - touch the first user byte without holding any lock

 - do write_begin() (which gets the page lock)

 - copy from user space using the "atomic" copy (which just gives up on fault)

 - if nothing got copied, go back and try again with a smaller copy
that can't cross a page. We might have raced with pageout.

It might be possible to do something similar for direct IO, although
simpler: just do the GUP entirely atomically (and in the fault case
just fall back to non-direct IO).

            Linus
