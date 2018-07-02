Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D9AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E18A24FBF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="U7W5o3t+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E18A24FBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933260AbeGBHas (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:30:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45703 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753437AbeGBHac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:30:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id g15-v6so6602708edr.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 00:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qnuz0Yfl04HEPzOhn5H8N9AZZdaWM/A5BlCEhIYSb+g=;
        b=U7W5o3t+GPk9EDNJstVjl8wzsvRgdXUsgCfw1Qw7cUbRICBa29B4BWZEJN761gyi/L
         z+wBT5wbB3PI9EvX6jFp1hrwTHMdKnHdLgABGuDmkjOxtq78erTj8AmsQajYrSEBW1w0
         TVc1EHI/mvi5b9aEQvy8GmMlY5T5XzbK24oAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=qnuz0Yfl04HEPzOhn5H8N9AZZdaWM/A5BlCEhIYSb+g=;
        b=uiQ+Kf/QfsuxEMJYm0MbAObTz7Pm1GJJgRNBnFy4cuQCP0ZUuvNQTDfrJJdpLSZ7FP
         pFyI+KV1BHjCmdvfwlhR4WA1gkKs0wR4lutP4iBTyNJtWNfQH2fVA7M+wY1P5gJvBmCB
         k3xR3VkY57tMfHQuksflTCR+Tsi+iIVZyDJMpJpHep4CQwfxabLYWTClLgV1izoOfwN6
         oJjXtRKBuWC1/a51FcdjC40G7K5ObOkUaGBf7FR/9T6/bbBLNTRZT13D+39Res/MK9Gw
         K4g3RHAhQfFo2OWOWS2UeGFBdgWoIK4kjwkZ1cKK7I8gp74/OqHBpPs2MLtjSBAtuC0i
         8shA==
X-Gm-Message-State: APt69E0ew1AZDG8IP9MhZbkW0aUI9Bmv8Fd4YG4JeGrawt7tbb3kmlGw
        UNBHjJ3OQpPDnygSGjER2Z7M/A==
X-Google-Smtp-Source: AAOMgpfG3VttCsTDui6+XjjI/YCUqKH4eCjpyQY4mKdIWr/pnHFgNtLmxSiPKvgQU9dtS0FBUtiGPg==
X-Received: by 2002:a50:9e6c:: with SMTP id z99-v6mr22669682ede.170.1530516631453;
        Mon, 02 Jul 2018 00:30:31 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id o15-v6sm7050117edt.4.2018.07.02.00.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 00:30:30 -0700 (PDT)
Date:   Mon, 2 Jul 2018 09:30:28 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yisheng Xie <ysxie@foxmail.com>, b.zolnierkie@samsung.com,
        keescook@chromium.org, j.w.r.degoede@gmail.com,
        david@lechnology.com, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] fbcon: introduce for_each_registered_fb() helper
Message-ID: <20180702073028.GZ13978@phenom.ffwll.local>
Mail-Followup-To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yisheng Xie <ysxie@foxmail.com>, b.zolnierkie@samsung.com,
        keescook@chromium.org, j.w.r.degoede@gmail.com,
        david@lechnology.com, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <1530202809-24105-1-git-send-email-ysxie@foxmail.com>
 <ffe03b382ee84dbef8567b7377b929e4a8d6c23c.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffe03b382ee84dbef8567b7377b929e4a8d6c23c.camel@linux.intel.com>
X-Operating-System: Linux phenom 4.16.0-2-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 07:20:13PM +0300, Andy Shevchenko wrote:
> On Fri, 2018-06-29 at 00:20 +0800, Yisheng Xie wrote:
> > Following pattern is often used:
> > 
> >  for (i = 0; i < FB_MAX; i++) {
> >         if (registered_fb[i]) {
> >                 ...
> >         }
> >  }
> > 
> > Therefore, as Andy's suggestion, for_each_registered_fb() helper can
> 
> Suggested-by then ?
> 
> > be introduced to make the code easier to read and write by reducing
> > indentation level. It also saves few lines of code in each occurrence.
> > 
> > This patch convert all part here at the same time.
> 
> LGTM except macro implementation. That's why I have mentioned
> for_each_pci_bridge() to look at.
> 
> > +#define for_each_registered_fb(i)		\
> > +	for (i = 0; i < FB_MAX; i++)		\
> > +		if (registered_fb[i])
> > +
> 
> This needs to be protected against nested conditionals.
> Otherwise compiler issues a warning and even may generate wrong code.

See for_each_if() in include/drm/drmP.h ... we should probably lift that
into a general header. The for_each_if() is used all over drm in iterator
macros, exactly to avoid surprises.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
