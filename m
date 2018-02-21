Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbeBUTjm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:39:42 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45685 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbeBUTjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:39:41 -0500
X-Google-Smtp-Source: AH8x224UWz0Y9weC1QpoGcCFmymZM34b9cz0noYwqXHMCqq+HGOID3WxSEQ0vlOCxQXR53SVvZH9Zw==
Date: Wed, 21 Feb 2018 22:39:38 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] proc: make /proc/*/cmdline go through LSM
Message-ID: <20180221193938.GA28799@avx2>
References: <20180221192339.GA28548@avx2>
 <CAHp75VdaxkMn2UxURSB4fWep=iv4CRAkmEtdKBp1HKyxtW2tTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdaxkMn2UxURSB4fWep=iv4CRAkmEtdKBp1HKyxtW2tTg@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 09:28:41PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 21, 2018 at 9:23 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > /proc/*/cmdline is not different from /proc/*/environ as it accesses
> > target task's memory (and can access the very same region of memory)
> > but it doesn't go through ptrace_may_access() and thus doesn't go through LSM.
> 
> > +static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
> > +{
> > +       struct mm_struct *mm = proc_mem_open(inode, mode);
> > +
> > +       if (IS_ERR(mm))
> > +               return PTR_ERR(mm);
> 
> So, is it possible to have it NULL?..

I haven't looked closely, but if kernel thread is accesses then yes.

Regardless, patch only moves function so that code compiles, untangling
this little mess is separate adventure.

> > +static int mem_release(struct inode *inode, struct file *file)
> > +{
> > +       struct mm_struct *mm = file->private_data;
> 
> > +       if (mm)
> 
> ...or I don't get this check.
> 
> > +               mmdrop(mm);
> > +       return 0;
> > +}

It should trigger if kernel thread is accessed.
