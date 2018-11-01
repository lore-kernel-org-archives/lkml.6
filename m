Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787CCC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473EC20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Nu/+Ijrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473EC20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeKBEXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 00:23:01 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:38386 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeKBEXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 00:23:01 -0400
Received: by mail-lj1-f172.google.com with SMTP id q186-v6so5717961ljb.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JR9rUjwyC6MIuio4ZAha46sSawiC0In9vkot0Q8cJ2Q=;
        b=Nu/+IjrlQBGr6lbwnDDEbN3gl7Dm5aEMZQdnVKQ/j2NiFCnJDdYsmTBTGgibLXHTFE
         P9NZAB+OG6Cuo1cSkQ5cSssqZKurVp5QdYgcJbSrqgi73Lkh3u82h2aSrnDfuCQlbRKA
         vv+QHJpJRE0c6EuXcEM12N8I9E//serNMtBL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JR9rUjwyC6MIuio4ZAha46sSawiC0In9vkot0Q8cJ2Q=;
        b=Q6W8DUyqt8ues2Alr+lVvN5KeL5OUXHG0z+rcD8qiV3az0r2PtkPluFx2PwA3BJ3q0
         eCtpVjxJy2jTx3dWbq2HJZozLCVhbcp2IbhCvu4166/uwR5tZkjQJioFAdnK71L0Zdd6
         Uzco2Ydlig5YMy87FoGRO34uWo5lnFfNSjC9It0ODjlBnk5vHhU6BeYk8BP2vEkdVL5P
         FuF0K/jZVmrggOe6EtnS/Zj4r4QMyPiD76t6yQWeJCFlVsRtEzQFuShzWSK8bNPoGjH0
         /SGslVNR7Jctgt+eNo0Bi+8GJdcLxldz5TvsCFIkHOprhfWQNNDB1dqUzso+MpBj6QM0
         F6sg==
X-Gm-Message-State: AGRZ1gK4SUocfpcsBKWxeXKC+p8/Iid7B+Xp2nLm2/VI7fwmiXnKVLeE
        3LdEjAxuyui/cUxNhyhm1RxIGBcqZ7o27Q==
X-Google-Smtp-Source: AJdET5fOa7G/xazpjxCE4GIWzTKI9kbKH6/gpFM5aA18TDbT7EyntB6vUK47RnOB1vr2X6pv22uJXg==
X-Received: by 2002:a2e:d11:: with SMTP id 17-v6mr6167351ljn.18.1541099922019;
        Thu, 01 Nov 2018 12:18:42 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id h79-v6sm3350732ljf.67.2018.11.01.12.18.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 12:18:41 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id c16so14996765lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 12:18:41 -0700 (PDT)
X-Received: by 2002:a19:288c:: with SMTP id o134-v6mr5447843lfo.124.1541099450974;
 Thu, 01 Nov 2018 12:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrWdpoDkbZjkucKL91GWpDPG9p=VqYrULade2pFDR7S=GQ@mail.gmail.com>
 <CAG48ez0vBqL0tyfWwmuc_cq+OAUoEi88=r+t6h64a-Fw8z59zA@mail.gmail.com> <20181101185225.GC5150@brightrain.aerifal.cx>
In-Reply-To: <20181101185225.GC5150@brightrain.aerifal.cx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 12:10:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgFo8tuZX5gzCfWGdAwGyn_Ar9JFnnMFNuwr9=vtfDV1g@mail.gmail.com>
Message-ID: <CAHk-=wgFo8tuZX5gzCfWGdAwGyn_Ar9JFnnMFNuwr9=vtfDV1g@mail.gmail.com>
Subject: Re: RFC: userspace exception fixups
To:     dalias@libc.org
Cc:     Jann Horn <jannh@google.com>, luto@kernel.org,
        dave.hansen@linux.intel.com, sean.j.christopherson@intel.com,
        jethro@fortanix.com, jarkko.sakkinen@linux.intel.com,
        fweimer@redhat.com, linux-api@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, nhorman@redhat.com,
        npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        carlos@redhat.com, adhemerval.zanella@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 11:52 AM Rich Felker <dalias@libc.org> wrote:
>
> There's no need to chain if the handler is specific to the context
> where the fault happens. You just replace the handler with the one
> relevant to the code you're about to run before you run it.

That's much too expensive to do as a system call.

Maybe an rseq-like "register an area where exception information will
be found" and then you can just swap in a pointer there (and nest with
previous pointers).

But even that doesn't work. Maybe some library wants to capture page
faults because they write-protected some area and want to log writes
and then emulate them (or just enable them after logging - statistical
logging is a thing).

And then another library (or just nested code) wants to handle the
eenter fault, so it overwrites the page handler fault. What do you do
if you now get a page fault before you even do the eenter?

The whole "one global error handler" model is broken. It's broken even
if the "global" one is just per-thread. Don't do it.

Even signals didn't make *that* bad a mistake, and signals are horrible.

                        Linus
