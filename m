Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B07C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C057B20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nwv1ti2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C057B20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeJPUiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbeJPUiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:38:07 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B6FD20869;
        Tue, 16 Oct 2018 12:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539694067;
        bh=bLz0sZD4d5SnIPRTuRRvhmsYA1bEdDr14t8NtgrZEiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nwv1ti2S4Gn9754DBq9qzFY5DgiwC/mnS1uVH9uaLoooiuGAIp8bH3ABud/kBSTZX
         C/wi5OYnTjmFnd1RkFbaKkXGNiNpfUAhwTv/TCM5+RoBUfX6hjaziCDbx6ZzO5Og+K
         au1vl/BO/m6LKOD/Yw8eazoUACAWQgvPDGdREjuo=
Date:   Tue, 16 Oct 2018 14:47:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] sysfs: constify sysfs create/remove files harder
Message-ID: <20181016124745.GA7733@kroah.com>
References: <20181004143750.30880-1-jani.nikula@intel.com>
 <20181016104845.GB4768@kroah.com>
 <87pnwakto2.fsf@intel.com>
 <20181016114347.GA21790@kroah.com>
 <87k1miks7j.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1miks7j.fsf@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 03:10:24PM +0300, Jani Nikula wrote:
> On Tue, 16 Oct 2018, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > On Tue, Oct 16, 2018 at 02:38:53PM +0300, Jani Nikula wrote:
> >> On Tue, 16 Oct 2018, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >> > On Thu, Oct 04, 2018 at 05:37:49PM +0300, Jani Nikula wrote:
> >> >> Let the passed in array be const (and thus placed in rodata) instead of
> >> >> a mutable array of const pointers.
> >> >> 
> >> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >> >> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> >> >> ---
> >> >>  fs/sysfs/file.c       | 4 ++--
> >> >>  include/linux/sysfs.h | 8 ++++----
> >> >>  2 files changed, 6 insertions(+), 6 deletions(-)
> >> >
> >> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> 
> >> Thanks; who should pick them up?
> >
> > I could pick the first one up, but as you need this for a drm patch,
> > both should probably go through that tree, right?
> 
> I can pick them both if it doesn't bother you that the sysfs parts will
> be merged in the merge window for v4.21 i.e. the change would be in drm
> trees for an entire release cycle. We've been done for v4.20 merge
> window for a while now.

No objection from me.

greg k-h
