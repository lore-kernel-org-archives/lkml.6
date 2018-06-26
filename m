Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBE5C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1666B26BD7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="h1c+bfwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1666B26BD7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965778AbeFZOBD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:01:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35947 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965453AbeFZOBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:01:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id t3-v6so1071937eds.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 07:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9GxP77a/HT1dinUR07gQ7KErhE3Vh8p3vBOZ39TUFFE=;
        b=h1c+bfwhKoAnhRrUP/YICjPJ7RHytTqHGF8RxjhmcW1ws33rBW72yeCoiwW/4K5Me+
         ixsj1mj99CbUDPKi8Dg1/jn9VE+kPoTBjF63iCgiZlLnv8w1sMv3fPRkiDs+jWd79/BP
         yHIFbxCIaVLCqbVkRL0zkalczFtj2EIe1GVZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=9GxP77a/HT1dinUR07gQ7KErhE3Vh8p3vBOZ39TUFFE=;
        b=PeAG7EGZpU7OOrU+UFbjPQsP9sfqh6kPncJdwlkVqGgjr1b7qmhzObswwMeswetQzZ
         hTtSVs4I5lcyBX3RiarRprtUYUQgqDgmhhV+IfIS3XsARvzD+zMwRMGr9pjjSuQXkiyA
         xuULQkLv3BbCCQ6smmXS3ff8cw/KL9fVQFx4YOCRJ6XE5CWdsIJGwMWPIVrSEdLXADGr
         zwdxFRUqlEP5ooOuhz90YkkB2Yf4LGZwW/mlPT9FT/doTx9dO2Np5W4Q08rUBl0LmcUx
         HAYKL0G+Pn7ozswEhoOAVo62Yebssy/mdFcFqRmEvrG77TjjBg2RIti8jEvHj3juiqUd
         1pIg==
X-Gm-Message-State: APt69E3IqfsdXhjLz9gTnJMOcWwJ5JvQJlHguSIsqXo1MyAy55gEMuT1
        qvNF1L025kSjHBblMZCglh7GTQ==
X-Google-Smtp-Source: AAOMgpfv90m1Hm/UXR+ajdahpQV9yq7ObHjFil9vz2MWxtb9/+2fsC2nef1VtQgiigL4E0lRVCKvCQ==
X-Received: by 2002:a50:bdc7:: with SMTP id z7-v6mr1966136edh.84.1530021659639;
        Tue, 26 Jun 2018 07:00:59 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-109.fiber7.init7.net. [212.51.149.109])
        by smtp.gmail.com with ESMTPSA id b32-v6sm954483edd.85.2018.06.26.07.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 07:00:58 -0700 (PDT)
Date:   Tue, 26 Jun 2018 16:00:55 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-fbdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where
 applicable
Message-ID: <20180626140055.GB13978@phenom.ffwll.local>
Mail-Followup-To: Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-fbdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180626135535.2990-1-hdegoede@redhat.com>
 <20180626135535.2990-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626135535.2990-3-hdegoede@redhat.com>
X-Operating-System: Linux phenom 4.16.0-2-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 03:55:34PM +0200, Hans de Goede wrote:
> Replace comments about places where the console lock should be held with
> calls to WARN_CONSOLE_UNLOCKED() to assert that it is actually held.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> -New patch in v3 of this patchset

For patches 1&2:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/video/fbdev/core/fbcon.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index c910e74d46ff..ac2cbdf710ee 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -817,8 +817,6 @@ static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
>   *
>   *	Maps a virtual console @unit to a frame buffer device
>   *	@newidx.
> - *
> - *	This should be called with the console lock held.
>   */
>  static int set_con2fb_map(int unit, int newidx, int user)
>  {
> @@ -828,6 +826,8 @@ static int set_con2fb_map(int unit, int newidx, int user)
>  	struct fb_info *oldinfo = NULL;
>   	int found, err = 0;
>  
> +	WARN_CONSOLE_UNLOCKED();
> +
>  	if (oldidx == newidx)
>  		return 0;
>  
> @@ -3039,11 +3039,12 @@ static inline int fbcon_unbind(void)
>  }
>  #endif /* CONFIG_VT_HW_CONSOLE_BINDING */
>  
> -/* called with console_lock held */
>  static int fbcon_fb_unbind(int idx)
>  {
>  	int i, new_idx = -1, ret = 0;
>  
> +	WARN_CONSOLE_UNLOCKED();
> +
>  	if (!fbcon_has_console_bind)
>  		return 0;
>  
> @@ -3089,11 +3090,12 @@ static int fbcon_fb_unbind(int idx)
>  	return ret;
>  }
>  
> -/* called with console_lock held */
>  static int fbcon_fb_unregistered(struct fb_info *info)
>  {
>  	int i, idx;
>  
> +	WARN_CONSOLE_UNLOCKED();
> +
>  	idx = info->node;
>  	for (i = first_fb_vc; i <= last_fb_vc; i++) {
>  		if (con2fb_map[i] == idx)
> @@ -3127,10 +3129,12 @@ static int fbcon_fb_unregistered(struct fb_info *info)
>  	return 0;
>  }
>  
> -/* called with console_lock held */
>  static void fbcon_remap_all(int idx)
>  {
>  	int i;
> +
> +	WARN_CONSOLE_UNLOCKED();
> +
>  	for (i = first_fb_vc; i <= last_fb_vc; i++)
>  		set_con2fb_map(i, idx, 0);
>  
> @@ -3172,11 +3176,12 @@ static inline void fbcon_select_primary(struct fb_info *info)
>  }
>  #endif /* CONFIG_FRAMEBUFFER_DETECT_PRIMARY */
>  
> -/* called with console_lock held */
>  static int fbcon_fb_registered(struct fb_info *info)
>  {
>  	int ret = 0, i, idx;
>  
> +	WARN_CONSOLE_UNLOCKED();
> +
>  	idx = info->node;
>  	fbcon_select_primary(info);
>  
> @@ -3325,7 +3330,6 @@ static int fbcon_event_notify(struct notifier_block *self,
>  		ret = fbcon_fb_unregistered(info);
>  		break;
>  	case FB_EVENT_SET_CONSOLE_MAP:
> -		/* called with console lock held */
>  		con2fb = event->data;
>  		ret = set_con2fb_map(con2fb->console - 1,
>  				     con2fb->framebuffer, 1);
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
