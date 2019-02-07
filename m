Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE2AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35D421904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfBGPJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:09:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:16417 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfBGPJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:09:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 07:08:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,344,1544515200"; 
   d="scan'208";a="114427874"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 07 Feb 2019 07:08:46 -0800
Date:   Thu, 7 Feb 2019 08:08:17 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCHv5 00/10] Heterogeneuos memory node attributes
Message-ID: <20190207150817.GC30221@localhost.localdomain>
References: <20190124230724.10022-1-keith.busch@intel.com>
 <20190207095336.0000529f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207095336.0000529f@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 01:53:36AM -0800, Jonathan Cameron wrote:
> As a general heads up, ACPI 6.3 is out and makes some changes.
> Discussions I've had in the past suggested there were few systems
> shipping with 6.2 HMAT and that many firmwares would start at 6.3.
> Of course, that might not be true, but there was fairly wide participation
> in the meeting so fingers crossed it's accurate.
> 
> https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
> 
> Particular points to note:
> 1. Most of the Memory Proximity Domain Attributes Structure was deprecated.
>    This includes the reservation hint which has been replaced
>    with a new mechanism (not used in this patch set)

Yes, and duplicating all the address ranges with SRAT never made any
sense. No need to define the same thing in multiple places; that's just
another opprotunity to get it wrong.
 
> 2. Base units for latency changed to picoseconds.  There is a lot more
>    explanatory text around how those work.
>
> 3. The measurements of latency and bandwidth no longer have an
>    'aggregate performance' version.  Given the work load was not described
>    this never made any sense.  Better for a knowledgeable bit of software
>    to work out it's own estimate.

Nice. Though they shifted 1st level cached to occupy the same value that
the aggregate used. They could have just deprecated the old value so we
could maintain compatibility, but that's okay!
 
> 4. There are now Generic Initiator Domains that have neither memory nor
>    processors.  I'll come back with proposals on handling those soon if
>    no one beats me to it. (I think it's really easy but may be wrong ;)
>    I've not really thought out how this series applies to GI only domains
>    yet.  Probably not useful to know you have an accelerator near to
>    particular memory if you are deciding where to pin your host processor
>    task ;)

I haven't any particular use for these at the moment either, though it
shouldn't change what this is going to export.

Thanks for the heads up! I'll incorporate 6.3 into v6.
