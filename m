Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753125AbeFAS15 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:27:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52326 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752268AbeFAS1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:27:54 -0400
X-Google-Smtp-Source: ADUXVKIae8mBKyxNOV3OjsFFbzBb/s1wigD8ioIa4J+JaZLQTabsowpfAZ31D3kn2EXGKNlBpBh+SA==
Date: Fri, 1 Jun 2018 20:27:50 +0200
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        =?iso-8859-1?Q?Cl=E9ment?= VUCHENER <clement.vuchener@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Subject: Re: [PATCH] HID: steam: use hid_device.driver_data instead of
 hid_set_drvdata()
Message-ID: <20180601182750.GA23501@casa>
References: <20180522201006.14003-1-rodrigorivascosta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522201006.14003-1-rodrigorivascosta@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all!

Could you check my previous patch to see if it makes any sense?
My machine currently crashes without it, but I'm not sure why. If you
think it is worth it I can try and bisect it.

Regards
--
Rodrigo Rivas Costa.


On Tue, May 22, 2018 at 10:10:06PM +0200, Rodrigo Rivas Costa wrote:
> When creating the low-level hidraw device, the reference to steam_device
> was stored using hid_set_drvdata(). But this value is not guaranteed to
> be kept when set before calling probe. If this pointer is reset, it
> crashes when opening the emulated hidraw device.
> 
> It looks like hid_set_drvdata() is for users "avobe" this hid_device,
> while hid_device.driver_data it for users "below" this one.
> 
> In this case, we are creating a virtual hidraw device, so we must use
> hid_device.driver_data.
> 
> Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
> ---
> 
> This patch is to be applied over hid/for-4.18/hid-steam. Is this the
> proper way to signal it?
> 
> I don't know exactly when the problem started. I am pretty sure that it
> worked with 4.16.2, but it failed with 4.16.9. Or maybe it is caused by
> upgrading the firmware of the controller, although the protocol seems
> identical.
> 
>  drivers/hid/hid-steam.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index cb86cc834201..0422ec2b13d2 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -573,7 +573,7 @@ static bool steam_is_valve_interface(struct hid_device *hdev)
>  
>  static int steam_client_ll_parse(struct hid_device *hdev)
>  {
> -	struct steam_device *steam = hid_get_drvdata(hdev);
> +	struct steam_device *steam = hdev->driver_data;
>  
>  	return hid_parse_report(hdev, steam->hdev->dev_rdesc,
>  			steam->hdev->dev_rsize);
> @@ -590,7 +590,7 @@ static void steam_client_ll_stop(struct hid_device *hdev)
>  
>  static int steam_client_ll_open(struct hid_device *hdev)
>  {
> -	struct steam_device *steam = hid_get_drvdata(hdev);
> +	struct steam_device *steam = hdev->driver_data;
>  	int ret;
>  
>  	ret = hid_hw_open(steam->hdev);
> @@ -605,7 +605,7 @@ static int steam_client_ll_open(struct hid_device *hdev)
>  
>  static void steam_client_ll_close(struct hid_device *hdev)
>  {
> -	struct steam_device *steam = hid_get_drvdata(hdev);
> +	struct steam_device *steam = hdev->driver_data;
>  
>  	mutex_lock(&steam->mutex);
>  	steam->client_opened = false;
> @@ -623,7 +623,7 @@ static int steam_client_ll_raw_request(struct hid_device *hdev,
>  				size_t count, unsigned char report_type,
>  				int reqtype)
>  {
> -	struct steam_device *steam = hid_get_drvdata(hdev);
> +	struct steam_device *steam = hdev->driver_data;
>  
>  	return hid_hw_raw_request(steam->hdev, reportnum, buf, count,
>  			report_type, reqtype);
> @@ -710,7 +710,7 @@ static int steam_probe(struct hid_device *hdev,
>  		ret = PTR_ERR(steam->client_hdev);
>  		goto client_hdev_fail;
>  	}
> -	hid_set_drvdata(steam->client_hdev, steam);
> +	steam->client_hdev->driver_data = steam;
>  
>  	/*
>  	 * With the real steam controller interface, do not connect hidraw.
> -- 
> 2.17.0
> 
