Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203ADC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED5120842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED5120842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeG0Fbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 01:31:33 -0400
Received: from www62.your-server.de ([213.133.104.62]:42788 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeG0Fbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 01:31:32 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fiu6I-0006pB-Mc; Fri, 27 Jul 2018 06:11:34 +0200
Received: from [99.0.85.34] (helo=localhost.localdomain)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fiu6I-000DGA-Bt; Fri, 27 Jul 2018 06:11:34 +0200
Subject: Re: [PATCH v3 bpf-next 02/14] bpf: introduce cgroup storage maps
To:     Roman Gushchin <guro@fb.com>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexei Starovoitov <ast@kernel.org>
References: <20180720174558.5829-1-guro@fb.com>
 <20180720174558.5829-3-guro@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a7bbd507-3de9-e574-7187-f7915add7474@iogearbox.net>
Date:   Fri, 27 Jul 2018 06:11:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180720174558.5829-3-guro@fb.com>
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
> This commit introduces BPF_MAP_TYPE_CGROUP_STORAGE maps:
> a special type of maps which are implementing the cgroup storage.
> 
> From the userspace point of view it's almost a generic
> hash map with the (cgroup inode id, attachment type) pair
> used as a key.
> 
> The only difference is that some operations are restricted:
>   1) a user can't create new entries,
>   2) a user can't remove existing entries.
> 
> The lookup from userspace is o(log(n)).
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Martin KaFai Lau <kafai@fb.com>

(First of all sorry for the late review, only limited availability this week
 on my side.)

> ---
>  include/linux/bpf-cgroup.h |  38 +++++
>  include/linux/bpf.h        |   1 +
>  include/linux/bpf_types.h  |   3 +
>  include/uapi/linux/bpf.h   |   6 +
>  kernel/bpf/Makefile        |   1 +
>  kernel/bpf/local_storage.c | 367 +++++++++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c      |  12 ++
>  7 files changed, 428 insertions(+)
>  create mode 100644 kernel/bpf/local_storage.c
> 
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 79795c5fa7c3..6b0e7bd4b154 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -3,19 +3,39 @@
>  #define _BPF_CGROUP_H
>  
>  #include <linux/jump_label.h>
> +#include <linux/rbtree.h>
>  #include <uapi/linux/bpf.h>
>  
[...]
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 15d69b278277..0b089ba4595d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5140,6 +5140,14 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
>  				return -E2BIG;
>  			}
>  
> +			if (map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE &&
> +			    bpf_cgroup_storage_assign(env->prog, map)) {
> +				verbose(env,
> +					"only one cgroup storage is allowed\n");
> +				fdput(f);
> +				return -EBUSY;
> +			}
> +
>  			/* hold the map. If the program is rejected by verifier,
>  			 * the map will be released by release_maps() or it
>  			 * will be used by the valid program until it's unloaded
> @@ -5148,6 +5156,10 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
>  			map = bpf_map_inc(map, false);
>  			if (IS_ERR(map)) {
>  				fdput(f);
> +				if (map->map_type ==
> +				    BPF_MAP_TYPE_CGROUP_STORAGE)
> +					bpf_cgroup_storage_release(env->prog,
> +								   map);

I think this behavior is a bit strange, meaning that we would reset the map via
bpf_cgroup_storage_release() in this case, but if we error out and exit in any
later instruction the prior bpf_cgroup_storage_assign() is not undone, meaning
at this point we have no other choice but to destroy the map since any later
BPF prog load with bpf_cgroup_storage_assign() attempt would fail with -EBUSY
even though it's not assigned anywhere, is that correct? Same also on any other
errors along the prog load path. E.g. say, as one example, your verifier buffer
is too small, so any retry with the very same program from loader side would fail
above due to different prog pointers?

>  				return PTR_ERR(map);
>  			}
>  			env->used_maps[env->used_map_cnt++] = map;
> 

