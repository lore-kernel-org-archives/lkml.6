Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E4CC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F3D2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="A6j2roN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F3D2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeIDRcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:32:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40361 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeIDRcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:32:35 -0400
Received: by mail-ed1-f68.google.com with SMTP id j62-v6so3187356edd.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 06:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eXYuAf+JCOuTyucs3DlR2NLG8nrxiiY1cqDAsD25atk=;
        b=A6j2roN6/HJnLdDDLlIq1Nbn/F5hN5kh+cqfJpX1f2kGWc8rPwqXkZEg5c9GutX4yh
         G6WH4/rcd7cF99Z8Gli6zT9TgKWw8dldAblKBoYH/IK+pS31THBZMBIil+dld6cZRzYL
         f2Zvb3F79IuIpQLU3xUcDdyjbanH3egGfHEm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=eXYuAf+JCOuTyucs3DlR2NLG8nrxiiY1cqDAsD25atk=;
        b=Oz97ZybxVO+pcindcjSoM06kbZ2Asbb2B8yAgLbyRg5KVWzpIfYKPslwxkd3oOqyQ+
         W/H5bMVpxNkjYuukhL3LBr5pjnP7RtNnq6Zkm28eKgnCdLw+adIO/hjkGQkutJnT+zJ8
         QE9zFbdLKLqMDAPzmYViKEWi0zdC9/+3FBn2yZ+mKFfpjr0pFRcMhOnxzRKIihA34f8K
         3u/G/diIk96jXr7h3Uf53LAMY4WVfGqKYjPhlM9HlSu0V3rL4i3aJdme9ZNriKHZ3iAb
         it3O0Q85KNW8OU3ozoFI1co7TuCyMK/y/Ko7LaeRJmEFx1sd8BNwiQ3Q75vxIBDSbJwS
         9dKg==
X-Gm-Message-State: APzg51CWk4Nyujpzy05atrWO8eGBtrZl2BNbnovcEYz0o84lNuAQVvuY
        5iE/4OuOYNFGJHqC2Vrmv6y3ug==
X-Google-Smtp-Source: ANB0VdZdRrju1pEqdFrDtwFGjCRHMip3VGg8ybttv8M2nr4djWrPVuhgbYc3EkNbkhZg5p4GUXuIHA==
X-Received: by 2002:a50:c101:: with SMTP id l1-v6mr35537472edf.126.1536066450098;
        Tue, 04 Sep 2018 06:07:30 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-109.fiber7.init7.net. [212.51.149.109])
        by smtp.gmail.com with ESMTPSA id z56-v6sm15397043edz.54.2018.09.04.06.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 06:07:28 -0700 (PDT)
Date:   Tue, 4 Sep 2018 15:07:26 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     willy@infradead.org, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        airlied@linux.ie, corbet@lwn.net, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document/gpu: Use new vm_fault_t type
Message-ID: <20180904130726.GR21634@phenom.ffwll.local>
Mail-Followup-To: Souptick Joarder <jrdr.linux@gmail.com>,
        willy@infradead.org, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        airlied@linux.ie, corbet@lwn.net, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180904041505.GA2712@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904041505.GA2712@jordon-HP-15-Notebook-PC>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 09:45:05AM +0530, Souptick Joarder wrote:
> We have introduce new return type vm_fault_t for
> fault handler. Update the document for the same.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
> v2: Revert spaces added in v1

Thanks, applied to drm-misc-next.
-Daniel

> 
>  Documentation/gpu/drm-mm.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
> index 21b6b72..c3ae888 100644
> --- a/Documentation/gpu/drm-mm.rst
> +++ b/Documentation/gpu/drm-mm.rst
> @@ -297,7 +297,7 @@ made up of several fields, the more interesting ones being:
>  	struct vm_operations_struct {
>  		void (*open)(struct vm_area_struct * area);
>  		void (*close)(struct vm_area_struct * area);
> -		int (*fault)(struct vm_fault *vmf);
> +		vm_fault_t (*fault)(struct vm_fault *vmf);
>  	};
>  
>  
> -- 
> 1.9.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
