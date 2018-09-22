Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E1CC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4252120685
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kJNYbW+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4252120685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbeIVVjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 17:39:17 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34248 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeIVVjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 17:39:17 -0400
Received: by mail-yw1-f67.google.com with SMTP id m129-v6so600143ywc.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 08:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a1TyfYG891DbMPk3sORoqm7Jiir1Rgvva9W1uLmUnAc=;
        b=kJNYbW+aDyg030xMPbLhrc6xL9bVKM0d3WKStUkL3Y0zI6dXkJItvHyGxoj6RNfpm1
         O7Dnq5tcZfJsPgPrTdCviM84vMH7SvOUfz2txm31LaQ9+LwVgSo6GSWdaOMzpKOLHhpx
         CNk+s0hER2lponsiPwh46PwadfJRXLPaOPmQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a1TyfYG891DbMPk3sORoqm7Jiir1Rgvva9W1uLmUnAc=;
        b=Rgsqb+k0WstIiTlflD6h+EcX1OE5EnIK9Glpsx7vdjlb9FFKZxsH/qSWSbZ8YUmXeY
         TLRZsx0MgKUBwHeYg+4vljhSSI20G4tXjlp10Pm7y1/1ll0fB+XXINwPSvxi1+G3GYTV
         X7nIYn83JmNyBcd9zLzKATkBT1ZctMvsXMqnfYhAgCcX3y5pVPbSEauAXNS3gqWHaRPc
         MHZfUUfRKuR26ZmN19ZuA/LAp2rKLKE5BaJpZ+NVu4ArDQLz9G+ioVugRCxzexx3lUFX
         SXVSlEyrxigao5eF/DF5Hf3QS/DBHEIIgQJuCcWmFk6ogM9TnApGNIW6sy5cA81ARpW7
         kKmQ==
X-Gm-Message-State: APzg51AZYicwGcE7I85DMHG4dTfPVBG2r/gcB8B+NH4YHocD5WvFzqMR
        ovNgsajzswKqhDfV6F/3iBQnzKAmNPo=
X-Google-Smtp-Source: ANB0VdYYgZVY0AKdmQmtsDC6KwzRVMVoJjtTSI9KDd7garydJy19yNwgtyeu1S2TDfw+FF6a804nCA==
X-Received: by 2002:a81:490c:: with SMTP id w12-v6mr1167464ywa.86.1537631116127;
        Sat, 22 Sep 2018 08:45:16 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id t64-v6sm2948508ywe.21.2018.09.22.08.45.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 08:45:13 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id c4-v6so6677239ybl.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 08:45:13 -0700 (PDT)
X-Received: by 2002:a25:3617:: with SMTP id d23-v6mr1258990yba.141.1537631112771;
 Sat, 22 Sep 2018 08:45:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Sat, 22 Sep 2018 08:45:12
 -0700 (PDT)
In-Reply-To: <20180913104629.5179-2-fanc.fnst@cn.fujitsu.com>
References: <20180913104629.5179-1-fanc.fnst@cn.fujitsu.com> <20180913104629.5179-2-fanc.fnst@cn.fujitsu.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 22 Sep 2018 08:45:12 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+LxEpoKAkEo8GQa-f729_Ebavgtnv+DA9bxf9XEz2QPQ@mail.gmail.com>
Message-ID: <CAGXu5j+LxEpoKAkEo8GQa-f729_Ebavgtnv+DA9bxf9XEz2QPQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] x86/boot: Add acpitb.c to parse acpi tables
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 3:46 AM, Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
> There is a bug that kaslr may randomly chooses some positions
> which are located in movable memory regions. This will break memory
> hotplug feature and make the movable memory chosen by KASLR can't be
> removed. So dig SRAT table from ACPI tables to get memory information.
>
> Imitate the ACPI code of parsing ACPI tables to dig and read ACPI
> tables. Since some operations are not needed here, functions are
> simplified. Functions will be used to dig only SRAT tables to get
> information of memory, so that KASLR can the memory in immovable node.
>
> And also, these functions won't influence the initialization of
> ACPI after start_kernel().
>
> Since use physical address directely, so acpi_os_map_memory()
> and acpi_os_unmap_memory() are not needed.
>
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/Makefile |   4 +
>  arch/x86/boot/compressed/acpitb.c | 401 ++++++++++++++++++++++++++++++

Does this logic live anywhere else in the kernel already? (i.e. could
other code be reused?)

-Kees

-- 
Kees Cook
Pixel Security
