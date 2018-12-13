Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BA4C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD5E20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544727189;
	bh=DhWqCxV1yImxRru4sAMI2v9YjHy4srnfkhwhgcYQKs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xshtBsVJlkNdVKVOsSP29+8HZ7643gpXqMW8R9sk0Yju84w9kLQgGllNvCKeh8pI8
	 5G4criM7GDAyK/w7y5RQWeqGgj6XcLJLOzBcqo8/8YOfG/q9yMUCYwG+KumVIcRP16
	 hOLkeigjd+3F1nWLkjUumAAQkWwatNuJ4q7HLi1k=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD5E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeLMSxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:53:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeLMSxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:53:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B94B2086D;
        Thu, 13 Dec 2018 18:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544727187;
        bh=DhWqCxV1yImxRru4sAMI2v9YjHy4srnfkhwhgcYQKs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gKaUJvP7Vv/nl1F2B6miWeH3tA53Tl6RcFSHHy8/6YUkFImgsdnQXIde4K8AVKePN
         PR1modCDb2InHdT1FFa1Pe7JXH9EdOv+1mzLPNvUXQI9X0BHUW+S6KDhQhIlm+M+m3
         i7HW/y2IgZ9I1cTEKiqkn5QlPpLlNdYHYREmNbuM=
Date:   Thu, 13 Dec 2018 19:53:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Martin Liu <liumartin@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH] driver core: Add missing dev->bus->need_parent_lock
 checks
Message-ID: <20181213185304.GB18107@kroah.com>
References: <7586985.G9YL5ver76@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7586985.G9YL5ver76@aspire.rjw.lan>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 07:27:47PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> __device_release_driver() has to check dev->bus->need_parent_lock
> before dropping the parent lock and acquiring it again as it may
> attempt to drop a lock that hasn't been acquired or lock a device
> that shouldn't be locked and create a lock imbalance.
> 
> Fixes: 8c97a46af04b (driver core: hold dev's parent lock when needed)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This should go into -stable for everything over 4.18 methinks.

Does this fix Daniel's lockdep splat?

thanks,

greg k-h
