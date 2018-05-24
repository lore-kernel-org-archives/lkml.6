Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935781AbeEXHlU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:41:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935585AbeEXHlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:41:18 -0400
Date: Thu, 24 May 2018 09:41:08 +0200
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eugene Syromiatnikov <esyr@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Jiri Olsa <jolsa@kernel.org>, brouer@redhat.com
Subject: Re: [PATCH bpf-next v2 0/3] bpf: add boot parameters for sysctl
 knobs
Message-ID: <20180524094108.066d885a@redhat.com>
In-Reply-To: <20180523220244.a4u25kapqbjnmpr4@ast-mbp>
References: <20180523121806.GA27675@asgard.redhat.com>
        <20180523220244.a4u25kapqbjnmpr4@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2018 15:02:45 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Wed, May 23, 2018 at 02:18:19PM +0200, Eugene Syromiatnikov wrote:
> > Some BPF sysctl knobs affect the loading of BPF programs, and during
> > system boot/init stages these sysctls are not yet configured.
> > A concrete example is systemd, that has implemented loading of BPF
> > programs.
> > 
> > Thus, to allow controlling these setting at early boot, this patch set
> > adds the ability to change the default setting of these sysctl knobs
> > as well as option to override them via a boot-time kernel parameter
> > (in order to avoid rebuilding kernel each time a need of changing these
> > defaults arises).
> > 
> > The sysctl knobs in question are kernel.unprivileged_bpf_disable,
> > net.core.bpf_jit_harden, and net.core.bpf_jit_kallsyms.  
> 
> - systemd is root. today it only uses cgroup-bpf progs which require root,
>   so disabling unpriv during boot time makes no difference to systemd.
>   what is the actual reason to present time?
> 
> - say in the future systemd wants to use so_reuseport+bpf for faster
>   networking. With unpriv disable during boot, it will force systemd
>   to do such networking from root, which will lower its security barrier.
>   How that make sense?
> 
> - bpf_jit_kallsyms sysctl has immediate effect on loaded programs.
>   Flipping it during the boot or right after or any time after
>   is the same thing. Why add such boot flag then?
> 
> - jit_harden can be turned on by systemd. so turning it during the boot
>   will make systemd progs to be constant blinded.
>   Constant blinding protects kernel from unprivileged JIT spraying.
>   Are you worried that systemd will attack the kernel with JIT spraying?


I think you are missing that, we want the ability to change these
defaults in-order to avoid depending on /etc/sysctl.conf settings, and
that the these sysctl.conf setting happen too late.

For example with jit_harden, there will be a difference between the
loaded BPF program that got loaded at boot-time with systemd (no
constant blinding) and when someone reloads that systemd service after
/etc/sysctl.conf have been evaluated and setting bpf_jit_harden (now
slower due to constant blinding).   This is inconsistent behavior.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
