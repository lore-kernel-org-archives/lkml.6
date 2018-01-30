Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbeA3HWB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 02:22:01 -0500
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:56834 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751510AbeA3HWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 02:22:00 -0500
Subject: Re: [PATCH 8/8] platform: vivid-cec: fix potential integer overflow
 in vivid_cec_pin_adap_events
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
References: <cover.1517268667.git.gustavo@embeddedor.com>
 <00eea53890802b679c138fc7f68a0f162261d95c.1517268668.git.gustavo@embeddedor.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <2e1afa55-d214-f932-4ba7-2e21f6a2cd3d@xs4all.nl>
Date: Tue, 30 Jan 2018 08:21:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <00eea53890802b679c138fc7f68a0f162261d95c.1517268668.git.gustavo@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHU+H4pqDI+s8aHQqbKoPgLGb4VmHZ/aesZgqxTgKITUMWzO6//bBJjms6v36cU1zGzdv5nQknR9RZH7ksI3eCKou6D58Es5Hf+O1+B0xhIungCwGq42
 ly6jJD21wKn4BKQV1qXoSwcZGBlyHjmaQMMVr1onBSG8JybJNqtvknac1Bx2jzAv+4bnEtmzhD3sjnstOGzFxptVINMf0xB0jfWcnwfPmYGEkpKpwhWRyJbz
 WOzWsOWfLIxrqiGj+N2W6aKrfoPrR2uwnF6cApiiYGZ8TtzTfy/k67AZa+fftva8pi+nnIHJsNAeks8/AvHCgQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On 01/30/2018 01:33 AM, Gustavo A. R. Silva wrote:
> Cast len to const u64 in order to avoid a potential integer
> overflow. This variable is being used in a context that expects
> an expression of type const u64.
> 
> Addresses-Coverity-ID: 1454996 ("Unintentional integer overflow")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/media/platform/vivid/vivid-cec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/vivid/vivid-cec.c b/drivers/media/platform/vivid/vivid-cec.c
> index b55d278..30240ab 100644
> --- a/drivers/media/platform/vivid/vivid-cec.c
> +++ b/drivers/media/platform/vivid/vivid-cec.c
> @@ -83,7 +83,7 @@ static void vivid_cec_pin_adap_events(struct cec_adapter *adap, ktime_t ts,
>  	if (adap == NULL)
>  		return;
>  	ts = ktime_sub_us(ts, (CEC_TIM_START_BIT_TOTAL +
> -			       len * 10 * CEC_TIM_DATA_BIT_TOTAL));
> +			       (const u64)len * 10 * CEC_TIM_DATA_BIT_TOTAL));

This makes no sense. Certainly the const part is pointless. And given that
len is always <= 16 there definitely is no overflow.

I don't really want this cast in the code.

Sorry,

	Hans

>  	cec_queue_pin_cec_event(adap, false, ts);
>  	ts = ktime_add_us(ts, CEC_TIM_START_BIT_LOW);
>  	cec_queue_pin_cec_event(adap, true, ts);
> 
