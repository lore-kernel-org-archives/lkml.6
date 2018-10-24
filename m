Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE16FC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809102054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TRRB4hXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809102054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbeJXPu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 11:50:59 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39216 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbeJXPu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 11:50:59 -0400
Received: by mail-lf1-f65.google.com with SMTP id p11-v6so3134344lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 00:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZNGBt4mvIyfcF3mrRY00L/E6V2hkchfohJKELWR3J9U=;
        b=TRRB4hXTn25/DHRQzoC4GqqTkzlgnbGKfEiN8LsjGXyYFn8J4O6Jo03+FPQo0fxGo3
         DR03/0WzwoQktAMrnwFiwC8o6zaK27+3jaJXbAmV1TxetLFg77xE0BjY7oj4R4H817DK
         OeHehr3Ldc2bCdIJqNjUV8wMnW54n0k+/4v28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNGBt4mvIyfcF3mrRY00L/E6V2hkchfohJKELWR3J9U=;
        b=YZ4XavcOPVukDdEVmCHUA3zDwJl1FIpolCjgjUte3NqCz1IUQT/0dWBnNFd+atUL3U
         CocxAVuNId0fwRL69VwofY3xKIY3H1Pj84v3PLbzeGNOxDcpJ90W+fEvs3IYtvOPtaOU
         WklPgJq1e10q9FjFU17/8WFuFL5oBMzbel7wmd5xvgSQZPXj1g6bZzn6wDoKSraXhyU2
         Mcje2mkOAHXYg5IVHiLartOXIHGQnvkAAIOyCnbNqz8U1er81sBEo3NG8pKxQLGIJpqo
         S1G60KnI9YZg9V4rTJGbsK/PrzncroZgqMoQD7OuGAc1BNpQG/87VxxGrQBSh6HnTof7
         0TuQ==
X-Gm-Message-State: ABuFfohLqcDn6RdDTFBDt+CArdL4af/QaoxWmtwNCShNNAuNzShwdrb4
        qNEe+krJrDXQ2neAixWucUgWwljiWUzjqd/u
X-Google-Smtp-Source: ACcGV617DqoKa/s3ub3gdKm9MTHCf89Pmm7kp01J0VKDWYhxEHKplKnxR4uCTT6w7tvhTEPUQvxlTQ==
X-Received: by 2002:a19:1f46:: with SMTP id f67mr13908382lff.1.1540365847288;
        Wed, 24 Oct 2018 00:24:07 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id e21-v6sm567305lfc.48.2018.10.24.00.24.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 00:24:06 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id p1-v6so3763729ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 00:24:06 -0700 (PDT)
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr1000775ljj.80.1540365845678;
 Wed, 24 Oct 2018 00:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181023.202921.1185045750138652543.davem@davemloft.net> <CAHk-=whuhCGujWKO8JObGQaSdWOpJBXdkM-B-vD80QZifveScw@mail.gmail.com>
In-Reply-To: <CAHk-=whuhCGujWKO8JObGQaSdWOpJBXdkM-B-vD80QZifveScw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Oct 2018 08:23:44 +0100
X-Gmail-Original-Message-ID: <CAHk-=wh2H9jE2RXibQgWs3_Q539roj62_gzPXKjnhhKqSFcw2g@mail.gmail.com>
Message-ID: <CAHk-=wh2H9jE2RXibQgWs3_Q539roj62_gzPXKjnhhKqSFcw2g@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Govind Singh <govinds@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 7:01 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. Tentatively pulled, but there's something wrong with the Kconfig rules.

Confirmed.

I did a978a5b8d83f ("net/kconfig: Make QCOM_QMI_HELPERS available when
COMPILE_TEST") to fix the breakage.

Why wasn't this noticed in testing?

                    Linus
