Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932452AbeCKXAd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 19:00:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38845 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932373AbeCKXA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 19:00:28 -0400
X-Google-Smtp-Source: AG47ELvejAFWmy3oRNMcd0XzoDpEDSXUFpxahwWT3R+h/CGG8khxP/D51s6C35b64xdyLL7OAiFlBw==
Subject: Re: [PATCH 3/3] wlcore: Use common error handling code in
 wl1271_acx_sta_rate_policies()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Kalle Valo <kvalo@codeaurora.org>
References: <b5db0825-394a-1d6d-351a-43be14e4c6b4@users.sourceforge.net>
 <7d5cc7b4-f0ce-192a-3e5e-c2944c1e3e3d@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5AA5B50B.6000101@broadcom.com>
Date: Mon, 12 Mar 2018 00:00:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <7d5cc7b4-f0ce-192a-3e5e-c2944c1e3e3d@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/2018 10:33 PM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 10 Mar 2018 22:18:45 +0100
>
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function.
>
> This issue was detected by using the Coccinelle software.

You call this an issue?

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/net/wireless/ti/wlcore/acx.c | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/wireless/ti/wlcore/acx.c b/drivers/net/wireless/ti/wlcore/acx.c
> index 1cc5bba670e1..7d37a417c756 100644
> --- a/drivers/net/wireless/ti/wlcore/acx.c
> +++ b/drivers/net/wireless/ti/wlcore/acx.c

[...]

>   	ret = wl1271_cmd_configure(wl, ACX_RATE_POLICY, acx, sizeof(*acx));
> -	if (ret < 0) {
> -		wl1271_warning("Setting of rate policies failed: %d", ret);
> -		goto out;
> -	}
> +	if (ret < 0)
> +		goto report_failure;
>
> -out:
> +free_acx:
>   	kfree(acx);
>   	return ret;
> +
> +report_failure:
> +	wl1271_warning("Setting of rate policies failed: %d", ret);
> +	goto free_acx;

In my opinion you are introducing a new issue. I don't call this 
"common" in any way. It is leaning more towards "spaghetti code" [1]. 
Jumping over a label to return to it with another jump. They are not 
long jumps, but it sure does not make thing more readable. Always aim 
for simple top-to-bottom.

Regards,
Arend

[1] https://en.wikipedia.org/wiki/Spaghetti_code

>   }
>
>   int wl1271_acx_ap_rate_policy(struct wl1271 *wl, struct conf_tx_rate_class *c,
>
