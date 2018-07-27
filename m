Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515B1C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0720E20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0720E20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeG0Fll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 01:41:41 -0400
Received: from www62.your-server.de ([213.133.104.62]:45360 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeG0Fll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 01:41:41 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fiuG5-0000OY-97; Fri, 27 Jul 2018 06:21:41 +0200
Received: from [99.0.85.34] (helo=localhost.localdomain)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fiuG4-000ULR-Vh; Fri, 27 Jul 2018 06:21:41 +0200
Subject: Re: [PATCH v3 bpf-next 04/14] bpf: allocate cgroup storage entries on
 attaching bpf programs
To:     Roman Gushchin <guro@fb.com>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexei Starovoitov <ast@kernel.org>
References: <20180720174558.5829-1-guro@fb.com>
 <20180720174558.5829-5-guro@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <60f1e04e-eff9-543f-9f0e-b0cd50bbe71e@iogearbox.net>
Date:   Fri, 27 Jul 2018 06:21:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180720174558.5829-5-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24786/Fri Jul 27 02:41:39 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/2018 07:45 PM, Roman Gushchin wrote:
> If a bpf program is using cgroup local storage, allocate
> a bpf_cgroup_storage structure automatically on attaching the program
> to a cgroup and save the pointer into the corresponding bpf_prog_list
> entry.
> Analogically, release the cgroup local storage on detaching
> of the bpf program.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> ---
>  include/linux/bpf-cgroup.h |  1 +
>  kernel/bpf/cgroup.c        | 28 ++++++++++++++++++++++++++--
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 1b1b4e94d77d..f37347331fdb 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -42,6 +42,7 @@ struct bpf_cgroup_storage {
>  struct bpf_prog_list {
>  	struct list_head node;
>  	struct bpf_prog *prog;
> +	struct bpf_cgroup_storage *storage;
>  };
>  
>  struct bpf_prog_array;
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index badabb0b435c..986ff18ef92e 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -34,6 +34,8 @@ void cgroup_bpf_put(struct cgroup *cgrp)
>  		list_for_each_entry_safe(pl, tmp, progs, node) {
>  			list_del(&pl->node);
>  			bpf_prog_put(pl->prog);
> +			bpf_cgroup_storage_unlink(pl->storage);
> +			bpf_cgroup_storage_free(pl->storage);
>  			kfree(pl);
>  			static_branch_dec(&cgroup_bpf_enabled_key);
>  		}
> @@ -188,6 +190,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
>  {
>  	struct list_head *progs = &cgrp->bpf.progs[type];
>  	struct bpf_prog *old_prog = NULL;
> +	struct bpf_cgroup_storage *storage, *old_storage = NULL;
>  	struct cgroup_subsys_state *css;
>  	struct bpf_prog_list *pl;
>  	bool pl_was_allocated;
> @@ -210,6 +213,10 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
>  	if (prog_list_length(progs) >= BPF_CGROUP_MAX_PROGS)
>  		return -E2BIG;
>  
> +	storage = bpf_cgroup_storage_alloc(prog);
> +	if (IS_ERR(storage))
> +		return -ENOMEM;
> +
>  	if (flags & BPF_F_ALLOW_MULTI) {
>  		list_for_each_entry(pl, progs, node)
>  			if (pl->prog == prog)
> @@ -217,24 +224,33 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
>  				return -EINVAL;
>  
>  		pl = kmalloc(sizeof(*pl), GFP_KERNEL);
> -		if (!pl)
> +		if (!pl) {
> +			bpf_cgroup_storage_free(storage);
>  			return -ENOMEM;
> +		}

Above code is:

        storage = bpf_cgroup_storage_alloc(prog);
        if (IS_ERR(storage))
                return -ENOMEM;

        if (flags & BPF_F_ALLOW_MULTI) {
                list_for_each_entry(pl, progs, node)
                        if (pl->prog == prog)
                                /* disallow attaching the same prog twice */
                                return -EINVAL;

                pl = kmalloc(sizeof(*pl), GFP_KERNEL);
                if (!pl) {
                        bpf_cgroup_storage_free(storage);
                        return -ENOMEM;
                }

Given bpf_cgroup_storage_alloc() only changes the mem and prepares (kmallocs)
the local storage buffer, we would leak it above where we attach the same
prog twice, no?

> +
>  		pl_was_allocated = true;
>  		pl->prog = prog;
> +		pl->storage = storage;
>  		list_add_tail(&pl->node, progs);
>  	} else {
>  		if (list_empty(progs)) {
>  			pl = kmalloc(sizeof(*pl), GFP_KERNEL);
> -			if (!pl)
> +			if (!pl) {
> +				bpf_cgroup_storage_free(storage);
>  				return -ENOMEM;
> +			}
>  			pl_was_allocated = true;
>  			list_add_tail(&pl->node, progs);
>  		} else {
>  			pl = list_first_entry(progs, typeof(*pl), node);
>  			old_prog = pl->prog;
> +			old_storage = pl->storage;
> +			bpf_cgroup_storage_unlink(old_storage);
>  			pl_was_allocated = false;
>  		}
>  		pl->prog = prog;
> +		pl->storage = storage;
>  	}
>  
>  	cgrp->bpf.flags[type] = flags;
> @@ -257,10 +273,13 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
>  	}
>  
>  	static_branch_inc(&cgroup_bpf_enabled_key);
> +	if (old_storage)
> +		bpf_cgroup_storage_free(old_storage);
>  	if (old_prog) {
>  		bpf_prog_put(old_prog);
>  		static_branch_dec(&cgroup_bpf_enabled_key);
>  	}
> +	bpf_cgroup_storage_link(storage, cgrp, type);
>  	return 0;
>  
>  cleanup:
> @@ -276,6 +295,9 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
>  
>  	/* and cleanup the prog list */
>  	pl->prog = old_prog;
> +	bpf_cgroup_storage_free(pl->storage);
> +	pl->storage = old_storage;
> +	bpf_cgroup_storage_link(old_storage, cgrp, type);
>  	if (pl_was_allocated) {
>  		list_del(&pl->node);
>  		kfree(pl);
> @@ -356,6 +378,8 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
>  
>  	/* now can actually delete it from this cgroup list */
>  	list_del(&pl->node);
> +	bpf_cgroup_storage_unlink(pl->storage);
> +	bpf_cgroup_storage_free(pl->storage);
>  	kfree(pl);
>  	if (list_empty(progs))
>  		/* last program was detached, reset flags to zero */
> 

