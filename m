Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12464ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A52206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fuBSNjTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A52206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389434AbeIUOi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:38:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43546 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUOi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:38:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id u23so953285edx.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 01:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NR+CCW3pkJ9mvVpeUWJ6PmjhwKYswuLkqjUgfWz+8BY=;
        b=fuBSNjTFRp1mnfw9nFj9dIuIgwUK8/bC6bAvspsf0gL/l4MuAw00F91jULcGGtwALh
         UlYNY0Ot2s5bLB3EdE633qsjWzf2tcLqGa6TjO3jE9ka0xQo115NoH1xbCwkkNixQTeo
         HCGZ/1dW1CgsZ+qH3X1cPFjx/tWlq+W5fwecM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=NR+CCW3pkJ9mvVpeUWJ6PmjhwKYswuLkqjUgfWz+8BY=;
        b=WAFHP6rTbcfqO0iPB3H8fyC81K/pw8Y5h8nBKYbsyJcLd6nKb0SpRC1B/6B9T2qD61
         wF47zevPDnezqoMEhX+SwaWtIU8fAdddxvnCRqld+UFySHig4q5cAOJoSqb5ujkYRYTD
         /Hinepxy0m59QiSStgrLRKWtxus9QA4tadSGNpYXWpLhzeeXQlPLcsR/4n/+swxLjWZ0
         1bDqiRtW6qXu2CWP3rxEYeViu6tBimCJvxJhI0gF+TYmuafty2JFgrhYnVXnp0Ze/lu7
         6ffii7Iulqoz9ycj3wH+gMGy/iqlhltLyvrELCYXP7Yu4krB4UdvXojdRrHXsBc/fk20
         0cog==
X-Gm-Message-State: APzg51AUhXx7am8sPQRxSVs6FUe7RXoD6+xtI/HBFZaBH8t6GAQw9TqR
        uWi2cLVcDHoF6VjXVXotwgrbAkS7Iezunw==
X-Google-Smtp-Source: ANB0VdZrVQiCgvCsjDeuMnXi8ddUpIzRSKh3ZmCOEOdVpXoGjXHp1n2OMOKh8XYcD2JLFCTtmuIxUw==
X-Received: by 2002:a50:8386:: with SMTP id 6-v6mr7457775edi.170.1537519835298;
        Fri, 21 Sep 2018 01:50:35 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x32-v6sm2311705eda.81.2018.09.21.01.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 01:50:33 -0700 (PDT)
Date:   Fri, 21 Sep 2018 10:50:31 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mahesh Kumar <mahesh1.kumar@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] drm/vkms: Fix possible memory leak in
 _vkms_get_crc()
Message-ID: <20180921085031.GV11082@phenom.ffwll.local>
Mail-Followup-To: Wei Yongjun <weiyongjun1@huawei.com>,
        David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mahesh Kumar <mahesh1.kumar@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <1536976399-1295-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536976399-1295-1-git-send-email-weiyongjun1@huawei.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 01:53:19AM +0000, Wei Yongjun wrote:
> 'vaddr_out' is malloced in _vkms_get_crc() and should be freed before
> leaving from the error handling cases, otherwise it will cause memory
> leak.
> 
> Fixes: db7f419c06d7 ("drm/vkms: Compute CRC with Cursor Plane")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/vkms/vkms_crc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_crc.c b/drivers/gpu/drm/vkms/vkms_crc.c
> index 0a27456..9d9e814 100644
> --- a/drivers/gpu/drm/vkms/vkms_crc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crc.c
> @@ -125,6 +125,7 @@ static uint32_t _vkms_get_crc(struct vkms_crc_data *primary_crc,
>  	mutex_lock(&vkms_obj->pages_lock);
>  	if (WARN_ON(!vkms_obj->vaddr)) {
>  		mutex_unlock(&vkms_obj->pages_lock);
> +		kfree(vaddr_out);
>  		return crc;
>  	}
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
