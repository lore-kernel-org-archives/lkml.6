Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbeFDTgB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:36:01 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35229 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeFDTf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:35:59 -0400
X-Google-Smtp-Source: ADUXVKIi74RMh1MxLYmp2A135EQEKVfIyIVvY2NZZDfdHjnWfY9hcp4YohwBC7DVABjHjV3GvTdc4g==
Date: Mon, 4 Jun 2018 12:35:55 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgoswami@codeaurora.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] rpmsg: smd: do not use mananged resources for
 endpoints and channels
Message-ID: <20180604193555.GB3206@builder>
References: <20180604093901.6963-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604093901.6963-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04 Jun 02:39 PDT 2018, Srinivas Kandagatla wrote:

> All the managed resources would be freed by the time release function
> is invoked. Handling such memory in qcom_smd_edge_release() would do
> bad things.
> 
> Found this issue while testing Audio usecase where the dsp is started up
> and shutdown in a loop.
> 
> This patch fixes this issue by using simple kzalloc for allocating
> channel->name and channel which is then freed in qcom_smd_edge_release().
> 
> Without this patch restarting a remoteproc would crash the system.
> Fixes: 53e2822e56c7 ("rpmsg: Introduce Qualcomm SMD backend")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thanks Srini,
Bjorn

> ---
>  drivers/rpmsg/qcom_smd.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
> index 5ce9bf7b897d..f63adcd95eb0 100644
> --- a/drivers/rpmsg/qcom_smd.c
> +++ b/drivers/rpmsg/qcom_smd.c
> @@ -1100,12 +1100,12 @@ static struct qcom_smd_channel *qcom_smd_create_channel(struct qcom_smd_edge *ed
>  	void *info;
>  	int ret;
>  
> -	channel = devm_kzalloc(&edge->dev, sizeof(*channel), GFP_KERNEL);
> +	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
>  	if (!channel)
>  		return ERR_PTR(-ENOMEM);
>  
>  	channel->edge = edge;
> -	channel->name = devm_kstrdup(&edge->dev, name, GFP_KERNEL);
> +	channel->name = kstrdup(name, GFP_KERNEL);
>  	if (!channel->name)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -1156,8 +1156,8 @@ static struct qcom_smd_channel *qcom_smd_create_channel(struct qcom_smd_edge *ed
>  	return channel;
>  
>  free_name_and_channel:
> -	devm_kfree(&edge->dev, channel->name);
> -	devm_kfree(&edge->dev, channel);
> +	kfree(channel->name);
> +	kfree(channel);
>  
>  	return ERR_PTR(ret);
>  }
> @@ -1378,13 +1378,13 @@ static int qcom_smd_parse_edge(struct device *dev,
>   */
>  static void qcom_smd_edge_release(struct device *dev)
>  {
> -	struct qcom_smd_channel *channel;
> +	struct qcom_smd_channel *channel, *tmp;
>  	struct qcom_smd_edge *edge = to_smd_edge(dev);
>  
> -	list_for_each_entry(channel, &edge->channels, list) {
> -		SET_RX_CHANNEL_INFO(channel, state, SMD_CHANNEL_CLOSED);
> -		SET_RX_CHANNEL_INFO(channel, head, 0);
> -		SET_RX_CHANNEL_INFO(channel, tail, 0);
> +	list_for_each_entry_safe(channel, tmp, &edge->channels, list) {
> +		list_del(&channel->list);
> +		kfree(channel->name);
> +		kfree(channel);
>  	}
>  
>  	kfree(edge);
> -- 
> 2.16.2
> 
