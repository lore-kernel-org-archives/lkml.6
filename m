Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbeDCPmE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:42:04 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34482 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbeDCPmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:42:01 -0400
X-Google-Smtp-Source: AIpwx49ZVIGNTkhstMBYryWU9A2W0CZUkvqnZpeFYfbrbGc5wS1OPxthD8e3Wn7DiPp+b0XJRvAZyg==
Date: Tue, 3 Apr 2018 08:41:58 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
Message-ID: <20180403154156.f37wrzjhuvijzi2i@ast-mbp.dhcp.thefacebook.com>
References: <4136.1522452584@warthog.procyon.org.uk>
 <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org>
 <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 08:11:07AM -0700, Andy Lutomirski wrote:
> >
> >> "bpf: Restrict kernel image access functions when the kernel is locked down":
> >> This patch just sucks in general.
> >
> > Yes - but that's what Alexei Starovoitov specified.  bpf kind of sucks since
> > it gives you unrestricted access to the kernel.
> 
> bpf, in certain contexts, gives you unrestricted access to *reading*
> kernel memory.  bpf should, under no circumstances, let you write to
> the kernel unless you're using fault injection or similar.
> 
> I'm surprised that Alexei acked this patch.  If something like XDP or
> bpfilter starts becoming widely used, this patch will require a lot of
> reworking to avoid breaking standard distros.

my understanding was that this lockdown set attemps to disallow _reads_
of kernel memory from anything, so first version of patch was adding
run-time checks for bpf_probe_read() which is no-go
and without this helper the bpf for tracing is losing a lot of its power,
so the easiest is to disable it all.
I think lockdown suppose to disable xdp, bpfilter, nflog, raw sockets + pcap too
otherwise even cap_net_admin can see traffic coming into host.
Similarly kprobe, perf_event, ftrace should be off as well?
