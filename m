Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D07EC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6410420866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6410420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbeIKBJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:09:47 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39890 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbeIKBJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:09:46 -0400
Received: by mail-oi0-f65.google.com with SMTP id c190-v6so42696782oig.6;
        Mon, 10 Sep 2018 13:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUDsvYXMPZP55hZvGk2Z3Xs77eWlvFEv7PUHABj7vec=;
        b=One/HRRPONg4CQ7YkAf5oqakkbI1gV2TMVPwr1QRfOZhZ/AFG5RrMIFSZgKZi2YIYg
         Fj6YO/hcD5zY//0NzSl6uc7DWdAUhJoYsUHmeYK65H4la5blN2oHiGon71bffglKDY0U
         livLVxbFOC/PEMI8YsqG5h1Nebyt5RIvcfmNyGE6UPtup7SFROW/ItmHiv+VAFu/XwBw
         DU85vCaLDEfq8rzgx02wbTC/jGCLAef0cwvTp/HkFNfJyvugvE6fisR0noBpDsuNnqLk
         878c8+NENbWjh/BBV1cRdvtAkSLKslgGcKUYnD5pZEF3EOqX7Hol5HaGVlEi2Bp0fLOq
         4yfQ==
X-Gm-Message-State: APzg51Dz/Hy3d+LY0v1prfbsKSanachdkUc41cQfvl3Ymr+z6JZp9vEB
        BxPe0hNo8SK+DSKtYCJIFNkRX8/yUVxU5GPv2aro1g==
X-Google-Smtp-Source: ANB0VdYqLyqXQTZknwftv5K69Q2r2uuc+8XR+0vurrGJI4kF6bBfhS4pmxlIPz5QAJAV0isYek3oGbFVRyNgIChuNts=
X-Received: by 2002:aca:ef0a:: with SMTP id n10-v6mr24389588oih.326.1536610440967;
 Mon, 10 Sep 2018 13:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180910124015.18073-1-fanc.fnst@cn.fujitsu.com> <20180910124015.18073-2-fanc.fnst@cn.fujitsu.com>
In-Reply-To: <20180910124015.18073-2-fanc.fnst@cn.fujitsu.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 Sep 2018 22:13:49 +0200
Message-ID: <CAJZ5v0gep7Q4w+yOvgfOUG8rU12tYEw3qtDKCoZN2=b8-=-fjw@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] x86/boot: Add acpitb.c to parse acpi tables
To:     fanc.fnst@cn.fujitsu.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, bhe@redhat.com,
        indou.takao@jp.fujitsu.com, Cao jin <caoj.fnst@cn.fujitsu.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 2:41 PM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
> Imitate the ACPI code of parsing ACPI tables to dig and read ACPI
> tables.

Why?

> Since some operations are not needed here,

What operations?

> functions are simplified. Functions will be used to dig SRAT tables to get
> information of memory, so that KASLR can the memory in immovable node.

So do you want to parse SRAT only or do something in addition to that?

> And also, these functions won't influence the initialization of
> ACPI after start_kernel().
