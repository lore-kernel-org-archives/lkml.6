Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeEPNzs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:55:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752651AbeEPNzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:55:42 -0400
Date: Wed, 16 May 2018 10:55:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH V1 06/19] perf tools: Fix kernel_start for PTI on x86
Message-ID: <20180516135539.GA1230@kernel.org>
References: <1526388213-30696-1-git-send-email-adrian.hunter@intel.com>
 <1526388213-30696-7-git-send-email-adrian.hunter@intel.com>
 <20180516130029.GA18538@kernel.org>
 <56a4889f-6ea9-d7c6-3f1e-ea9738d314d0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56a4889f-6ea9-d7c6-3f1e-ea9738d314d0@intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 16, 2018 at 04:45:41PM +0300, Adrian Hunter escreveu:
> On 16/05/18 16:00, Arnaldo Carvalho de Melo wrote:
> > 2303	bool machine__is(struct machine *machine, const char *arch)
> > 2304	{
> > 2305		return machine && machine->env && !strcmp(machine->env->arch, arch);
> > 2306	}
> > 2307	
> > 2308	int machine__get_kernel_start(struct machine *machine)
> > 2309	{
> > (gdb) p machine
> > $1 = (struct machine *) 0xc55548
> > (gdb) p machine->env
> > $2 = (struct perf_env *) 0xc06400 <perf_env>
> > (gdb) p machine-env->arch
> > No symbol "env" in current context.
> > (gdb) p machine->env->arch
> > $3 = 0x0
> > (gdb)
 
> If there is no perf_data then perf_session__new() uses perf_env but it seems
> perf_env.arch is not initialized.  Would it be OK to initialize
> perf_env.arch and perf_env.nr_cpus_avail?

I guess so, to make that always available, i.e. no perf.data? Those
should reflect the running machine environment.

So a preparatory patch that makes that the case would be good, I think.

- Arnaldo
