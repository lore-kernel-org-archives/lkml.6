Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096F9C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DB2213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="POrPVY7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DB2213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbeJLAj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:39:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbeJLAj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:39:28 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93C0720658;
        Thu, 11 Oct 2018 17:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539277880;
        bh=MKK8ApJEkkgS8pd4+rpOveZhl3ZwxDflwnrkkHVR/8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=POrPVY7yAhaLJYTI58U5auH0DuFDYpZ2nhBsisQreQEWiVfygQOXGDzremRuAtJe+
         pwKMX4p9n6vV9kW8Y/Y4rPXHyIXZfqUhhmwT/PkuDNXBH7nzPOxbdeTqQs0elwbl3R
         g12dx4SsaR6IG0iUjKPYLY5vwuzhZNdynIGBwdUw=
Date:   Thu, 11 Oct 2018 19:02:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Tejun Heo <tj@kernel.org>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org
Subject: Re: [workqueue/driver-core PATCH v2 1/5] workqueue: Provide
 queue_work_node to queue work near a given NUMA node
Message-ID: <20181011170204.GA7257@kroah.com>
References: <20181010230435.10609.77825.stgit@localhost.localdomain>
 <20181010230715.10609.83647.stgit@localhost.localdomain>
 <20181011150417.GO270328@devbig004.ftw2.facebook.com>
 <6f91e26d-00e5-10ba-b0ee-2b9f8d50934b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f91e26d-00e5-10ba-b0ee-2b9f8d50934b@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 09:49:59AM -0700, Alexander Duyck wrote:
> 
> 
> On 10/11/2018 8:04 AM, Tejun Heo wrote:
> > On Wed, Oct 10, 2018 at 04:07:42PM -0700, Alexander Duyck wrote:
> > > This patch provides a new function queue_work_node which is meant to
> > > schedule work on a "random" CPU of the requested NUMA node. The main
> > > motivation for this is to help assist asynchronous init to better improve
> > > boot times for devices that are local to a specific node.
> > > 
> > > For now we just default to the first CPU that is in the intersection of the
> > > cpumask of the node and the online cpumask. The only exception is if the
> > > CPU is local to the node we will just use the current CPU. This should work
> > > for our purposes as we are currently only using this for unbound work so
> > > the CPU will be translated to a node anyway instead of being directly used.
> > > 
> > > As we are only using the first CPU to represent the NUMA node for now I am
> > > limiting the scope of the function so that it can only be used with unbound
> > > workqueues.
> > > 
> > > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > 
> > Acked-by: Tejun Heo <tj@kernel.org>
> > 
> > Please let me know how you wanna route the patch.
> > 
> > Thanks.
> 
> I would be good with routing the patches through you if that works. I had
> included you, Greg, and Andrew as I wasn't sure how you guys had wanted this
> routed since this affected both the workqueue and device trees.
> 
> I'll update the patches to resolve the lack of kerneldoc for the new
> "async_" functions and add some comments to the patch descriptions on the
> gains seen related to some of the specific patches for v3.

As Tejun has acked this, and it affects the driver core, I'll be glad to
take it.

thanks,

greg k-h
