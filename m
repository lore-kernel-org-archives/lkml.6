Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ADCC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2189E219DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2189E219DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeHHOqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:46:25 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:41461 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHHOqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:46:25 -0400
Received: by mail-lj1-f173.google.com with SMTP id y17-v6so1559431ljy.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 05:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q9M7ola2pLAnqNhJRmdItVbelmqWBSEbB8FzZFzji7I=;
        b=mP178YBFhPn3L4SjyPeCLeOZMGmj1HPLPKGkKQ6VhMmOeQr4jUnA3tO6UQoRzl107Q
         kBZoWtFN39w86LQdIqDudSZrLbj57601qN2PBQNK6XIHHTEEFTlQpF5r+Xy4R7Kp8X9D
         Fcz3Fg7iWYCmI/N3YIbM+Az2Ek4K87OpYQOGvw+SlnG6rCS1qUwQKeowVzU/x+oWb+v+
         TKZnOr6Ar8S8WGwRV4wW03wmFkpKbyqWwHIUE7mdY0eMwEV9eVjBLR4wojl5L7OawEvN
         UvLnhFL/FI/VTS8bhw76cU0WJQCPNwPXbT5YB5bHIXbyFal4rBXYb58ovWutPIXxpOOE
         o3iA==
X-Gm-Message-State: AOUpUlHxZkDgBwU3QMm5p5v2ytUjgqEf3tMfbbdVeAsUNDa+bVLXweWZ
        ZijVMvVzXP41AW+fvuC9xO7Lv6B0g1Ypvz6/BlY=
X-Google-Smtp-Source: AA+uWPzESYKSV+/MSqMitDgkkknzIr1hhfXk9Ri8H8dQgf5t+LBXhr977j5EsY25i5VcHD3BYzc+SjVgC5aRJmI4UVg=
X-Received: by 2002:a2e:80d3:: with SMTP id r19-v6mr1892747ljg.85.1533731216278;
 Wed, 08 Aug 2018 05:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <1523884165-17044-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdXxV1nWGWAAXSkBWm-9VWHVc57nhFLfQ4BijbKGh-vaUQ@mail.gmail.com>
 <20180806155440.9dcb271a3b075bd964aec60f@linux-foundation.org> <87lg9hb12y.fsf@concordia.ellerman.id.au>
In-Reply-To: <87lg9hb12y.fsf@concordia.ellerman.id.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Aug 2018 14:26:43 +0200
Message-ID: <CAMuHMdW-aaiPVp4wLJDBzE84C1PdS20y688ePWqafnSU=UOSYQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.17-rc1
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 12:32 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Also I haven't been seeing this in my local builds because I have:
>
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y
>
> So I guess we need to work out why that's interfering with section
> mismatch analysis.

One other common case of missing section mismatch warnings is when some
versions of the compiler inline the called function, while other versions don't.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
