Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752397AbeCMIZK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:25:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49506 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbeCMIZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:25:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B5DFE60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tirupath@codeaurora.org
Subject: Re: [PATCH V1] Input: pm8941-pwrkey: add resin key capabilities
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1520410173-2507-1-git-send-email-tirupath@codeaurora.org>
 <20180307202147.GB195580@dtor-ws> <20180310182714.GD260013@dtor-ws>
From: Tirupathi Reddy T <tirupath@codeaurora.org>
Message-ID: <d0991385-d03b-a42e-9303-679f0c16de34@codeaurora.org>
Date: Tue, 13 Mar 2018 13:55:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310182714.GD260013@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 3/10/2018 11:57 PM, Dmitry Torokhov wrote:
> On Wed, Mar 07, 2018 at 12:21:47PM -0800, Dmitry Torokhov wrote:
>> Hi Tirupathi,
>>
>> On Wed, Mar 07, 2018 at 01:39:33PM +0530, Tirupathi Reddy wrote:
>>> Add resin key support to handle different types of key events
>>> defined in different platforms.
> Also, when you say "resin" key, I do not suppose it refers to teh
> material of the key, but rather have something to so with "reset in"
> signal or similar when is not actually used for resetting the device?
The resin is a "reset in" line to the "Power Management IC".
Usually in a regular usecase this line is used for "volume down key"
functionality and in other cases to reset the device on a long-press.
>>> Signed-off-by: Tirupathi Reddy <tirupath@codeaurora.org>
>>> ---
>>>   .../bindings/input/qcom,pm8941-pwrkey.txt          | 20 ++++++-
>>>   drivers/input/misc/pm8941-pwrkey.c                 | 63 +++++++++++++++++++++-
>>>   2 files changed, 81 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
>>> index 07bf55f..1c437e9 100644
>>> --- a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
>>> +++ b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
>>> @@ -20,6 +20,14 @@ PROPERTIES
>>>   		    defined by the binding document describing the node's
>>>   		    interrupt parent.
>>>   
>>> +- interrupt-names:
>>> +	Usage: required
>>> +	Value type: <stringlist>
>>> +	Definition: Interrupt names.  This list must match up 1-to-1 with the
>>> +		    interrupts specified in the 'interrupts' property. "kpdpwr"
>>> +		    must be specified.  "resin" may be specified for some
>>> +		    platforms.
>>> +
>>>   - debounce:
>>>   	Usage: optional
>>>   	Value type: <u32>
>>> @@ -32,12 +40,22 @@ PROPERTIES
>>>   	Definition: presence of this property indicates that the KPDPWR_N pin
>>>   		    should be configured for pull up.
>>>   
>>> +- linux,code:
>>> +	Usage: required for "resin" key
>>> +	Value type: <u32>
>>> +	Definition: The input key-code associated with the resin key.
>>> +		    Use the linux event codes defined in
>>> +		    include/dt-bindings/input/linux-event-codes.h
>>> +
>>>   EXAMPLE
>>>   
>>>   	pwrkey@800 {
>>>   		compatible = "qcom,pm8941-pwrkey";
>>>   		reg = <0x800>;
>>> -		interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
>>> +		interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>,
>>> +			     <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
>>> +		interrupt-names = "kpdpwr", "resin";
>>>   		debounce = <15625>;
>>>   		bias-pull-up;
>>> +		linux,code = <KEY_VOLUMEDOWN>;
>>>   	};
>>> diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
>>> index 18ad956..3f801cf 100644
>>> --- a/drivers/input/misc/pm8941-pwrkey.c
>>> +++ b/drivers/input/misc/pm8941-pwrkey.c
>>> @@ -28,6 +28,7 @@
>>>   
>>>   #define PON_RT_STS			0x10
>>>   #define  PON_KPDPWR_N_SET		BIT(0)
>>> +#define  PON_RESIN_N_SET		BIT(1)
>>>   
>>>   #define PON_PS_HOLD_RST_CTL		0x5a
>>>   #define PON_PS_HOLD_RST_CTL2		0x5b
>>> @@ -46,6 +47,8 @@
>>>   struct pm8941_pwrkey {
>>>   	struct device *dev;
>>>   	int irq;
>>> +	int resin_irq;
>>> +	u32 resin_key_code;
>>>   	u32 baseaddr;
>>>   	struct regmap *regmap;
>>>   	struct input_dev *input;
>>> @@ -130,6 +133,24 @@ static irqreturn_t pm8941_pwrkey_irq(int irq, void *_data)
>>>   	return IRQ_HANDLED;
>>>   }
>>>   
>>> +static irqreturn_t pm8941_resinkey_irq(int irq, void *_data)
>>> +{
>>> +	struct pm8941_pwrkey *pwrkey = _data;
>>> +	unsigned int sts;
>>> +	int error;
>>> +
>>> +	error = regmap_read(pwrkey->regmap,
>>> +			    pwrkey->baseaddr + PON_RT_STS, &sts);
>>> +	if (error)
>>> +		return IRQ_HANDLED;
>> It looks like you are reading the same register as the power on key.
>> Won't you lose events if both are pressed at the same time?
>>
>> I think you need a unified interrupt handler...
We are reading the real-time status register where both these
bits would be set and the PMIC arb would dispatch 2 interrupts.
>>> +
>>> +	input_report_key(pwrkey->input, pwrkey->resin_key_code,
>>> +			 !!(sts & PON_RESIN_N_SET));
>>> +	input_sync(pwrkey->input);
>>> +
>>> +	return IRQ_HANDLED;
>>> +}
>>> +
>>>   static int __maybe_unused pm8941_pwrkey_suspend(struct device *dev)
>>>   {
>>>   	struct pm8941_pwrkey *pwrkey = dev_get_drvdata(dev);
>>> @@ -153,6 +174,35 @@ static int __maybe_unused pm8941_pwrkey_resume(struct device *dev)
>>>   static SIMPLE_DEV_PM_OPS(pm8941_pwr_key_pm_ops,
>>>   			 pm8941_pwrkey_suspend, pm8941_pwrkey_resume);
>>>   
>>> +static int pm8941_resin_key_init(struct pm8941_pwrkey *pwrkey)
>>> +{
>>> +	int error;
>>> +
>>> +	/*
>>> +	 * Get the standard-key parameters. This might not be
>>> +	 * specified if there is no key mapping on the reset line.
>>> +	 */
>>> +	error = of_property_read_u32(pwrkey->dev->of_node, "linux,code",
>>> +			&pwrkey->resin_key_code);
>>> +	if (error) {
>>> +		dev_err(pwrkey->dev, "failed to read key-code for resin key\n");
>>> +		return error;
>>> +	}
>>> +
>>> +	/* Register key configuration */
>>> +	input_set_capability(pwrkey->input, EV_KEY, pwrkey->resin_key_code);
>>> +
>>> +	error = devm_request_threaded_irq(pwrkey->dev, pwrkey->resin_irq,
>>> +					  NULL, pm8941_resinkey_irq,
>>> +					  IRQF_ONESHOT,
>>> +					  "pm8941_resinkey", pwrkey);
>>> +	if (error)
>>> +		dev_err(pwrkey->dev, "failed requesting resin key IRQ: %d\n",
>>> +			error);
>>> +
>>> +	return error;
>>> +}
>>> +
>>>   static int pm8941_pwrkey_probe(struct platform_device *pdev)
>>>   {
>>>   	struct pm8941_pwrkey *pwrkey;
>>> @@ -182,7 +232,7 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>>>   		return -ENODEV;
>>>   	}
>>>   
>>> -	pwrkey->irq = platform_get_irq(pdev, 0);
>>> +	pwrkey->irq = platform_get_irq_byname(pdev, "kpdpwr");
>> You are breaking support for old DTS here I'm afraid.
Correct. The other way to address it is keep old code and enforce
kpdpwr interrupt should be the first one in interrupt list.

Addressed in Patch V2.
>>>   	if (pwrkey->irq < 0) {
>>>   		dev_err(&pdev->dev, "failed to get irq\n");
>>>   		return pwrkey->irq;
>>> @@ -241,6 +291,17 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>>>   		return error;
>>>   	}
>>>   
>>> +	pwrkey->resin_irq = platform_get_irq_byname(pdev, "resin");
>>> +	if (pwrkey->resin_irq >= 0) {
>> This is not entirely correct. I'd say if you have -ENXIO you can
>> conclude that the support for "resin" key is not enabled, but the rest
>> of the errors you should report up the stack. Deferrals will be retried
>> and other errors are fatal.
Addressed in Patch V2.
>>> +		/* resin key capabilities are defined in device node */
>>> +		error = pm8941_resin_key_init(pwrkey);
>>> +		if (error) {
>>> +			dev_err(&pdev->dev, "failed resin key initialization: %d\n",
>>> +				error);
>>> +			return error;
>>> +		}
>>> +	}
>>> +
>>>   	error = input_register_device(pwrkey->input);
>>>   	if (error) {
>>>   		dev_err(&pdev->dev, "failed to register input device: %d\n",
>>> -- 
>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>>>
>> Thanks.
>>
>> -- 
>> Dmitry
