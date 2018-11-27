Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACD3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B9E2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZVUQY0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B9E2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeK1AFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:05:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36029 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbeK1AFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:05:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id t3so22621247wrr.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 05:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yG5TnrGBBSyY7y8CYALHOUUTvp7hV2LYNKUOXmb+v4A=;
        b=HZVUQY0Ri8iSRtLMjsXYfQ3JP6rVv+EsaSH5Cl3dNElPBc2HBtNBBxqrSNdD3gB5f3
         x67T6exXb7jsaQD6VKXa9NNRByUkrsDGAG+si4N6p33d42/7x57IPK8TrKsVCN+Lgzoi
         s8HhJM6C9ql2DJ4b8SlUPkTTjkM9FxNnOHwBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yG5TnrGBBSyY7y8CYALHOUUTvp7hV2LYNKUOXmb+v4A=;
        b=kNnz3dVRT9OIjaxiqB5kCBf/pi+60IQn830xPq1hh2Qovi4m8yDmd8RHQGP+rSfcq/
         dnnWqhAg4Oj0LSJLRgPDCp1otd5CDKRhL18WnuOBHneMOdxds8KeK3CZqd/IkP2HiR48
         QpngYLSAHMiYVK5EZJUgZuAYfIpk64JnU5TZyaRE+Aw8KYZfs+i1Ax0Dbr7M+P+i6Eqi
         99Bc3awYQOSeAqQvJFeA8FRzI6qdmvs6RIKaxOdgCAnvYk+txBntjfn88EKOqJy4/UQ3
         3grz3/MS+9pqemHyZNjes56VG4JFN/Ldtdd0TZI3s8+IMx0Mh62lbM/ODkJGNaOTXqGR
         6Vzw==
X-Gm-Message-State: AA+aEWZ7kSdTTmBdhW3bL5GQ6NnqWyEbptBeyhL/xVrWydu8iO8a/0sh
        QVF3WnFMSAKesb3aNdQ9MdHihA==
X-Google-Smtp-Source: AFSGD/U6LtNlkeSPnVpaDEjpNHdfDPeK8FM4uCMRR4Ir7aRnDogYuac8WdnakoYxdhAuiZ/TXE+lhA==
X-Received: by 2002:adf:9467:: with SMTP id 94mr27215335wrq.305.1543324033890;
        Tue, 27 Nov 2018 05:07:13 -0800 (PST)
Received: from dell ([2.27.35.241])
        by smtp.gmail.com with ESMTPSA id h131sm6055585wmd.17.2018.11.27.05.07.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 05:07:13 -0800 (PST)
Date:   Tue, 27 Nov 2018 13:07:11 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, David Dajun Chen <dchen@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 02/11] mfd: da9055-core: make it explicitly non-modular
Message-ID: <20181127130711.GL4272@dell>
References: <1542861179-8941-3-git-send-email-paul.gortmaker@windriver.com>
 <201811231036.wIjm7GBh%fengguang.wu@intel.com>
 <20181123031456.GD14659@windriver.com>
 <20181123144328.GE14659@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181123144328.GE14659@windriver.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018, Paul Gortmaker wrote:

> [Re: [PATCH 02/11] mfd: da9055-core: make it explicitly non-modular] On 22/11/2018 (Thu 22:14) Paul Gortmaker wrote:
> 
> > [Re: [PATCH 02/11] mfd: da9055-core: make it explicitly non-modular] On 23/11/2018 (Fri 10:21) kbuild test robot wrote:
> > 
> 
> [...]
> 
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >    drivers/mfd/da9055-i2c.o: In function `da9055_i2c_remove':
> > > >> drivers/mfd/da9055-i2c.c:53: undefined reference to `da9055_device_exit'
> > 
> > Thanks for the report -- I'll look into what causes it, why my testing
> > didn't see it, and get an update to Lee as soon as possible.
> 
> OK, mystery solved.  I chose this smaller subset of MFD "simple" patches
> from my pending queue of MFD patches - to create a reasonable sized
> maintainer-friendly send, based on patches with zero runtime changes.
> 
> My other pending MFD patches have a trivial runtime behavior change;
> deleting a ".remove" field/function - that will never be used for a
> non-module case, but in theory could be (pointlessly) triggered by
> forcing a driver unbind.  (see mainline 98b72b94def9 as an example)
> Patches like this were left behind for a future send batch.

What about when .remove() is invoked during shutdown?

> Unfortunately that allowed me to overlook the fact that patch #2 link
> depended on the below ".remove" patch (not sent) to be applied 1st.
> 
> Lee, what would you like to have happen?  I can resend the queue with
> this patch, or I can resend with #2 being temporarily deferred until
> a future patch batch that has the below da9055-i2c in it, or ...
> 
> Whatever is easiest for you - let me know.
> 
> Paul.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
