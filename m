Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD81C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0355A20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SKeCSQfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0355A20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeJaBm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:42:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45004 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeJaBm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:42:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so3530700lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JFAc2zuQlXc7ElNZyPqaq+cd6PeIkqJmqFsP/0KawVA=;
        b=SKeCSQfsaHH6KBhQ8KL0Y4CQ9dv4WBdR4G3jpIEOTHEEgr2phxdm75g20eyhQvt59T
         WCEKHCGgFzDfapuGPTDKaaozk+MFfZGbYawfGJM+L5gC9NVQBBwQenkLAD43b9mKSf+N
         DYIiD8ciKvAsIit/LZEn4BEIGHNZkCTvQSTVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JFAc2zuQlXc7ElNZyPqaq+cd6PeIkqJmqFsP/0KawVA=;
        b=XVUmOIiXZTZqn7UM8MueSKdFivZqYrhrBfPaki50FJAv4tRy4hS/K26t+/QgifO/Li
         yFIFu0MdZ7KmW5slUJ5A05+7jWyjJ8tVuC1xIoqZYHwja1cjdnzyKVy8SajkPxpkJPgb
         1yz9VdRYFnC5J22dQX3K4gh+Tl34VmnDPj0ScRx2GE17AKO0pnIjvw+8Z3ztTaVaOdlq
         u4Bp8oWuIe7NskVYO4A7pugmeQ11ubrPIsoJnteOd+IEi5W3vscOHp72D1IloEraZxa2
         hR0Y/vCq1m3UYeKZ7bCPAwixEGINFNuLDyiyDO8ahaxVP2+PKTrsndaUL+TUj04Xxrtt
         IJRA==
X-Gm-Message-State: AGRZ1gIgXS+j2FLwhxs9kVx/9tM+YLNGfrd6PzIFyhSZJ2DHA7r2nhAY
        Fe1lnr0nHIdr9/afZprsJ0kD4MhXG/Nskw==
X-Google-Smtp-Source: AJdET5eYKkU/3u/FDL9iJrqV9nvQ/2p2yTfu6R7fh5NSE1e3u3QEZUhOin8/BGVmdY1ubPF82wARcA==
X-Received: by 2002:a2e:9181:: with SMTP id f1-v6mr2466267ljg.64.1540918122538;
        Tue, 30 Oct 2018 09:48:42 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id q62-v6sm3612316ljq.22.2018.10.30.09.48.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 09:48:41 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id s15-v6so12067689lji.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:48:41 -0700 (PDT)
X-Received: by 2002:a2e:9584:: with SMTP id w4-v6mr13038267ljh.118.1540918120654;
 Tue, 30 Oct 2018 09:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181030131332.141023797@goodmis.org>
In-Reply-To: <20181030131332.141023797@goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Oct 2018 09:48:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGWzXvefJowKiz+TD8qa89g3MzuPCSUkgGRVdRfbZY=A@mail.gmail.com>
Message-ID: <CAHk-=wjGWzXvefJowKiz+TD8qa89g3MzuPCSUkgGRVdRfbZY=A@mail.gmail.com>
Subject: Re: [PATCH 0/2] [GIT PULL] tracing: Fixes to synthetic events
To:     rostedt@goodmis.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 6:15 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> This is not my 4.20 pull request (that will be coming shortly). This
> is just some last minute fixes that Masami sent me that I finally got
> around to test.

Pulled. Real pull request is next,

                  Linus
