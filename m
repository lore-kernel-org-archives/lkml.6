Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E40C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DBA21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYyr349l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DBA21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeK3KQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:16:41 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38661 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbeK3KQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:16:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so1780445pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OlpdAZygJoxwQGARbrL3JAIAtknNPIQhWF26Eev2Vjg=;
        b=QYyr349lxsFdAJumj01VJUpYixpUl9GkbvlbM/0Jp+jtSBxZWUjwKH138E+YMHqtTE
         x299smk6ZoFWnHpYZyQIWUr0X1AHvGQxH5lxAxI2d6xHD25bOJxsOCg364c+q0EwqI6c
         /QadlUak/BVsUJhib5zBC8xBk2RZxHthHp5z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OlpdAZygJoxwQGARbrL3JAIAtknNPIQhWF26Eev2Vjg=;
        b=BsB57Cp6/ruvOgwnEpbt2SKXVYd0Jxjk/TwFeFW8lUE0oA/Bs0ad5c6q5Dw0PAW9i8
         lO4s9nDVcQytjzdqDrweCVQAghEZ9IDN2AvGVMvX05ZvHhHzpeDoDOCdRVLamEsXyeOf
         eylrLzr4vMvnRqYgfM5nBsSDY8HgouB7KQ71I6rDx5Fi/dGGTmvtUKcipOU4mafVFg/s
         bNYYA/IFPkvLItzqJ9OBRybbA5DnHbMSR8BL1fGulpw8rg9Kg+arVvfsQP/kEerys1L7
         m7R5yxUYQUVDNm4Rkdx1pK1mxwgNoZAR5dnAzC3ATWtrFng47aQX1HVxsDSSDA7ky/8i
         sV1Q==
X-Gm-Message-State: AA+aEWZoIFnJNmZVPs3+5q4WdeagmeuM2JbIYY4ADH27C+M9OYArYumO
        MGxmJhiDq0ZGVcYxGN9xJVpI0Q==
X-Google-Smtp-Source: AFSGD/VkSEO0kPQ2oCqhRSY8s2oVgMYxe9Jm7gwdfcnEnpWWKFlBVkgNLbiLorBqJapvrVu/gRr6qw==
X-Received: by 2002:a62:4851:: with SMTP id v78mr3330119pfa.97.1543532958570;
        Thu, 29 Nov 2018 15:09:18 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id e123sm3670195pgc.58.2018.11.29.15.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 15:09:18 -0800 (PST)
Date:   Thu, 29 Nov 2018 16:09:15 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        will.deacon@arm.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ast@kernel.org,
        hpa@zytor.com, suzuki.poulosi@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/6] coresight: Use PMU driver configuration for sink
 selection
Message-ID: <20181129230915.GA8881@xps15>
References: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
 <1543442478-31465-5-git-send-email-mathieu.poirier@linaro.org>
 <20181129074936.GE12347@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129074936.GE12347@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Nov 29, 2018 at 08:49:36AM +0100, Greg KH wrote:
> On Wed, Nov 28, 2018 at 03:01:16PM -0700, Mathieu Poirier wrote:
> > This patch uses the PMU driver configuration held in event::hw::drv_config
> > to select a sink for each event that is created (the old sysFS way of
> > working is kept around for backward compatibility).
> 
> It is "sysfs", no InterCaps please, I've never called it that in the
> past.
> 
> And just use sysfs, if that does not work properly, then fix that, don't
> create yet-another-way-to-configure-this-thing to just confuse people.

Thanks for the review, you've provided usefull comments.

Regarding the "char *" argument for the ioctl, I followed an example that
currently exist but I can proceed differently.  

My goal with this patchset was specifically to fix what is wrong with sysfs and
completely take it out of the equation.  The only reason to keep the kernel 
interface alive was to prevent braking older user space perf tools currently
using it.  

I chose to use an ioctl() because it is flexible and well suited for the dynamic
nature of perf events.  It is also currently used to set various event specific 
configuration so doing the same adds to the established pattern and avoids
creating a new way of doing things, something the perf crew would have been
quick to point out.

Was my approach wrong?

Regards,
Mathieu

> 
> thanks,
> 
> greg k-h
