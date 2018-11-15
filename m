Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF82C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42D621582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MujxpoVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42D621582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388749AbeKPE2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:28:20 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43986 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeKPE2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:28:20 -0500
Received: by mail-yw1-f68.google.com with SMTP id l200so3469626ywe.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 10:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CbOobFilVEKlKTZyRrBqOzKa/QVkvwiXfjOPPAzk9bI=;
        b=MujxpoVQ7TI71xQc325JRV9xhDDC5/dh+r8Fz1vnk1aVpExPC+0yFqvwVYD0e0VYtS
         KrhC9Yt4Z8qTKBwhUeh1C1HeqSSIwVaXfeytaPhKhHW3PSAr6PRAPvbXpgDSlzDvkngi
         PsHTpwO3+d0Ha8yXC1M+0dZhrJ55clVd1QQcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CbOobFilVEKlKTZyRrBqOzKa/QVkvwiXfjOPPAzk9bI=;
        b=DKOmhozhyEMugFvv4EEXXNYw+Zyi/jIdrmC0gMkQ/MvxUbRLd8k/z6e0k79ggIpjN3
         593KsyHn+tVFBdhqyQTBSi/kx+FUwSIXf7EyfxQMxEpkzE4fHknkBPL6l31AngHx9NWZ
         TxZBbZW2ZX/VmzQMV2tTqA2bMGS3LzMmLo968745IOyC+/vqgL0DgIHdx5vAdcS/lPXT
         yq5xYIXlsk+GdBAcsd34jnRKhsT128Ge/jSqE0L7vY3WGqZaAHFrT84btblxjLB1T3p9
         DXlocntV8pJjT4orZ56ZSE9UTVUzALw60IRHIWSd4lr1Z4cxC+fYXW1/RZPuFBmm78lg
         EZLw==
X-Gm-Message-State: AGRZ1gLC69ksGEqmesh5XHSa510j2u5DIlfhydnXiX3MCPRTzyALow4m
        ZjlGZR3eqLm3BO7lXlwjFRdmeuxgsRWz3A==
X-Google-Smtp-Source: AJdET5eSHBeehdAvsWp8Y4MzRrzvCDCO/LKG9J7jw61L2ZnEmQgi3DHGm8rIKo6BESUYqX6TE3ZSpw==
X-Received: by 2002:a81:4ac4:: with SMTP id x187-v6mr7005275ywa.249.1542305965335;
        Thu, 15 Nov 2018 10:19:25 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id a12-v6sm15559510ywh.20.2018.11.15.10.19.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 10:19:23 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 131-v6so8707031ybe.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 10:19:23 -0800 (PST)
X-Received: by 2002:a25:c695:: with SMTP id k143-v6mr6727259ybf.171.1542305962819;
 Thu, 15 Nov 2018 10:19:22 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Thu, 15 Nov 2018 10:19:21
 -0800 (PST)
In-Reply-To: <3ac94357-5860-f9fd-740d-a2cd277fd0a8@i2se.com>
References: <CAOtG3WrGCwVd2DWq6Gq_ajZau0xJ-kPMvFRU6HyELYtUr30_VA@mail.gmail.com>
 <3ac94357-5860-f9fd-740d-a2cd277fd0a8@i2se.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 15 Nov 2018 12:19:21 -0600
X-Gmail-Original-Message-ID: <CAGXu5jJfypZu=gp5vrB1Xf_Hr-Fpa7YqmXZT2z0MJhZtqR1ubg@mail.gmail.com>
Message-ID: <CAGXu5jJfypZu=gp5vrB1Xf_Hr-Fpa7YqmXZT2z0MJhZtqR1ubg@mail.gmail.com>
Subject: Re: [PATCH] firmware: raspberrypi: Fix firmware calls with large buffers
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     James Hughes <jnahughes@gmail.com>, Eric Anholt <eric@anholt.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 10:05 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Hi James,
>
> please look at
> https://www.kernel.org/doc/html/v4.19/process/submitting-patches.html,
> because there are several issues with this patch. Most critical one is
> that i received it not as plain text. Please make sure that send your
> patch with git send-email.

The irony is I had to fight Gmail over your multipart HTML+plain
email. Yay email clients! ;)

> Am 15.11.18 um 14:18 schrieb James Hughes:
> > A previous change (5bfdc1097654) moved away from VLA's
>
> Please use the commit format mentioned in the link above.

And actually, this SHA isn't the upstream SHA. This should be:

a1547e0bca51 ("firmware: raspberrypi: Remove VLA usage")

> > to a fixed maximum size for mailbox data.
> > However, some mailbox calls use larger data buffers
> > than the maximum allowed in that change. This fix therefor

Which ones did this? In the initial change I couldn't find anything
that exceeded 32 bytes. (I'm just curious if I missed something or if
something new appeared.)

> > [...]
> > + /* Some mailboxes can use over 1k bytes. Rather than checking

Up to Eric, but I think the preferred comment style is:

/*
 * lines go here
 */

Otherwise, this seems fine to me. Thanks for getting it fixed!

-- 
Kees Cook
