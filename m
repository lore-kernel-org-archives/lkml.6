Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753949AbeCFRmY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 12:42:24 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36043 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753500AbeCFRmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 12:42:23 -0500
X-Google-Smtp-Source: AG47ELtvA5H5WrnPCzEW3HtLzq5Wr4XDcHObH6b1nAdhyNlNpi9QU5IzHGNbbI7qZyFPXuCcgiVDMg==
Date: Tue, 6 Mar 2018 20:42:19 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jann@thejh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: + mm-relax-ptrace-mode-in-process_vm_readv2.patch added to -mm
 tree
Message-ID: <20180306174218.GA2080@avx2>
References: <20180306000721.gx9qqFGe8%akpm@linux-foundation.org>
 <CAGXu5jKP03X7+XX9Oq+vVjQJhO1+A9ZyLDD+Gsxv2nRCgVD4wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKP03X7+XX9Oq+vVjQJhO1+A9ZyLDD+Gsxv2nRCgVD4wQ@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 05:02:08PM -0800, Kees Cook wrote:
> On Mon, Mar 5, 2018 at 4:07 PM,  <akpm@linux-foundation.org> wrote:

> > It is more natural to check for read-from-memory permissions in case of
> > process_vm_readv() as PTRACE_MODE_ATTACH is equivalent to write
> > permissions.
> 
> NAK, this weakens the existing permission model for reading

What if existing permission model is overezealous?

/proc/*/auxv, /proc/*/environ, /proc*/cmdline, /proc/*/mem opened
for reading and process_vm_readv(2) should do PTRACE_MODE_READ and
everything else should do PTRACE_MODE_ATTACH.

> cross-process memory. ptrace-readable memory can only be done with
> ATTACH, and /proc/$pid/mem also requires ATTACH:
> 
> static int mem_open(struct inode *inode, struct file *file)
> {
>         int ret = __mem_open(inode, file, PTRACE_MODE_ATTACH);
> 
> Only auxv and environ use READ. We should absolutely not create a pass
> to a lower permission requirement here.
