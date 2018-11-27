Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0E4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09341208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09341208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbeK1IVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:21:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46413 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeK1IVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 03:21:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so16226082ply.13;
        Tue, 27 Nov 2018 13:22:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nqoAMvF8uoc2ofcZrCf3WAbH+onND6B9EOQ3JZarplo=;
        b=JCIqQwEoH2u2rKnwJqRaCMcmr4cGnLTJQB4zIN+Yke+DmvkuZ25aywTyqw27G1a3L5
         ieISNQwt4PtOVd41QKWU7RFnoFUpg5j03oigN7rPH3p31BH7O00G5KhPJJ5O0C8+eMHE
         4qUI3iLUTP+faWUUWPtUNkXu4hg4X5vWf12RBIUgvVOzcXNANPaJsTUPqBqY+tm4/GFS
         uBRPsdKXcwZrI38AZWXoV4gLhgaKgnJ5/X6gNIa2y8Y8IxsDpiYRyWk8R9t+wgWvGvup
         NvBZlTEEJqgeU+qfia824U3UdokJw7zM2qPAQesT6M2P1J28SBc7j8zVqgq/sx4LSCD7
         6NWA==
X-Gm-Message-State: AA+aEWavqTY/lX9UweK9lmP7Dd/AcqkaTL3t0X1FYlbE/GoWEAVEOFvW
        wPZbEOg0WxOzaTwnL0mcG9c=
X-Google-Smtp-Source: AFSGD/X60dEODaWxg5UtRvSGO0QJ5NALVlT3lOlr+CCglupXZWifvH4wr7Xvn794bOgl7D8g567UVg==
X-Received: by 2002:a17:902:728c:: with SMTP id d12mr18872417pll.284.1543353749604;
        Tue, 27 Nov 2018 13:22:29 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id d202sm7230723pfd.58.2018.11.27.13.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 13:22:28 -0800 (PST)
Message-ID: <1543353746.185366.90.camel@acm.org>
Subject: Re: [driver-core PATCH v6 9/9] libnvdimm: Schedule device
 registration on node local to the device
From:   Bart Van Assche <bvanassche@acm.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     alexander.h.duyck@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        jiangshanlai@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Date:   Tue, 27 Nov 2018 13:22:26 -0800
In-Reply-To: <CAPcyv4hya0ASfVue6GH3ZXKJOzytQXDqtEWxvrEdCTcb545tYg@mail.gmail.com>
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
         <154170044652.12967.17419321472770956712.stgit@ahduyck-desk1.jf.intel.com>
         <CAPcyv4jmTbHZbs2KHhH2_S6=mxxkwdiJCDL6widexMzePhNFBg@mail.gmail.com>
         <2031cf4705d76dd4d0f722a600a6a106cce2ba41.camel@linux.intel.com>
         <CAPcyv4gWwsYOeXVNDoDy4v=SU6bRyBG1fgSu84y64jGApaJ91g@mail.gmail.com>
         <1543350780.185366.81.camel@acm.org>
         <CAPcyv4hya0ASfVue6GH3ZXKJOzytQXDqtEWxvrEdCTcb545tYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-27 at 12:50 -0800, Dan Williams wrote:
+AD4 Thanks Bart, so tying this back to Alex's patches, does the ordering
+AD4 problem that Alex's patches solve impact the SCSI case? I'm looking
+AD4 for something like +ACI-SCSI depends on asynchronous probing and without
+AD4 'driver core: Establish clear order of operations for deferred probe
+AD4 and remove' probing is often needlessly serialized+ACI. I.e. does it
+AD4 suffer from the same platform problem that libnvdimm ran into where
+AD4 it's local async probing implementation was hindered by the driver
+AD4 core?

(+-Martin)

Hi Dan,

Patch 6/9 reduces the time needed to scan SCSI LUNs significantly. The only
way to realize that speedup is by enabling more concurrency. That's why I
think that patch 6/9 is a significant driver core improvement.

Bart.
