Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeERGQl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 02:16:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39655 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbeERGQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 02:16:39 -0400
X-Google-Smtp-Source: AB8JxZpkZZ6snXhsO28e4CdMWRno48jy68v1RLlE/U8/GTkYgsgK33gTHoy7KEeRXY7Ywsn9KzHbFg==
Date: Fri, 18 May 2018 08:16:36 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH -tip v3 4/7] kprobes: Ignore break_handler
Message-ID: <20180518061635.GA27960@gmail.com>
References: <152651499561.25583.14488389770693278906.stgit@devbox>
 <152651511510.25583.17622383189254834099.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152651511510.25583.17622383189254834099.stgit@devbox>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Ignore break_handler related code because it was only
> used by jprobe and jprobe is removed.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Documentation/kprobes.txt |    2 +-
>  kernel/kprobes.c          |   39 +++++----------------------------------
>  2 files changed, 6 insertions(+), 35 deletions(-)

Even after all these changes there's quite a bit of ->break_handler() use:

triton:~/tip> git grep -w break_handler
arch/arc/kernel/kprobes.c:              if (p->break_handler && p->break_handler(p, regs)) {
arch/arm/probes/kprobes/core.c:                  * for calling the break_handler below on re-entry,
arch/arm/probes/kprobes/core.c:         if (cur->break_handler && cur->break_handler(cur, regs)) {
arch/arm64/kernel/probes/kprobes.c:                      * for calling the break_handler below on re-entry,
arch/arm64/kernel/probes/kprobes.c:             if (cur_kprobe->break_handler  &&
arch/arm64/kernel/probes/kprobes.c:                  cur_kprobe->break_handler(cur_kprobe, regs)) {
arch/ia64/kernel/kprobes.c:                     if (p->break_handler && p->break_handler(p, regs)) {
arch/mips/kernel/kprobes.c:                     if (p->break_handler && p->break_handler(p, regs))
arch/powerpc/kernel/kprobes.c:                  if (p->break_handler && p->break_handler(p, regs)) {
arch/s390/kernel/kprobes.c:                      * for calling the break_handler below on re-entry
arch/s390/kernel/kprobes.c:             if (p->break_handler && p->break_handler(p, regs)) {
arch/s390/kernel/kprobes.c:                      * break_handler "returns" to the original
arch/sh/kernel/kprobes.c:                       if (p->break_handler && p->break_handler(p, regs)) {
arch/sh/kernel/kprobes.c:                                       if (p->break_handler &&
arch/sh/kernel/kprobes.c:                                           p->break_handler(p, args->regs))
arch/sparc/kernel/kprobes.c:                    if (p->break_handler && p->break_handler(p, regs))
arch/x86/include/asm/kprobes.h:  * a post_handler or break_handler).
include/linux/kprobes.h:        kprobe_break_handler_t break_handler;

Nothing appears to be actually _setting_ the break_handler, so all of this is 
stale code as well which should be removed?

Thanks,

	Ingo
