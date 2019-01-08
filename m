Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FF9C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FCF206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+pz2NYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfAHSJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:09:56 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35682 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbfAHSJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:09:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so2309897pfi.2;
        Tue, 08 Jan 2019 10:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=A4T96aVnkk14EUshgXHrRiI8oQv7bz3X/CAGzgbeLXs=;
        b=g+pz2NYrOnz/R8/UEv2/GjpyismiELQPnu5/11xNBfDxpSzR3iOL00lUxvkzlFpKlc
         UA1kGN5WBrYVm5zYqNkBI7ai4F0SYRQH9AhhQotR4UwiHsJBlI7IJUjwWrqj9rJjv0dc
         T0vhnVDNEjDOarNfOGB/SdeBWo8RGi2vJovSVe3LkJWWtIAr7cxrWnzyCXPON0a9MmdR
         Ul62MaU1957aLzQzuC8n8AlOZGBPdwWwskDnHiQt5PgiUzpK4tk9vkHVcVIMzsJi2ERd
         bq6XVMQlwKlaB+5LvBfdLY/kKz1eAx6zJdt1ldNSq1vqEPKMm2aummF5g4d29PORv5K/
         7g5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=A4T96aVnkk14EUshgXHrRiI8oQv7bz3X/CAGzgbeLXs=;
        b=UySBkC0u1S2EtYL5XG4x4eWyTQEAj7BdzAFYRj/T1yYBL1TbjX7p2s+00x/wO30yjM
         Ma0SUN7hpg1dLEE9m3dsrzyuUnW3eA8/L7g2pqxWVXBy+mErKNIzrvjM40bGidcVgDGx
         9elSW1Vwy43mPCxPTeYmjDnUppbwPv2DIfQIfcz0Vi99fFrLRBBeGXqd0armWmqCIyqX
         ZF50+GVRzbtuDVaeEmG+tUaL7QE6XFRD+W5D0mVUxIYnZggOFCyME9/JjWzwf6XfeKiz
         9AVY6eDc5nxkbypILD+TwmIWyzzybKmOK6RfTccPF84qj7/1Iw5BqKkmx6dynfrC5ynu
         Ve/w==
X-Gm-Message-State: AJcUukcSR9T/oZPYQvnv1cvCDpK76x1NlLqua7XqFOshcmFdOnXkDWAV
        bN1807RfZJOm8ailVruw4cjbYZI/
X-Google-Smtp-Source: ALg8bN5c7INaHd0c+dGLbv0kqvyJG+OjF4aj9MQTTbs++DkjxG4H4oaS0eEES6faXC+v+hZYk+TnuA==
X-Received: by 2002:a62:1112:: with SMTP id z18mr2703195pfi.173.1546970993886;
        Tue, 08 Jan 2019 10:09:53 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v15sm100675431pfn.94.2019.01.08.10.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 10:09:52 -0800 (PST)
Date:   Tue, 8 Jan 2019 10:09:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/170] 4.19.14-stable review
Message-ID: <20190108180951.GB28031@roeck-us.net>
References: <20190107104452.953560660@linuxfoundation.org>
 <20190108172503.GA28031@roeck-us.net>
 <20190108175640.GA2461@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190108175640.GA2461@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 06:56:40PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 08, 2019 at 09:25:03AM -0800, Guenter Roeck wrote:
> > On Mon, Jan 07, 2019 at 01:30:27PM +0100, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.19.14 release.
> > > There are 170 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Wed Jan  9 10:43:54 UTC 2019.
> > > Anything received after that time might be too late.
> > > 
> > 
> > Still (for v4.19.13-171-gc68ce175c3b8):
> > 
> > arch/powerpc/kernel/signal_64.c: In function ‘sys_rt_sigreturn’:
> > arch/powerpc/kernel/signal_64.c:761:21: error: ‘msr’ undeclared 
> > 
> > AFAICS commit 5c784c8414fba ("powerpc/tm: Remove msr_tm_active()") is missing.
> 
> Breno on this thread just said that this patch should not be applied,
> and another one will be submitted upstream instead to solve the problem
> correctly and then we can backport it.
> 
> So we can live with this build issue for now.
> 

I think you should drop the offending patch in this case. It doesn't make
sense to keep it - all it accomplishes is to break various builds. What is
the point of doing that ? Is that somehow better than living with the bug
it is supposed to fix ?

Guenter
