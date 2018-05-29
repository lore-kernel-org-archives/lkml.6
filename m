Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932496AbeE2IiR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 04:38:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932270AbeE2IiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 04:38:10 -0400
Date: Tue, 29 May 2018 10:37:59 +0200
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
Message-ID: <20180529103759.7ab88bb0@redhat.com>
In-Reply-To: <20180525194359.qckwj3tnsbufyapz@ast-mbp>
References: <20180523121806.GA27675@asgard.redhat.com>
        <20180523220244.a4u25kapqbjnmpr4@ast-mbp>
        <20180524094108.066d885a@redhat.com>
        <20180524233449.ga664pzexrkzepfv@ast-mbp>
        <20180525165009.GA20952@asgard.redhat.com>
        <20180525194359.qckwj3tnsbufyapz@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018 12:44:01 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Fri, May 25, 2018 at 06:50:09PM +0200, Eugene Syromiatnikov wrote:
> > On Thu, May 24, 2018 at 04:34:51PM -0700, Alexei Starovoitov wrote:  
> > > On Thu, May 24, 2018 at 09:41:08AM +0200, Jesper Dangaard Brouer wrote:  
> > > > On Wed, 23 May 2018 15:02:45 -0700
> > > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > >   
> > > > > On Wed, May 23, 2018 at 02:18:19PM +0200, Eugene Syromiatnikov wrote:  
> > > > > > Some BPF sysctl knobs affect the loading of BPF programs, and during
> > > > > > system boot/init stages these sysctls are not yet configured.
> > > > > > A concrete example is systemd, that has implemented loading of BPF
> > > > > > programs.
> > > > > > 
> > > > > > Thus, to allow controlling these setting at early boot, this patch set
> > > > > > adds the ability to change the default setting of these sysctl knobs
> > > > > > as well as option to override them via a boot-time kernel parameter
> > > > > > (in order to avoid rebuilding kernel each time a need of changing these
> > > > > > defaults arises).
> > > > > > 
> > > > > > The sysctl knobs in question are kernel.unprivileged_bpf_disable,
> > > > > > net.core.bpf_jit_harden, and net.core.bpf_jit_kallsyms.    
> > > > > 
> > > > > - systemd is root. today it only uses cgroup-bpf progs which require root,
> > > > >   so disabling unpriv during boot time makes no difference to systemd.
> > > > >   what is the actual reason to present time?  
> > systemd also runs a lot of code, some of which is unprivileged.  
> 
> systemd processes sysctl configs first. It's essential for system
> security to do so. If you have concerns in how systemd does that
> please bring it up with systemd folks.
> 
> > > > > - say in the future systemd wants to use so_reuseport+bpf for faster
> > > > >   networking. With unpriv disable during boot, it will force systemd
> > > > >   to do such networking from root, which will lower its security barrier.  
> > No, it will force systemd not to use SO_REUSEPORT BPF.  
> 
> sorry this argument makes no sense to me.
> 
> > > > > - bpf_jit_kallsyms sysctl has immediate effect on loaded programs.
> > > > >   Flipping it during the boot or right after or any time after
> > > > >   is the same thing. Why add such boot flag then?  
> > Well, that one was for completeness.  
> 
> Should we convert all sysctls to bootparams for 'completeness' ?

The bpf_jit_kallsyms option is not there for 'completeness', it is
there because I know Daniel talked about changing the default, and this
would provide an easy option for allowing changing this default (to on)
in different distros before flipping it on in some kernel release.


> > > > > - jit_harden can be turned on by systemd. so turning it during the boot
> > > > >   will make systemd progs to be constant blinded.
> > > > >   Constant blinding protects kernel from unprivileged JIT spraying.
> > > > >   Are you worried that systemd will attack the kernel with JIT spraying?  
> > I'm worried that systemd can be exploited for a JIT spraying attack.  
> 
> I'm afraid we're not on the same page with definition of 'JIT spraying attack'.
> 
> > Another thing I'm concerned with is that the generated code is different,
> > which introduces additional complication during debugging.  
> 
> specifically what kind of complication?
> 

I think kernel.unprivileged_bpf_disable is the best example, why we
need this facility.  Once kernel.unprivileged_bpf_disable is set to 1,
it cannot be turned back to 0.

It is a policy decision that I want unprivileged_bpf_disable=1.
Setting this policy in the sysctl step is too late, because as you
write above, you expect that e.g. systemd or other boot-scripts
want/can load bpf-progs in unpriv mode.  Thus, they can violate my
policy choice.

This also leads to the before mentioned inconsistency issue. The
init-script/systemd-service will during boot successfully load unpriv
bpf-prog, but when I afterwards when I reload (or stop/start) the
service, it will fail as it no longer can load the unpriv bpf program.

If a distribution makes this policy choice, then users cannot change it
back to unprivileged_bpf_disable=0 via sysctl.  Thus, we need a boot
param to allow users to change this policy.  If the disto didn't change
this default, then we still need the boot-param, to allow users to
enforce this policy choice towards init-scripts (as explained above).

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
