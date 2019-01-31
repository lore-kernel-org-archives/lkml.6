Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139E5C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D316A218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548947857;
	bh=IO+UdZLdEBG8ILfFVWQSt0JSuwDMK3rqwyJkoDdORqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qsdMxhNianIa6OzYMyWhEsxzheC+0c2KK76msr1mTWTAWZOAo6mlS+c9qgDebazJ+
	 4sFVTFdCueXDF/liqU/BMsCxDyZwJfVMlhrnVq8ihNrWBsdlZnKSvgj/JV6A7aXmlZ
	 SYJOGNdk1iiM94KaqKd3USv/Cm/qcH7nFN1Q3A3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbfAaPRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:17:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfAaPRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:17:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A71F0218D3;
        Thu, 31 Jan 2019 15:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548947854;
        bh=IO+UdZLdEBG8ILfFVWQSt0JSuwDMK3rqwyJkoDdORqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iWvmethggBo35q+UW/lN2FflgGGuv5zV8xEACRKNzKwXJSvvX8CWjZQ5p5Nmocf/i
         JYkcTj5tKafM7eInU8OR2HxaW5IPahW0+su5TAsiHPG5rBrXrNZFUo2mp6MqFCe5Md
         yTR7Moo0guU4ezmO8mTrMpkN4gn8pSnPHQsukfpo=
Date:   Thu, 31 Jan 2019 16:17:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org
Subject: Re: [driver-core PATCH v10 0/9] Add NUMA aware async_schedule calls
Message-ID: <20190131151731.GA19261@kroah.com>
References: <154818223154.18753.12374915684623789884.stgit@ahduyck-desk1.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154818223154.18753.12374915684623789884.stgit@ahduyck-desk1.amr.corp.intel.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 10:39:05AM -0800, Alexander Duyck wrote:
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
> patch set. Patches 1 through 3 address a number of issues that actually were
> causing the existing async_schedule calls to not show the performance that
> they could due to either not scaling on a per device basis, or due to issues
> that could result in a potential race. For example, patch 3 addresses the
> fact that we were calling async_schedule once per driver instead of once
> per device, and as a result we would have still ended up with devices
> being probed on a non-local node without addressing this first.
> 
> I have also updated the kernel module used to test async driver probing so
> that it can expose the original issue I was attempting to address.
> It will fail on a system of asynchronous work either takes longer than it
> takes to load a single device and a single driver with a device already
> added. It will also fail if the NUMA node that the driver is loaded on does
> not match the NUMA node the device is associated with.
> 
> RFC->v1:
>     Dropped nvdimm patch to submit later.
>         It relies on code in libnvdimm development tree.
>     Simplified queue_work_near to just convert node into a CPU.
>     Split up drivers core and PM core patches.
> v1->v2:
>     Renamed queue_work_near to queue_work_node
>     Added WARN_ON_ONCE if we use queue_work_node with per-cpu workqueue
> v2->v3:
>     Added Acked-by for queue_work_node patch
>     Continued rename from _near to _node to be consistent with queue_work_node
>         Renamed async_schedule_near_domain to async_schedule_node_domain
>         Renamed async_schedule_near to async_schedule_node
>     Added kerneldoc for new async_schedule_XXX functions
>     Updated patch description for patch 4 to include data on potential gains
> v3->v4
>     Added patch to consolidate use of need_parent_lock
>     Make asynchronous driver probing explicit about use of drvdata
> v4->v5
>     Added patch to move async_synchronize_full to address deadlock
>     Added bit async_probe to act as mutex for probe/remove calls
>     Added back nvdimm patch as code it relies on is now in Linus's tree
>     Incorporated review comments on parent & device locking consolidation
>     Rebased on latest linux-next
> v5->v6:
>     Drop the "This patch" or "This change" from start of patch descriptions.
>     Drop unnecessary parenthesis in first patch
>     Use same wording for "selecting a CPU" in comments added in first patch
>     Added kernel documentation for async_probe member of device
>     Fixed up comments for async_schedule calls in patch 2
>     Moved code related setting async driver out of device.h and into dd.c
>     Added Reviewed-by for several patches
> v6->v7:
>     Fixed typo which had kernel doc refer to "lock" when I meant "unlock"
>     Dropped "bool X:1" to "u8 X:1" from patch description
>     Added async_driver to device_private structure to store driver
>     Dropped unecessary code shuffle from async_probe patch
>     Reordered patches to move fixes up to front
>     Added Reviewed-by for several patches
>     Updated cover page and patch descriptions throughout the set
> v7->v8:
>     Replaced async_probe value with dead, only apply dead in device_del
>     Dropped Reviewed-by from patch 2 due to significant changes
>     Added Reviewed-by for patches reviewed by Luis Chamberlain
> v8->v9:
>     Dropped patch 1 as it was applied, shifted remaining patches by 1
>     Added new patch 9 that adds test framework for NUMA and sequential init
>     Tweaked what is now patch 1, and added Reviewed-by from Dan Williams
> v9->v10:
>     Moved "dead" from device struct to device_private struct
>     Added Reviewed-by from Rafael to patch 1
>     Rebased on latest linux-next

Thanks for sticking with this, now all queued up.

greg k-h
