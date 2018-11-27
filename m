Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444C1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12252208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12252208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeK1HcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:32:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34293 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeK1HcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:32:08 -0500
Received: by mail-pg1-f194.google.com with SMTP id 17so8390296pgg.1;
        Tue, 27 Nov 2018 12:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CyjZw2SClYd5GKPa1IfYkUZgjlfWdQPEIm3F9g0YCso=;
        b=cj8/rj3m3hEvtfIpjl81q/ggGNy6NUWcpUKmds8B+FzuDCvUJy9s1qw7UHQMoE9Oqa
         W4tA1Pvy0iFxOcwdatIHcHNiSiKZDB2OPktCGwOhTXUNwoXWkLG0QZ6SuGNKeqqkMONe
         GTV0R1yCvfIVHUgkMFFWwnwPHOxYsNLsKRmbVHmSEv8C0oRYo+MSbC0B/nu+dyqZ48wU
         GxQuThantIsX7saD6RzJD/JtzVW+V+97KLfkwzvZ0MzF0YOras5Wjt5vrYyCo0cSf9Tv
         qXUIKXF5CevOdg134QVNC7F7dnGrGh+08y23YOHMGGLWMS+F6hJzf5Szme8WwYqd5ryX
         7otQ==
X-Gm-Message-State: AA+aEWYgC3+tN74E24JiWfxgo/n9liFYMReHZRY6sOihhj8nVrFGCMUr
        nM/OXuurUN6cq7coVQqe1CU=
X-Google-Smtp-Source: AFSGD/UJW4hDtVA4/xAzbAHW3EOuSlq9VZTOn/wXDHYgldP+wrSz/aAvtPU4UtZytk+N4GrP4ajGgA==
X-Received: by 2002:a63:588:: with SMTP id 130mr30103759pgf.273.1543350782189;
        Tue, 27 Nov 2018 12:33:02 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id p83sm12711749pfi.85.2018.11.27.12.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 12:33:01 -0800 (PST)
Message-ID: <1543350780.185366.81.camel@acm.org>
Subject: Re: [driver-core PATCH v6 9/9] libnvdimm: Schedule device
 registration on node local to the device
From:   Bart Van Assche <bvanassche@acm.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        alexander.h.duyck@linux.intel.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        jiangshanlai@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>
Date:   Tue, 27 Nov 2018 12:33:00 -0800
In-Reply-To: <CAPcyv4gWwsYOeXVNDoDy4v=SU6bRyBG1fgSu84y64jGApaJ91g@mail.gmail.com>
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
         <154170044652.12967.17419321472770956712.stgit@ahduyck-desk1.jf.intel.com>
         <CAPcyv4jmTbHZbs2KHhH2_S6=mxxkwdiJCDL6widexMzePhNFBg@mail.gmail.com>
         <2031cf4705d76dd4d0f722a600a6a106cce2ba41.camel@linux.intel.com>
         <CAPcyv4gWwsYOeXVNDoDy4v=SU6bRyBG1fgSu84y64jGApaJ91g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-27 at 11:34 -0800, Dan Williams wrote:
+AD4 On Tue, Nov 27, 2018 at 10:04 AM Alexander Duyck
+AD4 +ADw-alexander.h.duyck+AEA-linux.intel.com+AD4 wrote:
+AD4 +AD4 
+AD4 +AD4 On Mon, 2018-11-26 at 18:21 -0800, Dan Williams wrote:
+AD4 +AD4 +AD4 On Thu, Nov 8, 2018 at 10:07 AM Alexander Duyck
+AD4 +AD4 +AD4 +ADw-alexander.h.duyck+AEA-linux.intel.com+AD4 wrote:
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 Force the device registration for nvdimm devices to be closer to the actual
+AD4 +AD4 +AD4 +AD4 device. This is achieved by using either the NUMA node ID of the region, or
+AD4 +AD4 +AD4 +AD4 of the parent. By doing this we can have everything above the region based
+AD4 +AD4 +AD4 +AD4 on the region, and everything below the region based on the nvdimm bus.
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 By guaranteeing NUMA locality I see an improvement of as high as 25+ACU for
+AD4 +AD4 +AD4 +AD4 per-node init of a system with 12TB of persistent memory.
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 It seems the speed-up is achieved with just patches 1, 2, and 9 from
+AD4 +AD4 +AD4 this series, correct? I wouldn't want to hold up that benefit while
+AD4 +AD4 +AD4 the driver-core bits are debated.
+AD4 +AD4 
+AD4 +AD4 Actually patch 6 ends up impacting things for persistent memory as
+AD4 +AD4 well. The problem is that all the async calls to add interfaces only do
+AD4 +AD4 anything if the driver is already loaded. So there are cases such as
+AD4 +AD4 the X86+AF8-PMEM+AF8-LEGACY+AF8-DEVICE case where the memory regions end up still
+AD4 +AD4 being serialized because the devices are added before the driver.
+AD4 
+AD4 Ok, but is the patch 6 change generally useful outside of the
+AD4 libnvdimm case? Yes, local hacks like MODULE+AF8-SOFTDEP are terrible for
+AD4 global problems, but what I'm trying to tease out if this change
+AD4 benefits other async probing subsystems outside of libnvdimm, SCSI
+AD4 perhaps? Bart can you chime in with the benefits you see so it's clear
+AD4 to Greg that the driver-core changes are a generic improvement?

Hi Dan,

For SCSI asynchronous probing is really important because when scanning SAN
LUNs there is plenty of potential for concurrency due to the network delay.

I think the following quote provides the information you are looking for:

+ACI-This patch reduces the time needed for loading the scsi+AF8-debug kernel
module with parameters delay+AD0-0 and max+AF8-luns+AD0-256 from 0.7s to 0.1s. In
other words, this specific test runs about seven times faster.+ACI

Source: https://www.spinics.net/lists/linux-scsi/msg124457.html

Best regards,

Bart.
