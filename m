Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01205C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CE421783
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRquREY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbfAJPkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:40:43 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45293 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbfAJPkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:40:42 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so4965730pgc.12;
        Thu, 10 Jan 2019 07:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sEDM8Cm8KkOdeb7wayGXYHQE+T67ai/kdB1bmLgaMGY=;
        b=cRquREY7IuRCAFM8sOcuRuDKRzsBeSdZtG8dpYjrwI7ZQOUXAjBOIXK0v1m0qz+YKs
         jsnHwuiarvrZIXi4YnbNSljs3jiCFm8ftVmLjYsYy1tHfCqABLSzp5kp5l4CrLMWaYUk
         vItVJiV6/P/ybfV1fom3FywA/xyes7BAy93hFnFor7nAIxF345ekruvzFgnI+dcS2fIN
         kIuq9iDfHqm1ktJpV54ElJS4RzlfOZyY7f10Uwpn9uxtzDRRkzHrFiuq9X63YarP57vw
         RBvFaBtbXRsJEp2hqrrHi/JYbdkrWqBKBciDQS00GQEzzlZLkhqQICf9Qtb9vXwnxhoN
         3kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sEDM8Cm8KkOdeb7wayGXYHQE+T67ai/kdB1bmLgaMGY=;
        b=t2AjdoSO4c/puRDjj4VM7b8imIplyw6CH3BEvPmAmlHKn2bF4X3tgEIu8rBMaNJ2si
         AHdUvl8F2eQ1pZc5plhnnGT85M7XLRHVuvD7aA2I/qEn3ltdtrl0t+MUxSFhhCccoWIv
         ITBWUDNzVd9jKsU80Azte6z+EWVsJjMVRjvQdpoM4WLvj5mVTqU/xPslhtxEtz+9Xa+i
         PYImdfQKYKjkXazoPno7ZB1ktWLzkh+zMAlYiK+2is3e39piM4aIRPEjNtvbJI1iO9HS
         L9OtAuVh1EfPAN8Gk2RbyaKODQf2LjcYhWWwjHN0T6bvVQ5kevR+rqaKM3G0rwv1Y4G1
         Ophw==
X-Gm-Message-State: AJcUukflYcFQdv1wE3UrcD9Pr9bxiSDk6dMOeKUHQTrk7PyhkSg6DfUm
        NfBIA9PsAJ+Awxr7Nk9uXDs=
X-Google-Smtp-Source: ALg8bN6LAud7R+pZupa2hlnAiasiBsL///OLIc8HljJKVY7AWODaLNztYaF9YhMUNMeBD3MRuNpukw==
X-Received: by 2002:a62:47d9:: with SMTP id p86mr10398418pfi.95.1547134842028;
        Thu, 10 Jan 2019 07:40:42 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e23sm111245541pfh.68.2019.01.10.07.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 07:40:40 -0800 (PST)
Date:   Thu, 10 Jan 2019 07:40:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/170] 4.19.14-stable review
Message-ID: <20190110154039.GA26814@roeck-us.net>
References: <20190107104452.953560660@linuxfoundation.org>
 <20190108230731.GC20519@roeck-us.net>
 <20190109143811.GB29274@kroah.com>
 <20190109194048.GA11505@roeck-us.net>
 <20190110065207.GA17195@kroah.com>
 <20190110131743.GE20217@kroah.com>
 <1547130295@msgid.manchmal.in-ulm.de>
 <1547133048@msgid.manchmal.in-ulm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547133048@msgid.manchmal.in-ulm.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 04:15:40PM +0100, Christoph Biedl wrote:
> Christoph Biedl wrote...
> 
> > Sorry for not getting back to you earlier. Building yesterday's
> > release (v4.19.14) *failed*, bisect led to
> >
> > | commit a9935a12768851762089fda8e5a9daaf0231808e (HEAD)
> > | Author: Breno Leitao <leitao@debian.org>
> > | Date:   Mon Nov 26 18:12:00 2018 -0200
> > |
> > |     powerpc/tm: Unset MSR[TS] if not recheckpointing
> >
> > Reverting that commit seems to be sufficient, build passes then.
> >
> > Additionally, neither 4.20 nor 5.0-rc1 show this problem. The
> > | commit 6f5b9f018f4c7686fd944d920209d1382d320e4e upstream.
> > builds as well, so I'll try to find the missing prerequisite next.
> 
> Cherry-picking
> 
> | commit 5c784c8414fba11b62e12439f11e109fb5751f38
> | Author: Breno Leitao <leitao@debian.org>
> | Date:   Thu Aug 16 14:21:07 2018 -0300
> |
> |     powerpc/tm: Remove msr_tm_active()
> 
> makes the build pass. Bruno, does this make sense?
> 
As I had reported and suggested well before the release.
According to Greg those responsible for the patch series rejected that.

Guenter
