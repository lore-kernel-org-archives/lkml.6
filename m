Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8666C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC2B22EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC2B22EBB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934618AbeF0BKY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:10:24 -0400
Received: from leo.clearchain.com ([199.73.29.74]:46731 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933723AbeF0BKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:10:23 -0400
Received: from leo.clearchain.com (localhost [127.0.0.1])
        by mail.clearchain.com (8.15.2/8.15.2) with ESMTPS id w5R1AFij000761
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 Jun 2018 10:40:15 +0930 (CST)
        (envelope-from peter.hutterer@who-t.net)
X-Authentication-Warning: leo.clearchain.com: Host localhost [127.0.0.1] claimed to be leo.clearchain.com
Received: (from whot@localhost)
        by leo.clearchain.com (8.15.2/8.15.2/Submit) id w5R1AFXU000759;
        Wed, 27 Jun 2018 10:40:15 +0930 (CST)
        (envelope-from peter.hutterer@who-t.net)
X-Authentication-Warning: leo.clearchain.com: whot set sender to peter.hutterer@who-t.net using -f
Date:   Wed, 27 Jun 2018 11:10:11 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mario.Limonciello@dell.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/12] HID: multitouch: handle palm for touchscreens
Message-ID: <20180627011011.GC25847@jelly>
References: <20180621120908.16706-1-benjamin.tissoires@redhat.com>
 <20180621120908.16706-13-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621120908.16706-13-benjamin.tissoires@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3 (mail.clearchain.com [127.0.0.1]); Wed, 27 Jun 2018 10:40:16 +0930 (CST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 02:09:08PM +0200, Benjamin Tissoires wrote:
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Usually, there is no palm rejection for touchscreens. You don't rest
> your palm on the touchscreen while interacting with it.
> However, some wacom devices do so because you can rest your palm while
> interacting with the stylus.
> 
> Unfortunately, the spec for touchscreens[1] is less precise than the one
> for touchpads[2]. This leads to a situation where it's 'legitimate'
> for a touchscreen to provide both tipswitch off and confidence off in the
> same report.
> 
> Work around that by keeping the slot active for one frame where we report
> MT_TOOL_PALM, and then synthesizing the release event in a separate frame.
> frame
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> [rebased and new commit message]
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

to the series unless otherwise noted.

Cheers,
   Peter

> ---
> changes in v2 (compared to Dmitry's initial submission):
> - extracted from the initial submission in a separate patch
> - rebased on top of my current series
> - add an extra input_mt_sync_frame(input); to release the single touch
>   emulation
> 
> no changes in v3
> ---
>  drivers/hid/hid-multitouch.c | 52 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 9c708aa261ee..3a1c2d80729b 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -118,6 +118,9 @@ struct mt_application {
>  	int left_button_state;		/* left button state */
>  	unsigned int mt_flags;		/* flags to pass to input-mt */
>  
> +	unsigned long *pending_palm_slots;	/* slots where we reported palm
> +						 * and need to release */
> +
>  	__u8 num_received;	/* how many contacts we received */
>  	__u8 num_expected;	/* expected last contact index */
>  	__u8 buttons_count;	/* number of physical buttons per touchpad */
> @@ -863,6 +866,28 @@ static int mt_compute_slot(struct mt_device *td, struct mt_application *app,
>  	return input_mt_get_slot_by_key(input, *slot->contactid);
>  }
>  
> +static void mt_release_pending_palms(struct mt_device *td,
> +				     struct mt_application *app,
> +				     struct input_dev *input)
> +{
> +	int slotnum;
> +	bool need_sync = false;
> +
> +	for_each_set_bit(slotnum, app->pending_palm_slots, td->maxcontacts) {
> +		clear_bit(slotnum, app->pending_palm_slots);
> +
> +		input_mt_slot(input, slotnum);
> +		input_mt_report_slot_state(input, MT_TOOL_PALM, false);
> +
> +		need_sync = true;
> +	}
> +
> +	if (need_sync) {
> +		input_mt_sync_frame(input);
> +		input_sync(input);
> +	}
> +}
> +
>  /*
>   * this function is called when a whole packet has been received and processed,
>   * so that it can decide what to send to the input layer.
> @@ -876,6 +901,9 @@ static void mt_sync_frame(struct mt_device *td, struct mt_application *app,
>  	input_mt_sync_frame(input);
>  	input_event(input, EV_MSC, MSC_TIMESTAMP, app->timestamp);
>  	input_sync(input);
> +
> +	mt_release_pending_palms(td, app, input);
> +
>  	app->num_received = 0;
>  	app->left_button_state = 0;
>  
> @@ -970,8 +998,23 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
>  
>  	if (app->application == HID_GD_SYSTEM_MULTIAXIS)
>  		tool = MT_TOOL_DIAL;
> -	else if (unlikely(!confidence_state))
> +	else if (unlikely(!confidence_state)) {
>  		tool = MT_TOOL_PALM;
> +		if (!active &&
> +		    input_mt_is_active(&mt->slots[slotnum])) {
> +			/*
> +			 * The non-confidence was reported for
> +			 * previously valid contact that is also no
> +			 * longer valid. We can't simply report
> +			 * lift-off as userspace will not be aware
> +			 * of non-confidence, so we need to split
> +			 * it into 2 events: active MT_TOOL_PALM
> +			 * and a separate liftoff.
> +			 */
> +			active = true;
> +			set_bit(slotnum, app->pending_palm_slots);
> +		}
> +	}
>  
>  	input_mt_slot(input, slotnum);
>  	input_mt_report_slot_state(input, tool, active);
> @@ -1206,6 +1249,13 @@ static int mt_touch_input_configured(struct hid_device *hdev,
>  	if (td->is_buttonpad)
>  		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
>  
> +	app->pending_palm_slots = devm_kcalloc(&hi->input->dev,
> +					       BITS_TO_LONGS(td->maxcontacts),
> +					       sizeof(long),
> +					       GFP_KERNEL);
> +	if (!app->pending_palm_slots)
> +		return -ENOMEM;
> +
>  	ret = input_mt_init_slots(input, td->maxcontacts, app->mt_flags);
>  	if (ret)
>  		return ret;
> -- 
> 2.14.3
> 
