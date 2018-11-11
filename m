Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B633C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 06:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11F720871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 06:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzVti6EG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11F720871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeKKQnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 11:43:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37403 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeKKQnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 11:43:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id p2-v6so5295079wmc.2;
        Sat, 10 Nov 2018 22:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HrxQm/tbSt1VIjLVODSUfW567jjThOILFv/yt2/HmBc=;
        b=KzVti6EGn5LCEglCVQoS/baNUy/ni0Co3kFhnaQrgBMqUscIKiWEd44kg1AovZ/jqy
         DDvUW9dBk5hKTmbFm/Xo/jJIIhl7jMBmUuzGWcEP75Apte6c/R5DklMpLdCv0jn3P67m
         MexRGlMKmy765VsfTAVHlOc1j8QnXKjbLM3q3ZgzO87CbJCN1RmrD/MicxX+TLIHXe/i
         f/tzVipRMZLBkuEwYPSG26rlcoiyWn047iNZLl7X+Xttrh6JUdb77Zr80RSH3VlOKhth
         x+Vat4BqxlilMgzU53A6x4k5Uu5NvApF2emqxAcELQ7+q+MYU2fU13KVPdqQX8unTPBG
         mXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HrxQm/tbSt1VIjLVODSUfW567jjThOILFv/yt2/HmBc=;
        b=UlMtpHPUw5bkGX8OAUVpiQHS5axC6WE5ensL+CU4wawdAuJl6qpEnB6gRO1DKSPj2D
         ZrElX3NPhoyibE51EpduTTqkTsROkfyb9uZH/d2dzAHJ9OcN6zrkn/vbucVEQbhJ6Omk
         HjciHStt7sCKCnlsgXiSygPqNbtLPbKLCHMDjAo/NnVTSeq/x079WuK02OIiFdN53l3y
         SGN9hVinlrvRtQDPIWgMhVnEZwBQGVIwyfXJdKkN9JBGNu8x1srwWtp/nsXJ0IAmp/QZ
         +HDzgFFQMVtrcYvHb9Y0I12dsPzShLbWaim1r+hF7nFZFjRhyuXxCtchoP94Ewf2GWu+
         KluQ==
X-Gm-Message-State: AGRZ1gIXd89nXAGTAqdeNbqS/YGyhnszyVpycj64vkecktxAhwVCbORq
        dGzqcr2M7iKS1RWP7tYDdPLSssx/
X-Google-Smtp-Source: AJdET5eOGS80HelRxLCPBBF8WdVCAjPjA1XLXOa2hZBfMHBnY/bioC3xav7HYEBByDCEIepuDHL6Pw==
X-Received: by 2002:a7b:c84f:: with SMTP id c15-v6mr3423622wml.79.1541919333930;
        Sat, 10 Nov 2018 22:55:33 -0800 (PST)
Received: from ?IPv6:2001:a61:245e:bd00:7c53:ba1a:108c:14a2? ([2001:a61:245e:bd00:7c53:ba1a:108c:14a2])
        by smtp.gmail.com with ESMTPSA id 137-v6sm8773312wmo.43.2018.11.10.22.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 22:55:32 -0800 (PST)
Cc:     mtk.manpages@gmail.com, Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
To:     Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
Date:   Sun, 11 Nov 2018 07:55:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding in glibc folk for comment]

On 11/10/18 7:52 PM, Daniel Colascione wrote:
> Now that glibc is basically not adding any new system call wrappers,
> how about publishing an "official" system call glue library as part of
> the kernel distribution, along with the uapi headers? I don't think
> it's reasonable to expect people to keep using syscall(__NR_XXX) for
> all new functionality, especially as the system grows increasingly
> sophisticated capabilities (like the new mount API, and hopefully the
> new process API) outside the strictures of the POSIX process.

As a quick glance at the glibc NEWS file shows, the above is not
quite true:

[[
Version 2.28
* The renameat2 function has been added...
* The statx function has been added...

Version 2.27
* Support for memory protection keys was added.  The <sys/mman.h> header now
  declares the functions pkey_alloc, pkey_free, pkey_mprotect...
* The copy_file_range function was added.

Version 2.26
* New wrappers for the Linux-specific system calls preadv2 and pwritev2.

Version 2.25
* The getrandom [function] have been added.
]]

I make that 11 system call wrappers added in the last 2 years.

That said, of course, there are many system calls that lack wrappers [1],
and the use of syscall() is undesirable.

The glibc folk do have their reasons for being conservative around
adding system calls (https://lwn.net/Articles/655028/). However, at
this point, I think one of the limiting factors is developer time
on the glibc project. Quite possibly, they just need some help to
add more (properly designed) wrappers faster.

Cheers,

Michael

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=6399 is a
    longstanding example.

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
