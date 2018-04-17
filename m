Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752707AbeDQWMp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 18:12:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35256 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeDQWMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 18:12:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Apr 2018 15:12:42 -0700
From: rishabhb@codeaurora.org
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm@lists.infradead.org,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        kyan@codeaurora.org, ckadabi@codeaurora.org,
        stanimir.varbanov@linaro.org, evgreen@chromium.org
Subject: Re: [PATCH v4 1/2] Documentation: Documentation for qcom, llcc
In-Reply-To: <9a9ffe61f85dd28199bcc2d449097059@codeaurora.org>
References: <1523390893-10904-1-git-send-email-rishabhb@codeaurora.org>
 <1523390893-10904-2-git-send-email-rishabhb@codeaurora.org>
 <20180416145912.ja7d2xd2kqiukrgl@rob-hp-laptop>
 <9a9ffe61f85dd28199bcc2d449097059@codeaurora.org>
Message-ID: <1d31f2d727d32922aaf98c345723229e@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-17 10:43, rishabhb@codeaurora.org wrote:
> On 2018-04-16 07:59, Rob Herring wrote:
>> On Tue, Apr 10, 2018 at 01:08:12PM -0700, Rishabh Bhatnagar wrote:
>>> Documentation for last level cache controller device tree bindings,
>>> client bindings usage examples.
>> 
>> "Documentation: Documentation ..."? That wastes a lot of the subject
>> line... The preferred prefix is "dt-bindings: ..."
>> 
>>> 
>>> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
>>> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>>> ---
>>>  .../devicetree/bindings/arm/msm/qcom,llcc.txt      | 58 
>>> ++++++++++++++++++++++
>>>  1 file changed, 58 insertions(+)
>>>  create mode 100644 
>>> Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
>>> 
>>> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt 
>>> b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
>>> new file mode 100644
>>> index 0000000..497cf0f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
>>> @@ -0,0 +1,58 @@
>>> +== Introduction==
>>> +
>>> +LLCC (Last Level Cache Controller) provides last level of cache 
>>> memory in SOC,
>>> +that can be shared by multiple clients. Clients here are different 
>>> cores in the
>>> +SOC, the idea is to minimize the local caches at the clients and 
>>> migrate to
>>> +common pool of memory
>>> +
>>> +Properties:
>>> +- compatible:
>>> +	 Usage: required
>>> +	 Value type: <string>
>>> +	 Definition: must be "qcom,sdm845-llcc"
>>> +
>>> +- reg:
>>> +	 Usage: required
>>> +	 Value Type: <prop-encoded-array>
>>> +	 Definition: must be addresses and sizes of the LLCC registers
>> 
>> How many address ranges?
>> 
> It consists of just one address range. I'll edit the definition to make
> it more clear.
>>> +
>>> +- #cache-cells:
>> 
>> This is all written as it is a common binding, but it is not one.
>> 
>> You already have most of the configuration data for each client in the
>> driver, I think I'd just put the client connection there too. Is there
>> any variation of this for a given SoC?
>> 
> #cache-cells and max-slices won't change for a given SOC. So you want 
> me
> to hard-code in the driver itself?
> 
I can use of_parse_phandle_with_fixed_args function and fix the number 
of
args as 1 instead of keeping #cache-cells here in DT. Does that look 
fine?
>>> +	 Usage: required
>>> +	 Value Type: <u32>
>>> +	 Definition: Number of cache cells, must be 1
>>> +
>>> +- max-slices:
>>> +	 usage: required
>>> +	 Value Type: <u32>
>>> +	 Definition: Number of cache slices supported by hardware
>> 
>> What's a slice?
>> 
> System cache memory provided by LLCC is divided into smaller chunks
> called slices. Each slice has its associated size and ID. Clients can
> query slice details, activate and deactivate them.
>>> +
>>> +Example:
>>> +
>>> +	llcc: qcom,llcc@1100000 {
>>> +		compatible = "qcom,sdm845-llcc";
>>> +		reg = <0x1100000 0x250000>;
>>> +		#cache-cells = <1>;
>>> +		max-slices = <32>;
>>> +	};
>>> +
>>> +== Client ==
>>> +
>>> +Properties:
>>> +- cache-slice-names:
>>> +	 Usage: required
>>> +	 Value type: <stringlist>
>>> +	 Definition: A set of names that identify the usecase names of a
>>> +			client that uses cache slice. These strings are
>>> +			used to look up the cache slice entries by name.
>>> +
>>> +- cache-slices:
>>> +	 Usage: required
>>> +	 Value type: <prop-encoded-array>
>>> +	 Definition: The tuple has phandle to llcc device as the first
>>> +			argument and the second argument is the usecase
>>> +			id of the client.
>>> +For Example:
>>> +	venus {
>>> +		cache-slice-names = "vidsc0", "vidsc1";
>>> +	 	cache-slices = <&llcc VIDSC0_ID>, <&llcc VIDSC1_ID>;
>>> +	};
>>> --
>>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>>> Forum,
>>> a Linux Foundation Collaborative Project
>>> 
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe devicetree" 
>>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
