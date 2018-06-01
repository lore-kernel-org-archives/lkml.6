Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeFAIoN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:44:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbeFAIoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:44:09 -0400
Date: Fri, 1 Jun 2018 10:43:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: James Simmons <jsimmons@infradead.org>
Cc: devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
        Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>,
        Dmitry Eremin <dmitry.eremin@intel.com>,
        Amir Shehata <amir.shehata@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH v2 23/25] staging: lustre: libcfs: rework CPU pattern
 parsing code
Message-ID: <20180601084347.GH19242@kroah.com>
References: <1527603725-30560-1-git-send-email-jsimmons@infradead.org>
 <1527603725-30560-24-git-send-email-jsimmons@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527603725-30560-24-git-send-email-jsimmons@infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:22:03AM -0400, James Simmons wrote:
> From: Dmitry Eremin <dmitry.eremin@intel.com>
> 
> Currently the module param string for CPU pattern can be
> modified which is wrong. Rewrite CPU pattern parsing code
> to avoid the passed buffer from being changed. This change
> also enables us to add real errors propogation to the caller
> functions.
> 
> Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
> Signed-off-by: Amir Shehata <amir.shehata@intel.com>
> Signed-off-by: Andreas Dilger <andreas.dilger@intel.com>
> Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8703
> Reviewed-on: https://review.whamcloud.com/23306
> Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9715
> Reviewed-on: https://review.whamcloud.com/27872
> Reviewed-by: James Simmons <uja.ornl@yahoo.com>
> Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
> Reviewed-by: Patrick Farrell <paf@cray.com>
> Reviewed-by: Olaf Weber <olaf.weber@hpe.com>
> Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
> Signed-off-by: James Simmons <jsimmons@infradead.org>
> ---
> Changelog:
> 
> v1) Initial patch
> v2) Rebased patch. No changes in code from earlier patch
> 
>  .../lustre/include/linux/libcfs/libcfs_cpu.h       |   2 +-
>  drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c    | 146 ++++++++++++---------
>  2 files changed, 87 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h b/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
> index c0aa0b3..12ed0a9 100644
> --- a/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
> +++ b/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
> @@ -393,7 +393,7 @@ static inline int cfs_cpu_init(void)
>  
>  static inline void cfs_cpu_fini(void)
>  {
> -	if (cfs_cpt_tab) {
> +	if (!IS_ERR_OR_NULL(cfs_cpt_tab)) {
>  		cfs_cpt_table_free(cfs_cpt_tab);
>  		cfs_cpt_tab = NULL;
>  	}
> diff --git a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
> index 649f7f9..aed48de 100644
> --- a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
> +++ b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
> @@ -692,11 +692,11 @@ int cfs_cpt_bind(struct cfs_cpt_table *cptab, int cpt)
>  		nodemask = cptab->ctb_parts[cpt].cpt_nodemask;
>  	}
>  
> -	if (cpumask_any_and(*cpumask, cpu_online_mask) >= nr_cpu_ids) {
> +	if (!cpumask_intersects(*cpumask, cpu_online_mask)) {
>  		CDEBUG(D_INFO,
>  		       "No online CPU found in CPU partition %d, did someone do CPU hotplug on system? You might need to reload Lustre modules to keep system working well.\n",
>  		       cpt);

This is the funniest error message I have seen in a while.

No one should have to reload all kernel modules just because the CPU
topology changed, that's crazy.  You have the ability to read all of
this at runtime, and react to changes that happen while the system is
running.  You should never need/rely on userspace passing in random
strings to pretend to match up with what the system really has at the
moment, that way lies madness.

All of this should be ripped out and use the proper apis instead.  No
special userspace api should be needed at all.

greg k-h
