Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF19C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF452089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF452089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeJIFk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 01:40:56 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35587 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbeJIFkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 01:40:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id j9-v6so21527328otl.2;
        Mon, 08 Oct 2018 15:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PBj6laRUBtHS5WTwGPQoOvXjQzrlCfhVTV+O4h6wDsA=;
        b=iS03SGfnwOasaEIcaTGDmn3Fo5Qo3CvouViu6C6GXLJm5KYzxKwqCAZE3Kbop0q12K
         NkSH0ICrwQWlarpLo0RZcFe/UW5XZSJXRJ8RMl6cxiMiIK3jr4LRGLzwjGmwXIIG3/zU
         unF8mvJz57oZXnRhrKqm6Q5VLFrPdebtZQCYKhIgIJ4jv8nAMqiZHGs7Xq5t9NsTmguE
         Kdi/g2ZSF6RC9jfnzOY0pUClFXmmapUKIJdMr3Ze1TRWbnJ+BxkRKb/mmEr92sN7RquM
         kx3Vey5EYbNo/HoKRvF5PWI/zC0SZ6jhMJFhau1T9vwtDn9fUQ+bhtlZO+Qq/HG0jWNX
         c4Rg==
X-Gm-Message-State: ABuFfojNX0T0lfnYA6uGcE7Y4zbjbSDpAXauUSmD3o05AglFVMSmDptB
        p65W1blglGFX/pbHbvaukVIOYdNbJoyxD4h6ZE8=
X-Google-Smtp-Source: ACcGV63T9WG4KY+bc8+0xOT4183y9RIlzYSVsWYKi97gtQY1i9JWHeqL5iaeKCGffAhB2YTe1BFQ5fPMANkI+PCrTMw=
X-Received: by 2002:a9d:4590:: with SMTP id x16mr10124584ote.258.1539037620215;
 Mon, 08 Oct 2018 15:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <000301d45ecb$4f002a90$ed007fb0$@net> <003801d45f54$3d9b0c50$b8d124f0$@net>
In-Reply-To: <003801d45f54$3d9b0c50$b8d124f0$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Oct 2018 00:26:48 +0200
Message-ID: <CAJZ5v0h4sVoen++nF1cYvqQeY3qN0B1aP42e8A4SZwxzBV3NVA@mail.gmail.com>
Subject: Re: [PATCH 0/6] cpuidle: menu: Fixes, optimizations and cleanups
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 12:14 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2018.10.08 00:51 Rafael J. Wysocki wrote:
> > On Mon, Oct 8, 2018 at 8:02 AM Doug Smythies <dsmythies@telus.net> wrote:
> >>
> >> On 2018.10.03 23:56 Rafael J. Wysocki wrote:
> >>> On Tue, Oct 2, 2018 at 11:51 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

[cut]

> >> Test 2: pipe test 2 CPUs, one core. CPU test:
> >>
> >> The average loop times graph is here:
> >> http://fast.smythies.com/linux-pm/k419/k419-rjw-pipe-1core.png
> >>
> >> The power and idle statistics graphs are here:
> >> http://fast.smythies.com/linux-pm/k419/k419-rjw-pipe-1core.htm
> >>
> >> Conclusions:
> >>
> >> Better performance at the cost of more power with
> >> the patch set, but late August had both better performance
> >> and less power.
> >>
> >> Overall idle entries and exits are about the same, but way
> >> way more idle state 0 entries and exits with the patch set.
> >
> >Same as above (and expected too).
>
> I Disagree. The significant transfer of idle entries from
> idle state 1 with kernel 4.19-rc6 to idle state 0 with the
> additional 8 patch set is virtually entirely due to this patch:
>
> "[PATCH 2/6] cpuidle: menu: Compute first_idx when latency_req is known"

OK

> As far as I can determine from all of this data, in particular the
> histogram data below, it seems to me that it now is selecting
> idle state 0 whereas before it was selecting idle state 1
> is the correct decision for those very short duration idle states
> (well, for my processor (older i7-2600K) at least).

At least, that's a matter of consistency IMO.

State 1 should not be selected if the final latency limit is below its
exit latency and that's what happens in that situation.

> Note: I did test my above assertion with kernels compiled with only
> the first 2 and then 3 of the 8 patch set.

I see.

Thanks,
Rafael
