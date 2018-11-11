Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70792C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB0C2148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEwCP08/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB0C2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeKKXel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 18:34:41 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46507 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeKKXel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 18:34:41 -0500
Received: by mail-qk1-f193.google.com with SMTP id q1so9244462qkf.13;
        Sun, 11 Nov 2018 05:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=74m9KJK6j44RUE8YyIAqbjJD1bEM3SxJxzuzyOkCbOA=;
        b=HEwCP08/xzOWqBjvDUkwaxaiay5ZTJq2fmV6csv0zKD9RddjmblKE+3XKcKCpuYHSc
         1sHVQ35kYhJFPhNtA3gK1GvfpRD2poKWrVYG9Lgk5KlPs9nCc7qP+xSTQeKU+aLqf3Sj
         xQ2YKpf46CSNEnMw40twLRxAsJR8UxGYVBSqR/aQ392Pm72il8JsXiBs83mXE8sZ/zMm
         DLAECZXNAHQJsOOIO9m3wH9lHaSA+gVVA8gVL1cDkKxaHkk7ZT8uSWUrGbbzPjU1/lLO
         dSyibk9V0F4zocXPRepJOBqP9U+XVT6fyKcFoMsVxheFgSB97U4ymW7ALJAVzNBokvHl
         rZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=74m9KJK6j44RUE8YyIAqbjJD1bEM3SxJxzuzyOkCbOA=;
        b=O2IHUIvOydB40JlhosNEbx7rsfWSpI8q0MCp71U/pbBPTK7cIQakzighg4eOMGDVap
         OVethmI2u5D3Zy6zRUOkUgyF0uEoy0+cDjd7XYZkAvj6a+S+7BqoIuGzmmChcGM24oRa
         ty5GolJ5IpUR2r15LQHvQ+JO1nK8bOJhihsBYB5cmJSZIKQmajZPjE/NnpkXMUDZZYfH
         PQmbETyKza0mER0dss7eYjoYkyCwXND82W64RVK+k64HSHZdvu8x/3kftpRJqPrdn0V8
         MVdbg5xxktGnuG+9j2okW6/ZSfmbmp7L4/0kfxLhNkzWU8i04GUqrY70VwGBdW6ejgRZ
         lu0w==
X-Gm-Message-State: AGRZ1gIUeHiam1KjqvMA8WXoeRmSQI72a0pXHWtzQ5vWbMxX2MSWPCsa
        8LMLKkt0qW4ao5YhpsZIng==
X-Google-Smtp-Source: AJdET5dar/SNivGtFSAIhxmzVeHjmUjetjobBacshblzzj6VXckAGBCvXrE/CR5JUDGDzsDKZs77ig==
X-Received: by 2002:ac8:7598:: with SMTP id s24mr15907680qtq.6.1541943962671;
        Sun, 11 Nov 2018 05:46:02 -0800 (PST)
Received: from gabell ([2601:18f:600:d880:e05a:2ef5:9c12:1533])
        by smtp.gmail.com with ESMTPSA id y46-v6sm9449077qty.42.2018.11.11.05.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 05:46:02 -0800 (PST)
Date:   Sun, 11 Nov 2018 08:45:57 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        mingo@redhat.com, keescook@chromium.org, rjw@rjwysocki.net,
        lenb@kernel.org, ard.biesheuvel@linaro.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181111134556.qxv2v4g7dl5irzo7@gabell>
References: <20181016195902.GK5212@zn.tnic>
 <20181022154204.kagmdb55jtoez4ca@gabell>
 <20181025103345.GF14020@nazgul.tnic>
 <20181025134050.ggiir77ehntikbwg@gabell>
 <20181106184519.GA16391@zn.tnic>
 <20181106193636.svyjwuwrlgnpuyyf@gabell>
 <20181106204511.GO13712@zn.tnic>
 <20181106222133.lb7674yzszivzihd@gabell>
 <20181108105129.GA7543@zn.tnic>
 <20181110105422.GA20023@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110105422.GA20023@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 11:54:22AM +0100, Borislav Petkov wrote:
> On Thu, Nov 08, 2018 at 11:51:29AM +0100, Borislav Petkov wrote:
> > A global definition which doesn't need allocation?
> > 
> > Maybe hpa would have another, better idea...
> 
> ...and he has: just put that address in a new field in struct
> boot_params by converting one of the padding arrays there.
> 
> Don't forget to document it in Documentation/x86/zero-page.txt
> 
> This way you don't need any of the allocation fun or to use setup_data
> at all.

Thanks!
I have the prototype patch to use boot_params [1].
I will try to brush up it.

[1] https://lore.kernel.org/lkml/20181016151353.punyk7exekut2543@gabell

Thanks,
Masa
