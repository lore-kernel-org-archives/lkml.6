Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45A4C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A846A20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gpdmAAF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A846A20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387908AbeKFTzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:55:31 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43449 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387491AbeKFTzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:55:31 -0500
Received: by mail-ed1-f68.google.com with SMTP id e4so958359edv.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 02:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qCNoZTA95EAsmIwJMFZDys65LWxEVyaiF+lXzQbjOx8=;
        b=gpdmAAF6jpC+Hlh9AzymIvepUeHK5qeonWGhNkBZaA5nDLL/FH9crggybRIcAUNNow
         tvykKVUh0QKrzmP81q0nSmIpVjXwcoaojr4I7dJpgS6HPMVSuokWxCj5UafCuLIZhCeY
         1WNcLVZosIVLloTAFg4Jx5yTiNbdfa54HnyJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qCNoZTA95EAsmIwJMFZDys65LWxEVyaiF+lXzQbjOx8=;
        b=OYmYgJjxyw3e2c48LrICynsLT1n5f91uC7J1zgowayfqtrrVVJ2st/lBRTOVB4pVlK
         ubmeWDnNa1d+qzz+RX7rBDhp9no0LybxTmmvU5zezHEnDMxG3IQbdSQBhmARNIBudXtY
         WAjCwtnmK9u6RfgRPXAqgLuXRH0dSXn2DCNSukyMho1FYwmVUyM77m6Yeg5IosW7+P9V
         GPYC+lgdQdhRrCcxN/sKHooOREpgCqOoMfMTlf8Ts19NGEUIWt0lj+rF9SQpQYBieCfr
         0orFJB4aBwjqkEw/MX2HevydDSJHzofby23UId6WvESYSdPK/YNNkK6WkCIowU3QyLHe
         6bOA==
X-Gm-Message-State: AGRZ1gJFt1YoejS76fWGFBGh72MVo3uZBaf6+ud68MvXP+tDK3abpvDm
        mhLnaWlLzoZT/8KiT3BMgTq+SA==
X-Google-Smtp-Source: AJdET5fjzjRgsiZuJKUX5CwL0vHFl1Kd8mHkvOecWEab/x9EoLmZPeblfRMgyu8/eNq49juxlC9CQQ==
X-Received: by 2002:aa7:d7c4:: with SMTP id e4-v6mr17127247eds.69.1541500256840;
        Tue, 06 Nov 2018 02:30:56 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id dc5-v6sm1040118ejb.53.2018.11.06.02.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 02:30:55 -0800 (PST)
Date:   Tue, 6 Nov 2018 11:30:53 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Eric Anholt <eric@anholt.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/syncobj: Fix oops on
 drm_syncobj_find_fence(file_priv, 0, ...).
Message-ID: <20181106103053.GM21967@phenom.ffwll.local>
Mail-Followup-To: "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Eric Anholt <eric@anholt.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181105230110.4812-1-eric@anholt.net>
 <BY1PR12MB050299A6BA4B1967250724AAB4CB0@BY1PR12MB0502.namprd12.prod.outlook.com>
 <f3bff02c-9a71-77c8-d386-fdbedd4ce2f7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3bff02c-9a71-77c8-d386-fdbedd4ce2f7@amd.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 09:10:55AM +0000, Koenig, Christian wrote:
> Acked-by: Christian König <christian.koenig@amd.com>
> 
> Should I push it to drm-misc-next?

Yeah.

This should have broken an igt somewhere ... would be good to double check
whether that's true and why it wasn't caught. From a quick look i915
doesn't use this interface (it uses drm_syncobj_find, which isn't broken
like this), only amdgpu and v3d use this.

I guess an in-kernel unit test for these driver interfaces is what we need
here.
-Daniel

> 
> Christian.
> 
> Am 06.11.18 um 03:18 schrieb Zhou, David(ChunMing):
> > Reviewed-by: Chunming Zhou <david1.zhou@amd.com>
> >
> >> -----Original Message-----
> >> From: Eric Anholt <eric@anholt.net>
> >> Sent: Tuesday, November 06, 2018 7:01 AM
> >> To: dri-devel@lists.freedesktop.org
> >> Cc: linux-kernel@vger.kernel.org; Eric Anholt <eric@anholt.net>; Zhou,
> >> David(ChunMing) <David1.Zhou@amd.com>; Koenig, Christian
> >> <Christian.Koenig@amd.com>
> >> Subject: [PATCH] drm/syncobj: Fix oops on
> >> drm_syncobj_find_fence(file_priv, 0, ...).
> >>
> >> This broke rendering on V3D, where we almost always have a 0 in-syncobj.
> >>
> >> Signed-off-by: Eric Anholt <eric@anholt.net>
> >> Fixes: 48197bc564c7 ("drm: add syncobj timeline support v9")
> >> Cc: Chunming Zhou <david1.zhou@amd.com>
> >> Cc: Christian König <christian.koenig@amd.com>
> >> ---
> >>   drivers/gpu/drm/drm_syncobj.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_syncobj.c
> >> b/drivers/gpu/drm/drm_syncobj.c index 4dca5f7e8c4b..da8175d9c6ff 100644
> >> --- a/drivers/gpu/drm/drm_syncobj.c
> >> +++ b/drivers/gpu/drm/drm_syncobj.c
> >> @@ -443,7 +443,8 @@ int drm_syncobj_find_fence(struct drm_file
> >> *file_private,
> >>   	int ret;
> >>
> >>   	ret = drm_syncobj_search_fence(syncobj, point, flags, fence);
> >> -	drm_syncobj_put(syncobj);
> >> +	if (syncobj)
> >> +		drm_syncobj_put(syncobj);
> >>   	return ret;
> >>   }
> >>   EXPORT_SYMBOL(drm_syncobj_find_fence);
> >> --
> >> 2.19.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
