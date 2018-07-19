Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48C6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB2C2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5KC1zLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB2C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbeGSLGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:06:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45168 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730598AbeGSLGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:06:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id q5-v6so6732013ljh.12;
        Thu, 19 Jul 2018 03:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rGwWKn29vtcxvCO/gtF2+bZliPLeWRIhSZgbVRPH6ws=;
        b=X5KC1zLUPsFD4D9+UveGsRbg4/IPQLZGH+nzz2XU+5S9C738L2oTF3tr7b8cVpjwTA
         KlIhStFNZmeC1iTA9SYUNtzAAdDwsvZCjNMFJDSHLzLflSSTYG29cjV026shQKI/+ZZO
         zhr9bJWAnI0SSxzUlXU6uWEVxBxq6MKlgbAG1G8jZmA0ZyIgtKlY7zRad7X81RcbSkhi
         tT60fvDF+ziQQCzIr3uEzODBBEX7drRbcm+a/DK5Y8oHyyUyrWvUe1vWWf9h2MdgSGBn
         fazJ2zf7w5vV+fXy+C/WwaIezirS3nwJSY94pvuOz8TTAFVjTdWbrTSVgNkYII/4t4LK
         4apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rGwWKn29vtcxvCO/gtF2+bZliPLeWRIhSZgbVRPH6ws=;
        b=oQtSFVQAx2TBej7GE8BvmOFIPPdfl5P+2zoGMv6Mhf+E/FHCa2R+A7EwseWRnzFGEt
         ucVR/Oancxud8YeftB6tHj7nMdHlzL6uEjfjILVOlpKUEP33gwXNbKltSqx9h/xfvCor
         aLEYMAHI7iSz3yafnvirhSBM3U9KuUOWuGJv/dffScudLkANR2KBD6eWKFlPjj0wZGG6
         D+9upN5/s6lOAMQd1zTu2ISy1k9mzHSByJY+Ds9v923pliPOE0IetR1Bc2oM0JJPQ7Ur
         Xn/b/YvQzs+pTOmMx/n/1ibhz0TzN7nW2ICaYCsgCTJKLpcBvsjTnV95G/NbFO0mVKhb
         7Raw==
X-Gm-Message-State: AOUpUlGiomFcF9JykROrJeWrhv0SiDStg7L5NoYlCdu6eDT83JSimlMh
        cbW4N27+vpgq3oJbOfWwmJs=
X-Google-Smtp-Source: AAOMgpcUf0Hhc1nR6tAfBHo+PVq2V4COkGmjmZzKI2kAsb2qU4mFhT0VasAERYeoPD8gPVf/nlqOcQ==
X-Received: by 2002:a2e:4357:: with SMTP id q84-v6mr7098366lja.13.1531995829681;
        Thu, 19 Jul 2018 03:23:49 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id n7-v6sm907456lfe.87.2018.07.19.03.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 03:23:48 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fg65w-00051P-TO; Thu, 19 Jul 2018 12:23:36 +0200
Date:   Thu, 19 Jul 2018 12:23:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        t-kristo@ti.com, linux-rtc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org
Subject: Re: [PATCH v4 1/4] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
Message-ID: <20180719102336.GA19245@localhost>
References: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
 <1531372060-10532-2-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531372060-10532-2-git-send-email-j-keerthy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 10:37:37AM +0530, Keerthy wrote:
> Cut down the shutdown time from 2 seconds to 1 sec. In case of roll
> over try again.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>

> @@ -435,17 +435,23 @@ static void omap_rtc_power_off(void)

> +	/* set alarm one second from now */
>  	omap_rtc_read_time_raw(rtc, &tm);
> +	seconds = tm.tm_sec;
>  	bcd2tm(&tm);
>  	rtc_tm_to_time(&tm, &now);
> -	rtc_time_to_tm(now + 2, &tm);
> +	rtc_time_to_tm(now + 1, &tm);

One more thing, the comment before final mdelay as well as that delay
itself also needs to be updated to reflect this change.

Thanks,
Johan
