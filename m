Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3EEC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6437218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="RsVaYmhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfAaRrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:47:03 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44078 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfAaRrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:47:02 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so2966908lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 09:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YQ0CTgjbmd0pdovplDj2NTtmiXDZ+p8m8vgln3T/kaw=;
        b=RsVaYmhBlOMvoKu0Bs80xDlVn5d/2mEFZfCWvwoNREkNG5gxJdU1M+i7AXhkE0F7vW
         OyNoAefM1EAdRDJLMDPbYWrqvJYZTdxjbpF3G1ZKHc5ccIgQkP675sGCT4IovbulvJqR
         AAO+eTtsQpEy6wH/2b6ttNHnNSij2ra0H7y4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YQ0CTgjbmd0pdovplDj2NTtmiXDZ+p8m8vgln3T/kaw=;
        b=Fi6+fxqvnFHEKpa+g6SlMCasVaZuXQ+wpex5W4ZQLJkObknb+SRTU9+5OLIZY5ZFB3
         O7wtht4w4vYsfzYZs9TDxM0Vyg4AShB7C2iPRSrb2CrGqgGfHfR/Lm/lI7u0+t051cEs
         fF83CDVSsjV6enZoaGoOiNm49znupcc3AZR2jznqn1M5QtVOROF51hRPCYbtKFT+aBmJ
         Q1wMwvkdUo1NyNq8TQ/wnJ0VnNnFrILezX/IN5gD93TzxtnvNCFtbc2uB6daBcStnpJu
         1XCSYqEg7mTmAlNUV8XtmYIWW++ZWxLZ3ix7jJ2bqgmyeTwgNO8d1uPIGwjA3dywySu0
         7KoQ==
X-Gm-Message-State: AJcUukcxg1qMrqdI2FmhFw5g5YGWPPv/qtTlkgqXuY/QMku7Hr710JpT
        X5V6ts98PG6SOZ4Uy9GG0haQBzLESHYKASgsRVnJOg==
X-Google-Smtp-Source: ALg8bN7WyUdF3lMQZG0vshgU7Ox7FsCVbh5rnJsJCpT9ySluP1phE9AEe1cSAkPmPgqITFfyJbpAJqZ0Xqgfhsx6yGM=
X-Received: by 2002:a19:4bc9:: with SMTP id y192mr27207292lfa.49.1548956820295;
 Thu, 31 Jan 2019 09:47:00 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <20190130124420.1834-1-vbabka@suse.cz> <20190130124420.1834-2-vbabka@suse.cz> <20190131094357.GQ18811@dhcp22.suse.cz>
In-Reply-To: <20190131094357.GQ18811@dhcp22.suse.cz>
From:   Josh Snyder <joshs@netflix.com>
Date:   Thu, 31 Jan 2019 09:46:48 -0800
Message-ID: <CA+t-nXQwU7q_2jVM+PY16wETRp9tBngcpWMtSnBz1u1ev-ZBig@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm/mincore: make mincore() more conservative
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>, Jiri Kosina <jkosina@suse.cz>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Chinner <david@fromorbit.com>,
        Kevin Easton <kevin@guarana.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Daniel Gruss <daniel@gruss.cc>, Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 1:44 AM Michal Hocko <mhocko@kernel.org> wrote:
> One thing is still not clear to me though. Is the new owner/writeable
> check OK for the Netflix-like usecases? I mean does happycache have
> appropriate access to the cache data? I have tried to re-read the
> original thread but couldn't find any confirmation.

The owner/writable check will suit every database that I've ever used
happycache with, including cassandra, postgres and git.

Acked-by: Josh Snyder <joshs@netflix.com>
