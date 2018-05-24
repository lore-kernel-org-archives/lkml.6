Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965856AbeEXJLV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 05:11:21 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:35093 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965456AbeEXJLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:11:18 -0400
Subject: Re: [PATCH v5 4/6] mfd: cros-ec: Introduce CEC commands and events
 definitions.
To: Neil Armstrong <narmstrong@baylibre.com>, airlied@linux.ie,
        hans.verkuil@cisco.com, lee.jones@linaro.org, olof@lixom.net,
        seanpaul@google.com
Cc: sadolfsson@google.com, felixe@google.com, bleung@google.com,
        darekm@google.com, marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        eballetbo@gmail.com
References: <1527152101-17278-1-git-send-email-narmstrong@baylibre.com>
 <1527152101-17278-5-git-send-email-narmstrong@baylibre.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <bb0b5060-5ccc-814c-5256-53151a831178@xs4all.nl>
Date: Thu, 24 May 2018 11:11:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527152101-17278-5-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOj6VP5LgqdOusYaJyWEMNesuV+HstqSaQakyIgQjo1m8v7UsLKVE8C0sV1Nghz6t15ZWyFK+Lsjc+aLbaYEWCHA34G2zR9i1DUomkfVhpZaZc1lwTWN
 xPQbVSd71V8XHXNgpq88FBNudciCSC8+2808+0bh1t3iy8kgK0ZPxCouxJMKxbm2bYRhRccNaNwo2BGHyhizeQIDbxg8WAjryIpuNBLsMwvSyNZDmDHGBvXR
 Lx6ZswJVUqSpM6Jtd2hvbFej1cMn+bJH20te0NA/hZc7hYxWn1aZzzaL1xYRFBPNZ5PQP1iW78z3H/Xdfx6qSJnmixqI9q/55QICqOmzcQc3Pp/h9RUjyHp5
 ePR0Yv4eL+e6Zpx+qIjOhzz9+OrGVUxII80dUT8KH2yRy/1dJYC7yeUjn0Jda5pMxL7841cfCW97ykIz3vlJFngcyBMsO9gtnEyqQ+JMNVXzlC3OL/M6Rtix
 UL/RcbN5PynO7Us7Y6mRp/qZDpHA+7MeY4Mw0aqA78mIh2MeRQYXPgT+oGOLTAdM4AIx0hzexOIN9njVtIBi4wtvuZMUZglK50cnlr1OEpvuFjpGZIGl8s63
 0r4+xb93L6pj73RN6Y9oX3SGcMMUozN8r+1eZs45O4MioLgiwV95Croqa1OiuogtA7IEW110Eg79sUC24kqz3W7ARWee822I6jPAy7G7ZLF0HPsOXr6C5x6I
 Znpcjb732HfDfo9/6ikkHs3EGiWQ8yDy8SUel3rTsRr+jGKyDNDTTB6bl2+Npixnw+9LRSgvuP+4eAO/4j+VudvoDoRUgK6QjVJc9SM1QeoPAIOvnP5ot+yx
 LJePHQoJvg6d4IrMlBk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/18 10:54, Neil Armstrong wrote:
> The EC can expose a CEC bus, this patch adds the CEC related definitions
> needed by the cros-ec-cec driver.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  include/linux/mfd/cros_ec_commands.h | 85 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index cc0768e..ea9646f 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -804,6 +804,8 @@ enum ec_feature_code {
>  	EC_FEATURE_MOTION_SENSE_FIFO = 24,
>  	/* EC has RTC feature that can be controlled by host commands */
>  	EC_FEATURE_RTC = 27,
> +	/* EC supports CEC commands */
> +	EC_FEATURE_CEC = 35,
>  };
>  
>  #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
> @@ -2078,6 +2080,12 @@ enum ec_mkbp_event {
>  	/* EC sent a sysrq command */
>  	EC_MKBP_EVENT_SYSRQ = 6,
>  
> +	/* Notify the AP that something happened on CEC */
> +	EC_MKBP_CEC_EVENT = 8,
> +
> +	/* Send an incoming CEC message to the AP */
> +	EC_MKBP_EVENT_CEC_MESSAGE = 9,
> +
>  	/* Number of MKBP events */
>  	EC_MKBP_EVENT_COUNT,
>  };
> @@ -2850,6 +2858,83 @@ struct ec_params_reboot_ec {
>  
>  /*****************************************************************************/
>  /*
> + * HDMI CEC commands
> + *
> + * These commands are for sending and receiving message via HDMI CEC
> + */
> +#define MAX_CEC_MSG_LEN 16

Can you rename this to EC_MAX_CEC_MSG_LEN? It is way too similar to the
CEC_MAX_MSG_LEN defined in cec.h. Since this is a property of the EC hw/fw
it makes sense to prefix it accordingly.

> +
> +/* CEC message from the AP to be written on the CEC bus */
> +#define EC_CMD_CEC_WRITE_MSG 0x00B8
> +
> +/**
> + * struct ec_params_cec_write - Message to write to the CEC bus
> + * @msg: message content to write to the CEC bus
> + */
> +struct ec_params_cec_write {
> +	uint8_t msg[MAX_CEC_MSG_LEN];
> +} __packed;
> +
> +/* Set various CEC parameters */
> +#define EC_CMD_CEC_SET 0x00BA
> +
> +/**
> + * struct ec_params_cec_set - CEC parameters set
> + * @cmd: parameter type, can be CEC_CMD_ENABLE or CEC_CMD_LOGICAL_ADDRESS
> + * @enable: in case cmd is CEC_CMD_ENABLE, this field can be 0 to disable CEC
> + * 	or 1 to enable CEC functionnality
> + * @address: in case cmd is CEC_CMD_LOGICAL_ADDRESS, this field encodes the
> + *	requested logical address between 0 and 15 or 0xff to unregister
> + */
> +struct ec_params_cec_set {
> +	uint8_t cmd; /* enum cec_command */
> +	union {
> +		uint8_t enable;
> +		uint8_t address;
> +	};
> +} __packed;
> +
> +/* Read various CEC parameters */
> +#define EC_CMD_CEC_GET 0x00BB
> +
> +/**
> + * struct ec_params_cec_get - CEC parameters get
> + * @cmd: parameter type, can be CEC_CMD_ENABLE or CEC_CMD_LOGICAL_ADDRESS
> + */
> +struct ec_params_cec_get {
> +	uint8_t cmd; /* enum cec_command */
> +} __packed;
> +
> +/**
> + * struct ec_response_cec_get - CEC parameters get response
> + * @enable: in case cmd was CEC_CMD_ENABLE, this field will 0 if CEC is
> + * 	disabled or 1 if CEC functionnality is enabled
> + * @address: in case cmd was CEC_CMD_LOGICAL_ADDRESS, this will encode the
> + *	configured logical address between 0 and 15 or 0xff if unregistered
> + */
> +struct ec_response_cec_get {
> +	union {
> +		uint8_t enable;
> +		uint8_t address;
> +	};
> +} __packed;
> +
> +/* CEC parameters command */
> +enum cec_command {

Same here: shouldn't all of this be prefixed with ec_ or EC_?

Regards,

	Hans

> +	/* CEC reading, writing and events enable */
> +	CEC_CMD_ENABLE,
> +	/* CEC logical address  */
> +	CEC_CMD_LOGICAL_ADDRESS,
> +};
> +
> +/* Events from CEC to AP */
> +enum mkbp_cec_event {
> +	EC_MKBP_CEC_SEND_OK			= BIT(0),
> +	EC_MKBP_CEC_SEND_FAILED			= BIT(1),
> +};
> +
> +/*****************************************************************************/
> +/*
>   * Special commands
>   *
>   * These do not follow the normal rules for commands.  See each command for
> 
