Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ED7C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3A12082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544484914;
	bh=w5Laf/kjI1DF3+HmTaLogMArxC5rwqyVriqkK2x6J/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cU4sF/sUSczAnuA66+V3tddITHtJBM54XT1CF3s0IimxeQfHU/9sxAryhSkTqrvgP
	 f2tZqXTvTxvf+uvoJVoMItZcFWy96fqDskSrjhK724chgj7QK1uqyHnKTuWznw/Lrr
	 LqLQkMJSnLGS5GrDwerAe0giypIP5a/SMBQqJV2g=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3A12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeLJXfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:35:13 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33899 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeLJXfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:35:12 -0500
Received: by mail-yb1-f193.google.com with SMTP id k136so2304109ybk.1;
        Mon, 10 Dec 2018 15:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5yQoZ8P88jYpTwwM04yDXYAth/HKueoRZjwW5RziMBI=;
        b=NFTRwaljona+ybLq6Pwguntw12rXAWpUZrXJ9RIwK/QyB+X1qwNM8GosH/92bagefL
         ns4cSvH8ekL/7KpAcPeH0IWoILsfswpj2QqB43v9nrG232c2I3ivUUjkgpDnQ/AFMT03
         T4cIVztPrpp0EnxDAAYSGrtavsQmdY3yc0yjL+0qLHIDmFg1/9qCh7UjlvmWzNsjUZ3+
         /G2DG4XxXkNkLgxW0tA0nozQwFtDzwdtGWebUKUlJDLxKlit1xT1EJSnxOZWr1RNA8Jh
         glFSVQi0RZ74b0Hf8DuOpBKE4TMLNUoCFzRV7XE+bxEQir9eI6JH0H7gMriNoJAsshCz
         rsrg==
X-Gm-Message-State: AA+aEWakfYUy0XWgVBrGcXjqjt7o8tWDAcwjWeyiAaAKUPA+nZw4qhf6
        DZwtSwdZSkEPBdhUFTIFBGs=
X-Google-Smtp-Source: AFSGD/Wth5rN23AQfLBmvDc+/dKWZGjhYmxBJ6yZoc23UJguBmSQbTpZSCdHlTiYbjZiz28b90Pbpg==
X-Received: by 2002:a25:75c3:: with SMTP id q186mr9245964ybc.506.1544484910801;
        Mon, 10 Dec 2018 15:35:10 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id j137sm4376707ywj.57.2018.12.10.15.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 15:35:09 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Mon, 10 Dec 2018 15:35:07 -0800
Date:   Mon, 10 Dec 2018 15:35:07 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org
Subject: Re: [driver-core PATCH v8 0/9] Add NUMA aware async_schedule calls
Message-ID: <20181210233507.GK28501@garbanzo.do-not-panic.com>
References: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
 <20181210192216.GJ28501@garbanzo.do-not-panic.com>
 <dd0b44d5dd9d19ac6735f80ae66bb437ec55b2cf.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd0b44d5dd9d19ac6735f80ae66bb437ec55b2cf.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 03:25:04PM -0800, Alexander Duyck wrote:
> On Mon, 2018-12-10 at 11:22 -0800, Luis Chamberlain wrote:
> > On Wed, Dec 05, 2018 at 09:25:13AM -0800, Alexander Duyck wrote:
> > > This patch set provides functionality that will help to improve the
> > > locality of the async_schedule calls used to provide deferred
> > > initialization.
> > > 
> > > This patch set originally started out focused on just the one call to
> > > async_schedule_domain in the nvdimm tree that was being used to defer the
> > > device_add call however after doing some digging I realized the scope of
> > > this was much broader than I had originally planned. As such I went
> > > through and reworked the underlying infrastructure down to replacing the
> > > queue_work call itself with a function of my own and opted to try and
> > > provide a NUMA aware solution that would work for a broader audience.
> > > 
> > > In addition I have added several tweaks and/or clean-ups to the front of the
> > > patch set. Patches 1 through 4 address a number of issues that actually were
> > > causing the existing async_schedule calls to not show the performance that
> > > they could due to either not scaling on a per device basis, or due to issues
> > > that could result in a potential deadlock. For example, patch 4 addresses the
> > > fact that we were calling async_schedule once per driver instead of once
> > > per device, and as a result we would have still ended up with devices
> > > being probed on a non-local node without addressing this first.
> > 
> > No tests were added. Again, I think it would be good to add test
> > cases to showcase the old mechanisms, illustrate the new, and ensure
> > we don't regress both now and also help us ensure we don't regress
> > moving forward.
> > 
> > This is all too critical of a path for the kernel, and these changes
> > are rather instrusive. I'd readlly like to see test code for it now
> > rather than later.
> > 
> >   Luis
> 
> Sorry about that. I was more focused on the rewrite of patch 2 and
> overlooked the comment about lib/test_kmod.c.
> 
> I'll look into it and see if I can squeeze it in for v9.

Superb!

  Luis
