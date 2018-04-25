Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbeDYNta (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:49:30 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:45168 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754043AbeDYNt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:49:28 -0400
Subject: Re: [PATCH] remoteproc: rename "crashed" parameter
To: Alex Elder <elder@linaro.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180425133626.11781-1-elder@linaro.org>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <93951de4-3758-0293-eeb1-bba9dd561c4b@st.com>
Date: Wed, 25 Apr 2018 15:49:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425133626.11781-1-elder@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alex,

I have already proposed it few weeks ago.

https://lkml.org/lkml/2018/4/10/192

could you ack it, if you test it on your side?

Thanks,
Arnaud

On 04/25/2018 03:36 PM, Alex Elder wrote:
> The last commit to "remoteproc_core.c":
>   880f5b388252 remoteproc: eAPass type of shutdown to subdev remove
> added a Boolean flag to the subdevice remove method, to distinguish
> between graceful shutdown and a crash.  Unfortunately, the names of
> the parameters were inconsistent, and in fact have opposite meanings.
> 
> In most cases, the parameter is named "crashed", but rproc_add_subdev()
> names the parameter "graceful" in the prototype for the remove method.
> 
> The remove method is ultimately called (and supplied with the Boolean
> flag value) by rproc_remove_subdevices().  That is only called by
> rproc_stop(), and in the two spots where that is used, "graceful" is
> the right name for the flag:
>   rproc_shutdown() passes true, indicating a graceful shutdown
>   rproc_trigger_recovery() passes false, indicating a crash
> 
> The fix is to make the parameter name consistent, and making the
> name and sense of the parameter to always be "crashed" produces the
> smallest change.  So that's what this patch does.
> 
> To verify this change, rproc_add_subdev() is called in five spots:
>   - qcom_add_glink_subdev() passes glink_subdev_remove()
>   - qcom_add_smd_subdev() passes smd_subdev_remove()
>   - qcom_add_ssr_subdev() passes ssr_notify_stop()
>   - qcom_add_sysmon_subdev() passes sysmon_stop()
>   - rproc_handle_vdev() passes rproc_vdev_do_remove()
> 
> Of these, only sysmon_stop() uses its "crashed" parameter.  And it
> clearly assumes that "crashed" is the intended meaning:
> 
>         /* Don't request graceful shutdown if we've crashed */
>         if (crashed)
>                 return;
> 
> So this function (added after the "crashed" parameter was added)
> exhibited buggy behavior, which is now fixed by this patch.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 4 ++--
>  include/linux/remoteproc.h           | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 6d9c5832ce47..a9609d971f7f 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1163,7 +1163,7 @@ int rproc_trigger_recovery(struct rproc *rproc)
>  	if (ret)
>  		return ret;
>  
> -	ret = rproc_stop(rproc, false);
> +	ret = rproc_stop(rproc, true);
>  	if (ret)
>  		goto unlock_mutex;
>  
> @@ -1316,7 +1316,7 @@ void rproc_shutdown(struct rproc *rproc)
>  	if (!atomic_dec_and_test(&rproc->power))
>  		goto out;
>  
> -	ret = rproc_stop(rproc, true);
> +	ret = rproc_stop(rproc, false);
>  	if (ret) {
>  		atomic_inc(&rproc->power);
>  		goto out;
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index d09a9c7af109..dfdaede9139e 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -569,7 +569,7 @@ static inline struct rproc *vdev_to_rproc(struct virtio_device *vdev)
>  void rproc_add_subdev(struct rproc *rproc,
>  		      struct rproc_subdev *subdev,
>  		      int (*probe)(struct rproc_subdev *subdev),
> -		      void (*remove)(struct rproc_subdev *subdev, bool graceful));
> +		      void (*remove)(struct rproc_subdev *subdev, bool crashed));
>  
>  void rproc_remove_subdev(struct rproc *rproc, struct rproc_subdev *subdev);
>  
> 
