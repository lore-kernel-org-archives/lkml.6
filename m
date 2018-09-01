Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10875C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 20:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA96720837
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 20:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9PSUM7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA96720837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeIBA5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 20:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbeIBA5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 20:57:24 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3781220837
        for <linux-kernel@vger.kernel.org>; Sat,  1 Sep 2018 20:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535834654;
        bh=lXu2+nIlMGgCTry89SzOW1qIHafr5mJXKwp0GCD2WUE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=q9PSUM7ymEq2oYmYDv+ps2lVJX1pvkxrWZfDJE0ob2+FnbLjeJAUmZDoSmfHU1cAe
         8NiY/BRq3XxMK+qXW/EzO2UcinPy9hP50PdlPJXPnHAenvjZKQBk5lSA9r1Qo4I7Gh
         Cf64Z1NFSRGy8DW7wO4mE2cMTklPfR8RwiXlg26s=
Received: by mail-wr1-f49.google.com with SMTP id v17-v6so14202418wrr.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 13:44:14 -0700 (PDT)
X-Gm-Message-State: APzg51Bg781PfLXj6pYrBDPTKxZI4rtSHpBVWYzkxWuxnln7HekJmqVt
        SheXkbfNgrrYAE73Yl+MCzTR0287tJZFFeayS7bfQg==
X-Google-Smtp-Source: ANB0VdZg8Q+Mjt/kYkpSCv3YUcPP3eJeoIseqfc2Tw+qPSdjpDZJi8hJC3+PbgyBIchLOCUlzcbQ5f/NAsOYgjYVK6E=
X-Received: by 2002:a5d:4c49:: with SMTP id n9-v6mr15303968wrt.71.1535834652737;
 Sat, 01 Sep 2018 13:44:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:9045:0:0:0:0:0 with HTTP; Sat, 1 Sep 2018 13:43:52 -0700 (PDT)
In-Reply-To: <20180901201452.27828-1-sneves@dei.uc.pt>
References: <20180901201452.27828-1-sneves@dei.uc.pt>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 1 Sep 2018 13:43:52 -0700
X-Gmail-Original-Message-ID: <CALCETrXeeW0RhJws0oLQAHomZ539B00PL=_NtPGOsfd=aw+TTw@mail.gmail.com>
Message-ID: <CALCETrXeeW0RhJws0oLQAHomZ539B00PL=_NtPGOsfd=aw+TTw@mail.gmail.com>
Subject: Re: [PATCH] x86/vdso: fix lsl operand order
To:     Samuel Neves <sneves@dei.uc.pt>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 1, 2018 at 1:14 PM, Samuel Neves <sneves@dei.uc.pt> wrote:
> In the __getcpu function, lsl was using the wrong target
> and destination registers. Luckily, the compiler tends to
> choose %eax for both variables, so it has been working
> so far.
>
> Cc: x86@kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Samuel Neves <sneves@dei.uc.pt>

Acked-by: Andy Lutomirski <luto@kernel.org>
Fixes: a582c540ac1b ("x86/vdso: Use RDPID in preference to LSL when available")

Whoops!  I even wrote a selftest just for the offending commit, but,
of course, the selftest passes :(  I tested this by giving gcc some
gentle encouragement to allocate different registers, and the existing
code is indeed wrong and the fix indeed fixes it.

--Andy
