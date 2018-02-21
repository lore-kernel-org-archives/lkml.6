Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519212926; cv=none;
        d=google.com; s=arc-20160816;
        b=yzZN4Wt7nsQjJP8dnyk8gj0xJyBYbhYUzHeg/2iBwQfSgBTcnXGhyomRB69IrKM4PG
         y4qYNBCAmFXsZSPiSAUQfAXtQGypExAKyRMmf+LWWkclZJGw84gvjd59q5wVQsZlLs1k
         AxIb/LqpJsjqMqkguwCwtbVXkvLFrYHr3hqnMJJStoqXKQVS6XpqoP7B8gSSjI4uZXu1
         HRXD5XS/MfwP4CTZOxQluPrsDGfhsv7xZIgaXhS5vmR7e2/AOMDlTgE9AnUxsHM5a66I
         Dhrkg1G79cTcPBpflcutRPHs1QkhXI+Yt35GoNQo7MfHjGzCAYaw4ZIwYPI7V4X/dQfW
         4yUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=DUk37AtOepqKt6B2Z0ndLLny2iwPmI5kdc1hlZhvB2o=;
        b=CdnDGs6TB4++Tw1XL6N562AkeevfA+T/gj+Fu2Lofz5abWBEcGysNXrQX5wL84KIiR
         EVWGsohFLTn9sbfZw4cr9TnYJy5MjJ90OS3Q72k75PLJp+7EfjMt5DFt5Dm4tLnwsQcL
         R6xXHh8b94qEvI80BvyAEeARJ09pRi8J03wq4BBPeVF8pus8dSP+PQH8qQKHXGCoN6D9
         a5+NjugiIxulRTUOKYL/nivFU9OkLo5V2av2IRDPmjA3LMRLAeLm3+vSmQasK655Ynhs
         ZWCBWwIBHsGXrJUVrKPQNuGMxc1sI8Bl1m1TFwD1xL8R0b6rHuBcGsc1VWwe6LYGntET
         wq8w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=cevmQQe1;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=cevmQQe1;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELs7K/R4HCksr3uZsbFTuGN0yqoN9mYXyjBTOokU/PvM4Zf95su818G+g6LgP2SpqBuZuhcpq4K0ruZJKc/tsA0=
MIME-Version: 1.0
In-Reply-To: <20180219181159.tzbhhvbvpc236qma@rob-hp-laptop>
References: <7fc26df245d56fd2014532b56e67630e76e2c513.1518316248.git.baolin.wang@linaro.org>
 <20180219181159.tzbhhvbvpc236qma@rob-hp-laptop>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 21 Feb 2018 19:35:26 +0800
Message-ID: <CAMz4kuL-VZ8XY5-ZLWfXLVXWb4zmxD-aaLQ-ka9M8V83y1B7Ag@mail.gmail.com>
Subject: Re: [PATCH v2] Input: gpio_keys: Add level trigger support for GPIO keys
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
	Greg KH <gregkh@linuxfoundation.org>, stephen lu <lumotuwe@gmail.com>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>, Joseph Lo <josephl@nvidia.com>,
	Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-input@vger.kernel.org,
	DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591902511604872416?=
X-GMAIL-MSGID: =?utf-8?q?1593010213698726021?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Rob,

On 20 February 2018 at 02:11, Rob Herring <robh@kernel.org> wrote:
> On Sun, Feb 11, 2018 at 02:55:04PM +0800, Baolin Wang wrote:
>> On some platforms (such as Spreadtrum platform), the GPIO keys can only
>> be triggered by level type. So this patch introduces one property to
>> indicate if the GPIO trigger type is level trigger or edge trigger.
>
> If the parent interrupt controller only supports a certain trigger, then
> it should ignore setting the trigger type.

We still need to set high level type trigger or low level type trigger
if it only supports level trigger.

>
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Changes since v1:
>>  - Diable the GPIO irq until reversing the GPIO level type.
>> ---
>>  .../devicetree/bindings/input/gpio-keys.txt        |    2 ++
>>  drivers/input/keyboard/gpio_keys.c                 |   26 +++++++++++++++++++-
>>  include/linux/gpio_keys.h                          |    1 +
>>  3 files changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
>> index a949404..e3104bd 100644
>> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
>> @@ -29,6 +29,8 @@ Optional subnode-properties:
>>       - linux,can-disable: Boolean, indicates that button is connected
>>         to dedicated (not shared) interrupt which can be disabled to
>>         suppress events from the button.
>> +     - gpio-key,level-trigger: Boolean, indicates that button's interrupt
>> +       type is level trigger. Otherwise it is edge trigger as default.
>
> No. Just use 'interrupts' instead of 'gpios' and specify the trigger
> type. Or put both if you need to read the state.

Okay, so something as below to get the level type from the
'interrupts' property.
if (fwnode_property_read_u32(child, "interrupts", &button->level_type))
        button->level_type = IRQ_TYPE_NONE;

-- 
Baolin.wang
Best Regards
