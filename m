Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37581ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC89620673
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC89620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbeGMPtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:49:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39752 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbeGMPtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:49:01 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D58982C;
        Fri, 13 Jul 2018 15:33:53 +0000 (UTC)
Date:   Fri, 13 Jul 2018 17:33:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Simon Que <sque@chromium.org>
Subject: Re: [PATCH] staging: gasket remove current_kernel_time usage
Message-ID: <20180713153351.GA23607@kroah.com>
References: <20180713150703.3156256-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713150703.3156256-1-arnd@arndb.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 05:06:37PM +0200, Arnd Bergmann wrote:
> A new user of the deprecated current_kernel_time() function has appeared
> here. This code won't work correct during leap seconds or a concurrent
> settimeofday() call, and it probably doesn't do what the author intended
> even for the normal case, as it passes a timeout in nanoseconds but
> reads the time using a jiffies-granularity accessor.
> 
> I'm changing it to ktime_get_ns() here, which simplifies the logic,
> and uses a high-res clocksource. This is a bit slower, but that
> probably doesn't matter in a busy-wait loop.
> 
> Note: it also doesn't matter in the current version, as there are no
> callers of this function.

Let's just rip the whole function out, I've been going through and
removing functions that no one calls and no one uses.  That would make
more sense here.  Want me to send a patch for that, or do you want to?

thanks,

greg k-h
