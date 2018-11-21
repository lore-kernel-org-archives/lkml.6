Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3458CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F5A21527
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g00m7Ibo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F5A21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732172AbeKVGIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:08:14 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:43252 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbeKVGIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:08:14 -0500
Received: by mail-lf1-f52.google.com with SMTP id u18so4835417lff.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y8wDBrAzpdMnVkrvJqqGZZbsgJ4R6rzI7uBBGHPMSaE=;
        b=g00m7IbobXqC6aN/++Dm/5WFJ7hG5iWtI3WpySCM2zgPTrGQyh9grAi78vpL6tBoF2
         zbDgKnX5dE85Qhs9UaKzkbint+qe411ij0ohxGO58AuAEehiep9p2U3nm8aJk00eziGx
         sXEyM4r95+aDkzdmjiTpUImguJRC1fMBphjMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y8wDBrAzpdMnVkrvJqqGZZbsgJ4R6rzI7uBBGHPMSaE=;
        b=acPF0PqSpYiExbfZ2LJHslJ5fktSGeuz9aCu6YiP2LVVmqF2O6Sm4ssjROmEGf5YdN
         CYx/ufybQREd8PMnQ6a68fJ6/xtPe7/wQT68h0h1abV1uiQxk0P83hykr/2kZVDkAdOW
         S5coYRkdCADeNVZBOKulbTuxYpmt1lBaDmfoJoI0CadWGsIjs8e6fYHHOYsWGdy90rBl
         TBpx2fYiHV8/TSG4UO+WLOTBvMbPGFCITtUj2hHo5U21ZdNZm2vBdcR/iqtnnBy7DLfT
         ivFXsPtpZ7agFwyvLNl2e6e3QPHbRx3/nOjE/lC3AteRw1LhH/WgKYblzXtIRaHWy/CL
         YD3g==
X-Gm-Message-State: AGRZ1gJ2tzsUlEjM1mJRS9MyKv+MVOq5zCcdvAiJzzJPa+xJ0mdBnqc8
        gGwl2t1oK4qgZ0kaSDjJGWhBdm101H/rlg==
X-Google-Smtp-Source: AJdET5cMIbBFVTAMZNGqz8v7Xol5uP3RmxKkFDZK1oiW4eqtFP0nhfOpg23PGgvsnvYsR5UW4Tg1eQ==
X-Received: by 2002:a19:3809:: with SMTP id f9mr4406630lfa.148.1542828755367;
        Wed, 21 Nov 2018 11:32:35 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id b128sm6877781lfe.91.2018.11.21.11.32.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 11:32:34 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id u6-v6so5880532ljd.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:32:33 -0800 (PST)
X-Received: by 2002:a2e:994:: with SMTP id 142-v6mr4350675ljj.120.1542828753232;
 Wed, 21 Nov 2018 11:32:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542757030.git.tim.c.chen@linux.intel.com>
 <6652faa67f8c4e90c737f9fd9c7e0e2d3cd51cca.1542757030.git.tim.c.chen@linux.intel.com>
 <CAHk-=wiRh4QVAHV086U02tDCJz9g8MYHegEHbxCZ6-Ap4ow5Lw@mail.gmail.com> <aeeab5d3-c2cf-e6a5-9da3-d14d30e79011@linux.intel.com>
In-Reply-To: <aeeab5d3-c2cf-e6a5-9da3-d14d30e79011@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Nov 2018 11:32:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wib4jeM1HFMopLGRaVFSJY-a1Wip3rY-q5ko+-BwvX7Zw@mail.gmail.com>
Message-ID: <CAHk-=wib4jeM1HFMopLGRaVFSJY-a1Wip3rY-q5ko+-BwvX7Zw@mail.gmail.com>
Subject: Re: [Patch v6 14/16] x86/speculation: Use STIBP to restrict
 speculation on non-dumpable task
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, thomas.lendacky@amd.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>, dave.hansen@intel.com,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        "Van De Ven, Arjan" <arjan@linux.intel.com>, jcm@redhat.com,
        longman9394@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        david.c.stewart@intel.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 9:41 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> When STIBP is on, it will prevent not only untrusted code from attacking,
> but also trusted code from getting attacked.  So non-dumpable task running
> with STIBP will protect itself from attacks from code running on sibling CPU.

I understand.

You didn't read my email about why "dumpable" is not sensible.

             Linus
