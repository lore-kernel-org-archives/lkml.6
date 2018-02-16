Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932184AbeBPJlK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:41:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:10739 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932120AbeBPJlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:41:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="28542024"
Message-ID: <1518774066.22495.367.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/2] x86/platform/atom: Re-use
 DEFINE_SHOW_ATTRIBUTE() macro
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date: Fri, 16 Feb 2018 11:41:06 +0200
In-Reply-To: <20180216091020.wyjgsihl25tereeu@gmail.com>
References: <20180214154317.52290-1-andriy.shevchenko@linux.intel.com>
         <20180216091020.wyjgsihl25tereeu@gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-16 at 10:10 +0100, Ingo Molnar wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > ...instead of open coding file operations followed by custom
> > ->open()
> > callbacks per each attribute.
> > 
> > While here, replace permissions by explicit octal value.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  arch/x86/platform/atom/punit_atom_debug.c | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> > 
> > diff --git a/arch/x86/platform/atom/punit_atom_debug.c
> > b/arch/x86/platform/atom/punit_atom_debug.c
> > index d49d3be81953..156b445bcf4d 100644
> > --- a/arch/x86/platform/atom/punit_atom_debug.c
> > +++ b/arch/x86/platform/atom/punit_atom_debug.c
> > @@ -109,18 +109,7 @@ static int punit_dev_state_show(struct seq_file
> > *seq_file, void *unused)
> >  
> >  	return 0;
> >  }
> > -
> > -static int punit_dev_state_open(struct inode *inode, struct file
> > *file)
> > -{
> > -	return single_open(file, punit_dev_state_show, inode-
> > >i_private);
> > -}
> > -
> > -static const struct file_operations punit_dev_state_ops = {
> > -	.open		= punit_dev_state_open,
> > -	.read		= seq_read,
> > -	.llseek		= seq_lseek,
> > -	.release	= single_release,
> > -};
> > +DEFINE_SHOW_ATTRIBUTE(punit_dev_state);
> >  
> >  static struct dentry *punit_dbg_file;
> 
> Hm, that octal value replacement does not seem to be part of this
> patch, only the 
> next patch.
> 
> Also, the debugfs_create_file() call still uses the old
> &punit_dev_state_ops 
> callback array.
> 
> Did a patch hunk go missing?

Ooops, sorry.
Indeed, it happened to be half baked.

> 
> I've added the fixes below to the patch.

Thanks!

> 
> Thanks,
> 
> 	Ingo
> 
> --- tip.orig/arch/x86/platform/atom/punit_atom_debug.c
> +++ tip/arch/x86/platform/atom/punit_atom_debug.c
> @@ -132,9 +121,9 @@ static int punit_dbgfs_register(struct p
>  	if (!punit_dbg_file)
>  		return -ENXIO;
>  
> -	dev_state = debugfs_create_file("dev_power_state", S_IFREG |
> S_IRUGO,
> +	dev_state = debugfs_create_file("dev_power_state", 0444,
>  					punit_dbg_file, punit_device,
> -					&punit_dev_state_ops);
> +					&punit_dev_state_fops);
>  	if (!dev_state) {
>  		pr_err("punit_dev_state register failed\n");
>  		debugfs_remove(punit_dbg_file);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
