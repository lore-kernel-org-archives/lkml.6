Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C60C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF08620878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF08620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933523AbeGJIDX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:03:23 -0400
Received: from www62.your-server.de ([213.133.104.62]:44606 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbeGJIDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:03:21 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fcncG-0000bt-4Z; Tue, 10 Jul 2018 10:03:20 +0200
Received: from [2a02:120b:c3f4:b8b0:b5ea:3969:d380:aafd] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fcncF-0004a0-Tb; Tue, 10 Jul 2018 10:03:19 +0200
Subject: Re: [PATCH bpf] bpf: fix some bad __rcu annotations in bpf/core.c
To:     Roman Gushchin <guro@fb.com>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexei Starovoitov <ast@kernel.org>, yhs@fb.com
References: <20180710015915.26358-1-guro@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <31c2b14a-8890-0ebd-bb59-01616e9d8d5d@iogearbox.net>
Date:   Tue, 10 Jul 2018 10:03:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180710015915.26358-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24739/Tue Jul 10 06:45:06 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On 07/10/2018 03:59 AM, Roman Gushchin wrote:
> Sparse shows some "incorrect type" warnings in the bpf core code.

Thanks for taking a stab at these! It would really help if you could
split the patch into a small series and fix each individual case that
is problematic here.

Please also add Fixes tags to the patches.

More below.

> They are caused by bad __rcu annotations:
> 1) bpf_prog_array_alloc() returns an __rcu pointer, which isn't true.
>    At that moment it's obviously an exclusive "owning" pointer,
>    which is valid for an infinite amount of time, so __rcu is
>    meaningless.
> 2) The progs local variable in compute_effective_progs should be
>    marked as __bpf too, it's a local variable, not shared with anyone

Typo: __bpf ?

>    else at all. The real __rcu variable is array pointer, which should
>    be assigned with rcu_assign_pointer.
> 3) __rcu progs argument of bpf_prog_array_free() should be casted
>    to a simple pointer before calling kfree_rcu().
> 4) There is a missing rcu_dereference() annotation in
>    bpf_prog_array_copy_to_user().
> 5) old_array __rcu pointer in bpf_prog_array_copy() is used as
>    a "normal" non-__rcu pointer.
> 
> These changes remove the following sparse warnings:
> kernel/bpf/core.c:1544:31: warning: incorrect type in return expression (different address spaces)
> kernel/bpf/core.c:1544:31:    expected struct bpf_prog_array [noderef] <asn:4>*
> kernel/bpf/core.c:1544:31:    got void *
> kernel/bpf/core.c:1548:17: warning: incorrect type in return expression (different address spaces)
> kernel/bpf/core.c:1548:17:    expected struct bpf_prog_array [noderef] <asn:4>*
> kernel/bpf/core.c:1548:17:    got struct bpf_prog_array *<noident>
> kernel/bpf/core.c:1556:9: warning: incorrect type in argument 1 (different address spaces)
> kernel/bpf/core.c:1556:9:    expected struct callback_head *head
> kernel/bpf/core.c:1556:9:    got struct callback_head [noderef] <asn:4>*<noident>
> kernel/bpf/core.c:1629:34: warning: incorrect type in initializer (different address spaces)
> kernel/bpf/core.c:1629:34:    expected struct bpf_prog **prog
> kernel/bpf/core.c:1629:34:    got struct bpf_prog *[noderef] <asn:4>*<noident>
> kernel/bpf/core.c:1653:31: warning: incorrect type in assignment (different address spaces)
> kernel/bpf/core.c:1653:31:    expected struct bpf_prog **existing_prog
> kernel/bpf/core.c:1653:31:    got struct bpf_prog *[noderef] <asn:4>*<noident>
> kernel/bpf/core.c:1681:15: warning: incorrect type in assignment (different address spaces)
> kernel/bpf/core.c:1681:15:    expected struct bpf_prog_array *array
> kernel/bpf/core.c:1681:15:    got struct bpf_prog_array [noderef] <asn:4>*
> kernel/bpf/core.c:1687:31: warning: incorrect type in assignment (different address spaces)
> kernel/bpf/core.c:1687:31:    expected struct bpf_prog **[assigned] existing_prog
> kernel/bpf/core.c:1687:31:    got struct bpf_prog *[noderef] <asn:4>*<noident>
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/bpf.h |  2 +-
>  kernel/bpf/cgroup.c |  7 +++----
>  kernel/bpf/core.c   | 14 ++++++++------
>  3 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8827e797ff97..943fb08d8287 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -352,7 +352,7 @@ struct bpf_prog_array {
>  	struct bpf_prog *progs[0];
>  };
>  
> -struct bpf_prog_array __rcu *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
> +struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
>  void bpf_prog_array_free(struct bpf_prog_array __rcu *progs);
>  int bpf_prog_array_length(struct bpf_prog_array __rcu *progs);
>  int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 3d83ee7df381..badabb0b435c 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -95,7 +95,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
>  				   enum bpf_attach_type type,
>  				   struct bpf_prog_array __rcu **array)
>  {
> -	struct bpf_prog_array __rcu *progs;
> +	struct bpf_prog_array *progs;
>  	struct bpf_prog_list *pl;
>  	struct cgroup *p = cgrp;
>  	int cnt = 0;
> @@ -120,13 +120,12 @@ static int compute_effective_progs(struct cgroup *cgrp,
>  					    &p->bpf.progs[type], node) {
>  				if (!pl->prog)
>  					continue;
> -				rcu_dereference_protected(progs, 1)->
> -					progs[cnt++] = pl->prog;
> +				progs->progs[cnt++] = pl->prog;
>  			}
>  		p = cgroup_parent(p);
>  	} while (p);
>  
> -	*array = progs;
> +	rcu_assign_pointer(*array, progs);
>  	return 0;
>  }
>  
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 1e5625d46414..f6e5b207a0d7 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1538,7 +1538,7 @@ static struct {
>  	.null_prog = NULL,
>  };
>  
> -struct bpf_prog_array __rcu *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
> +struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
>  {
>  	if (prog_cnt)
>  		return kzalloc(sizeof(struct bpf_prog_array) +
> @@ -1550,10 +1550,11 @@ struct bpf_prog_array __rcu *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)

Looks good to me to here.

>  void bpf_prog_array_free(struct bpf_prog_array __rcu *progs)
>  {
> -	if (!progs ||
> -	    progs == (struct bpf_prog_array __rcu *)&empty_prog_array.hdr)
> +	struct bpf_prog_array *array = rcu_access_pointer(progs);

Can you elaborate on the rcu_access_pointer() part? This looks odd, at minimum
this needs a comment explaining why it's needed. Is the __rcu annotation above
even correct?

> +
> +	if (!array || array == &empty_prog_array.hdr)
>  		return;
> -	kfree_rcu(progs, rcu);
> +	kfree_rcu(array, rcu);
>  }
>  
>  int bpf_prog_array_length(struct bpf_prog_array __rcu *progs)
> @@ -1626,7 +1627,7 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
>  void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *progs,
>  				struct bpf_prog *old_prog)
>  {
> -	struct bpf_prog **prog = progs->progs;
> +	struct bpf_prog **prog = rcu_dereference(progs)->progs;

Can you elaborate here as well? __rcu annotation buggy instead?

>  	for (; *prog; prog++)
>  		if (*prog == old_prog) {
> @@ -1635,11 +1636,12 @@ void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *progs,
>  		}
>  }
>  
> -int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
> +int bpf_prog_array_copy(struct bpf_prog_array __rcu *__old_array,
>  			struct bpf_prog *exclude_prog,
>  			struct bpf_prog *include_prog,
>  			struct bpf_prog_array **new_array)
>  {
> +	struct bpf_prog_array *old_array = rcu_access_pointer(__old_array);

Same comment here, this doesn't look right. We even fetch old_array->progs
from it later on in this path.

>  	int new_prog_cnt, carry_prog_cnt = 0;
>  	struct bpf_prog **existing_prog;
>  	struct bpf_prog_array *array;
> 

Thanks,
Daniel
