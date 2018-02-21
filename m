Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeBUT2o (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:28:44 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:37701 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751376AbeBUT2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:28:43 -0500
X-Google-Smtp-Source: AH8x224YkfBPziBMG8GPY/KvYGrzRJumU/W4Kc2x0yMnX1Z5kxvH1Q+K9IRTvKCWBgFzcBXbAh0O5XGjwCKiJMMlIyM=
MIME-Version: 1.0
In-Reply-To: <20180221192339.GA28548@avx2>
References: <20180221192339.GA28548@avx2>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Feb 2018 21:28:41 +0200
Message-ID: <CAHp75VdaxkMn2UxURSB4fWep=iv4CRAkmEtdKBp1HKyxtW2tTg@mail.gmail.com>
Subject: Re: [PATCH 1/5] proc: make /proc/*/cmdline go through LSM
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 9:23 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> /proc/*/cmdline is not different from /proc/*/environ as it accesses
> target task's memory (and can access the very same region of memory)
> but it doesn't go through ptrace_may_access() and thus doesn't go through LSM.

> +static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
> +{
> +       struct mm_struct *mm = proc_mem_open(inode, mode);
> +
> +       if (IS_ERR(mm))
> +               return PTR_ERR(mm);

So, is it possible to have it NULL?..

> +
> +       file->private_data = mm;
> +       return 0;
> +}

> +static int mem_release(struct inode *inode, struct file *file)
> +{
> +       struct mm_struct *mm = file->private_data;

> +       if (mm)

...or I don't get this check.

> +               mmdrop(mm);
> +       return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko
