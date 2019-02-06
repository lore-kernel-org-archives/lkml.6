Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26949C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84F52175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWpaYTga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfBFQXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:23:43 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41883 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfBFQXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:23:43 -0500
Received: by mail-qt1-f194.google.com with SMTP id b15so8455434qto.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 08:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oh8atz+iR4+ECiTaTUpXjXYmQ7/3LE+YBTxI8eIOLLo=;
        b=tWpaYTgaC1VhxaInRFw64von/l/FM/TLujCJXUrbriI4YQ13wcU6AuSvHje/98AdnZ
         8w50ELobBZqPTOhXKmia/+8bgx2/hevaoxgOPvTgltRWCIUEG/immBiVCVeRpoG10CZl
         //JE4PsgMFJNO8R4EvyFxSNOH5//iDoukqN3xf3vx++BMLW28lF31oCIEF/3m1WujHO3
         t7JO+phXxLC3mENZ6wWMJ+1gUglycbVkc94Ab9YCqqP8gGoy33kAFDXdnw5hGsWYtHPs
         ZLmxC0amFps+/36QlYVAULx+mgGDKsF0gPSPKGHdoOWvk/imA4sxDw2hZCvNWnLMi5Qf
         pWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oh8atz+iR4+ECiTaTUpXjXYmQ7/3LE+YBTxI8eIOLLo=;
        b=D8psmnE/uCLb9g74PyWsN2/cdOdg0GnhuJ4Oeb9RJHQjY8YItTPlJREbmBRgztEWCy
         /njUYUVE3S1AbwYoObMrvCIFXrmUhvAGjTtiBT+Wu5A5D81JesztaYEoBstxzqH+gOmh
         CRvDJLAuvA3PzvHaLJyU8GqGxlh0ocRXQKwt7kS62tWZwqwdYyqXA1rDTSVqQqy1+KpJ
         PwQ42z1xStyF5D+2pHc5QWsQ3u12cVqzdEuwcjPRG9k6KNASehLeM+LJfMyQXI6FwqSF
         eC0IGv/c6niyLwTR9ykyYr9BTb/KK4c5EAPnQddsV4Ml+PB1sgQ/1khzIBxe7bgNAZKE
         pewg==
X-Gm-Message-State: AHQUAuavbaDZRkOrOwkaSZNgQY9X7teySzJde4pYRMQgCla7zILQLais
        yioMwAxgtIlzaR/Ax/fkAHZU11GE4fNkrhO4j0izeMTG
X-Google-Smtp-Source: AHgI3IaGu0Ejmhv1aJskOfnIF+yDDxWd4YAdFCdnHVSQQI8YGXZZ+yVxFm+jzwOUoJ9XbW+9NVprGOnTuzckiFmGwIw=
X-Received: by 2002:ac8:278a:: with SMTP id w10mr8408581qtw.149.1549470221761;
 Wed, 06 Feb 2019 08:23:41 -0800 (PST)
MIME-Version: 1.0
References: <1549469662-13614-1-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1549469662-13614-1-git-send-email-vincent.guittot@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 6 Feb 2019 17:23:30 +0100
Message-ID: <CAKfTPtBnJRm6J9mtSzZiZ9s3dWHHsHmACYb-Cu2p7oChwnZOPg@mail.gmail.com>
Subject: Re: [PATCH 0/2] sched/fair: Fix O(nr_cgroups) in load balance path
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Sargun Dhillon <sargun@sargun.me>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2019 at 17:14, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> This patchset adds missing pieces in the management of leaf_cfs_rq_list
> to ensure that cfs_rqs are always correctly ordered before
> re-enabling ("sched/fair: Fix O(nr_cgroups) in load balance path")

I should have mentioned that this patchset applies on the latest
tip/sched/core branch

>
> Vincent Guittot (2):
>   sched/fair: optimization of update_blocked_averages()
>   sched/fair: Fix O(nr_cgroups) in load balance path
>
>  kernel/sched/fair.c | 67 ++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 53 insertions(+), 14 deletions(-)
>
> --
> 2.7.4
>
