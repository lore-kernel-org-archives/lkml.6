Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FCAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4D920823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfARLnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:43:32 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36437 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfARLnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:43:32 -0500
Received: by mail-io1-f67.google.com with SMTP id m19so10457895ioh.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 03:43:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQMzALn4iJTKfRphe8KZrjvPoA5PieogVTEyw3GtY04=;
        b=eFjUNbRXLNuYb1hsRRmGbp/pou+Rf1bqpm0jJRHCpcOZ0zwYucmULC5Xfto/KVIy6u
         DHQ2Llwkj3BRnq+RVMgQLLbvTGzHAg5ndyGcEIbOQS6Te+65z6OnRJC60OSc/NZ0C/+n
         usm7EhYxR+KfnSczYB9pXt2a7kjbz/u7pTjjkeKWr/5Ysd5chaZcZeQqVK4bYG94tzAs
         P9ifhnA1ZVCcqqycCWj+kHCnBVNnf2KbYbKv3c07zAnMHmkMYEBdvFdwlJXZumDD3O8q
         5RMSMa4r9w2CDpGCqj6tPoPymVTzzWbpgMBl3m41gpz2IcjXr+08HrtmLlHAsKFdlnnV
         bPhA==
X-Gm-Message-State: AJcUukfyDTbyfZLKdM84vBh72+IZ+AVX4S70ABCqTnHirPYP3RYdnmav
        /a+19/LFD0fYNIziHgBibVLV2d6oX+yLTiTTS9tYKg==
X-Google-Smtp-Source: ALg8bN6hkXD9ktoPhcV8A4KD/oXim0fCthUk+A125dQ+w8jPhq/eIVjPTjN968A9T/H8WXGHTtJJCiCeiLlkpxK48Jo=
X-Received: by 2002:a6b:b502:: with SMTP id e2mr9250629iof.43.1547811811315;
 Fri, 18 Jan 2019 03:43:31 -0800 (PST)
MIME-Version: 1.0
References: <20190118111310.29589-1-kasong@redhat.com> <20190118111310.29589-3-kasong@redhat.com>
 <20190118112628.GC622@zn.tnic>
In-Reply-To: <20190118112628.GC622@zn.tnic>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 18 Jan 2019 19:43:20 +0800
Message-ID: <CACPcB9dTm_2UCRord01oW+mmoPYY7dFTHj7qFrMxOnhPx3Ov3w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] acpi: store acpi_rsdp address for later kexec usage
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Robert Moore <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 7:26 PM Borislav Petkov <bp@alien8.de> wrote:

> No, this is getting completely nuts: there's a bunch of functions which
> all end up returning boot_params's field except pvh_get_root_pointer().
>
> And now you're adding a late variant. And the cmdline paramater
> acpi_rsdp is in a CONFIG_KEXEC wrapper, and and...
>
> Wait until Chao Fan's stuff is applied, then do your changes ontop
> an drop all that ifdeffery. We will make this RDSP thing enabled
> unconditionally so that there's no need for ifdeffery and function
> wrappers.
>
> Also, after Chao's stuff, you won't need to call
> acpi_os_get_root_pointer() because the early code would've done that.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.

Good suggestion, will wait for Chao's update then.


--
Best Regards,
Kairui Song
