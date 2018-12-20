Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B79FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE49121741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqhlpFCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731774AbeLTMTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:19:40 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44546 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbeLTMTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:19:40 -0500
Received: by mail-ot1-f65.google.com with SMTP id f18so1556153otl.11;
        Thu, 20 Dec 2018 04:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vf4qKu0c0jrKrDi24L+SYLKQ4APSwnYjDMwf+iBTiQE=;
        b=gqhlpFCLXYna5v3k3HtYbmf80qY46l7bhExshrSCsFBkpgd3hvw1tSACEj4lcO9Rmg
         9aw6R6EKhRxWf5BhD+pIqaMq1weystbKk+laTx8OaEgsL7ECsbVcPLkJ6aBRd4FnFcFk
         ZZReBOK0G+gOSoWBFUysjoHbwbIhjd8+4s/p0BlN53S3+AcbtQsvIi5XuCtd4bEamyTH
         m0cQJTr0bksV9UNFnOtAkdl0L4fay7N82Uqje/w3Y0VGAmxxvStOZ7n2JnBs7g51/Fra
         xg56zcwU68UThSkitC30kgmyxnH3RoCqEovMxGNKYs+u/PKfGX/3fPlNpibVb4hsBii3
         OXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vf4qKu0c0jrKrDi24L+SYLKQ4APSwnYjDMwf+iBTiQE=;
        b=RFVYpRxqjv32x1k8kE0htULDEaRoCzc39lTOP0IbJNicrAVcaBpGlJxVCfMvTHSMwT
         TgzynhL/bFfUKv8v2X442e4AEU8Hzn7Q/ykygCKfU7dUmwdvA5gLGG3yIlLeHcgEUr6e
         ExLXzrmpsdIQRY/o8vxkJvsesqkFkDgNZK5x04YvEEuSpm5IOgeDEmko9Ovy6L6+nxg/
         Y0otDg64Nf+k7fjZ6j5m5uEc1W0iIDTDyNYO31Q0uZR3nNWduNcHL0h81kVvqllPnLUe
         YKSWaXDaQaDopWBVPs0QOTU7z+5STJrr42BcoW+s8L/rFGsCux9JLB1qdBeOX/o6zk8w
         eTOA==
X-Gm-Message-State: AA+aEWYyZTY1GLlxGeJwLl33JaOD31dksBDjZG25TpC7hiV4wbD54LyV
        Mt5iXNi18PxgY/CNQPrOekUp8rZv0cMcBLPSU6s=
X-Google-Smtp-Source: AFSGD/VAtsXtHXKSHxZ4UVO2V4FPR4uGycjFeclD3eugEhBqnSwpiSgR3zcWtu+wWcNb/7X/OjxlETgcQLP4opguDzE=
X-Received: by 2002:a9d:5249:: with SMTP id q9mr17432055otg.160.1545308379878;
 Thu, 20 Dec 2018 04:19:39 -0800 (PST)
MIME-Version: 1.0
References: <20181220085922.332225035@linuxfoundation.org> <20181220085923.169451350@linuxfoundation.org>
In-Reply-To: <20181220085923.169451350@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 20 Dec 2018 12:19:04 +0000
Message-ID: <CADVatmMq2cNhoM0RJyuS=u_u-K9ksM1TWLeD1+ytTzVsHx=i-A@mail.gmail.com>
Subject: Re: [PATCH 4.14 21/72] locking/qspinlock: Ensure node is initialised
 before updating prev->next
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Dec 20, 2018 at 9:27 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> commit 95bcade33a8af38755c9b0636e36a36ad3789fe6 upstream.

It seems 9d4646d14d51 ("locking/qspinlock: Elide back-to-back RELEASE
operations with smp_wmb()") is improving the fix. Is it worth to take
this also?


-- 
Regards
Sudip
