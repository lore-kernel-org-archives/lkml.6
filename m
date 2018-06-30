Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B63C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179E1243F4
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179E1243F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbeF3PuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 11:50:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:43207 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbeF3PuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 11:50:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jun 2018 08:50:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,291,1526367600"; 
   d="scan'208";a="53097629"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 30 Jun 2018 08:50:04 -0700
Message-ID: <1ba466210967263ee586f562730b875a5c80c2c1.camel@linux.intel.com>
Subject: Re: [PATCH v2 fbdev-for-next 1/2] fbcon: introduce
 for_each_registered_fb() helper
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yisheng Xie <ysxie@foxmail.com>, b.zolnierkie@samsung.com,
        keescook@chromium.org, j.w.r.degoede@gmail.com,
        david@lechnology.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 30 Jun 2018 18:50:03 +0300
In-Reply-To: <1530343789-4237-1-git-send-email-ysxie@foxmail.com>
References: <1530343789-4237-1-git-send-email-ysxie@foxmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-06-30 at 15:29 +0800, Yisheng Xie wrote:
> Following pattern is often used:
> 
>  for (i = 0; i < FB_MAX; i++) {
>         if (registered_fb[i]) {
>                 ...
>         }
>  }
> 
> Therefore, as Andy's suggestion, for_each_registered_fb() helper can
> be introduced to make the code easier to read and write by reducing
> indentation level. It also saves few lines of code in each occurrence.
> 
> This patch convert all part here at the same time.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Yisheng Xie <ysxie@foxmail.com>
> ---
> v2:
>  - rebase it to fbdev-for-next branch and add one more loop to replace
> - per Hans
>  - Macro should be protected against nested conditionals. - per Andy
>  drivers/video/fbdev/core/fbcon.c | 31 +++++++++++--------------------
>  drivers/video/fbdev/core/fbmem.c |  4 +---
>  include/linux/fb.h               |  4 ++++
>  3 files changed, 16 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c
> b/drivers/video/fbdev/core/fbcon.c
> index 5fb156b..e30d3a1 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2234,8 +2234,8 @@ static int fbcon_switch(struct vc_data *vc)
>  	 *
>  	 * info->currcon = vc->vc_num;
>  	 */
> -	for (i = 0; i < FB_MAX; i++) {
> -		if (registered_fb[i] != NULL && registered_fb[i]-
> >fbcon_par) {
> +	for_each_registered_fb(i) {
> +		if (registered_fb[i]->fbcon_par) {
>  			struct fbcon_ops *o = registered_fb[i]-
> >fbcon_par;
>  
>  			o->currcon = vc->vc_num;
> @@ -3124,11 +3124,9 @@ static int fbcon_fb_unregistered(struct fb_info
> *info)
>  	if (idx == info_idx) {
>  		info_idx = -1;
>  
> -		for (i = 0; i < FB_MAX; i++) {
> -			if (registered_fb[i] != NULL) {
> -				info_idx = i;
> -				break;
> -			}
> +		for_each_registered_fb(i) {
> +			info_idx = i;
> +			break;
>  		}
>  	}
>  
> @@ -3609,10 +3607,8 @@ static int fbcon_output_notifier(struct
> notifier_block *nb,
>  	deferred_takeover = false;
>  	logo_shown = FBCON_LOGO_DONTSHOW;
>  
> -	for (i = 0; i < FB_MAX; i++) {
> -		if (registered_fb[i])
> -			fbcon_fb_registered(registered_fb[i]);
> -	}
> +	for_each_registered_fb(i)
> +		fbcon_fb_registered(registered_fb[i]);
>  
>  	return NOTIFY_OK;
>  }
> @@ -3638,11 +3634,9 @@ static void fbcon_start(void)
>  
>  		console_lock();
>  
> -		for (i = 0; i < FB_MAX; i++) {
> -			if (registered_fb[i] != NULL) {
> -				info_idx = i;
> -				break;
> -			}
> +		for_each_registered_fb(i) {
> +			info_idx = i;
> +			break;
>  		}
>  
>  		do_fbcon_takeover(0);
> @@ -3669,15 +3663,12 @@ static void fbcon_exit(void)
>  	kfree((void *)softback_buf);
>  	softback_buf = 0UL;
>  
> -	for (i = 0; i < FB_MAX; i++) {
> +	for_each_registered_fb(i) {
>  		int pending = 0;
>  
>  		mapped = 0;
>  		info = registered_fb[i];
>  
> -		if (info == NULL)
> -			continue;
> -
>  		if (info->queue.func)
>  			pending = cancel_work_sync(&info->queue);
>  		DPRINTK("fbcon: %s pending work\n", (pending ?
> "canceled" :
> diff --git a/drivers/video/fbdev/core/fbmem.c
> b/drivers/video/fbdev/core/fbmem.c
> index 609438d..645c6ac 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1593,10 +1593,8 @@ static int
> do_remove_conflicting_framebuffers(struct apertures_struct *a,
>  	int i, ret;
>  
>  	/* check all firmware fbs and kick off if the base addr
> overlaps */
> -	for (i = 0 ; i < FB_MAX; i++) {
> +	for_each_registered_fb(i) {
>  		struct apertures_struct *gen_aper;
> -		if (!registered_fb[i])
> -			continue;
>  
>  		if (!(registered_fb[i]->flags &
> FBINFO_MISC_FIRMWARE))
>  			continue;
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index aa74a22..fd31e6f 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -650,6 +650,10 @@ extern int fb_get_color_depth(struct
> fb_var_screeninfo *var,
>  extern int num_registered_fb;
>  extern struct class *fb_class;
>  
> +#define for_each_registered_fb(i)		\
> +	for (i = 0; i < FB_MAX; i++)		\
> +		if (!registered_fb[i]) {} else
> +
>  extern int lock_fb_info(struct fb_info *info);
>  
>  static inline void unlock_fb_info(struct fb_info *info)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
