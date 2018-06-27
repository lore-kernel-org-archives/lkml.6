Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300E7C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0C822EC0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0C822EC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934579AbeF0BJN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:09:13 -0400
Received: from leo.clearchain.com ([199.73.29.74]:10339 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbeF0BJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:09:11 -0400
Received: from leo.clearchain.com (localhost [127.0.0.1])
        by mail.clearchain.com (8.15.2/8.15.2) with ESMTPS id w5R1926A000437
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 Jun 2018 10:39:03 +0930 (CST)
        (envelope-from peter.hutterer@who-t.net)
X-Authentication-Warning: leo.clearchain.com: Host localhost [127.0.0.1] claimed to be leo.clearchain.com
Received: (from whot@localhost)
        by leo.clearchain.com (8.15.2/8.15.2/Submit) id w5R19248000435;
        Wed, 27 Jun 2018 10:39:02 +0930 (CST)
        (envelope-from peter.hutterer@who-t.net)
X-Authentication-Warning: leo.clearchain.com: whot set sender to peter.hutterer@who-t.net using -f
Date:   Wed, 27 Jun 2018 11:08:58 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mario.Limonciello@dell.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/12] HID: multitouch: report MT_TOOL_PALM for
 non-confident touches
Message-ID: <20180627010858.GB25847@jelly>
References: <20180621120908.16706-1-benjamin.tissoires@redhat.com>
 <20180621120908.16706-11-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621120908.16706-11-benjamin.tissoires@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3 (mail.clearchain.com [127.0.0.1]); Wed, 27 Jun 2018 10:39:03 +0930 (CST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 02:09:06PM +0200, Benjamin Tissoires wrote:
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> According to Microsoft specification [1] for Precision Touchpads (and
> Touchscreens) the devices use "confidence" reports to signal accidental
> touches, or contacts that are "too large to be a finger". Instead of
> simply marking contact inactive in this case (which causes issues if
> contact was originally proper and we lost confidence in it later, as
> this results in accidental clicks, drags, etc), let's report such
> contacts as MT_TOOL_PALM and let userspace decide what to do.
> Additionally, let's report contact size for such touches as maximum
> allowed for major/minor, which should help userspace that is not yet
> aware of MT_TOOL_PALM to still perform palm rejection.

tbh. I have a queasy feeling about this last bit. MT_TOOL_PALM has shown to
not be reliable on some devices (X1 Carbon 6th) and we mask it out on those.
Changing the major/minor means it's impossible to rely on the touch size for
palm detection once a device supports MT_TOOL_PALM.

Cheers,
   Peter

> 
> [1] https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/touchpad-windows-precision-touchpad-collection
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> [splitted and rebased]
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> ---
> 
> changes in v2:
> - dropped the delayed release in case of palm detection. This is
>   a FW bug for PTP devices, and should only happen with touchscreens
> - move input_set_abs_params(hi->input, ABS_MT_TOOL_TYPE,...) into
>   its own test so other devices can add MT_QUIRK_CONFIDENCE to their
>   quirks.
> 
> no changes in v3
> ---
>  drivers/hid/hid-multitouch.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index a4a274ebfbef..36c8b67bb032 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -736,6 +736,13 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  				cls->name == MT_CLS_WIN_8_DUAL) &&
>  				field->application == HID_DG_TOUCHPAD)
>  				app->quirks |= MT_QUIRK_CONFIDENCE;
> +
> +			if (app->quirks & MT_QUIRK_CONFIDENCE)
> +				input_set_abs_params(hi->input,
> +						     ABS_MT_TOOL_TYPE,
> +						     MT_TOOL_FINGER,
> +						     MT_TOOL_PALM, 0, 0);
> +
>  			MT_STORE_FIELD(confidence_state);
>  			return 1;
>  		case HID_DG_TIPSWITCH:
> @@ -958,10 +965,12 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
>  	if (quirks & MT_QUIRK_HOVERING)
>  		inrange_state = *slot->inrange_state;
>  
> -	active = (*slot->tip_state || inrange_state) && confidence_state;
> +	active = *slot->tip_state || inrange_state;
>  
>  	if (app->application == HID_GD_SYSTEM_MULTIAXIS)
>  		tool = MT_TOOL_DIAL;
> +	else if (unlikely(!confidence_state))
> +		tool = MT_TOOL_PALM;
>  
>  	input_mt_slot(input, slotnum);
>  	input_mt_report_slot_state(input, tool, active);
> @@ -993,11 +1002,20 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
>  			orientation = -azimuth;
>  		}
>  
> -		/*
> -		 * divided by two to match visual scale of touch
> -		 * for devices with this quirk
> -		 */
> -		if (quirks & MT_QUIRK_TOUCH_SIZE_SCALING) {
> +		if (unlikely(!confidence_state)) {
> +			/*
> +			 * When reporting palm, set contact to maximum
> +			 * size to help userspace that does not
> +			 * recognize MT_TOOL_PALM to reject contacts
> +			 * that are too large.
> +			 */
> +			major = input_abs_get_max(input, ABS_MT_TOUCH_MAJOR);
> +			minor = input_abs_get_max(input, ABS_MT_TOUCH_MINOR);
> +		} else if (quirks & MT_QUIRK_TOUCH_SIZE_SCALING) {
> +			/*
> +			 * divided by two to match visual scale of touch
> +			 * for devices with this quirk
> +			 */
>  			major = major >> 1;
>  			minor = minor >> 1;
>  		}
> -- 
> 2.14.3
> 
