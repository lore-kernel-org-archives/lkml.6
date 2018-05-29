Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964983AbeE2Po6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:44:58 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50972 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935333AbeE2Poy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:44:54 -0400
From: Fabien DESSENNE <fabien.dessenne@st.com>
To: Alex Elder <elder@linaro.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>
CC: "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] remoteproc: Introduce prepare and unprepare for
 subdevices
Thread-Topic: [PATCH 5/5] remoteproc: Introduce prepare and unprepare for
 subdevices
Thread-Index: AQHT92Frw9uXdjnJHEu8kI0cFnjdMaRGs4eAgAAAgYCAAAOjAA==
Date: Tue, 29 May 2018 15:44:51 +0000
Message-ID: <ffa85ea6-fc01-b853-d89e-fec7ae7a90a4@st.com>
References: <20180515205345.8090-1-elder@linaro.org>
 <20180515205345.8090-6-elder@linaro.org>
 <90ecf369-517c-1741-0af2-c1988986d2a9@st.com>
 <872c26d7-52ff-d82f-373e-236fd713ec33@st.com>
 <b4497e23-fbc2-e739-07ed-af78273cce09@linaro.org>
In-Reply-To: <b4497e23-fbc2-e739-07ed-af78273cce09@linaro.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B7F6B418CA96A4E97BC53A469A0CEF9@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4TFjUsd001277

Hi Alex,


That's the correct syntax (I wrote it with the official form a few lines 
later (after the Signed-off-by / Acked-by)).

You can add it to the full patch set (although I tested only the core 
part + the future ST driver part)

BR


Fabien



On 29/05/18 17:31, Alex Elder wrote:
> On 05/29/2018 10:30 AM, Fabien DESSENNE wrote:
>> Hi,
>>
>> Adding my 'Tested-by'.
> Normally you would say:
>
>      Tested-by: Fabien DESSENNE <fabien.dessenne@st.com>
>
> The reason it might be important is you might wish to indicate the
> name and/or e-mail as something different from what you're now
> sending from.
>
> Is what I wrote above the way you would like it to appear?
>
> I will add that line to every one of my patches when I update them.
>
> Thanks.
>
> 					-Alex
>> BR,
>>
>> Fabien
>>
>>
>> On 29/05/18 17:26, Arnaud Pouliquen wrote:
>>> Hi Fabien,
>>> Please , could you add your "Tested-by" as you test it on ST platform?
>>>
>>> Thanks
>>> Arnaud
>>>
>>> On 05/15/2018 10:53 PM, Alex Elder wrote:
>>>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>>
>>>> On rare occasions a subdevice might need to prepare some hardware
>>>> resources before a remote processor is booted, and clean up some
>>>> state after it has been shut down.
>>>>
>>>> One such example is the IP Accelerator found in various Qualcomm
>>>> platforms, which is accessed directly from both the modem remoteproc
>>>> and the application subsystem and requires an intricate lockstep
>>>> process when bringing the modem up and down.
>>>>
>>>> [elder@linaro.org: minor description and comment edits]
>>>>
>>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>> Acked-by: Alex Elder <elder@linaro.org>
>> Tested-by: Fabien Dessenne <fabien.dessenne@st.com>
>>
>>>> ---
>>>>    drivers/remoteproc/remoteproc_core.c | 56 ++++++++++++++++++++++++++--
>>>>    include/linux/remoteproc.h           |  4 ++
>>>>    2 files changed, 57 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>>>> index 2ede7ae6f5bc..283b258f5e0f 100644
>>>> --- a/drivers/remoteproc/remoteproc_core.c
>>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>>> @@ -776,6 +776,30 @@ static int rproc_handle_resources(struct rproc *rproc,
>>>>    	return ret;
>>>>    }
>>>>    
>>>> +static int rproc_prepare_subdevices(struct rproc *rproc)
>>>> +{
>>>> +	struct rproc_subdev *subdev;
>>>> +	int ret;
>>>> +
>>>> +	list_for_each_entry(subdev, &rproc->subdevs, node) {
>>>> +		if (subdev->prepare) {
>>>> +			ret = subdev->prepare(subdev);
>>>> +			if (ret)
>>>> +				goto unroll_preparation;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +
>>>> +unroll_preparation:
>>>> +	list_for_each_entry_continue_reverse(subdev, &rproc->subdevs, node) {
>>>> +		if (subdev->unprepare)
>>>> +			subdev->unprepare(subdev);
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>>    static int rproc_start_subdevices(struct rproc *rproc)
>>>>    {
>>>>    	struct rproc_subdev *subdev;
>>>> @@ -810,6 +834,16 @@ static void rproc_stop_subdevices(struct rproc *rproc, bool crashed)
>>>>    	}
>>>>    }
>>>>    
>>>> +static void rproc_unprepare_subdevices(struct rproc *rproc)
>>>> +{
>>>> +	struct rproc_subdev *subdev;
>>>> +
>>>> +	list_for_each_entry_reverse(subdev, &rproc->subdevs, node) {
>>>> +		if (subdev->unprepare)
>>>> +			subdev->unprepare(subdev);
>>>> +	}
>>>> +}
>>>> +
>>>>    /**
>>>>     * rproc_coredump_cleanup() - clean up dump_segments list
>>>>     * @rproc: the remote processor handle
>>>> @@ -902,11 +936,18 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>>>>    		rproc->table_ptr = loaded_table;
>>>>    	}
>>>>    
>>>> +	ret = rproc_prepare_subdevices(rproc);
>>>> +	if (ret) {
>>>> +		dev_err(dev, "failed to prepare subdevices for %s: %d\n",
>>>> +			rproc->name, ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>>    	/* power up the remote processor */
>>>>    	ret = rproc->ops->start(rproc);
>>>>    	if (ret) {
>>>>    		dev_err(dev, "can't start rproc %s: %d\n", rproc->name, ret);
>>>> -		return ret;
>>>> +		goto unprepare_subdevices;
>>>>    	}
>>>>    
>>>>    	/* Start any subdevices for the remote processor */
>>>> @@ -914,8 +955,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>>>>    	if (ret) {
>>>>    		dev_err(dev, "failed to probe subdevices for %s: %d\n",
>>>>    			rproc->name, ret);
>>>> -		rproc->ops->stop(rproc);
>>>> -		return ret;
>>>> +		goto stop_rproc;
>>>>    	}
>>>>    
>>>>    	rproc->state = RPROC_RUNNING;
>>>> @@ -923,6 +963,14 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>>>>    	dev_info(dev, "remote processor %s is now up\n", rproc->name);
>>>>    
>>>>    	return 0;
>>>> +
>>>> +stop_rproc:
>>>> +	rproc->ops->stop(rproc);
>>>> +
>>>> +unprepare_subdevices:
>>>> +	rproc_unprepare_subdevices(rproc);
>>>> +
>>>> +	return ret;
>>>>    }
>>>>    
>>>>    /*
>>>> @@ -1035,6 +1083,8 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
>>>>    		return ret;
>>>>    	}
>>>>    
>>>> +	rproc_unprepare_subdevices(rproc);
>>>> +
>>>>    	rproc->state = RPROC_OFFLINE;
>>>>    
>>>>    	dev_info(dev, "stopped remote processor %s\n", rproc->name);
>>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>>> index 8f1426330cca..e3c5d856b6da 100644
>>>> --- a/include/linux/remoteproc.h
>>>> +++ b/include/linux/remoteproc.h
>>>> @@ -477,15 +477,19 @@ struct rproc {
>>>>    /**
>>>>     * struct rproc_subdev - subdevice tied to a remoteproc
>>>>     * @node: list node related to the rproc subdevs list
>>>> + * @prepare: prepare function, called before the rproc is started
>>>>     * @start: start function, called after the rproc has been started
>>>>     * @stop: stop function, called before the rproc is stopped; the @crashed
>>>>     *	    parameter indicates if this originates from a recovery
>>>> + * @unprepare: unprepare function, called after the rproc has been stopped
>>>>     */
>>>>    struct rproc_subdev {
>>>>    	struct list_head node;
>>>>    
>>>> +	int (*prepare)(struct rproc_subdev *subdev);
>>>>    	int (*start)(struct rproc_subdev *subdev);
>>>>    	void (*stop)(struct rproc_subdev *subdev, bool crashed);
>>>> +	void (*unprepare)(struct rproc_subdev *subdev);
>>>>    };
>>>>    
>>>>    /* we currently support only two vrings per rvdev */
>>>>
