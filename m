Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934188AbeEWWCx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 18:02:53 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38773 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933791AbeEWWCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 18:02:49 -0400
X-Google-Smtp-Source: AB8JxZrhje+BAN3CcIlkY5olfp3P1TCIyya/K6wqvaAbR23YqhQ0LJ9UQLGx/PIAJzeU1UGqVT5eew==
Date: Wed, 23 May 2018 15:02:45 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Eugene Syromiatnikov <esyr@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v2 0/3] bpf: add boot parameters for sysctl knobs
Message-ID: <20180523220244.a4u25kapqbjnmpr4@ast-mbp>
References: <20180523121806.GA27675@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523121806.GA27675@asgard.redhat.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 02:18:19PM +0200, Eugene Syromiatnikov wrote:
> Some BPF sysctl knobs affect the loading of BPF programs, and during
> system boot/init stages these sysctls are not yet configured.
> A concrete example is systemd, that has implemented loading of BPF
> programs.
> 
> Thus, to allow controlling these setting at early boot, this patch set
> adds the ability to change the default setting of these sysctl knobs
> as well as option to override them via a boot-time kernel parameter
> (in order to avoid rebuilding kernel each time a need of changing these
> defaults arises).
> 
> The sysctl knobs in question are kernel.unprivileged_bpf_disable,
> net.core.bpf_jit_harden, and net.core.bpf_jit_kallsyms.

- systemd is root. today it only uses cgroup-bpf progs which require root,
  so disabling unpriv during boot time makes no difference to systemd.
  what is the actual reason to present time?

- say in the future systemd wants to use so_reuseport+bpf for faster
  networking. With unpriv disable during boot, it will force systemd
  to do such networking from root, which will lower its security barrier.
  How that make sense?

- bpf_jit_kallsyms sysctl has immediate effect on loaded programs.
  Flipping it during the boot or right after or any time after
  is the same thing. Why add such boot flag then?

- jit_harden can be turned on by systemd. so turning it during the boot
  will make systemd progs to be constant blinded.
  Constant blinding protects kernel from unprivileged JIT spraying.
  Are you worried that systemd will attack the kernel with JIT spraying?
