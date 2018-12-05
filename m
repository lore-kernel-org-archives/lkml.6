Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7570C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C172082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFrAqxFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C172082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeLEVgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:36:51 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40502 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLEVgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:36:50 -0500
Received: by mail-ed1-f65.google.com with SMTP id d3so18302785edx.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+sjIeKW3FYcMFqeagTauYO4NZrxG10uwKgi88/M3S1w=;
        b=iFrAqxFWD5Bkb/ClWLF+v1m6w5iCcXLJs8Sr4GsAIP2ZHOhyvijb8ZWFlmroLSDZBa
         r8uwfXkHZkR2KwNLr639mVVesyMLEUZCLQT0IHIDvKd4Rcal+nn74pGgknYsLLK7hU5f
         wYWK8+221oUMkTFVK8XsJzctk5arE+Vm0AByZeJp/VUyrJP4rt/04NtcOCkoTaFcoFYu
         Ey4K1WKvsXStRX4+L1hYa0zpFmnK8FbYIcD67lKV8UlQhX/7VXx+Icy7oft26VKXfDvq
         Ufv2HHVnVttht8HV/KqtoRU25Zw9urpRTKxh9+io/Iul9NXlWq7vjvKGQW3K6GrIm8Wm
         xScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+sjIeKW3FYcMFqeagTauYO4NZrxG10uwKgi88/M3S1w=;
        b=J7QWn2jyO+Vg355XqwfL15U0vSAhqf+rbDXEJXXRYC1NNMz3fGdeYxxpHeY5oAKg4F
         tBsSdVBHomgJZpLeGYl/Er8EYNvVImrUjyjRvyV4NWGJC39Q3P14n3aKK6Vm7lImWVfr
         icJEYwExRVRtdV0uUv5xpKOZE1YGp95GiV+2snF7jxyG1shc1JlG1pQnqOqeAycfkl4o
         bt8A4xSPs5BAxbeyUCq75HFF5QMRtIIY2Iixa9asoTee6VleLsFlZzX2+l2UlbAIlLPh
         zHyq9MSol6QQhovbgrln2kTA6GXjwZRW9ABugGvbMC2Ob8hyrS2rWjCZmnYTRYBIGpmt
         69Uw==
X-Gm-Message-State: AA+aEWZ1+6EJ3fGPtKXsHlfRpfT1n1TEJfexngGeM/fJtYcp+jY3Ivhg
        h3YLg21p+iV/BwTtAh5Ao8x06fQI
X-Google-Smtp-Source: AFSGD/WkAd8ul/OFT3EGjlDoRVry4jF0u+YJb3NXwftyhaIkp9g01eePSmdbpOX4cnYCNwGRo0ibSA==
X-Received: by 2002:a17:906:6308:: with SMTP id p8-v6mr19910299ejk.100.1544045808658;
        Wed, 05 Dec 2018 13:36:48 -0800 (PST)
Received: from dell.be.48ers.dk (d51a5bc31.access.telenet.be. [81.165.188.49])
        by smtp.gmail.com with ESMTPSA id e35sm5763234eda.13.2018.12.05.13.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 13:36:47 -0800 (PST)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peter@korsgaard.com>)
        id 1gUeqc-000405-UZ; Wed, 05 Dec 2018 22:36:46 +0100
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "firmware: dmi_scan: Use lowercase letters for UUID"
References: <20181205211351.5309-1-peter@korsgaard.com>
Date:   Wed, 05 Dec 2018 22:36:46 +0100
In-Reply-To: <20181205211351.5309-1-peter@korsgaard.com> (Peter Korsgaard's
        message of "Wed, 5 Dec 2018 22:13:51 +0100")
Message-ID: <87mupjzmdt.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Peter" == Peter Korsgaard <peter@korsgaard.com> writes:

 > This reverts commit 712ff25450bd01366301eef81c33e865d901e7b7.
 > The output of dmi_save_uuid() is exposed to user space as
 > /sys/devices/virtual/dmi/id/*_uuid, so this breaks backwards compatibility,
 > E.G.  I have systems that include the content of dmi/id/product_uuid as part
 > of the keyphrase for cryptsetup luksOpen.

 > As the change was purely cosmetical, revert it to fix such breakage.

 > Signed-off-by: Peter Korsgaard <peter@korsgaard.com>

Sorry, this should have had a:

Cc: stable@vger.kernel.org

As 4.19 is affected. Jean, can you add that when committing?


> ---
 >  drivers/firmware/dmi_scan.c | 4 ++--
 >  1 file changed, 2 insertions(+), 2 deletions(-)

 > diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
 > index 099d83e4e910..2ed51651565f 100644
 > --- a/drivers/firmware/dmi_scan.c
 > +++ b/drivers/firmware/dmi_scan.c
 > @@ -211,9 +211,9 @@ static void __init dmi_save_uuid(const struct dmi_header *dm, int slot,
 >  	 * says that this is the defacto standard.
 >  	 */
 >  	if (dmi_ver >= 0x020600)
 > -		sprintf(s, "%pUl", d);
 > +		sprintf(s, "%pUL", d);
 >  	else
 > -		sprintf(s, "%pUb", d);
 > +		sprintf(s, "%pUB", d);
 
 >  	dmi_ident[slot] = s;
 >  }
 > -- 
 > 2.11.0


-- 
Bye, Peter Korsgaard
