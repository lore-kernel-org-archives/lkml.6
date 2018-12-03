Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B01AC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECAB920850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FNgEJnrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAB920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeLCRed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:34:33 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46779 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeLCRed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:34:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so12167881ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7LcLnMk4V5PpabCgP7lHlco39TNBY8EwSdngHqUzyCc=;
        b=FNgEJnrLY375WNyOgrlITMygyw4NqgVOkjxz4Ekqt5qRdgw7QUA4cvP/whQsH6jZIZ
         TltdhCdhqqQ+RloEdQbMOmRY2tAkL3r9DkdqOfixL2XFcuZqv4z949rJ3mK9fSEJx506
         ndk8MYrcpGhCLV5uP6DEaApdy0KlRdACTOsNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LcLnMk4V5PpabCgP7lHlco39TNBY8EwSdngHqUzyCc=;
        b=m0XcNSuP2YLL4K3kaaYQm5r9u9Xkt6Ha7UAQ0pwnNN2wN8oEhtRrctrzD+dthvLQu7
         SZZyVOihpmI9A9P2k5EXJPjsmgN1Umlz18Dt1/egac7QGEqs0N4BE9pHBroDEoIrRXDf
         cPxmPqQj8R5dClqsrSlC7j4taPwETLkyDesV85AD7WV73ZE/+pZoSn+lhJ9hgs6D2p8Q
         C7J/1H99VloA29o9JTonrktZO3TsiJ842nbWJaxKUG1JCyBaEFW+qg0ZgynplylWraa7
         zLp39aeTmQtw4QE2pgcv/9ByIwX4k6SBUXkoTsnoRQJz4SIo/Uy8Xeew9GzvnFrKrDGY
         WmQw==
X-Gm-Message-State: AA+aEWbMFjbEuybGfBQm6qv86gLbVGRBidUE6Fm1UNs/xKPgQgiAYllm
        8TmAz0oM59P1anUqaSu705XjD/2JQ1Q=
X-Google-Smtp-Source: AFSGD/VA0PSMAhao3CyIFULE4cPJovkst5T/0jxLekCR/fsqkYvxwJO38I30k3fDADxNv7pYL3yOBw==
X-Received: by 2002:a2e:63cd:: with SMTP id s74-v6mr10272021lje.117.1543858464412;
        Mon, 03 Dec 2018 09:34:24 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id i127-v6sm2585899lji.3.2018.12.03.09.34.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 09:34:23 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id c16so9782288lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:34:23 -0800 (PST)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr9296579lfa.106.1543858462654;
 Mon, 03 Dec 2018 09:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20181203110237.14787-1-rpenyaev@suse.de>
In-Reply-To: <20181203110237.14787-1-rpenyaev@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Dec 2018 09:34:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiQX4HnBpyrxCwJmhBRff0GG65tOhsRnA=2KdYL=PBdyg@mail.gmail.com>
Message-ID: <CAHk-=wiQX4HnBpyrxCwJmhBRff0GG65tOhsRnA=2KdYL=PBdyg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] epoll: use rwlock in order to reduce
 ep_poll_callback() contention
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 3:03 AM Roman Penyaev <rpenyaev@suse.de> wrote:
>
> Also I'm not quite sure where to put very special lockless variant
> of adding element to the list (list_add_tail_lockless() in this
> patch).  Seems keeping it locally is safer.

That function is scary, and can be mis-used so easily that I
definitely don't want to see it anywhere else.

Afaik, it's *really* important that only "add_tail" operations can be
done in parallel.

This also ends up making the memory ordering of "xchg()" very very
important. Yes, we've documented it as being an ordering op, but I'm
not sure we've relied on it this directly before.

I also note that now we do more/different locking in the waitqueue
handling, because the code now takes both that rwlock _and_ the
waitqueue spinlock for wakeup. That also makes me worried that the
"waitqueue_active()" games are no no longer reliable. I think they're
fine (looks like they are only done under the write-lock, so it's
effectively the same serialization anyway), but the upshoot of all of
this is that I *really* want others to look at this patch too. A lot
of small subtle things here.

                Linus
