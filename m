Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA305C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A98C2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="COGqVSXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A98C2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeKCBnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:43:25 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:42068 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeKCBnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:43:25 -0400
Received: by mail-lj1-f177.google.com with SMTP id f3-v6so2277239ljk.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1gojRRPFHFxe2nZxtR1k5MEpluq6KZMhtlS3NOLbGN4=;
        b=COGqVSXjRnRcHtg3jBnz84qPT9wgPQoUOVbwBiMiEwGmns+iv0HY+BK0S226lRBw3A
         hr8tw/PgO5pN+KaUzj/Z3NPiJ/Q+AVh1Es/u+AQYVqP4OmI07jZJtegCFQpuKnGuCCT/
         OXK+B8OQv5ilHhLwReT7tGZiOaXmQHPs/9GuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1gojRRPFHFxe2nZxtR1k5MEpluq6KZMhtlS3NOLbGN4=;
        b=FgTS28AGYVd2JmYuZFgCRNTn+byPIYd/lfyjW/J/2YlJAhMdwB7PLLswYql3xMTj8P
         FPze/OvzlmVPtZvD6docmVa+SOFHDMkV1ewIxRnGmeUSx/A3ForTN8sC0ZYuwNC2vvbT
         /W70JjXIfKRUracpONkZJe39hOu5Wj0G8nEE7AcJ1r1BA09T5AgTZnc/bFz51spGSQSG
         c7QMLRf08y6Lr79tPisnJRkpF34vQPWLzvz7GRDbenqAapTqLAg6eODx44RDlrCTmE0J
         ly3Zf4YARBDtf2XCBNLn4vFVWb5AwOK+V4qL/r+kS+EOdtzem4Rbl+n1OFRKVZDhlc40
         FRtQ==
X-Gm-Message-State: AGRZ1gI84qoRyEGlM/AwclmbI0zSrE54F1+TqqcZEODAZfgfHjcSZIsm
        mzmLjiLcEGOkWbZvo0hFJ2NwJErFNPqCCw==
X-Google-Smtp-Source: AJdET5cZ2wA4BdIUaZPGlWVBgLzRdA1LIH9wgRt3qAjT4cGDpA2wHLaLIw8UvwwCGdh6PBlgJNjALQ==
X-Received: by 2002:a2e:2d01:: with SMTP id t1-v6mr7088880ljt.99.1541176541077;
        Fri, 02 Nov 2018 09:35:41 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id o5-v6sm4034845ljh.34.2018.11.02.09.35.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 09:35:40 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id u6-v6so2310748ljd.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 09:35:40 -0700 (PDT)
X-Received: by 2002:a2e:874e:: with SMTP id q14-v6mr5490276ljj.120.1541176539601;
 Fri, 02 Nov 2018 09:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181102051459.GS6311@dastard>
In-Reply-To: <20181102051459.GS6311@dastard>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Nov 2018 09:35:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrpyMSWM4wxYE+E4fSbpkD3yBATjLnzvvAKBfhGwUaAw@mail.gmail.com>
Message-ID: <CAHk-=whrpyMSWM4wxYE+E4fSbpkD3yBATjLnzvvAKBfhGwUaAw@mail.gmail.com>
Subject: Re: [GIT PULL] vfs: fix many problems in vfs clone/dedupe implementation
To:     david@fromorbit.com
Cc:     djwong@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 10:15 PM Dave Chinner <david@fromorbit.com> wrote:
>
> Can you please pull update containing a rework of the VFS clone and
> dedupe file range infrastructure from the tag listed below?

I don't love the timing of this at the end of the merge window, but pulled,

                Linus
