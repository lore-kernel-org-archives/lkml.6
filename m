Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeFESyl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:54:41 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com ([46.30.210.185]:10992
        "EHLO mailrelay4-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751823AbeFESyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:54:39 -0400
X-HalOne-Cookie: a1baff992037b3e5f4264410afd75ae66ee173c7
X-HalOne-ID: e4c83567-68f1-11e8-a32f-d0431ea8bb10
Subject: Re: [RFC/PATCH] Input: make input_report_slot_state() return boolean
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20180605171604.GA221901@dtor-ws>
From: Henrik Rydberg <rydberg@bitmath.org>
Message-ID: <4d841422-9bc1-1558-d8fb-a450cbec5279@bitmath.org>
Date: Tue, 5 Jun 2018 20:54:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180605171604.GA221901@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 07:16 PM, Dmitry Torokhov wrote:

> Let's make input_report_slot_state() return boolean representing whether
> the contact is active or not. This will allow writing code like:
>
> 	if (input_mt_report_slot_state(input, obj->mt_tool,
> 					obj->type != RMI_2D_OBJECT_NONE) {
>
> 		input_event(sensor->input, EV_ABS, ABS_MT_POSITION_X, obj->x);
> 		input_event(sensor->input, EV_ABS, ABS_MT_POSITION_Y, obj->y);
> 		...
> 	}
>
> instead of:
>
> 	input_mt_report_slot_state(input, obj->mt_tool,
> 				   obj->type != RMI_2D_OBJECT_NONE);
> 	if (obj->type != RMI_2D_OBJECT_NONE) {
> 		input_event(sensor->input, EV_ABS, ABS_MT_POSITION_X, obj->x);
> 		input_event(sensor->input, EV_ABS, ABS_MT_POSITION_Y, obj->y);
> 		...
> 	}
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>   drivers/input/input-mt.c | 10 +++++++---
>   include/linux/input/mt.h |  2 +-
>   2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
> index 7ca4b318ed419..4a69716e54614 100644
> --- a/drivers/input/input-mt.c
> +++ b/drivers/input/input-mt.c
> @@ -131,8 +131,10 @@ EXPORT_SYMBOL(input_mt_destroy_slots);
>    * inactive, or if the tool type is changed, a new tracking id is
>    * assigned to the slot. The tool type is only reported if the
>    * corresponding absbit field is set.
> + *
> + * Returns true if contact is active.
>    */
> -void input_mt_report_slot_state(struct input_dev *dev,
> +bool input_mt_report_slot_state(struct input_dev *dev,
>   				unsigned int tool_type, bool active)
>   {
>   	struct input_mt *mt = dev->mt;
> @@ -140,14 +142,14 @@ void input_mt_report_slot_state(struct input_dev *dev,
>   	int id;
>   
>   	if (!mt)
> -		return;
> +		return false;
>   
>   	slot = &mt->slots[mt->slot];
>   	slot->frame = mt->frame;
>   
>   	if (!active) {
>   		input_event(dev, EV_ABS, ABS_MT_TRACKING_ID, -1);
> -		return;
> +		return false;
>   	}
>   
>   	id = input_mt_get_value(slot, ABS_MT_TRACKING_ID);
> @@ -156,6 +158,8 @@ void input_mt_report_slot_state(struct input_dev *dev,
>   
>   	input_event(dev, EV_ABS, ABS_MT_TRACKING_ID, id);
>   	input_event(dev, EV_ABS, ABS_MT_TOOL_TYPE, tool_type);
> +
> +	return true;
>   }
>   EXPORT_SYMBOL(input_mt_report_slot_state);
>   
> diff --git a/include/linux/input/mt.h b/include/linux/input/mt.h
> index d7188de4db968..3f4bf60b0bb55 100644
> --- a/include/linux/input/mt.h
> +++ b/include/linux/input/mt.h
> @@ -100,7 +100,7 @@ static inline bool input_is_mt_axis(int axis)
>   	return axis == ABS_MT_SLOT || input_is_mt_value(axis);
>   }
>   
> -void input_mt_report_slot_state(struct input_dev *dev,
> +bool input_mt_report_slot_state(struct input_dev *dev,
>   				unsigned int tool_type, bool active);
>   
>   void input_mt_report_finger_count(struct input_dev *dev, int count);
   Reviewed-by: Henrik Rydberg <rydberg@bitmath.org>

Thanks, Dmitry.

Henrik
