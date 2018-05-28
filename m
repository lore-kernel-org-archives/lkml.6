Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754070AbeE1Ikb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:40:31 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41360 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753986AbeE1Ik1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:40:27 -0400
X-Google-Smtp-Source: ADUXVKI/5H5s0qY9hWw2DoMZjf9BqMwGB7oy/rxM6DAMmx40fBo60YUkIW4cGiorN8rkKYbp+2HmvdXSuZIqqLB2284=
MIME-Version: 1.0
In-Reply-To: <20180517094658.18707-1-douly.fnst@cn.fujitsu.com>
References: <20180517094658.18707-1-douly.fnst@cn.fujitsu.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 28 May 2018 10:40:26 +0200
X-Google-Sender-Auth: NiOJyOJ7vIJfEMD0WYo0FHgdB4U
Message-ID: <CAJZ5v0hpEf3gxfAtfufGQVyGEWoszMfEciNKiYf0TrUWNXtiuQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] Remove the check of duplicate processors
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 11:46 AM, Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
> There is a bug in CPU hotplug code, I have two simple fix method, but I can't
> ensure which one is better. So sent it out,  seek help.
>
> We found some processors which have the same processor ID but in different
> PXM in ACPI namespace. such as this:
>
> proc_id   |    pxm
> --------------------
> 0       <->     0
> 1       <->     0
> 2       <->     1
> 3       <->     1
> ......
> 89      <->     0
> 89      <->     1
> 89      <->     2
> 89      <->     3
> ......
>
> So we create a mechanism to validate them. make the processor(ID=89)
> as invalid. And once a processor be hotplugged physically, we check its
> processor id.
>
>     Commit 8e089eaa1999 ("acpi: Provide mechanism to validate processors in the ACPI tables")
>     Commit a77d6cd96849 ("acpi/processor: Check for duplicate processor ids at hotplug time")
>
> Recently, I found the check mechanism has a bug, it didn't use the
> acpi_processor_ids_walk() right and always gave us a wrong result.
> First, I fixed it by modifying the value with AE_OK which is the
> standard acpi_status value.
>
>     https://lkml.org/lkml/2018/3/20/273
>
> But, now, I even think this check is useless. my reasons are following:
>
>     1). Based on the practical effect, It works well, and no bug be reported
>     2). Based on the code, the duplicate cases can be dealed with by
>
>        if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id))
>
> That seems more reasonable, let's see the following case:
>
>                           Before the patch,             After the patch
>
> the first processor(ID=89)
> hot-add                        failed                        success
>
> the others processor(ID=89)
> hot-add                        failed                        failed
>
>
> So, What's your idea about it.
>
> Dou Liyang (1):
>   acpi/processor: Remove the check of duplicates processor ids

Can you please resend the patch with the above information in the
changelog of it?

That would make it easier to review and discuss it.

Also I think that we need some sort of a check against duplicate IDs.
