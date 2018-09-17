Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCFFECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA652086E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Cxdw9ozq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Jkf/iRmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA652086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbeIRCnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:43:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46626 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeIRCnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:43:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F0F9660866; Mon, 17 Sep 2018 21:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537218859;
        bh=mzNmUdxWAWLjKLCJH4ZKluLP+JDNKXNaccuHM95Yb2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cxdw9ozqxOeRTtBcuH2thZ5oy9nl4LD2G3k7hOUeU1297tfmSrepqEhabD9oqYXcE
         4Q7Mcx6iKHd5lTn2X24Qkqoo5+jDVxOkJhf9ycWzdqc4OWdYB9yURJihMSs5COlDM/
         vQ8FOP03pfFmRQ8Cg2PkG+hoOWlrYe6woeWe0ZMs=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 158FD606FC;
        Mon, 17 Sep 2018 21:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537218857;
        bh=mzNmUdxWAWLjKLCJH4ZKluLP+JDNKXNaccuHM95Yb2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jkf/iRmVOZcUfs+mW+m8TY05XFy73KxZ5hpjU2nGfun0MQNqwdsxn4oY4duKZisJp
         kwOuLHubX7kv3Y0o9FLy83dL7HC3CFJgyqjrQn5tO1GnCPlC0/UmZdyECBop7c6MW7
         5SYwIjJUix+DD+IS+zM3XiYJ4aAUm9mqBIq3z9AE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 158FD606FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 17 Sep 2018 15:14:14 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v2 2/2] soc: qcom: cmd-db: Stop memcpy()ing in
 cmd_db_read_aux_data()
Message-ID: <20180917211414.GC6981@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>, Rob Clark <robdclark@gmail.com>
References: <20180917204007.250862-1-swboyd@chromium.org>
 <20180917204007.250862-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917204007.250862-3-swboyd@chromium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 01:40:07PM -0700, Stephen Boyd wrote:
> Let's change the function signature to return the pointer to memory or
> an error pointer on failure, and take an argument that lets us return
> the size of the aux data read. This way we can remove the
> cmd_db_read_aux_data_len() API entirely and also get rid of the memcpy
> operation from cmd_db to the caller.
> 
> Cc: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Jordan Crouse <jcrouse@codeaurora.org>
> Cc: Rob Clark <robdclark@gmail.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 34 ++++++++++-----------
>  drivers/soc/qcom/cmd-db.c             | 43 +++++----------------------
>  include/soc/qcom/cmd-db.h             | 12 ++------
>  3 files changed, 28 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index bbb8126ec5c5..e4387a3fa745 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -860,23 +860,23 @@ static int a6xx_gmu_memory_probe(struct a6xx_gmu *gmu)
>  }
>  
>  /* Get the list of RPMh voltage levels from cmd-db */
> -static int a6xx_gmu_rpmh_arc_cmds(const char *id, void *vals, int size)
> +static const u16 *a6xx_gmu_rpmh_arc_cmds(const char *id, int *size)
>  {
> -	u32 len = cmd_db_read_aux_data_len(id);
> -
> -	if (!len)
> -		return 0;
> -
> -	if (WARN_ON(len > size))
> -		return -EINVAL;
> -
> -	cmd_db_read_aux_data(id, vals, len);
> +	size_t len;
> +	const u16 *vals;
>  
> +	vals = cmd_db_read_aux_data(id, &len);
>  	/*
>  	 * The data comes back as an array of unsigned shorts so adjust the
>  	 * count accordingly
>  	 */
> -	return len >> 1;
> +	len >>= 1;
> +
> +	if (!len || WARN_ON(len > 16))
> +		len = 0;

I don't think we care any more about the size of the array since there isn't any
data being copied.

> +
> +	*size = len;
> +	return vals;
>  }

I'm not sure this function has any value any more. We could just call
cmd_db_read_aux_data() directly for each id and adjust the size on the fly
when we call a6xx_gmu_rpmh_arc_votes_init.

>  /* Return the 'arc-level' for the given frequency */
> @@ -907,8 +907,8 @@ static u32 a6xx_gmu_get_arc_level(struct device *dev, unsigned long freq)
>  
>  static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
>  		unsigned long *freqs, int freqs_count,
> -		u16 *pri, int pri_count,
> -		u16 *sec, int sec_count)
> +		const u16 *pri, int pri_count,
> +		const u16 *sec, int sec_count)
>  {
>  	int i, j;
>  
> @@ -970,14 +970,14 @@ static int a6xx_gmu_rpmh_votes_init(struct a6xx_gmu *gmu)
>  	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
>  	struct msm_gpu *gpu = &adreno_gpu->base;
>  
> -	u16 gx[16], cx[16], mx[16];
> +	const u16 *gx, *cx, *mx;
>  	u32 gxcount, cxcount, mxcount;
>  	int ret;
>  
>  	/* Get the list of available voltage levels for each component */
> -	gxcount = a6xx_gmu_rpmh_arc_cmds("gfx.lvl", gx, sizeof(gx));
> -	cxcount = a6xx_gmu_rpmh_arc_cmds("cx.lvl", cx, sizeof(cx));
> -	mxcount = a6xx_gmu_rpmh_arc_cmds("mx.lvl", mx, sizeof(mx));
> +	gx = a6xx_gmu_rpmh_arc_cmds("gfx.lvl", &gxcount);
> +	cx = a6xx_gmu_rpmh_arc_cmds("cx.lvl", &cxcount);
> +	mx = a6xx_gmu_rpmh_arc_cmds("mx.lvl", &mxcount);
>  
>  	/* Build the GX votes */
>  	ret = a6xx_gmu_rpmh_arc_votes_init(&gpu->pdev->dev, gmu->gx_arc_votes,
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index 5c9cc6824891..c701b3b010f1 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -192,55 +192,28 @@ EXPORT_SYMBOL(cmd_db_read_addr);
>  /**
>   * cmd_db_read_aux_data() - Query command db for aux data.
>   *
> - *  @id: Resource to retrieve AUX Data on.
> - *  @data: Data buffer to copy returned aux data to. Returns size on NULL
> - *  @len: Caller provides size of data buffer passed in.
> + *  @id: Resource to retrieve AUX Data on
> + *  @len: size of data buffer returned

Is the GPU the only consumer of this function?  Would it make more sense to
return the number of entries rather than the size? I would suppose that would
imply that the caller knows the size of the entries but we have to know that
anyway if we're going to walk the list.

>   *
> - *  Return: size of data on success, errno otherwise
> + *  Return: pointer to data on success, error pointer otherwise
>   */
> -int cmd_db_read_aux_data(const char *id, u8 *data, size_t len)
> +const void *cmd_db_read_aux_data(const char *id, size_t *len)
>  {
>  	int ret;
>  	const struct entry_header *ent;
>  	const struct rsc_hdr *rsc_hdr;
> -	u16 ent_len;
> -
> -	if (!data)
> -		return -EINVAL;
>  
>  	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
>  	if (ret)
> -		return ret;
> -
> -	ent_len = le16_to_cpu(ent->len);
> -	if (len < ent_len)
> -		return -EINVAL;
> +		return ERR_PTR(ret);
>  
> -	len = min_t(u16, ent_len, len);
> -	memcpy(data, rsc_offset(rsc_hdr, ent), len);
> +	if (len)
> +		*len = le16_to_cpu(ent->len);
>  
> -	return len;
> +	return rsc_offset(rsc_hdr, ent);
>  }
>  EXPORT_SYMBOL(cmd_db_read_aux_data);

<snip>

Jordan
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
