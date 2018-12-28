Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D45DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F4620873
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545987490;
	bh=rKnLkGYa5pvUiGDSe5Z/Tdh111Nsr2hCaWHa8Rjq4I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=caW5E5H/JuQ/PGJhSp78FgJ2ZhWMFcs2ECub2j7eWTHPRK8CL9Dyc8bWW8+xR9NqV
	 1FTKlB7QLvGbxCxDiMugEohwR8z4Ev8geJ13J+eE46GLINjt6JHUnt7sqBBP+nFPCh
	 sU5kv3QlvttsEsf/Gz9XRRDKmUE8R40J3RaXYc8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbeL1I6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 03:58:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:37628 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729345AbeL1I6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 03:58:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68A4DAD12;
        Fri, 28 Dec 2018 08:58:06 +0000 (UTC)
Date:   Fri, 28 Dec 2018 09:58:04 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        David Windsor <dave@nullcore.net>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@surriel.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] mm: Mark 'stack_vm_area' with __maybe_unused
Message-ID: <20181228085804.GR16738@dhcp22.suse.cz>
References: <1545965190-2381-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545965190-2381-1-git-send-email-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 28-12-18 02:46:30, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning when
> CONFIG_VMAP_STACK is not set:

Isn't this warning disabled? I can see the following
# These warnings generated too much noise in a regular build.
# Use make W=1 to enable them (see scripts/Makefile.extrawarn)
KBUILD_CFLAGS += -Wno-unused-but-set-variable

in the main makefile. IMHO this warning doesn't really give us much.

> 
> kernel/fork.c: In function 'dup_task_struct':
> kernel/fork.c:843:20: warning:
>  variable 'stack_vm_area' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  kernel/fork.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index e2a5156..b38c392 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -840,7 +840,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
>  {
>  	struct task_struct *tsk;
>  	unsigned long *stack;
> -	struct vm_struct *stack_vm_area;
> +	struct vm_struct *stack_vm_area __maybe_unused;
>  	int err;
>  
>  	if (node == NUMA_NO_NODE)
> 
> 
> 

-- 
Michal Hocko
SUSE Labs
