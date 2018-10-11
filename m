Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9653C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D57204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yrh9PP0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D57204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeJLDTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:19:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39654 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeJLDTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:19:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id c25-v6so4931485pfe.6;
        Thu, 11 Oct 2018 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KDY/cOnx+553uOFRwA2NY7TXZ01hRpHbDBzwaSA9o1Y=;
        b=Yrh9PP0vvA1terySneQpLQc9pTZp5QiGmmrwZrVgUw1WPQGhsT32VjxFTtVJbq67G6
         9v108fA14bpRunVD36tKmWeZhaE7TgpzdjYUhzhGLf6eXY1KfdIe5Jche+rzTEeXnuxo
         Tw/pURfL4LTxiGnZLlYZiR82FoEyvU2wetQkOH+iQZHFTIPlm5GFG22tRUuHS58IpWGM
         LDsoqQ7l1rcuiPECoH4g7hOqQas0TKfucCcjrhostjg4WxRbp2vbTx2QQS4lQoXJlB8K
         1hDTEG+a59/Ok2y105ejzDh1jzsxsp2VSKgP5f/N4T28AdQ0/6kdQnsQ0Q/pf0vVyIKD
         nioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KDY/cOnx+553uOFRwA2NY7TXZ01hRpHbDBzwaSA9o1Y=;
        b=JFIhOAJD7dRnzq/gF6ibjRq1m86LeXrMxAhQkWOfPZF36b2PD7IOvkihK3lRyzwPZz
         TiRHFGL5C1O+BuQWbLvCugEQ219M50fnk3lqyFyvA0Km/Lx1kh182aQbEXOjHPChGLwK
         BEf4N8pFcp0b9RQRilDX5bnrvV0cUopF303Ws4cxiyQzm9wwvYU7lE5HivuZguP4QV4p
         Ggi4J0hmKFxK72E6sIjAXQHP9M56WbkLuL+tUU9Xp9N1vBhPGX315VX3Sj8qQPdIoWIe
         J2gnBakbHo0oICuRR7rtW+2NS29Frc5JCKEo3m4ULAshKjUjrVwqhzjMklSNgBQHpZM0
         BmoA==
X-Gm-Message-State: ABuFfojWqgtI5OnIJSFcnfPEbf6czWz0G8epMHbSw0SqMKkwXiWyJG4a
        nZi5nQLlw+dQA/n4DYzo6dQ=
X-Google-Smtp-Source: ACcGV62UVwI94gO/ddOUUgK3fLejtFdX8DTOKAYKWnNSvyrg22zJRWDlHl43qrGiSG7zn3Th1PNAAA==
X-Received: by 2002:aa7:814f:: with SMTP id d15-v6mr2938368pfn.78.1539287427839;
        Thu, 11 Oct 2018 12:50:27 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id d10-v6sm29202998pgp.26.2018.10.11.12.50.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 12:50:27 -0700 (PDT)
Date:   Thu, 11 Oct 2018 12:50:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (ina3221) Add operating mode support
Message-ID: <20181011195025.GA7038@roeck-us.net>
References: <20181010043310.30873-1-nicoleotsuka@gmail.com>
 <20181010043310.30873-3-nicoleotsuka@gmail.com>
 <32c22986-544e-aca1-12bf-9080667cf499@roeck-us.net>
 <20181010230906.GB1706@Asurada-Nvidia.nvidia.com>
 <20181010234300.GA25480@roeck-us.net>
 <20181011002411.GA10379@Asurada-Nvidia.nvidia.com>
 <20181011193152.GA4854@roeck-us.net>
 <20181011193658.GA3828@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011193658.GA3828@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On Thu, Oct 11, 2018 at 12:36:59PM -0700, Nicolin Chen wrote:
> On Thu, Oct 11, 2018 at 12:31:52PM -0700, Guenter Roeck wrote:
> 
> > > One more question here, and this might sound a bit abuse of using
> > > the existing hwmon ABI: would it sound plausible to you that the
> > > driver powers down the chip when all three channels get disabled
> > > via in[123]_enable nodes? :)
> > > 
> > 
> > I would not call that an abuse, no.
> 
> Hmm..do you mean that you aren't in favor of powering down the chip
> after all channels get disabled?
> 
No, I was trying to say that I would be ok with powering down the chip.

> I was thinking about having pm_runtime_get_sync()/put() for channel
> enabling/disabling routine of in[123]_enable.
> 

Not sure if that would work. It might end up waking the chip when a
sysfs attribute is accessed. It might be worth a try, though.

It might also be possible to utilize userspace runtime attributes,
like setting runtime_enabled and setting the idle time before the sensor
shuts down. It would probably be necessary to implement not only
activating the sensor, though - we would also need to to ensure that
the first reading after activation waits until the first read is
complete.

Guenter
