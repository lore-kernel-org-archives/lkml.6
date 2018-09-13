Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA50AC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1A42133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1A42133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeIMHPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:15:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42980 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeIMHPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:15:14 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0H2z-0005Wy-CZ; Thu, 13 Sep 2018 02:07:57 +0000
Date:   Thu, 13 Sep 2018 03:07:57 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/17] compat_ioctl: add generic_compat_ioctl_ptrarg()
Message-ID: <20180913020757.GP19965@ZenIV.linux.org.uk>
References: <20180912150142.157913-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912150142.157913-1-arnd@arndb.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 05:01:02PM +0200, Arnd Bergmann wrote:
> Many drivers have ioctl() handlers that are completely compatible
> between 32-bit and 64-bit architectures, except for the argument
> that is passed down from user space and may have to be passed
> through compat_ptr() in order to become a valid 64-bit pointer.
> 
> Using ".compat_ptr=generic_compat_ioctl_ptrarg" in file operations
> should let us simplify a lot of those drivers to avoid #ifdef
> checks, and convert additional drivers that don't have proper
> compat handling yet.

Just keep in mind that this should *only* be used when all
ioctls implemented in a given instance do take pointers.
Because otherwise you are asking for trouble - e.g. if one of
them takes an u32 used as a bitmap, this will run into trouble
as soon as somebody uses bit 31.  With no visible warnings.

IOW, it shouldn't be used blindly and it should come with big
fat warning.
