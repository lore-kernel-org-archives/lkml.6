Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbeEUQ0S (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 12:26:18 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46481 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752824AbeEUQ0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 12:26:15 -0400
X-Google-Smtp-Source: AB8JxZpuEa2m2FvsazKrjHpqUCG2lMKy6MtYA0B0UJXxIevT5V3qRI9Ux97h9/mQJ14cQe3Z3OuKFQ==
Date: Mon, 21 May 2018 09:26:11 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Alban Crequy <alban.crequy@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, cgroups@vger.kernel.org,
        Alban Crequy <alban@kinvolk.io>, tj@kernel.org
Subject: Re: [PATCH] [RFC] bpf: tracing: new helper bpf_get_current_cgroup_ino
Message-ID: <20180521162609.lpdrnozowmzdn57m@ast-mbp.dhcp.thefacebook.com>
References: <20180513173318.21680-1-alban@kinvolk.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180513173318.21680-1-alban@kinvolk.io>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 07:33:18PM +0200, Alban Crequy wrote:
>  
> +BPF_CALL_2(bpf_get_current_cgroup_ino, u32, hierarchy, u64, flags)
> +{
> +	// TODO: pick the correct hierarchy instead of the mem controller
> +	struct cgroup *cgrp = task_cgroup(current, memory_cgrp_id);
> +
> +	if (unlikely(!cgrp))
> +		return -EINVAL;
> +	if (unlikely(hierarchy))
> +		return -EINVAL;
> +	if (unlikely(flags))
> +		return -EINVAL;
> +
> +	return cgrp->kn->id.ino;

ino only is not enough to identify cgroup. It needs generation number too.
I don't quite see how hierarchy and flags can be used in the future.
Also why limit it to memcg?

How about something like this instead:

BPF_CALL_2(bpf_get_current_cgroup_id)
{
        struct cgroup *cgrp = task_dfl_cgroup(current);

        return cgrp->kn->id.id;
}
The user space can use fhandle api to get the same 64-bit id.
