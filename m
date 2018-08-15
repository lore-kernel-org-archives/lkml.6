Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2544BC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9882148E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Pyvr8M8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9882148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbeHOTjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:39:10 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36500 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729878AbeHOTjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:39:10 -0400
Received: by mail-it0-f66.google.com with SMTP id p81-v6so2780715itp.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 09:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=URRwdKsWPN4QB1pyMsvk8HDM1uwozQYxOyukEpBYvlc=;
        b=Pyvr8M8cMQ7MSv+rhQfxAOHMTVsYosVj1nhywDlw27DrSgVc3lBpTHs+QNx4KwTSj5
         DiLxkKCsGrTdyIJn/Tt4v2PA+vpTV/9LbMoVgrH/BtW07KCv68RrNA6uoXRwtF6hIZ78
         8TjAUhHVuDY11txmZr2IQWYZUx7Zqt+I3b7d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=URRwdKsWPN4QB1pyMsvk8HDM1uwozQYxOyukEpBYvlc=;
        b=M8WJm8YGGK0yzZezHp+pgnwDhfCP1iOTZO4HY4foKE9ZAziDoq35WlCh3QrHTDzeWr
         8CwatNiSDw/17tzq/K08sInA5uArwFHORQc+HRGHbQmXF7VdDlsR4UDFBoK19o77FouE
         pbFaoJrbk+u2/lS4FG3cNRJiukzLsUxAziIpZTfnxw8W4uV/wWy9ChpHHTtAtq2/AFdl
         +tBUUE8oa/HomSQsljmejO5f+p46d2uWYFhVqVrzuwC4VAQm7EGeX9oOY20hbqv7ptCd
         ifLSGuG+DOEOv1lnRJtSnGbp3JX3Gh0L0wpGAxxv6eewGU+5M2PJ+qo7BgZGwCMAWUGh
         u73Q==
X-Gm-Message-State: AOUpUlFj0Q26w0bp6KRDcikb0X5cvaVkDn3kuVNhlI+QUpomXj6klJDv
        PkI538okyPdDURv6sXGoF3PG/p1fm/QoOupXnbw=
X-Google-Smtp-Source: AA+uWPyxVFs5DIoQUj2hQhBfMh2qRa8olmGlzcssTa5UNXUCeTx+M0r9f4gop6gLrtwxUPZWIN/hW1Kv9F6uQATMd6A=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr18280822itb.16.1534351575659;
 Wed, 15 Aug 2018 09:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <1534347513-10120-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1534347513-10120-1-git-send-email-linux@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 09:46:04 -0700
Message-ID: <CA+55aFyJEffCB7bg=Bo=r_FjT8dtr30iArwZEj+ORfggnppjhA@mail.gmail.com>
Subject: Re: [PATCH RESEND] x86/l1tf: Fix build error seen if CONFIG_KVM_INTEL
 is disabled
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Meelis Roos <mroos@linux.ee>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 8:38 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Sorry for the early resend; widening the audience.

Yeah, I don't seem to see the first one, and the x86 people are all on vacation.

Applied.

            Linus
