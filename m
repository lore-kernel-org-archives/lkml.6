Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627F0C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151192081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544469743;
	bh=GoODwZ0Fvc8MLJQyTTY55DMhigKCagy+mClUXIKAHtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F2VT4PnSkWEtKsQ1rbx3TomILZM83Z3hgF9cOcTRG5YhhKVg99TvCA2vrQYVercWn
	 E+Ble2rzeVOl72d7fq2PtUbnbifqc/bCQYAV5FJvZ9A5mjVG+MPRBjnMs3oAvSD5OH
	 vGHBSrBTCTcnplDJUF/uxCPT7GdwC+zNorMg6pb8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151192081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbeLJTWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:22:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43263 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbeLJTWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:22:21 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so5409862pgk.10;
        Mon, 10 Dec 2018 11:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AVo+u9NLR/oBW9gZDhAvRM7N9iNds4jkmmwfCuJ9nlM=;
        b=oJB9ualk7YQt7uqyyUrMUV+9MDCKson9bYfwZW/KGt9/DiXukKa48u0E2V6sDHCoTs
         zRrJO7fj/E1Pm72EAQm7dq1/iTJexI6CWgnTAe3aNuSkCkN/BY44+ksuc+maPlNUOV5L
         nKQQTyEv1KmhPS4Ak2swOS90nh/tWg1qQAw3bKYRmuKrJT+UBJ3VuhuSNdfQCCyFM6G9
         VomDLvrSGzD6min9sJ+oy3/2V2ijRjP3USzKpolB2A4cKUDvCOjzPEi5ucvRuUOtwXbH
         u/dSACxNvD/pK0P13DN3F85RqjM7euV+TyqcPT+8V+2kmBXfi7OB+4jmv/oR7+S6ePjG
         tM4w==
X-Gm-Message-State: AA+aEWbF44BDckgfUfNB40R8NyjthK7TUm/8BZ7ePKYodDTMYQhi9qGC
        41zVqe759w7z5N9ItXZwFNs=
X-Google-Smtp-Source: AFSGD/UABbjkxuxAqj3cO+4bHkJGbakrZYJazNiL4fV4TtnA8CCHOWfby/wxQE0qtlrp9x4p/rj48w==
X-Received: by 2002:a62:2292:: with SMTP id p18mr13875865pfj.9.1544469740247;
        Mon, 10 Dec 2018 11:22:20 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id a18sm16312820pgj.30.2018.12.10.11.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 11:22:19 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Mon, 10 Dec 2018 11:22:16 -0800
Date:   Mon, 10 Dec 2018 11:22:16 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org
Subject: Re: [driver-core PATCH v8 0/9] Add NUMA aware async_schedule calls
Message-ID: <20181210192216.GJ28501@garbanzo.do-not-panic.com>
References: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 09:25:13AM -0800, Alexander Duyck wrote:
> This patch set provides functionality that will help to improve the
> locality of the async_schedule calls used to provide deferred
> initialization.
> 
> This patch set originally started out focused on just the one call to
> async_schedule_domain in the nvdimm tree that was being used to defer the
> device_add call however after doing some digging I realized the scope of
> this was much broader than I had originally planned. As such I went
> through and reworked the underlying infrastructure down to replacing the
> queue_work call itself with a function of my own and opted to try and
> provide a NUMA aware solution that would work for a broader audience.
> 
> In addition I have added several tweaks and/or clean-ups to the front of the
> patch set. Patches 1 through 4 address a number of issues that actually were
> causing the existing async_schedule calls to not show the performance that
> they could due to either not scaling on a per device basis, or due to issues
> that could result in a potential deadlock. For example, patch 4 addresses the
> fact that we were calling async_schedule once per driver instead of once
> per device, and as a result we would have still ended up with devices
> being probed on a non-local node without addressing this first.

No tests were added. Again, I think it would be good to add test
cases to showcase the old mechanisms, illustrate the new, and ensure
we don't regress both now and also help us ensure we don't regress
moving forward.

This is all too critical of a path for the kernel, and these changes
are rather instrusive. I'd readlly like to see test code for it now
rather than later.

  Luis
