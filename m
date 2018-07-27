Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE016C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C4220673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C4220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389189AbeG0TYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 15:24:11 -0400
Received: from www62.your-server.de ([213.133.104.62]:57809 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbeG0TYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 15:24:11 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fj736-0001bS-AS; Fri, 27 Jul 2018 20:01:08 +0200
Received: from [99.0.85.34] (helo=localhost.localdomain)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fj736-000PLj-0E; Fri, 27 Jul 2018 20:01:08 +0200
Subject: Re: [PATCH v3 bpf-next 01/14] bpf: add ability to charge bpf maps
 memory dynamically
To:     Roman Gushchin <guro@fb.com>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexei Starovoitov <ast@kernel.org>
References: <20180720174558.5829-1-guro@fb.com>
 <20180720174558.5829-2-guro@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4f96442f-d9bc-c366-1dbd-17d4cc47783a@iogearbox.net>
Date:   Fri, 27 Jul 2018 20:01:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180720174558.5829-2-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24788/Fri Jul 27 18:45:51 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/2018 07:45 PM, Roman Gushchin wrote:
> This commits extends existing bpf maps memory charging API
> to support dynamic charging/uncharging.
> 
> This is required to account memory used by maps,
> if all entries are created dynamically after
> the map initialization.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> ---
>  include/linux/bpf.h  |  2 ++
>  kernel/bpf/syscall.c | 53 +++++++++++++++++++++++++++++++++++++---------------
>  2 files changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5b5ad95cf339..5a4a256473c3 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -435,6 +435,8 @@ struct bpf_map * __must_check bpf_map_inc(struct bpf_map *map, bool uref);
>  void bpf_map_put_with_uref(struct bpf_map *map);
>  void bpf_map_put(struct bpf_map *map);
>  int bpf_map_precharge_memlock(u32 pages);
> +int bpf_map_charge_memlock(struct bpf_map *map, u32 pages);
> +void bpf_map_uncharge_memlock(struct bpf_map *map, u32 pages);
>  void *bpf_map_area_alloc(size_t size, int numa_node);
>  void bpf_map_area_free(void *base);
>  void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr);
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index d10ecd78105f..cee452a19538 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -181,32 +181,55 @@ int bpf_map_precharge_memlock(u32 pages)
>  	return 0;
>  }
>  
> -static int bpf_map_charge_memlock(struct bpf_map *map)
> +static int bpf_charge_memlock(struct user_struct *user, u32 pages)
>  {
> -	struct user_struct *user = get_current_user();
> -	unsigned long memlock_limit;
> +	unsigned long memlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>  
> -	memlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +	if (atomic_long_add_return(pages, &user->locked_vm) > memlock_limit) {
> +		atomic_long_sub(pages, &user->locked_vm);
> +		return -EPERM;
> +	}
> +	return 0;
> +}
>  
> -	atomic_long_add(map->pages, &user->locked_vm);
> +static int bpf_map_init_memlock(struct bpf_map *map)
> +{
> +	struct user_struct *user = get_current_user();
> +	int ret;
>  
> -	if (atomic_long_read(&user->locked_vm) > memlock_limit) {
> -		atomic_long_sub(map->pages, &user->locked_vm);
> +	ret = bpf_charge_memlock(user, map->pages);
> +	if (ret) {
>  		free_uid(user);
> -		return -EPERM;
> +		return ret;
>  	}
>  	map->user = user;
> -	return 0;
> +	return ret;
>  }
>  
> -static void bpf_map_uncharge_memlock(struct bpf_map *map)
> +static void bpf_map_release_memlock(struct bpf_map *map)
>  {
>  	struct user_struct *user = map->user;
> -
> -	atomic_long_sub(map->pages, &user->locked_vm);
> +	atomic_long_sub(map->pages, &map->user->locked_vm);

Just a small nit since you're respinning anyway, could you also make a
proper destructor for the bpf_charge_memlock(), so we have a bpf_uncharge_memlock()
which this one here would be calling as well as ...

>  	free_uid(user);
>  }
>  
> +int bpf_map_charge_memlock(struct bpf_map *map, u32 pages)
> +{
> +	int ret;
> +
> +	ret = bpf_charge_memlock(map->user, pages);
> +	if (ret)
> +		return ret;
> +	map->pages += pages;
> +	return ret;
> +}
> +
> +void bpf_map_uncharge_memlock(struct bpf_map *map, u32 pages)
> +{
> +	atomic_long_sub(pages, &map->user->locked_vm);

... this one, so we hide the details there.

> +	map->pages -= pages;
> +}
> +
>  static int bpf_map_alloc_id(struct bpf_map *map)
>  {
>  	int id;
> @@ -256,7 +279,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
>  {
>  	struct bpf_map *map = container_of(work, struct bpf_map, work);
>  
> -	bpf_map_uncharge_memlock(map);
> +	bpf_map_release_memlock(map);
>  	security_bpf_map_free(map);
>  	/* implementation dependent freeing */
>  	map->ops->map_free(map);
> @@ -492,7 +515,7 @@ static int map_create(union bpf_attr *attr)
>  	if (err)
>  		goto free_map_nouncharge;
>  
> -	err = bpf_map_charge_memlock(map);
> +	err = bpf_map_init_memlock(map);
>  	if (err)
>  		goto free_map_sec;
>  
> @@ -515,7 +538,7 @@ static int map_create(union bpf_attr *attr)
>  	return err;
>  
>  free_map:
> -	bpf_map_uncharge_memlock(map);
> +	bpf_map_release_memlock(map);
>  free_map_sec:
>  	security_bpf_map_free(map);
>  free_map_nouncharge:
> 

