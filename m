Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA97BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E35208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EgLAdCVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E35208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeHXXwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:52:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40807 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbeHXXwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:52:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19-v6so7796084ljc.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 13:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aj6cFGtYyNmgFRF0CsuaFHXt7/KEqSM0JH9fyvPRAAs=;
        b=EgLAdCVS4gIOcZUeNbd8Rics2MU7nJ91dBtxIW6IXJoHuwFlJQG0zsb7u/RDc1Qp78
         Ferm0XTe2qHhhbhfTPU2lOCg5x42XJaEReVSnoArMhiBlUHevtQyEEbGajCqqZBPWaPV
         UZePYacMr3Cs3cDXvnOLDeK/bOR3PzvKYgFus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aj6cFGtYyNmgFRF0CsuaFHXt7/KEqSM0JH9fyvPRAAs=;
        b=nRp789ybPFmFffReiz+Fr336ES2fPK/w7MIVyDJ2L/jVvx0v3uxq7rrj6uiT22gb5G
         HNZpQvMcqaD0w+WRJVA7M8CM/h4IC3W8rYS1XB6pt0f0FpbqGiHL3MhAsNx89Udj+MIz
         3/ZeWaetBH4a0o0m3s0sAp8jjJRwv3xK43p4MvfqfAywdkvv7z3nbjBNRwWI2WFqRC9X
         prWr8xNVhlJl67m9iokRi6fjrn5w7/IDfBjpVv4Ft7U3suf0wySKFwd5mLpi4qkdyxle
         LgYdFrsVDZ2opSwdkBbPQ/8T9fcS5XdEeiKMgUoWoB9uufRPv5AAEHQnG6LbzPDeKKHj
         xIyQ==
X-Gm-Message-State: APzg51AT4kKnU4w22hUQKbbxx7vUpe+b8ZVQhMymCHHCSDtUjCEXhRlu
        vL86UAE+7KvlUyx9ZwxQ60nTd+IMW4QQY7Na5fTM4w==
X-Google-Smtp-Source: ANB0VdY3TUtQLbHXLlSQlppXx4vZ3+3nKyajxkKbTwKH9BA8eYz5rV/V7xkNO80fRARV6UXSJwIuiFAmymbx473N5eA=
X-Received: by 2002:a2e:6301:: with SMTP id x1-v6mr2396966ljb.9.1535141791333;
 Fri, 24 Aug 2018 13:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20171215092305.994559179@linuxfoundation.org> <20171215092311.347628971@linuxfoundation.org>
 <CAL1RGDVgShymmT+TJ3mAHEL7n+qoisk6mQ=Tji_T=0d_QA=VKw@mail.gmail.com>
 <1535129126.2902.36.camel@codethink.co.uk> <CAL1RGDW1Lo+F5D479Jsi-AFsmjVpdDre_qOFSCwWubG6U=bxeQ@mail.gmail.com>
 <20180824191749.GA15489@kroah.com> <CAL1RGDXUx-frpWuuYyc-VrAEoOU2+irGQPRWvoBzO2ZxEPGrww@mail.gmail.com>
 <20180824201025.GB18715@roeck-us.net>
In-Reply-To: <20180824201025.GB18715@roeck-us.net>
From:   Roland Dreier <roland@purestorage.com>
Date:   Fri, 24 Aug 2018 13:16:18 -0700
Message-ID: <CAL1RGDXa2POjmrr8UK-2oYyQtxYxiOs5t9BrpGUHRXqkDjMW5w@mail.gmail.com>
Subject: Re: [PATCH 4.4 103/105] Revert "x86/mm/pat: Ensure cpa->pfn only
 contains page frame numbers"
To:     linux@roeck-us.net
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        matt@codeblueprint.co.uk, bp@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, luto@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, bp@alien8.de,
        brgerst@gmail.com, davej@codemonkey.org.uk, dvlasenk@redhat.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        sai.praneeth.prakhya@intel.com, sds@tycho.nsa.gov,
        Thomas Gleixner <tglx@linutronix.de>, toshi.kani@hp.com,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Yazen.Ghannam@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sounds great. I'll hold off with sending my RFT series and wait for your
> test results. I think we'll also need d367cef0a7f0c6 ("x86/mm/pat: Fix
> boot crash when 1GB pages are not supported by the CPU").

Sure, makes sense - I don't have any EFI systems with CPUs old enough
not to support 1G pages but that looks reasonable.  I'll pull that
into my tree as well.

 - R.
