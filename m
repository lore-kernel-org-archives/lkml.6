Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9777BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEE6250B3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XsUTPnba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DEE6250B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752332AbeFYH5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:57:09 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:43876 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeFYH5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:57:07 -0400
Received: by mail-lj1-f172.google.com with SMTP id x3-v6so5342094ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 00:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WU6tY2blVqHM5Ct6pAniDe8wIZoKyuSC/i0MKQXrAj4=;
        b=XsUTPnba3rJypSBgqfzboUOAR9lh/Wf3gZq0rPssGMPpcxTKeXCTZ4wX9058Qzmzcm
         StbnYReM3re1Y/6ZIvH64hRWmKZr4lQXBkVkd2i9R9QHDa9GAy4rYXpJ5Uzp37KgELkx
         fn1bEDX0Ch0hy9QWq0/9wVHV1KQ/HKb28YSdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WU6tY2blVqHM5Ct6pAniDe8wIZoKyuSC/i0MKQXrAj4=;
        b=h77HhXg3GgHYqD9V+omVzwZ3zvMhDurgTaM9+VPRRacm0dRltD7G0cyO+L0Zyg47yF
         5S1wfFf1cnFcJj3cYIRRbWOe+HCq9vYEbJBQEvUw8r+1v4+ZZjMPDCSRESbh23C+Sb27
         q1zg6QVjZ8/9zIYBh1q10CAojVq1MT9Af6ktpOUXORLDeAFW9yIQCaioZ+W+wlOqz61l
         nyRRZIUDKBOGrVAHNElDxjV65+mbzGXE67CxUBtuhfCkyyEZp0j+1nmVsNfA2C58Al1f
         20ig+D5eaqNeLzURNfM80/2JoNOk9ZO0Yiyp0vliSEZDYy1BldUpu8/tWUQDuF/IDOqB
         YVzQ==
X-Gm-Message-State: APt69E3a6j12pSjBy2WuE7BM4siblfGLZVJDwcTtrqA0UcImewLxbv1H
        7zww2ZYZz8z/ZliBfdlBl4gNHV1lf31BJtjcss7mhw==
X-Google-Smtp-Source: ADUXVKLzRjJ7kjGIQ8HZWDeLZSjBSTDFJuaxvioZL4gsUA1Y3AoVZ3fSQeQB6eYHP76kxHK8WeY3ywJvs7/SWcqwOx4=
X-Received: by 2002:a2e:9dd0:: with SMTP id x16-v6mr6611804ljj.142.1529913426381;
 Mon, 25 Jun 2018 00:57:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 00:57:05
 -0700 (PDT)
In-Reply-To: <CA+G9fYvsGCogLWYooQ9qjUYuu5XO=pwD_q3vqD-ys41wwPk90w@mail.gmail.com>
References: <20180624142740.481662434@linuxfoundation.org> <CA+G9fYsxWVXZH=VB9tCvBcJ_K4pOPs51J1XnnCjF8vcBVMadDg@mail.gmail.com>
 <20180625065557.GA5140@kroah.com> <CA+G9fYvsGCogLWYooQ9qjUYuu5XO=pwD_q3vqD-ys41wwPk90w@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 25 Jun 2018 13:27:05 +0530
Message-ID: <CA+G9fYt27umnoetNwEgPFSNKe+sYNKHibHDfm9ft3CjNAM+kAQ@mail.gmail.com>
Subject: Re: [PATCH 4.17 00/70] 4.17.3-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> This looks like a quemu bug, not a kernel issue, so did you tell the
>> qemu developers about this?
>
> Thanks for confirming this is not a kernel bug.
> I will report this bug to qemu developer mailing list.

Reported QEMU bug on launchpad,
Bug id #1778473.

- Naresh
