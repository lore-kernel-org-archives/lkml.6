Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD829C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513AF2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOnv6sR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513AF2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbeI0Wut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:50:49 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51591 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeI0Wut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:50:49 -0400
Received: by mail-it1-f194.google.com with SMTP id 74-v6so6937504itw.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zrOR3Y7eMPYjw8UznjIjMGzzAkBQfeFWEjlOl3mv5gs=;
        b=kOnv6sR6hum/RGtORyQ96vC7RPLu/+IJAeoXDtCmcKfs/dA1o4ldcBCKThcdXezqaX
         SjfBHlPP7ALrKfYFLnC1DV7CacSc1y2xbXMwVXLRgJOBW2ofCqkCi00dCQyTtJJ5hWok
         G8aztS3cb0s1v6SFlh86sayGS29Lz8WbwUsAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zrOR3Y7eMPYjw8UznjIjMGzzAkBQfeFWEjlOl3mv5gs=;
        b=q/ikgUOODN8DnC9VUdqc+BrKquvNVB56v36gqxauDfG8TYuslywWAals6Aifp+G/yS
         TPnX3meKm+AGMc1XshzthhiqB3V4g+KucTLbAfkSzv4EWazPedvglIhFwAEOKQZ5mOe4
         JbgAjkixBnwU8Rv/hG+wS0PvNnqQztJ31/GeMoXtvnKtZ56DiDRIR9/McHmZc0f/sl+F
         Pum8IrLjuQMtXImdHHAmOr5GKSnUH3D2IH1+f8TpfuxTlQkwQie/9sQQz9y8DStL5gyn
         0AyJDiSkHNm9u783xLp0ul42FgT/pyyfL31YCmXobDWVdHhZwKZvS3qY2CNPLxazABZG
         rD+Q==
X-Gm-Message-State: ABuFfoihQZtxu3scA72KfGjvGNc/yhzYVDm6SjafwQWLcuhfTCzTxJrT
        RrMpe4dsuxU/XJVWD5O124F3DQ==
X-Google-Smtp-Source: ACcGV63lVF0pnBg2mrnWWP5dYMRMjFD1zwizs2fkT45XcoCC3kUjnNzlGG9X5syXP9Kv++R3UszRug==
X-Received: by 2002:a24:324e:: with SMTP id j75-v6mr9548534ita.100.1538065904845;
        Thu, 27 Sep 2018 09:31:44 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id h16-v6sm1293459iti.14.2018.09.27.09.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 09:31:43 -0700 (PDT)
Date:   Thu, 27 Sep 2018 10:31:41 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [QUEUED v20180920 01/16] stm class: Rework policy node fallback
Message-ID: <20180927163141.GA7481@xps15>
References: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
 <20180920124553.56978-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920124553.56978-2-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Thu, Sep 20, 2018 at 03:45:38PM +0300, Alexander Shishkin wrote:
> Currently, if no matching policy node can be found for a trace source,
> we'll try to use "default" policy node, then, if that doesn't exist,
> we'll pick the first node, in order of creation. If that also fails,
> we'll allocate M/C range from the beginning of the device's M/C range.
> 
> This makes it difficult to know which node (if any) was used in any
> particular case.
> 
> In order to make things more deterministic, the new order is as follows:
>   * if they supply ID string, use that and nothing else,
>   * if they are a task, use their task name (comm),
>   * use "default", if it exists,
>   * return failure, to let them know there is no suitable rule.

I am good with the "default" catch all clause but the change in behaviour has to
be documented.  Otherwise people can be mislead in thinking that a regression
has happened.

Before this patch:

root@nano:~# mkdir /sys/kernel/config/stp-policy/20100000.stm.test
root@nano:~# echo 20100000.stm > /sys/class/stm_source/ftrace/stm_source_link
root@linaro-nano:~# cat /sys/class/stm_source/ftrace/stm_source_link
20100000.stm

After this patch:
root@nano:~# mkdir /sys/kernel/config/stp-policy/20100000.stm.test
root@nano:~# echo 20100000.stm > /sys/class/stm_source/ftrace/stm_source_link
bash: echo: write error: Invalid argument
root@nano:~# mkdir /sys/kernel/config/stp-policy/20100000.stm.test/default
root@nano:~# echo 20100000.stm > /sys/class/stm_source/ftrace/stm_source_link
root@linaro-nano:~# cat /sys/class/stm_source/ftrace/stm_source_link
20100000.stm

> 
> This should provide enough convenience with the "default" catch-all node,
> while not leaving *everything* to chance. As a side effect, this relaxes
> the requirement of using ioctl() for identification with the possibility of
> using task names as policy nodes.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  drivers/hwtracing/stm/core.c   | 89 ++++++++++++++++++++--------------
>  drivers/hwtracing/stm/policy.c | 12 ++---
>  drivers/hwtracing/stm/stm.h    |  2 -
>  3 files changed, 58 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
> index 10bcb5d73f90..7b1c549d6320 100644
> --- a/drivers/hwtracing/stm/core.c
> +++ b/drivers/hwtracing/stm/core.c
> @@ -293,15 +293,15 @@ static int stm_output_assign(struct stm_device *stm, unsigned int width,
>  	if (width > stm->data->sw_nchannels)
>  		return -EINVAL;
>  
> -	if (policy_node) {
> -		stp_policy_node_get_ranges(policy_node,
> -					   &midx, &mend, &cidx, &cend);
> -	} else {
> -		midx = stm->data->sw_start;
> -		cidx = 0;
> -		mend = stm->data->sw_end;
> -		cend = stm->data->sw_nchannels - 1;
> -	}
> +	/* We no longer accept policy_node==NULL here */
> +	if (WARN_ON_ONCE(!policy_node))
> +		return -EINVAL;
> +
> +	/*
> +	 * Also, the caller holds reference to policy_node, so it won't
> +	 * disappear on us.
> +	 */
> +	stp_policy_node_get_ranges(policy_node, &midx, &mend, &cidx, &cend);
>  
>  	spin_lock(&stm->mc_lock);
>  	spin_lock(&output->lock);
> @@ -405,19 +405,30 @@ static int stm_char_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> -static int stm_file_assign(struct stm_file *stmf, char *id, unsigned int width)
> +static int
> +stm_assign_first_policy(struct stm_device *stm, struct stm_output *output,
> +			char **ids, unsigned int width)
>  {
> -	struct stm_device *stm = stmf->stm;
> -	int ret;
> +	struct stp_policy_node *pn;
> +	int err, n;
>  
> -	stmf->policy_node = stp_policy_node_lookup(stm, id);
> +	/*
> +	 * On success, stp_policy_node_lookup() will return holding the
> +	 * configfs subsystem mutex, which is then released in
> +	 * stp_policy_node_put(). This allows the pdrv->output_open() in
> +	 * stm_output_assign() to serialize against the attribute accessors.
> +	 */
> +	for (n = 0, pn = NULL; ids[n] && !pn; n++)
> +		pn = stp_policy_node_lookup(stm, ids[n]);
>  
> -	ret = stm_output_assign(stm, width, stmf->policy_node, &stmf->output);
> +	if (!pn)
> +		return -EINVAL;
>  
> -	if (stmf->policy_node)
> -		stp_policy_node_put(stmf->policy_node);
> +	err = stm_output_assign(stm, width, pn, output);
>  
> -	return ret;
> +	stp_policy_node_put(pn);
> +
> +	return err;
>  }
>  
>  static ssize_t notrace stm_write(struct stm_data *data, unsigned int master,
> @@ -455,16 +466,23 @@ static ssize_t stm_char_write(struct file *file, const char __user *buf,
>  		count = PAGE_SIZE - 1;
>  
>  	/*
> -	 * if no m/c have been assigned to this writer up to this
> -	 * point, use "default" policy entry
> +	 * If no m/c have been assigned to this writer up to this
> +	 * point, try to use the task name and "default" policy entries.
>  	 */
>  	if (!stmf->output.nr_chans) {
> -		err = stm_file_assign(stmf, "default", 1);
> +		char comm[sizeof(current->comm)];
> +		char *ids[] = { comm, "default", NULL };
> +
> +		get_task_comm(comm, current);
> +
> +		err = stm_assign_first_policy(stmf->stm, &stmf->output, ids, 1);
>  		/*
>  		 * EBUSY means that somebody else just assigned this
> -		 * output, which is just fine for write()
> +		 * output, which is just fine for write(), except for (XXX)
> +		 * it doesn't actually return -EBUSY, but -EINVAL and WARNs
> +		 * in this case. Hrrr.
>  		 */
> -		if (err && err != -EBUSY)
> +		if (err)
>  			return err;
>  	}
>  
> @@ -550,6 +568,7 @@ static int stm_char_policy_set_ioctl(struct stm_file *stmf, void __user *arg)
>  {
>  	struct stm_device *stm = stmf->stm;
>  	struct stp_policy_id *id;
> +	char *ids[] = { NULL, NULL };
>  	int ret = -EINVAL;
>  	u32 size;
>  
> @@ -582,7 +601,9 @@ static int stm_char_policy_set_ioctl(struct stm_file *stmf, void __user *arg)
>  	    id->width > PAGE_SIZE / stm->data->sw_mmiosz)
>  		goto err_free;
>  
> -	ret = stm_file_assign(stmf, id->id, id->width);
> +	ids[0] = id->id;
> +	ret = stm_assign_first_policy(stmf->stm, &stmf->output, ids,
> +				      id->width);
>  	if (ret)
>  		goto err_free;
>  
> @@ -818,8 +839,8 @@ EXPORT_SYMBOL_GPL(stm_unregister_device);
>  static int stm_source_link_add(struct stm_source_device *src,
>  			       struct stm_device *stm)
>  {
> -	char *id;
> -	int err;
> +	char *ids[] = { NULL, "default", NULL };
> +	int err = -ENOMEM;
>  
>  	mutex_lock(&stm->link_mutex);
>  	spin_lock(&stm->link_lock);
> @@ -833,19 +854,13 @@ static int stm_source_link_add(struct stm_source_device *src,
>  	spin_unlock(&stm->link_lock);
>  	mutex_unlock(&stm->link_mutex);
>  
> -	id = kstrdup(src->data->name, GFP_KERNEL);
> -	if (id) {
> -		src->policy_node =
> -			stp_policy_node_lookup(stm, id);
> -
> -		kfree(id);
> -	}
> -
> -	err = stm_output_assign(stm, src->data->nr_chans,
> -				src->policy_node, &src->output);
> +	ids[0] = kstrdup(src->data->name, GFP_KERNEL);
> +	if (!ids[0])
> +		goto fail_detach;
>  
> -	if (src->policy_node)
> -		stp_policy_node_put(src->policy_node);
> +	err = stm_assign_first_policy(stm, &src->output, ids,
> +				      src->data->nr_chans);
> +	kfree(ids[0]);
>  
>  	if (err)
>  		goto fail_detach;
> diff --git a/drivers/hwtracing/stm/policy.c b/drivers/hwtracing/stm/policy.c
> index 3fd07e275b34..15d35d891643 100644
> --- a/drivers/hwtracing/stm/policy.c
> +++ b/drivers/hwtracing/stm/policy.c
> @@ -392,7 +392,7 @@ static struct configfs_subsystem stp_policy_subsys = {
>  static struct stp_policy_node *
>  __stp_policy_node_lookup(struct stp_policy *policy, char *s)
>  {
> -	struct stp_policy_node *policy_node, *ret;
> +	struct stp_policy_node *policy_node, *ret = NULL;
>  	struct list_head *head = &policy->group.cg_children;
>  	struct config_item *item;
>  	char *start, *end = s;
> @@ -400,10 +400,6 @@ __stp_policy_node_lookup(struct stp_policy *policy, char *s)
>  	if (list_empty(head))
>  		return NULL;
>  
> -	/* return the first entry if everything else fails */
> -	item = list_entry(head->next, struct config_item, ci_entry);
> -	ret = to_stp_policy_node(item);
> -
>  next:
>  	for (;;) {
>  		start = strsep(&end, "/");
> @@ -449,13 +445,17 @@ stp_policy_node_lookup(struct stm_device *stm, char *s)
>  
>  	if (policy_node)
>  		config_item_get(&policy_node->group.cg_item);
> -	mutex_unlock(&stp_policy_subsys.su_mutex);
> +	else
> +		mutex_unlock(&stp_policy_subsys.su_mutex);
>  
>  	return policy_node;
>  }
>  
>  void stp_policy_node_put(struct stp_policy_node *policy_node)
>  {
> +	lockdep_assert_held(&stp_policy_subsys.su_mutex);
> +
> +	mutex_unlock(&stp_policy_subsys.su_mutex);
>  	config_item_put(&policy_node->group.cg_item);
>  }
>  
> diff --git a/drivers/hwtracing/stm/stm.h b/drivers/hwtracing/stm/stm.h
> index 923571adc6f4..e5df08ae59cf 100644
> --- a/drivers/hwtracing/stm/stm.h
> +++ b/drivers/hwtracing/stm/stm.h
> @@ -57,7 +57,6 @@ struct stm_output {
>  
>  struct stm_file {
>  	struct stm_device	*stm;
> -	struct stp_policy_node	*policy_node;
>  	struct stm_output	output;
>  };
>  
> @@ -71,7 +70,6 @@ struct stm_source_device {
>  	struct stm_device __rcu	*link;
>  	struct list_head	link_entry;
>  	/* one output per stm_source device */
> -	struct stp_policy_node	*policy_node;
>  	struct stm_output	output;
>  };
>  
> -- 
> 2.18.0
> 
