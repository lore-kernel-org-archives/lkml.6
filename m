Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A6FC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD762084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="avLREWX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD762084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeLLLnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:43:06 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55848 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeLLLnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:43:06 -0500
Received: by mail-it1-f194.google.com with SMTP id o19so8541527itg.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 03:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cO9SEBmTeSjG5hJV2GYmUGZPU+/TZz/y527TWGrbuJs=;
        b=avLREWX9OVBvOxYB32E5uEnBLtkgLuwZwLPzvvDDCh2BIVk9ZkPIHj0YSx0Ds5lJ4W
         dgIiMFlHjk2Y5+vP+bh9DGlD2xI1a5bzw0S6adkLBIwuMV7Qtz2f4TCQB8eUZ4Yu9L1B
         8EBKoL86e7NNMThIyhkaEsq/vVhEsUbW9mBRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cO9SEBmTeSjG5hJV2GYmUGZPU+/TZz/y527TWGrbuJs=;
        b=Nw1HktzEBYxdWtGRkfODWWP8Zd/RMbB2GcjvqO1chOcVPMeeSzknRn34FTaLTax0IW
         JyZLJzX8wHn5/akfSV/igvfz4s6tVrN19XNndJqRDm15UDZqq48/61+TN9Fb156VvpKX
         4gPHUpGSgBoqB6JH38UNWQXwtXotHw+ZO8Mgg8AuHtxTJIjJDZ920v2Qk5EFtzQuvBeU
         AGqfUP8a5EDeNbkBAGa7oSPNtwF8I96rDRwVMi1/kOyqLeTLVPHJaCTXk2SyuKsX7vLO
         wygh3pVqYVPCGachBxmbU+rVoKZhoGMj2CCXfUK5bo4NRm/gpDvKOjGec0qUPRYr+rpv
         +Zlw==
X-Gm-Message-State: AA+aEWbRwYDEj5GOlrpimWMaUvvz0Q2LJkQA4O/F37vsAfXeXxrhNk0a
        F6j14jXxSgXIxP+w6F+Tg3ayPjcuQZj82y5uF/XDEg==
X-Google-Smtp-Source: AFSGD/XYiQbP+XYpTCR8NH22SOKWH5uMHtfJtqaccMkoIiqjOt1pjLpSqNEdXdVPBTQaNwMLwEkwoFo++N2FIOoxrps=
X-Received: by 2002:a24:9b87:: with SMTP id o129mr5730709itd.128.1544614985390;
 Wed, 12 Dec 2018 03:43:05 -0800 (PST)
MIME-Version: 1.0
References: <20181212022506.171936-1-dbasehore@chromium.org>
 <20181212022506.171936-2-dbasehore@chromium.org> <20181212090901.GV5289@hirez.programming.kicks-ass.net>
In-Reply-To: <20181212090901.GV5289@hirez.programming.kicks-ass.net>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Wed, 12 Dec 2018 03:42:54 -0800
Message-ID: <CAGAzgsrj91jyp96XPiww=32NUhbcwH9q_t0OxzotRF-3Zga_=Q@mail.gmail.com>
Subject: Re: RFC [PATCH 1/1] locking/lockdep: Fix nest lock warning on unlock
To:     Peter Zijlstra <peterz@infradead.org>, sboyd@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, will.deacon@arm.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 1:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Dec 11, 2018 at 06:25:06PM -0800, Derek Basehore wrote:
> > The function __lock_acquire checks that the nest lock is held passed
> > in as an argument. The issue with this is that __lock_acquire is used
> > for internal bookkeeping on lock_release. This produces a false
> > positive lockdep warning on unlock. Since you explicitly don't need to
> > hold the nest lock on unlock, this is an issue.
>
> Who is triggering this?

I'm writing code right now that triggers this. The goal is to reduce
lock contention in the Common Clk Framework by getting rid of its
global lock. One of the approaches I'm considering is adding a nest
lock with n "subtree" locks. After locking all of the needed subtree
locks, it's important to unlock the nest lock to reduce contention.
