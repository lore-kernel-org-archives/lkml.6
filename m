Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5C3C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B3920823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SDDQN3kL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B3920823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbeJaEnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:43:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36619 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeJaEnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:43:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id s15-v6so12601884lji.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 12:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zCqS3d2JlgJGyOakCY8LcfD1Dd9JxdPoSIxoRxgc1u4=;
        b=SDDQN3kLLEGYdiMQSJO2b/sc1ZSW7rqbkhZ6XcC3pqDpcXau+CDwPAhzlISLMjTwyH
         +f7XLEfHnJZdui/SoTfa8opEluyY8btjM1+Ckw22i5oav8HsgPzLNdltIM9uA4ROuwll
         7texGZjRmfX5Ozw0Q9LLhoyc6Yi7LP5RjGAMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCqS3d2JlgJGyOakCY8LcfD1Dd9JxdPoSIxoRxgc1u4=;
        b=tkeSBYbkuXGBFAAQ9tiA1R9WRufL5CQxRSx+lEX5mkb9y5m1okjhgpsNPyIBk7O9QL
         0KkX2eELI0MTt+ZwuMRw4B0SBXTMc578Uz29/G3WCUfs1pGnZRz98whu4cz2XopvUovB
         2Tl1KTIVEZAO/A1I1jaVmptZlwf4XsIESUt/bKwlthlp1SCDGpfYSBTmswP7KkUhdGXv
         X6WptqGgEHHV1wHpiuAtslvx6vZUx/w9vv7uRm0cmamLZ5n0lb/Uw9KeFyHqYGNQlydG
         WApoIuOoFRJQwCID40wpiOKxvInq4bePYz0caa+teY890RCmUV5eMlYnd8JfArvRCJzR
         vRZw==
X-Gm-Message-State: AGRZ1gKqxjjiGZz31vpPRIx9Ruqhd+dVYJVnDfB6Qi+iAYJpIzgE1rXc
        7DVfEAAaTZyt8+NxZiphUe1WrsbslUROqw==
X-Google-Smtp-Source: AJdET5dyjx59SrdpA+fSRXwRAUzReULy+k7TzS7fenfncz4e/ZVSo8Z1NogRzU5wOWesVd+J75XIrQ==
X-Received: by 2002:a2e:9c86:: with SMTP id x6-v6mr63833lji.50.1540928887236;
        Tue, 30 Oct 2018 12:48:07 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id y80-v6sm3801441lfd.78.2018.10.30.12.48.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 12:48:06 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id k11-v6so12598963lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 12:48:06 -0700 (PDT)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr40722ljh.59.1540928885862;
 Tue, 30 Oct 2018 12:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YSQ.7.76.1810301455170.1498@knanqh.ubzr>
In-Reply-To: <nycvar.YSQ.7.76.1810301455170.1498@knanqh.ubzr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Oct 2018 12:47:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5LD3Wkk8gb_SoDGd3Yxsef2089jDDBxN4qHubab6c2w@mail.gmail.com>
Message-ID: <CAHk-=wh5LD3Wkk8gb_SoDGd3Yxsef2089jDDBxN4qHubab6c2w@mail.gmail.com>
Subject: Re: [GIT PULL] Cramfs fixes
To:     nicolas.pitre@linaro.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 12:09 PM Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>
> Make the Cramfs code more robust against filesystem corruptions,
> plus trivial indentation fixes.

Shortlog?

Anyway, pulled.

                 Linus
