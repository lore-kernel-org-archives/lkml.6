Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846BBC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BABF20645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544430654;
	bh=UxFvOvKE8DRlDf2dZlkb3JA6SKstglnL7Q6wpboluTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S29V2PDfRi0wuR6afNkZK1cMfXgkPRf+M58TKAGNz5SYdPyvBbZL/HmFIr0rYTnXs
	 QcBs3kDSl1WdDXXGtaEPs4u3emfDojeWPPHgnrYtIn2vQt3pSZYuOc2U1g2k9Qdrm5
	 ADdrC2H5THSS7qR/4ZdH02k63Xtac/re8j8ZLSFU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BABF20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeLJIax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:30:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:53182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbeLJIaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:30:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 95FA5AD75;
        Mon, 10 Dec 2018 08:30:50 +0000 (UTC)
Date:   Mon, 10 Dec 2018 09:30:49 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chanho Min <chanho.min@lge.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seungho Park <seungho1.park@lge.com>
Subject: Re: [PATCH] exec: make prepare_bprm_creds static
Message-ID: <20181210083049.GI1286@dhcp22.suse.cz>
References: <1544428194-2431-1-git-send-email-chanho.min@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544428194-2431-1-git-send-email-chanho.min@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-12-18 16:49:54, Chanho Min wrote:
> prepare_bprm_creds is not used outside exec.c, so there's no reason for it
> to have external linkage.
> 
> Signed-off-by: Chanho Min <chanho.min@lge.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  fs/exec.c               | 2 +-
>  include/linux/binfmts.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index fc281b7..b6c9e5f 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1399,7 +1399,7 @@ EXPORT_SYMBOL(finalize_exec);
>   * Or, if exec fails before, free_bprm() should release ->cred and
>   * and unlock.
>   */
> -int prepare_bprm_creds(struct linux_binprm *bprm)
> +static int prepare_bprm_creds(struct linux_binprm *bprm)
>  {
>  	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
>  		return -ERESTARTNOINTR;
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index e9f5fe6..6a9e43d 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -138,7 +138,6 @@ extern int transfer_args_to_stack(struct linux_binprm *bprm,
>  extern int bprm_change_interp(const char *interp, struct linux_binprm *bprm);
>  extern int copy_strings_kernel(int argc, const char *const *argv,
>  			       struct linux_binprm *bprm);
> -extern int prepare_bprm_creds(struct linux_binprm *bprm);
>  extern void install_exec_creds(struct linux_binprm *bprm);
>  extern void set_binfmt(struct linux_binfmt *new);
>  extern ssize_t read_code(struct file *, unsigned long, loff_t, size_t);
> -- 
> 2.1.4
> 

-- 
Michal Hocko
SUSE Labs
