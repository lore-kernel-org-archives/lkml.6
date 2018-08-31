Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB000C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B8120837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GA3/uWrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B8120837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeHaFeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:34:21 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36625 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeHaFeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:34:21 -0400
Received: by mail-it0-f68.google.com with SMTP id u13-v6so5261168iti.1;
        Thu, 30 Aug 2018 18:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEDpd09z+D1w9x6ey5KLDa45+xyXCiFT5LtuJOT76zY=;
        b=GA3/uWrIIFVUkCgPH8VHmklSGHbqEDA/XYpSBKIazT43rnriQi8DQDZWjsX1nHdTfi
         jQE8Rt9G5zrU98mSc7tDG5X0A/CIfecJxOV3isE8h/4XMoCq5uiOPKwa5dUbveJTdpuE
         kN0fwoXgCD4+zlyxqHy7d0SWWX22LcDWRlxqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEDpd09z+D1w9x6ey5KLDa45+xyXCiFT5LtuJOT76zY=;
        b=Un8tkPDNF1kVU6MRtLoZ2dJklDQfwK7WXtZuQSwilABT7kNnBrhu2lOcGXaerbmjFP
         oPM5YqFeXoaqSbNL0oK1zzM8Ai8D5NLl5RCAzEW0EOx5M4X4pKfberi9Rms6JVL+ZDSX
         RPb/CmkYg/9LUp+OTYqVBP2AW7VVMPcR/Rw+MaK2/G7Hi6/drVimNYg2GSPTL9yZ2nAy
         QD+PPoUS5w5RsF1KZU6TZwV0rCsAzi75kGlI92QFMMvo4qAEcmlr1R9JuUUx0PXjEHkr
         8+4rzfi/XNLxNcz0ZeNSJKf6xwxirm/T2GJJhL8cgx2CK2wSV+yvb4lZZJDcassCLt9G
         KTwg==
X-Gm-Message-State: APzg51BkN+YHZ7KCRjsbM32NO+LLtbFz+KPW+MFQwsGKT0hZKPAtXncX
        MS9NgCyZoj/iAlpbozO4LJ4LoUF30Maj0DVBUOs=
X-Google-Smtp-Source: ANB0VdZo1aq65uf5Hk0yfDiqshuOJPB41SyIM79FgxXKMurA60vNIsSIl4qAYN0Yk5fHsBTrFY19A1PR6G2YjtBXFRk=
X-Received: by 2002:a24:8309:: with SMTP id d9-v6mr3901530ite.123.1535678962883;
 Thu, 30 Aug 2018 18:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180830214517.29372-1-tony.luck@intel.com>
In-Reply-To: <20180830214517.29372-1-tony.luck@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Aug 2018 18:29:11 -0700
Message-ID: <CA+55aFxVQqnFVQaCYHbnWnt3kBfVkLWgNvKFkf6qgDWCSDNpEg@mail.gmail.com>
Subject: Re: [PATCH] x86/mce: Fix set_mce_nospec() to avoid #GP fault
To:     Tony Luck <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 2:45 PM Tony Luck <tony.luck@intel.com> wrote:
>
> Fix is to move one step at a time. First mark the page not present
> (using the decoy address). Then it is safe to use the actual address
> of the 1:1 mapping to mark it "uc", and finally as present.

Can't we do it in one step, but make sure that he clflush gets the real address?

              Linus
