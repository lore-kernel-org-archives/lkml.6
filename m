Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F685C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE56B2238E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="USFvtvQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE56B2238E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeHIWSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:18:38 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40163 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeHIWSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:18:38 -0400
Received: by mail-pl0-f67.google.com with SMTP id s17-v6so2976687plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K0C5EfJYX/VLCol+e7qiMZZQclTTNWSM3ViZXpefC7g=;
        b=USFvtvQW/h690lHqRnCDiBy0N2VNhZy0Sp/zT7birLiM8vwiqNU8rueMnR5WJbDlZ2
         c+Dkuw7n1nIpgyN8ALGyHf6cIPubuWYIHKq/JtoLsIPml3+64pCiJ+1pOxiL4Syq/qmd
         sOJTJuTajR6m/nYY2mwQW8Rh03BFTX6IKgXTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K0C5EfJYX/VLCol+e7qiMZZQclTTNWSM3ViZXpefC7g=;
        b=taCL2kwuDFdjRwba/jsScTLVsH9ydHcfqyKHb+tAfn5B+HbQ/fOuI0HCLaNCm4d3mZ
         36aEnQ9hfdPqUw05hDyqJThEjXKIG+v431WkvuI7GHgv6LU3kyhnWnVWMo2tiU82rV4Y
         9pTNBx9WML3ULja5Pb8/GLTzrwdF8R8uz/PGM+rw6JzTpDnpGzh9FaXiIYHzSXzYhF2E
         ymjNeOrsN9t7e6YnNKsVGVSe0pFegr61v1MKIBZoKTBY8DerTELwDv6IK+pvqFEFanLg
         liO2pRXyjYb0PxEke9L4XGTJUkYGGHNftkdZ0NQUFGpzsz1eWKd/lgOMSfW9OEfxtZ7U
         eKHQ==
X-Gm-Message-State: AOUpUlEo1ByqWNDrpYC7hq6Q9g3AWGdltoswGzCdS3rob/kN72vupJMs
        Sq7d6brC1RPzFeA4F1dH9tXcNw==
X-Google-Smtp-Source: AA+uWPxntaSn0yzkwkRr9H1MplDZ5ByFjwiOquYDOeRwdiL9lgCaYGXmM+BhC1P+kH4GFZi6KlAKVA==
X-Received: by 2002:a17:902:b609:: with SMTP id b9-v6mr3230243pls.321.1533844337377;
        Thu, 09 Aug 2018 12:52:17 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id m15-v6sm15221205pfk.149.2018.08.09.12.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 12:52:16 -0700 (PDT)
Date:   Thu, 9 Aug 2018 12:52:13 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 2/7] firmware: coreboot: Unmap ioregion on failure
Message-ID: <20180809195211.GA137192@ban.mtv.corp.google.com>
References: <20180809171722.144325-1-swboyd@chromium.org>
 <20180809171722.144325-3-swboyd@chromium.org>
 <20180809174936.GC129285@ban.mtv.corp.google.com>
 <153384363124.220756.3747855789935101539@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153384363124.220756.3747855789935101539@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 09, 2018 at 12:40:31PM -0700, Stephen Boyd wrote:
> Quoting Brian Norris (2018-08-09 10:49:38)
> > On Thu, Aug 09, 2018 at 10:17:17AM -0700, Stephen Boyd wrote:
> > > Both callers of coreboot_table_init() ioremap the pointer that comes in
> > > but they don't unmap the memory on failure. Both of them also fail probe
> > > immediately with the return value of coreboot_table_init(), leaking a
> > > mapping when it fails. Plug the leak so the mapping isn't left unused.
> > > 
> > > Cc: Wei-Ning Huang <wnhuang@chromium.org>
> > > Cc: Julius Werner <jwerner@chromium.org>
> > > Cc: Brian Norris <briannorris@chromium.org>
> > > Cc: Samuel Holland <samuel@sholland.org>
> > > Fixes: 570d30c2823f ("firmware: coreboot: Expose the coreboot table as a bus")
> > 
> > I suppose this is fair, since that commit introduced error paths and
> > didn't clean them up. But one warning below:
> > 
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > ---
> > >  drivers/firmware/google/coreboot_table.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
> > > index 19db5709ae28..0d3e140444ae 100644
> > > --- a/drivers/firmware/google/coreboot_table.c
> > > +++ b/drivers/firmware/google/coreboot_table.c
> > > @@ -138,6 +138,9 @@ int coreboot_table_init(struct device *dev, void __iomem *ptr)
> > >               ptr_entry += entry.size;
> > >       }
> > >  
> > > +     if (ret)
> > > +             iounmap(ptr);
> > 
> > This works because no sub-driver is using this mapping any more (i.e.,
> > because we killed coreboot_table_find()). Otherwise, we'd need to
> > explicitly kill all the sub-devices first. IOW, if this gets backported
> > to older kernels, it would need to go along with this and its other
> > dependencies:
> 
> The memory is copied out of the table. So do the devices actually use
> the memory that we remap here? I don't see how it's a problem if we
> unmap the table after we populate devices.

No, the memory is (or was) copied each time. See:

int coreboot_table_find(int tag, void *data, size_t data_size)
{
...
	memcpy_fromio(&header, ptr_header, sizeof(header));
...

(where ptr_header is an alias for 'ptr')

So before commit b616cf53aa7a and friends, this patch is a bad idea.

Just to reiterate/clarify: none of this is a criticism of this patch as
applied to mainline. It's just a criticism of what might happen with the
'Fixes' tag if we aren't careful.

Brian


> > b616cf53aa7a firmware: coreboot: Remove unused coreboot_table_find
