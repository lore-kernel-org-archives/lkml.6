Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752714AbeE0XdE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 19:33:04 -0400
Received: from leo.clearchain.com ([199.73.29.74]:36601 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbeE0XdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 19:33:01 -0400
Date: Mon, 28 May 2018 09:12:00 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>,
        Oscar Morante <spacepluk@gmail.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: rmi: use HID_QUIRK_NO_INPUT_SYNC
Message-ID: <20180527231200.GA13676@jelly>
References: <20180525125106.18008-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525125106.18008-1-benjamin.tissoires@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 02:51:06PM +0200, Benjamin Tissoires wrote:
> When we receive a RMI4 report, we should not unconditionally send an
> input_sync event. Instead, we should let the rmi4 transport layer do it
> for us.
> 
> This fixes a situation where we might receive X in a report and the rest
> in a subsequent one. And this messes up user space.
> 
> Link: https://bugs.freedesktop.org/show_bug.cgi?id=100436
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---

yes please! 

Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
   Peter

> 
> Hi,
> 
> Oscar, do you mind if we add your "Tested-by: Oscar Morante <your@email>"?
> 
> Andrew, can you check for any sides effects please?
> 
> Cheers,
> Benjamin
> 
>  drivers/hid/hid-rmi.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index 9c9362149641..9e33165250a3 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -413,6 +413,24 @@ static int rmi_event(struct hid_device *hdev, struct hid_field *field,
>  	return 0;
>  }
>  
> +static void rmi_report(struct hid_device *hid, struct hid_report *report)
> +{
> +	struct hid_field *field = report->field[0];
> +
> +	if (!(hid->claimed & HID_CLAIMED_INPUT))
> +		return;
> +
> +	switch (report->id) {
> +	case RMI_READ_DATA_REPORT_ID:
> +		/* fall-through */
> +	case RMI_ATTN_REPORT_ID:
> +		return;
> +	}
> +
> +	if (field && field->hidinput && field->hidinput->input)
> +		input_sync(field->hidinput->input);
> +}
> +
>  #ifdef CONFIG_PM
>  static int rmi_suspend(struct hid_device *hdev, pm_message_t message)
>  {
> @@ -637,6 +655,7 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	hid_set_drvdata(hdev, data);
>  
>  	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
> +	hdev->quirks |= HID_QUIRK_NO_INPUT_SYNC;
>  
>  	ret = hid_parse(hdev);
>  	if (ret) {
> @@ -744,6 +763,7 @@ static struct hid_driver rmi_driver = {
>  	.remove			= rmi_remove,
>  	.event			= rmi_event,
>  	.raw_event		= rmi_raw_event,
> +	.report			= rmi_report,
>  	.input_mapping		= rmi_input_mapping,
>  	.input_configured	= rmi_input_configured,
>  #ifdef CONFIG_PM
> -- 
> 2.14.3
> 
