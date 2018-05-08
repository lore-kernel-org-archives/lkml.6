Date: Tue, 8 May 2018 16:25:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: damian <damian.tometzki@icloud.com>, peterz@infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: Kernel build with gcc 8 a lot of warnings
Message-ID: <20180508142515.GA16111@kroah.com>
References: <20180505192112.GA18728@zrhn9910b>
 <20180507045453.leou4zypnlcck4vr@treble>
 <20180508055126.GA18724@kroah.com>
 <20180508133226.uwjbx44fwlxgyzu5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508133226.uwjbx44fwlxgyzu5@treble>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 08:34:47AM -0500, Josh Poimboeuf wrote:
> On Tue, May 08, 2018 at 07:51:26AM +0200, Greg KH wrote:
> > On Sun, May 06, 2018 at 11:54:53PM -0500, Josh Poimboeuf wrote:
> > > On Sat, May 05, 2018 at 09:21:12PM +0200, damian wrote:
> > > > Helllo together,
> > > > 
> > > > Hello everybody,
> > > > 
> > > > is something special to note when kernel build with gcc 8? I receive various warnings from the objtool:
> > > > With GCC 7 works all fine.
> > > > 
> > > > kernel/cgroup/cgroup.o: warning: objtool: parse_cgroup_root_flags()+0x40: sibling call from callable instruction with modified stack frame
> > > > kernel/cgroup/cgroup.o: warning: objtool: cgroup_addrm_files()+0x2a3: sibling call from callable instruction with modified stack frame
> > > > kernel/cgroup/cgroup.o: warning: objtool: cgroup_apply_control_enable()+0x20b: sibling call from callable instruction with modified stack frame
> > > > kernel/cgroup/cgroup.o: warning: objtool: rebind_subsystems()+0x296: sibling call from callable instruction with modified stack frame
> > > > kernel/cgroup/cgroup.o: warning: objtool: cgroup_sk_alloc_disable()+0x10: sibling call from callable instruction with modified stack frame
> > > > kernel/cgroup/cgroup.o: warning: objtool: parse_cgroup_root_flags.cold.45()+0xa: call without frame pointer save/setup
> > > > kernel/cgroup/cgroup.o: warning: objtool: cgroup_addrm_files.cold.46()+0x17: call without frame pointer save/setup
> > > > kernel/cgroup/cgroup.o: warning: objtool: cgroup_apply_control_enable.cold.47()+0x24: call without frame pointer save/setup
> > > > kernel/cgroup/cgroup.o: warning: objtool: rebind_subsystems.cold.48()+0x10: call without frame pointer save/setup
> > > > kernel/cgroup/cgroup.o: warning: objtool: cgroup_sk_alloc_disable.cold.49()+0x7: call without frame pointer save/setup
> > > >   CC      kernel/cgroup/stat.o
> > > >   CC [M]  arch/x86/kvm/../../../virt/kvm/kvm_main.o
> > > > arch/x86/kernel/acpi/boot.o: warning: objtool: acpi_register_lapic()+0x10: sibling call from callable instruction with modified stack frame
> > > > arch/x86/kernel/acpi/boot.o: warning: objtool: acpi_map_cpu()+0x2c: sibling call from callable instruction with modified stack frame
> > > > arch/x86/kernel/acpi/boot.o: warning: objtool: acpi_register_lapic.cold.6()+0x7: call without frame pointer save/setup
> > > > arch/x86/kernel/acpi/boot.o: warning: objtool: acpi_map_cpu.cold.7()+0x7: call without frame pointer save/setup
> > > 
> > > Thanks, this is a known issue with GCC 8 that I haven't gotten a chance
> > > to fix yet.  They're related to the fact that GCC 8 is splitting out
> > > 'unlikely' code into 'cold' subfunctions in .text.unlikely.
> > > 
> > > I've got some old patches that fix it.  Now that GCC 8 is out, I'll need
> > > get the patches dusted off and cleaned up for merging.
> > 
> > Any pointers to these patches?  Archi linux just changed their default
> > compiler to gcc 8 and now I'm seeing this in my local builds :(
> 
> I'm still dusting the code off, but this fixes most of the warnings.
> The rest of the code should hopefully be ready soon.
> 
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] objtool: Detect GCC 8 cold subfunctions
> 
> GCC 8 moves a lot of unlikely code out of line to "cold" subfunctions in
> .text.unlikely.  Properly detect the new subfunctions and treat them as
> extensions of the original functions.
> 
> This fixes a bunch of warnings like:
> 
>   kernel/cgroup/cgroup.o: warning: objtool: parse_cgroup_root_flags()+0x33: sibling call from callable instruction with modified stack frame
>   kernel/cgroup/cgroup.o: warning: objtool: cgroup_addrm_files()+0x290: sibling call from callable instruction with modified stack frame
>   kernel/cgroup/cgroup.o: warning: objtool: cgroup_apply_control_enable()+0x25b: sibling call from callable instruction with modified stack frame
>   kernel/cgroup/cgroup.o: warning: objtool: rebind_subsystems()+0x325: sibling call from callable instruction with modified stack frame
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  tools/objtool/check.c | 7 ++++---
>  tools/objtool/elf.c   | 3 +++
>  tools/objtool/elf.h   | 1 +
>  3 files changed, 8 insertions(+), 3 deletions(-)

<snip>

Much nicer, thanks for the patch, seems to build things "quieter" now.
For the other warnings, they are "safe" to ignore, right?  It's just
objtool checking to see if all is ok, but the result should be fine no
matter what, right?

thanks,

greg k-h
