Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BDBC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 12:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5A72184E
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 12:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeLWMtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 07:49:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:57114 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbeLWMtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 07:49:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AFE78ACFA;
        Sun, 23 Dec 2018 12:49:06 +0000 (UTC)
Date:   Sun, 23 Dec 2018 13:48:59 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cache updates for 4.21
Message-ID: <20181223124859.GA26860@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the latest x86-cache-for-linus tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cache-for-linus

This update contains:

 - The generalization of the RDT code to accommodate the addition of AMD's
   very similar implementation of the cache monitoring feature.

   This entails a subsystem move into a separate and generic
   arch/x86/kernel/cpu/resctrl/ directory along with adding
   vendor-specific initialization and feature detection helpers.

   Ontop of that is the unification of user-visible strings, both in the
   resctrl filesystem error handling and Kconfig.

   Provided by Babu Moger and Sherry Hurwitz.

 - Code simplifications and error handling improvements by Reinette
   Chatre.

And just because we're not having enough fun, this pull request
conflicts with the fs context changes in the vfs tree. Find the merge
conflict resolution (git show -M) at the end of this mail. For reference,
the merge resolution is also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git vfs-x86-cache

Thanks,
Boris.

------------------>

The following changes since commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6:

  Linux 4.20-rc3 (2018-11-18 13:33:44 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cache-for-linus

for you to fetch changes up to 52eb74339a6233c69f4e3794b69ea7c98eeeae1b:

  x86/resctrl: Fix rdt_find_domain() return value and checks (2018-12-11 22:09:28 +0100)

----------------------------------------------------------------
Babu Moger (13):
      x86/resctrl: Rename and move rdt files to a separate directory
      x86/resctrl: Rename the RDT functions and definitions
      x86/resctrl: Re-arrange the RDT init code
      x86/resctrl: Move all the macros to resctrl/internal.h
      x86/resctrl: Initialize the vendor-specific resource functions
      x86/resctrl: Bring cbm_validate() into the resource structure
      x86/resctrl: Add vendor check for the MBA software controller
      x86/resctrl: Rename the config option INTEL_RDT to RESCTRL
      x86/resctrl: Fixup the user-visible strings
      x86/resctrl: Introduce AMD QOS feature
      Documentation: Rename and update intel_rdt_ui.txt to resctrl_ui.txt
      MAINTAINERS: Update resctrl filename patterns
      x86/resctrl: Remove unnecessary check for cbm_validate()

Reinette Chatre (2):
      x86/resctrl: Use rdt_last_cmd_puts() where possible
      x86/resctrl: Fix rdt_find_domain() return value and checks

Sherry Hurwitz (1):
      x86/resctrl: Add AMD's X86_FEATURE_MBA to the scattered CPUID features

 Documentation/x86/{intel_rdt_ui.txt => resctrl_ui.txt}                             |   9 ++-
 MAINTAINERS                                                                        |   6 +-
 arch/x86/Kconfig                                                                   |  22 ++++---
 arch/x86/include/asm/{intel_rdt_sched.h => resctrl_sched.h}                        |  28 ++++-----
 arch/x86/kernel/cpu/Makefile                                                       |   5 +-
 arch/x86/kernel/cpu/resctrl/Makefile                                               |   4 ++
 arch/x86/kernel/cpu/{intel_rdt.c => resctrl/core.c}                                | 186 +++++++++++++++++++++++++++++++++++++++++++++++-------------
 arch/x86/kernel/cpu/{intel_rdt_ctrlmondata.c => resctrl/ctrlmondata.c}             | 107 ++++++++++++++++++++++++++++------
 arch/x86/kernel/cpu/{intel_rdt.h => resctrl/internal.h}                            |  55 +++++++++++-------
 arch/x86/kernel/cpu/{intel_rdt_monitor.c => resctrl/monitor.c}                     |  16 +++---
 arch/x86/kernel/cpu/{intel_rdt_pseudo_lock.c => resctrl/pseudo_lock.c}             |  40 ++++++-------
 arch/x86/kernel/cpu/{intel_rdt_pseudo_lock_event.h => resctrl/pseudo_lock_event.h} |   2 +-
 arch/x86/kernel/cpu/{intel_rdt_rdtgroup.c => resctrl/rdtgroup.c}                   |  61 ++++++++++----------
 arch/x86/kernel/cpu/scattered.c                                                    |   7 ++-
 arch/x86/kernel/process_32.c                                                       |   4 +-
 arch/x86/kernel/process_64.c                                                       |   4 +-
 include/linux/sched.h                                                              |   2 +-
 17 files changed, 385 insertions(+), 173 deletions(-)
 rename Documentation/x86/{intel_rdt_ui.txt => resctrl_ui.txt} (99%)
 rename arch/x86/include/asm/{intel_rdt_sched.h => resctrl_sched.h} (77%)
 create mode 100644 arch/x86/kernel/cpu/resctrl/Makefile
 rename arch/x86/kernel/cpu/{intel_rdt.c => resctrl/core.c} (83%)
 rename arch/x86/kernel/cpu/{intel_rdt_ctrlmondata.c => resctrl/ctrlmondata.c} (81%)
 rename arch/x86/kernel/cpu/{intel_rdt.h => resctrl/internal.h} (91%)
 rename arch/x86/kernel/cpu/{intel_rdt_monitor.c => resctrl/monitor.c} (98%)
 rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock.c => resctrl/pseudo_lock.c} (97%)
 rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock_event.h => resctrl/pseudo_lock_event.h} (95%)
 rename arch/x86/kernel/cpu/{intel_rdt_rdtgroup.c => resctrl/rdtgroup.c} (98%)

---
commit ba13cfacc0883dbe485d123f5087963701572098
Merge: 0a6185274b63 52eb74339a62
Author: Borislav Petkov <bp@suse.de>
Date:   Thu Dec 20 19:59:36 2018 +0100

    Merge branch 'x86-cache-for-linus' into vfs-x86-cache
    
     Conflicts:
            arch/x86/Kconfig
            arch/x86/kernel/cpu/resctrl/rdtgroup.c
    
    Signed-off-by: Borislav Petkov <bp@suse.de>

diff --cc arch/x86/Kconfig
index 642353a65649,2d0577e805d2..62adf94c8dfa
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@@ -443,15 -444,27 +443,23 @@@ config RETPOLIN
  	  branches. Requires a compiler with -mindirect-branch=thunk-extern
  	  support for full protection. The kernel may run slower.
  
- config INTEL_RDT
- 	bool "Intel Resource Director Technology support"
- 	depends on X86 && CPU_SUP_INTEL
 -	  Without compiler support, at least indirect branches in assembler
 -	  code are eliminated. Since this includes the syscall entry path,
 -	  it is not entirely pointless.
 -
+ config RESCTRL
+ 	bool "Resource Control support"
+ 	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
  	select KERNFS
  	help
- 	  Select to enable resource allocation and monitoring which are
- 	  sub-features of Intel Resource Director Technology(RDT). More
- 	  information about RDT can be found in the Intel x86
- 	  Architecture Software Developer Manual.
+ 	  Enable Resource Control support.
+ 
+ 	  Provide support for the allocation and monitoring of system resources
+ 	  usage by the CPU.
+ 
+ 	  Intel calls this Intel Resource Director Technology
+ 	  (Intel(R) RDT). More information about RDT can be found in the
+ 	  Intel x86 Architecture Software Developer Manual.
+ 
+ 	  AMD calls this AMD Platform Quality of Service (AMD QoS).
+ 	  More information about AMD QoS can be found in the AMD64 Technology
+ 	  Platform Quality of Service Extensions manual.
  
  	  Say N if unsure.
  
diff --cc arch/x86/kernel/cpu/resctrl/internal.h
index d5ec5643e7ab,822b7db634ee..e49b77283924
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@@ -4,18 -4,21 +4,22 @@@
  
  #include <linux/sched.h>
  #include <linux/kernfs.h>
 +#include <linux/fs_context.h>
  #include <linux/jump_label.h>
  
- #define IA32_L3_QOS_CFG		0xc81
- #define IA32_L2_QOS_CFG		0xc82
- #define IA32_L3_CBM_BASE	0xc90
- #define IA32_L2_CBM_BASE	0xd10
- #define IA32_MBA_THRTL_BASE	0xd50
+ #define MSR_IA32_L3_QOS_CFG		0xc81
+ #define MSR_IA32_L2_QOS_CFG		0xc82
+ #define MSR_IA32_L3_CBM_BASE		0xc90
+ #define MSR_IA32_L2_CBM_BASE		0xd10
+ #define MSR_IA32_MBA_THRTL_BASE		0xd50
+ #define MSR_IA32_MBA_BW_BASE		0xc0000200
  
- #define L3_QOS_CDP_ENABLE	0x01ULL
+ #define MSR_IA32_QM_CTR			0x0c8e
+ #define MSR_IA32_QM_EVTSEL		0x0c8d
  
- #define L2_QOS_CDP_ENABLE	0x01ULL
+ #define L3_QOS_CDP_ENABLE		0x01ULL
+ 
+ #define L2_QOS_CDP_ENABLE		0x01ULL
  
  /*
   * Event IDs are used to program IA32_QM_EVTSEL before reading event
diff --cc arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 37c0ccb50823,8388adf241b2..93cb6f994681
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@@ -2032,88 -2065,8 +2032,91 @@@ out
  	rdt_last_cmd_clear();
  	mutex_unlock(&rdtgroup_mutex);
  	cpus_read_unlock();
 +	return ret;
 +}
 +
 +enum rdt_param {
 +	Opt_cdp,
 +	Opt_cdpl2,
 +	Opt_mba_mpbs,
 +	nr__rdt_params
 +};
  
 -	return dentry;
 +static const struct fs_parameter_spec rdt_param_specs[nr__rdt_params] = {
 +	[Opt_cdp]	= { fs_param_is_flag },
 +	[Opt_cdpl2]	= { fs_param_is_flag },
 +	[Opt_mba_mpbs]	= { fs_param_is_flag },
 +};
 +
 +static const char *const rdt_param_keys[nr__rdt_params] = {
 +	[Opt_cdp]	= "cdp",
 +	[Opt_cdpl2]	= "cdpl2",
 +	[Opt_mba_mpbs]	= "mba_mbps",
 +};
 +
 +static const struct fs_parameter_description rdt_fs_parameters = {
 +	.name		= "rdt",
 +	.nr_params	= nr__rdt_params,
 +	.keys		= rdt_param_keys,
 +	.specs		= rdt_param_specs,
 +	.no_source	= true,
 +};
 +
 +static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 +{
 +	struct rdt_fs_context *ctx = rdt_fc2context(fc);
 +	struct fs_parse_result result;
 +	int opt;
 +
 +	opt = fs_parse(fc, &rdt_fs_parameters, param, &result);
 +	if (opt < 0)
 +		return opt;
 +
 +	switch (opt) {
 +	case Opt_cdp:
 +		ctx->enable_cdpl3 = true;
 +		return 0;
 +	case Opt_cdpl2:
 +		ctx->enable_cdpl2 = true;
 +		return 0;
 +	case Opt_mba_mpbs:
- 		ctx->enable_mba_mbps = true;
- 		return 0;
++		if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
++			ctx->enable_mba_mbps = true;
++			return 0;
++		}
++		break;
 +	}
 +
 +	return -EINVAL;
 +}
 +
 +static void rdt_fs_context_free(struct fs_context *fc)
 +{
 +	struct rdt_fs_context *ctx = rdt_fc2context(fc);
 +
 +	kernfs_free_fs_context(fc);
 +	kfree(ctx);
 +}
 +
 +static const struct fs_context_operations rdt_fs_context_ops = {
 +	.free		= rdt_fs_context_free,
 +	.parse_param	= rdt_parse_param,
 +	.get_tree	= rdt_get_tree,
 +};
 +
 +static int rdt_init_fs_context(struct fs_context *fc, struct dentry *reference)
 +{
 +	struct rdt_fs_context *ctx;
 +
 +	ctx = kzalloc(sizeof(struct rdt_fs_context), GFP_KERNEL);
 +	if (!ctx)
 +		return -ENOMEM;
 +
 +	ctx->kfc.root = rdt_root;
 +	ctx->kfc.magic = RDTGROUP_SUPER_MAGIC;
 +	fc->fs_private = &ctx->kfc;
 +	fc->ops = &rdt_fs_context_ops;
 +	return 0;
  }
  
  static int reset_all_ctrls(struct rdt_resource *r)
diff --cc arch/x86/kernel/process_32.c
index d3e593eb189f,dc4d92764d1a..9d08f0510620
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@@ -56,11 -56,9 +56,11 @@@
  #include <asm/debugreg.h>
  #include <asm/switch_to.h>
  #include <asm/vm86.h>
- #include <asm/intel_rdt_sched.h>
+ #include <asm/resctrl_sched.h>
  #include <asm/proto.h>
  
 +#include "process.h"
 +
  void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
  {
  	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
