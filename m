Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536FEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C69E206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ATVrXUvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C69E206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404358AbeKWEd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:33:27 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41327 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733020AbeKWEd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:33:26 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so7059430lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 09:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n0hsOztC/mWOUSdIfKC3qI63u5JMMNr9hOgldkbjdjc=;
        b=ATVrXUvysewxWVsZAsL6YnIHshTItsh7aq0wkW6o56SYwbQcJiCV0vxONeMBw465JZ
         zJdfYdjS29+2hrn5SjZ1yNvBzLHHBnjuVEprpGZSijrM6b34zh7XM9D8udQRdrLP99Fi
         zcaqAOLR1niCzGy/jrqYyfWQ77L8VU6d55eRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n0hsOztC/mWOUSdIfKC3qI63u5JMMNr9hOgldkbjdjc=;
        b=lNFg4OGAe2q2ASj6fFchKlPgLR2R3x+MPZ3LdXTa3L974Gj1e73akE252dvhgCduS4
         ngSSigRdFpDgCbkgat/ZiXpEOXsPXMvZEACUBh1B8MHtuf41veqIrClPDpFkd3zfFji8
         rt9y1fp/4v24UfPPaoI52YPb7bOWgUURma0kjG/grZcpEd13FcFIcXxAdEJ5b3h165P6
         pYyZtP6rk+0pw/5T1iyPl68M2sfl3T1tf6K/MqGbyCBNKjsOfaypYOLcMmQsTjolBh2a
         N8rjyJPCbBZdi6+cUXEc58QkZNT054eycEjO8GBUj5PCMMcyUjOfSFbESo2seA3vsJFt
         yycQ==
X-Gm-Message-State: AGRZ1gKcvWiklXmMYm1+jTLm+ImI0lhZ2IfSJoPDXkd1sVlnNtfM3OJs
        O1g4tEtaGuhEVDGaH5Jm2lmvvGHhXr4aog==
X-Google-Smtp-Source: AJdET5fJg35pY7T5bfDeqhoT+j/KNkrfc5hHm5mdBxb1xhgsaM2YZwlfj92dB595NiHQEaopP5TPTg==
X-Received: by 2002:a19:4287:: with SMTP id p129mr7434169lfa.135.1542909178510;
        Thu, 22 Nov 2018 09:52:58 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 75-v6sm7665854ljs.50.2018.11.22.09.52.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 09:52:57 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id n18-v6so8638405lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 09:52:57 -0800 (PST)
X-Received: by 2002:a2e:3e04:: with SMTP id l4-v6mr7354579lja.148.1542909176487;
 Thu, 22 Nov 2018 09:52:56 -0800 (PST)
MIME-Version: 1.0
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com> <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <26eff539-7de7-784c-0c88-f1d30753299d@redhat.com> <7ea44458b90b4d41a08ba9012818d273@AcuMS.aculab.com>
In-Reply-To: <7ea44458b90b4d41a08ba9012818d273@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Nov 2018 09:52:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjLNuNpHRfuVTb6awstC9OOmSb3S8aP51ufep-Th4dXKw@mail.gmail.com>
Message-ID: <CAHk-=wjLNuNpHRfuVTb6awstC9OOmSb3S8aP51ufep-Th4dXKw@mail.gmail.com>
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
To:     David.Laight@aculab.com
Cc:     dvlasenk@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, brgerst@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 9:36 AM David Laight <David.Laight@aculab.com> wrote:
>
> The other problem with the ERMS copy is that it gets used
> for copy_to/from_io() - and the 'rep movsb' on uncached
> locations has to do byte copies.

Ugh. I thought we changed that *long* ago, because even our non-ERMS
copy is broken for PCI (it does overlapping stores for the small tail
cases).

But looking at "memcpy_{from,to}io()", I don't see x86 overriding it
with anything better.

I suspect nobody uses those functions for anything critical any more.
The fbcon people have their own copy functions, iirc.

But we definitely should fix this. *NONE* of the regular memcpy
functions actually work right for PCI space any more, and haven't for
a long time.

                 Linus
