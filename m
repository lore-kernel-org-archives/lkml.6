Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ACEBBC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 02:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA09208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 02:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T6Nc55Cg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA09208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935916AbeFNCiN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 22:38:13 -0400
Received: from casper.infradead.org ([85.118.1.10]:35822 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935745AbeFNCiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 22:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4XI4KmCJ+6AGWf3cSZ8PSkD8eqfQuB5IBRjq7/s64A8=; b=T6Nc55CgdK+9UQPSZj0MQ8lMs
        PqyXop8lpsGmFjXYNdIkx0BDscMgBvrgBGTjI7b8pNqSCV5waYKGKWJKq3G1LDwNEy0gCXbAtyapt
        K2zfFlsVJeRL3cF/0iQFtXQblHn58ggGuG3mj1jRB3zcBTgF09vIFBkfkfuKkur1D5uAkuauWrElc
        KVhIW3V7psmOF3y40RbPyzYmH9H6EyCHMtNeEXZRbU6E3SuhOFRUVRT73XJBddQXo92Y/T7ensypn
        IG/ba2jdc3q5vxo1sHfJyg/yvq6NhYS2ynoYpTYOP6ihLAv539GNKNqY82jlNEmXfAA2+UK7OfRWo
        R2iTeUn2g==;
Received: from jsimmons (helo=localhost)
        by casper.infradead.org with local-esmtp (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTI9D-0002EL-8Z; Thu, 14 Jun 2018 02:38:05 +0000
Date:   Thu, 14 Jun 2018 03:38:03 +0100 (BST)
From:   James Simmons <jsimmons@infradead.org>
To:     NeilBrown <neilb@suse.com>
cc:     Oleg Drokin <oleg.drokin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 07/11] staging: lustre: fold lprocfs_call_handler
 functionality into lnet_debugfs_*
In-Reply-To: <152826511912.16761.6908134754944227444.stgit@noble>
Message-ID: <alpine.LFD.2.21.1806140336320.6734@casper.infradead.org>
References: <152826510267.16761.14361003167157833896.stgit@noble> <152826511912.16761.6908134754944227444.stgit@noble>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180614_033803_500420_C70C668B 
X-CRM114-Status: GOOD (  28.34  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> The calling convention for ->proc_handler is rather clumsy,
> as a comment in fs/procfs/proc_sysctl.c confirms.
> lustre has copied this convention to lnet_debugfs_{read,write},
> and then provided a wrapper for handlers - lprocfs_call_handler -
> to work around the clumsiness.
> 
> It is cleaner to just fold the functionality of lprocfs_call_handler()
> into lnet_debugfs_* and let them call the final handler directly.
> 
> If these files were ever moved to /proc/sys (which seems unlikely) the
> handling in fs/procfs/proc_sysctl.c would need to be fixed to, but
> that would not be a bad thing.
> 
> So modify all the functions that did use the wrapper to not need it
> now that a more sane calling convention is available.

Reviewed-by: James Simmons <jsimmons@infradead.org>
 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  .../staging/lustre/include/linux/libcfs/libcfs.h   |    4 -
>  drivers/staging/lustre/lnet/libcfs/module.c        |   84 +++++++-------------
>  drivers/staging/lustre/lnet/lnet/router_proc.c     |   41 +++-------
>  3 files changed, 41 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
> index edc7ed0dcb94..7ac609328256 100644
> --- a/drivers/staging/lustre/include/linux/libcfs/libcfs.h
> +++ b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
> @@ -57,10 +57,6 @@ int libcfs_setup(void);
>  extern struct workqueue_struct *cfs_rehash_wq;
>  
>  void lustre_insert_debugfs(struct ctl_table *table);
> -int lprocfs_call_handler(void *data, int write, loff_t *ppos,
> -			 void __user *buffer, size_t *lenp,
> -			 int (*handler)(void *data, int write, loff_t pos,
> -					void __user *buffer, int len));
>  
>  /*
>   * Memory
> diff --git a/drivers/staging/lustre/lnet/libcfs/module.c b/drivers/staging/lustre/lnet/libcfs/module.c
> index 5dc7de9e6478..02c404c6738e 100644
> --- a/drivers/staging/lustre/lnet/libcfs/module.c
> +++ b/drivers/staging/lustre/lnet/libcfs/module.c
> @@ -290,33 +290,15 @@ static struct miscdevice libcfs_dev = {
>  
>  static int libcfs_dev_registered;
>  
> -int lprocfs_call_handler(void *data, int write, loff_t *ppos,
> -			 void __user *buffer, size_t *lenp,
> -			 int (*handler)(void *data, int write, loff_t pos,
> -					void __user *buffer, int len))
> -{
> -	int rc = handler(data, write, *ppos, buffer, *lenp);
> -
> -	if (rc < 0)
> -		return rc;
> -
> -	if (write) {
> -		*ppos += *lenp;
> -	} else {
> -		*lenp = rc;
> -		*ppos += rc;
> -	}
> -	return 0;
> -}
> -EXPORT_SYMBOL(lprocfs_call_handler);
> -
> -static int __proc_dobitmasks(void *data, int write,
> -			     loff_t pos, void __user *buffer, int nob)
> +static int proc_dobitmasks(struct ctl_table *table, int write,
> +			   void __user *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	const int tmpstrlen = 512;
>  	char *tmpstr;
>  	int rc;
> -	unsigned int *mask = data;
> +	size_t nob = *lenp;
> +	loff_t pos = *ppos;
> +	unsigned int *mask = table->data;
>  	int is_subsys = (mask == &libcfs_subsystem_debug) ? 1 : 0;
>  	int is_printk = (mask == &libcfs_printk) ? 1 : 0;
>  
> @@ -351,32 +333,23 @@ static int __proc_dobitmasks(void *data, int write,
>  	return rc;
>  }
>  
> -static int proc_dobitmasks(struct ctl_table *table, int write,
> -			   void __user *buffer, size_t *lenp, loff_t *ppos)
> +static int proc_dump_kernel(struct ctl_table *table, int write,
> +			    void __user *buffer, size_t *lenp, loff_t *ppos)
>  {
> -	return lprocfs_call_handler(table->data, write, ppos, buffer, lenp,
> -				    __proc_dobitmasks);
> -}
> +	size_t nob = *lenp;
>  
> -static int __proc_dump_kernel(void *data, int write,
> -			      loff_t pos, void __user *buffer, int nob)
> -{
>  	if (!write)
>  		return 0;
>  
>  	return cfs_trace_dump_debug_buffer_usrstr(buffer, nob);
>  }
>  
> -static int proc_dump_kernel(struct ctl_table *table, int write,
> +static int proc_daemon_file(struct ctl_table *table, int write,
>  			    void __user *buffer, size_t *lenp, loff_t *ppos)
>  {
> -	return lprocfs_call_handler(table->data, write, ppos, buffer, lenp,
> -				    __proc_dump_kernel);
> -}
> +	size_t nob = *lenp;
> +	loff_t pos = *ppos;
>  
> -static int __proc_daemon_file(void *data, int write,
> -			      loff_t pos, void __user *buffer, int nob)
> -{
>  	if (!write) {
>  		int len = strlen(cfs_tracefile);
>  
> @@ -390,13 +363,6 @@ static int __proc_daemon_file(void *data, int write,
>  	return cfs_trace_daemon_command_usrstr(buffer, nob);
>  }
>  
> -static int proc_daemon_file(struct ctl_table *table, int write,
> -			    void __user *buffer, size_t *lenp, loff_t *ppos)
> -{
> -	return lprocfs_call_handler(table->data, write, ppos, buffer, lenp,
> -				    __proc_daemon_file);
> -}
> -
>  static int libcfs_force_lbug(struct ctl_table *table, int write,
>  			     void __user *buffer,
>  			     size_t *lenp, loff_t *ppos)
> @@ -419,9 +385,11 @@ static int proc_fail_loc(struct ctl_table *table, int write,
>  	return rc;
>  }
>  
> -static int __proc_cpt_table(void *data, int write,
> -			    loff_t pos, void __user *buffer, int nob)
> +static int proc_cpt_table(struct ctl_table *table, int write,
> +			  void __user *buffer, size_t *lenp, loff_t *ppos)
>  {
> +	size_t nob = *lenp;
> +	loff_t pos = *ppos;
>  	char *buf = NULL;
>  	int len = 4096;
>  	int rc  = 0;
> @@ -457,13 +425,6 @@ static int __proc_cpt_table(void *data, int write,
>  	return rc;
>  }
>  
> -static int proc_cpt_table(struct ctl_table *table, int write,
> -			  void __user *buffer, size_t *lenp, loff_t *ppos)
> -{
> -	return lprocfs_call_handler(table->data, write, ppos, buffer, lenp,
> -				    __proc_cpt_table);
> -}
> -
>  static struct ctl_table lnet_table[] = {
>  	{
>  		.procname = "debug",
> @@ -573,10 +534,17 @@ static ssize_t lnet_debugfs_read(struct file *filp, char __user *buf,
>  {
>  	struct ctl_table *table = filp->private_data;
>  	int error;
> +	loff_t old_pos = *ppos;
>  
>  	error = table->proc_handler(table, 0, (void __user *)buf, &count, ppos);
> -	if (!error)
> +	/*
> +	 * On success, the length read is either in error or in count.
> +	 * If ppos changed, then use count, else use error
> +	 */
> +	if (!error && *ppos != old_pos)
>  		error = count;
> +	else if (error > 0)
> +		*ppos += error;
>  
>  	return error;
>  }
> @@ -586,10 +554,14 @@ static ssize_t lnet_debugfs_write(struct file *filp, const char __user *buf,
>  {
>  	struct ctl_table *table = filp->private_data;
>  	int error;
> +	loff_t old_pos = *ppos;
>  
>  	error = table->proc_handler(table, 1, (void __user *)buf, &count, ppos);
> -	if (!error)
> +	if (!error) {
>  		error = count;
> +		if (*ppos == old_pos)
> +			*ppos += count;
> +	}
>  
>  	return error;
>  }
> diff --git a/drivers/staging/lustre/lnet/lnet/router_proc.c b/drivers/staging/lustre/lnet/lnet/router_proc.c
> index ae4b7f5953a0..f135082fec5c 100644
> --- a/drivers/staging/lustre/lnet/lnet/router_proc.c
> +++ b/drivers/staging/lustre/lnet/lnet/router_proc.c
> @@ -74,11 +74,13 @@
>  
>  #define LNET_PROC_VERSION(v)	((unsigned int)((v) & LNET_PROC_VER_MASK))
>  
> -static int __proc_lnet_stats(void *data, int write,
> -			     loff_t pos, void __user *buffer, int nob)
> +static int proc_lnet_stats(struct ctl_table *table, int write,
> +			   void __user *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	int rc;
>  	struct lnet_counters *ctrs;
> +	size_t nob = *lenp;
> +	loff_t pos = *ppos;
>  	int len;
>  	char *tmpstr;
>  	const int tmpsiz = 256; /* 7 %u and 4 %llu */
> @@ -122,13 +124,6 @@ static int __proc_lnet_stats(void *data, int write,
>  	return rc;
>  }
>  
> -static int proc_lnet_stats(struct ctl_table *table, int write,
> -			   void __user *buffer, size_t *lenp, loff_t *ppos)
> -{
> -	return lprocfs_call_handler(table->data, write, ppos, buffer, lenp,
> -				    __proc_lnet_stats);
> -}
> -
>  static int proc_lnet_routes(struct ctl_table *table, int write,
>  			    void __user *buffer, size_t *lenp, loff_t *ppos)
>  {
> @@ -562,9 +557,11 @@ static int proc_lnet_peers(struct ctl_table *table, int write,
>  	return rc;
>  }
>  
> -static int __proc_lnet_buffers(void *data, int write,
> -			       loff_t pos, void __user *buffer, int nob)
> +static int proc_lnet_buffers(struct ctl_table *table, int write,
> +			     void __user *buffer, size_t *lenp, loff_t *ppos)
>  {
> +	size_t nob = *lenp;
> +	loff_t pos = *ppos;
>  	char *s;
>  	char *tmpstr;
>  	int tmpsiz;
> @@ -620,13 +617,6 @@ static int __proc_lnet_buffers(void *data, int write,
>  	return rc;
>  }
>  
> -static int proc_lnet_buffers(struct ctl_table *table, int write,
> -			     void __user *buffer, size_t *lenp, loff_t *ppos)
> -{
> -	return lprocfs_call_handler(table->data, write, ppos, buffer, lenp,
> -				    __proc_lnet_buffers);
> -}
> -
>  static int proc_lnet_nis(struct ctl_table *table, int write,
>  			 void __user *buffer, size_t *lenp, loff_t *ppos)
>  {
> @@ -784,10 +774,13 @@ static struct lnet_portal_rotors	portal_rotors[] = {
>  	},
>  };
>  
> -static int __proc_lnet_portal_rotor(void *data, int write,
> -				    loff_t pos, void __user *buffer, int nob)
> +static int proc_lnet_portal_rotor(struct ctl_table *table, int write,
> +				  void __user *buffer, size_t *lenp,
> +				  loff_t *ppos)
>  {
>  	const int buf_len = 128;
> +	size_t nob = *lenp;
> +	loff_t pos = *ppos;
>  	char *buf;
>  	char *tmp;
>  	int rc;
> @@ -845,14 +838,6 @@ static int __proc_lnet_portal_rotor(void *data, int write,
>  	return rc;
>  }
>  
> -static int proc_lnet_portal_rotor(struct ctl_table *table, int write,
> -				  void __user *buffer, size_t *lenp,
> -				  loff_t *ppos)
> -{
> -	return lprocfs_call_handler(table->data, write, ppos, buffer, lenp,
> -				    __proc_lnet_portal_rotor);
> -}
> -
>  static struct ctl_table lnet_table[] = {
>  	/*
>  	 * NB No .strategy entries have been provided since sysctl(8) prefers
> 
> 
> 
