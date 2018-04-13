Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751111AbeDMRUk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 13:20:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750859AbeDMRUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 13:20:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6882177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 13 Apr 2018 14:20:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH 17/17] perf annotate: Handle variables in 'sub', 'or' and
 many other instructions
Message-ID: <20180413172035.GB26496@kernel.org>
References: <20180413140111.25313-1-acme@kernel.org>
 <20180413140111.25313-18-acme@kernel.org>
 <20180413162043.GD6694@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180413162043.GD6694@tassilo.jf.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 13, 2018 at 09:20:43AM -0700, Andi Kleen escreveu:
> On Fri, Apr 13, 2018 at 11:01:11AM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>

> > Just like is done for 'mov' and others that can have as source or
> > targets variables resolved by objdump, to make them more compact:
> > 
> > -               orb    $0x4,0x224d71(%rip)        # 226ca4 <_rtld_global+0xca4>
> > +               orb    $0x4,_rtld_global+0xca4
 
> That's not equivalent.  It could be non rip relative too. You would need
> to keep at least the (%rip).

So, the function is _dl_start in /lib64/ld-2.26.so, the objdump output
is:

0000000000001b10 <_dl_start>:
<SNIP>
    1d1f:       0f 84 ab 00 00 00       je     1dd0 <_dl_start+0x2c0>
    1d25:       48 8d 3d 64 3c 22 00    lea    0x223c64(%rip),%rdi        # 225990 <_rtld_global+0x990>
    1d2c:       80 0d 71 3f 22 00 04    orb    $0x4,0x223f71(%rip)        # 225ca4 <_rtld_global+0xca4>
    1d33:       e8 78 92 00 00          callq  afb0 <_dl_setup_hash>
<SNIP>

Then...

    21: 0000000000225000  3960 OBJECT  GLOBAL DEFAULT   20 _rtld_global@@GLIBC_PRIVATE

0x225ca4 = 0x225000 + 0x0xca4 

And that is equal to 0x1d33 + 0x223f71

What do I miss? Or where is it that I'm misinterpreting the calculations
that objdump did in its output?

This is just to make things compact, on the TUI if one wants to see the
original its just a matter of pressing 'o', i.e. that line appears by
default as:

perf annotate _dl_start
press HOME
press /orb
<SNIP>
       │215:   lea    _rtld_global+0x990,%rdi
       │       orb    $0x4,_rtld_global+0xca4
       │     → callq  _dl_setup_hash 
<SNIP>

press 'o', to see details, i.e. was this encoded as rip-relative?

<SNIP>
       │1f25:   lea    0x224a64(%rip),%rdi        # 226990 <_rtld_global+0x990>
       │1f2c:   orb    $0x4,0x224d71(%rip)        # 226ca4 <_rtld_global+0xca4>
       │1f33: → callq  b080 <_dl_setup_hash>  
<SNIP>

Now, if we have a non-rip relative orb, lemme search one with:

perf annotate --stdio2
/orb

There, we have one in the kernel's sys_pselect6:

perf annotate sys_pselect6
/orb
       │       mov    %gs:0x15b40,%rax
       │       orb    $0x4,0x490(%rax)
       │       mov    %rdx,0x718(%rax)
       │       mov    (%rax),%rdx

No variables resolved, nothing done, press 'o' to see the original objdump
disassembled line:

       │ffffffff8128af29:   mov    %gs:0x15b40,%rax
       │ffffffff8128af32:   orb    $0x4,0x490(%rax)
       │ffffffff8128af39:   mov    %rdx,0x718(%rax)
       │ffffffff8128af40:   mov    (%rax),%rdx

About something mildly related: what do you think about this:
http://ref.x86asm.net/, there is a xml file there[1] I'm thinking about
using, if available on the developer's HOME or some other standard place,
to provide help about the instructions :-)

- Arnaldo

[1] http://ref.x86asm.net/x86reference.xml

look for <mnem>PUNPCKHQDQ</mnem>

<entry r="yes">
	<pref>66</pref>
	<proc_start>10</proc_start>
	<syntax>
		<mnem>PUNPCKHQDQ</mnem>
		<dst>
			<a>V</a>
			<t>dq</t>
		</dst>
		<src>
			<a>W</a>
			<t>dq</t>
		</src>
	</syntax>
	<instr_ext>sse2</instr_ext>
	<grp1>simdint</grp1>
	<grp2>shunpck</grp2>
	<note>
		<brief>Unpack High Data</brief>
	</note>
</entry>

8-)
