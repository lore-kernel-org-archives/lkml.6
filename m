Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753886AbeEHCij (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753525AbeEHCih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:38:37 -0400
X-Google-Smtp-Source: AB8JxZpEpf76IY65Pnehx9Jo2dHiIcD2DEYSQs4XAiQX4sU1UJPP98Bjwyhjw4+xfYx9E/WfRuPHQlkuyVRDd1gTj7s=
MIME-Version: 1.0
References: <5AF03EBD02000078001C1303@prv1-mh.provo.novell.com>
In-Reply-To: <5AF03EBD02000078001C1303@prv1-mh.provo.novell.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 08 May 2018 02:38:25 +0000
X-Gmail-Original-Message-ID: <CALCETrX=SM=YBSpRv53Qmxk2PkHcTFWWvw-JGOh0C4UpvTReAA@mail.gmail.com>
Message-ID: <CALCETrX=SM=YBSpRv53Qmxk2PkHcTFWWvw-JGOh0C4UpvTReAA@mail.gmail.com>
Subject: Re: [PATCH] x86-64/Xen: fix stack switching
To: Jan Beulich <JBeulich@suse.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Lutomirski <luto@kernel.org>,
        xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 7, 2018 at 5:16 AM Jan Beulich <JBeulich@suse.com> wrote:

> While on native entry into the kernel happens on the trampoline stack,
> PV Xen kernels are being entered with the current thread stack right
> away. Hence source and destination stacks are identical in that case,
> and special care is needed.

> Other than in sync_regs() the copying done on the INT80 path as well as
> on the NMI path itself isn't NMI / #MC safe, as either of these events
> occurring in the middle of the stack copying would clobber data on the
> (source) stack. (Of course, in the NMI case only #MC could break
> things.)

I think I'd rather fix this by changing the stack switch code or
alternativing around it on non-stack-switching kernels.  Or make Xen use a
trampoline stack just like native.


> I'm not altering the similar code in interrupt_entry(), as that code
> path is unreachable when running an PV Xen guest afaict.

> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Cc: stable@kernel.org
> ---
> There would certainly have been the option of using alternatives
> patching, but afaict the patching code isn't NMI / #MC safe, so I'd
> rather stay away from patching the NMI path. And I thought it would be
> better to use similar code in both cases.

I would hope we do the patching before we enable any NMIs.


> Another option would be to make the Xen case match the native one, by
> going through the trampoline stack, but to me this would look like extra
> overhead for no gain.

Avoiding even more complexity in the nmi code seems like a big gain to me.
