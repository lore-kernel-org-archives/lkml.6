Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933618AbeE2Lxq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:53:46 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39812 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933428AbeE2Lxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:53:43 -0400
X-Google-Smtp-Source: AB8JxZrptg8JGxfobwzL8Mi1ZRyQhT2POUCil0Tp6aCghUG0UM89/TBLlTqxwk1R4ANVsoaZIzXlbg==
Subject: Re: [PATCH 4/5] remoteproc: rename subdev probe and remove functions
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180515205345.8090-1-elder@linaro.org>
 <20180515205345.8090-5-elder@linaro.org>
 <dc10f869-48fb-84da-9df2-409d6c3568dc@st.com>
From: Alex Elder <elder@linaro.org>
Message-ID: <726fa7c1-dab8-c1e5-721a-2f60d7f967d8@linaro.org>
Date: Tue, 29 May 2018 06:53:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <dc10f869-48fb-84da-9df2-409d6c3568dc@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 04:12 AM, Arnaud Pouliquen wrote:
> Hello Alex
> 
> 
> We have the same needs (prepare unprepare steps) on our platform. We
> tested you core patches and they answers to our need.

I'm very glad to hear that.  Would you offer your "Tested-by" on these?

On your comment below, yes, I will re-send v2 and will separate the
core from the glink code.

Thanks.

					-Alex

> Just a remark below
> 
> On 05/15/2018 10:53 PM, Alex Elder wrote:
>> Rename functions used when subdevices are started and stopped to
>> reflect the new naming scheme.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> ---
>>  drivers/remoteproc/qcom_common.c     | 16 ++++++++--------
>>  drivers/remoteproc/remoteproc_core.c |  8 ++++----
>>  2 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
>> index 4ae87c5b8793..6f77840140bf 100644
>> --- a/drivers/remoteproc/qcom_common.c
>> +++ b/drivers/remoteproc/qcom_common.c
>> @@ -33,7 +33,7 @@
>>  
>>  static BLOCKING_NOTIFIER_HEAD(ssr_notifiers);
>>  
>> -static int glink_subdev_probe(struct rproc_subdev *subdev)
>> +static int glink_subdev_start(struct rproc_subdev *subdev)
>>  {
>>  	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
>>  
>> @@ -42,7 +42,7 @@ static int glink_subdev_probe(struct rproc_subdev *subdev)
>>  	return PTR_ERR_OR_ZERO(glink->edge);
>>  }
>>  
>> -static void glink_subdev_remove(struct rproc_subdev *subdev, bool crashed)
>> +static void glink_subdev_stop(struct rproc_subdev *subdev, bool crashed)
>>  {
>>  	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
>>  
>> @@ -64,8 +64,8 @@ void qcom_add_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glink)
>>  		return;
>>  
>>  	glink->dev = dev;
>> -	glink->subdev.start = glink_subdev_probe;
>> -	glink->subdev.stop = glink_subdev_remove;
>> +	glink->subdev.start = glink_subdev_start;
>> +	glink->subdev.stop = glink_subdev_stop;
>>  
>>  	rproc_add_subdev(rproc, &glink->subdev);
>>  }
>> @@ -129,7 +129,7 @@ int qcom_register_dump_segments(struct rproc *rproc,
>>  }
>>  EXPORT_SYMBOL_GPL(qcom_register_dump_segments);
>>  
>> -static int smd_subdev_probe(struct rproc_subdev *subdev)
>> +static int smd_subdev_start(struct rproc_subdev *subdev)
>>  {
>>  	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
>>  
>> @@ -138,7 +138,7 @@ static int smd_subdev_probe(struct rproc_subdev *subdev)
>>  	return PTR_ERR_OR_ZERO(smd->edge);
>>  }
>>  
>> -static void smd_subdev_remove(struct rproc_subdev *subdev, bool crashed)
>> +static void smd_subdev_stop(struct rproc_subdev *subdev, bool crashed)
>>  {
>>  	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
>>  
>> @@ -160,8 +160,8 @@ void qcom_add_smd_subdev(struct rproc *rproc, struct qcom_rproc_subdev *smd)
>>  		return;
>>  
>>  	smd->dev = dev;
>> -	smd->subdev.start = smd_subdev_probe;
>> -	smd->subdev.stop = smd_subdev_remove;
>> +	smd->subdev.start = smd_subdev_start;
>> +	smd->subdev.stop = smd_subdev_stop;
>>  
>>  	rproc_add_subdev(rproc, &smd->subdev);
>>  }
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index ca39fad175f2..2ede7ae6f5bc 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -301,14 +301,14 @@ void rproc_free_vring(struct rproc_vring *rvring)
>>  	rsc->vring[idx].notifyid = -1;
>>  }
>>  
>> -static int rproc_vdev_do_probe(struct rproc_subdev *subdev)
>> +static int rproc_vdev_do_start(struct rproc_subdev *subdev)
>>  {
>>  	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
>>  
>>  	return rproc_add_virtio_dev(rvdev, rvdev->id);
>>  }
>>  
>> -static void rproc_vdev_do_remove(struct rproc_subdev *subdev, bool crashed)
>> +static void rproc_vdev_do_stop(struct rproc_subdev *subdev, bool crashed)
>>  {
>>  	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
>>  
>> @@ -399,8 +399,8 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
>>  
>>  	list_add_tail(&rvdev->node, &rproc->rvdevs);
>>  
>> -	rvdev->subdev.start = rproc_vdev_do_probe;
>> -	rvdev->subdev.stop = rproc_vdev_do_remove;
>> +	rvdev->subdev.start = rproc_vdev_do_start;
>> +	rvdev->subdev.stop = rproc_vdev_do_stop;
>>  
>>  	rproc_add_subdev(rproc, &rvdev->subdev);
> 
> Could you split in 2 patches one for the core another, the other for the
> glink driver?
> 
> Regards
> Arnaud
> 
