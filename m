Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755425AbeE2Xpn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 19:45:43 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44298 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755284AbeE2Xpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 19:45:38 -0400
X-Google-Smtp-Source: ADUXVKKXxjZqpyiL6JS/pWwBiM1KBXPQntKOArZfRZpCvVbA6BFTR00mnD+w65zMe9qwVDq9JcKxvw==
Date: Tue, 29 May 2018 16:45:34 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ben Chan <benchan@chromium.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>, dtor@chromium.org,
        drinkcat@chromium.org
Subject: Re: [PATCH] HID: multitouch: fix calculation of last slot field in
 multi-touch reports
Message-ID: <20180529234534.GG167092@dtor-ws>
References: <20180529225655.214380-1-benchan@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529225655.214380-1-benchan@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 03:56:55PM -0700, Ben Chan wrote:
> According to [1] and also seemingly agreed by [2], the Scan Time usage
> (0x0D 0x56) is a report level usage, not a contact level usage.
> 
> However, the hid-multitouch driver currently includes HID_DG_SCANTIME
> when calculating `td->last_slot_field', which may lead to
> mt_complete_slot() being prematurely called in certain cases (e.g. when
> each touch input report includes more than one contact and the Scan Time
> usage appears before any contact logical collection).
> 
> This patch fixes the issue by skipping mt_store_field() on
> HID_DG_SCANTIME, similar to how HID_DG_CONTACTCOUNT and
> HID_DG_CONTACTMAX are handled.
> 
> [1] https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-precision-touchpad-required-hid-top-level-collections#windows-precision-touchpad-input-reports
> [2] https://patchwork.kernel.org/patch/1742181/
> 
> Fixes: 29cc309d8bf19 ("HID: hid-multitouch: forward MSC_TIMESTAMP")
> Signed-off-by: Ben Chan <benchan@chromium.org>

This looks reasonable to me.

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/hid/hid-multitouch.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index dad2fbb0e3f8..161551aab496 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -620,13 +620,16 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  			hid_map_usage(hi, usage, bit, max,
>  				EV_MSC, MSC_TIMESTAMP);
>  			input_set_capability(hi->input, EV_MSC, MSC_TIMESTAMP);
> -			mt_store_field(usage, td, hi);
>  			/* Ignore if indexes are out of bounds. */
>  			if (field->index >= field->report->maxfield ||
>  			    usage->usage_index >= field->report_count)
>  				return 1;
>  			td->scantime_index = field->index;
>  			td->scantime_val_index = usage->usage_index;
> +			/*
> +			 * We don't set td->last_slot_field as scan time is
> +			 * global to the report.
> +			 */
>  			return 1;
>  		case HID_DG_CONTACTCOUNT:
>  			/* Ignore if indexes are out of bounds. */
> -- 
> 2.17.0.921.gf22659ad46-goog
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
