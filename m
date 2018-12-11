Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B55C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548682084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544537080;
	bh=xb9eOeif/e2j1o+cz5g1tXlUm/9YoeUL+z4mqsHwzJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yrRDtY9EOCFRnCJb32bLzLWCTKhAm3jzvLYc1D30h7UwKmq2DZe3lwd2e57VYIO7U
	 rCLkPNLLv4zL22xl34RE2/YJ7v2pZMg/vaXmKOvxA3MYU4tAZtYHKCzsUDbmTwvSi2
	 g7euW2wzF7iEUO1X0D3AOm/WrZoaL1gYIo4Zpz6g=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548682084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeLKOEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:04:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbeLKOEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:04:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 742222084A;
        Tue, 11 Dec 2018 14:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544537078;
        bh=xb9eOeif/e2j1o+cz5g1tXlUm/9YoeUL+z4mqsHwzJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nKWUT4kpJLWWD01rwelUOoHA5WbhUtiFSNHTvuwNtTTyFo1kQeZXDnsm1MrrCXSoh
         RgwoCZfUqHUEeUAV7GjOoN/Ngkyg0DL56Pq8XlC8NMxC9TWRxXXdtTo4YQtQHernNT
         gg45hH54CztET3C5kI3qv+mGX9ii05MdnEZJC6pY=
Date:   Tue, 11 Dec 2018 15:04:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH 4.19 044/110] drm/i915: Disable LP3 watermarks on all SNB
 machines
Message-ID: <20181211140435.GA17389@kroah.com>
References: <20181129135921.231283053@linuxfoundation.org>
 <20181129135923.048859299@linuxfoundation.org>
 <20181205213905.GW9144@intel.com>
 <20181206072807.GA21314@kroah.com>
 <20181207170108.GX9144@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181207170108.GX9144@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 07:01:08PM +0200, Ville Syrjälä wrote:
> On Thu, Dec 06, 2018 at 08:28:07AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Dec 05, 2018 at 11:39:05PM +0200, Ville Syrjälä wrote:
> > > On Thu, Nov 29, 2018 at 03:12:15PM +0100, Greg Kroah-Hartman wrote:
> > > > 4.19-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > This one apparently introduces some annoying dmesg errors:
> > > [    3.487895] [drm:intel_print_wm_latency [i915]] *ERROR* Primary WM3 latency not provided
> > > [    3.487926] [drm:intel_print_wm_latency [i915]] *ERROR* Sprite WM3 latency not provided
> > > [    3.487955] [drm:intel_print_wm_latency [i915]] *ERROR* Cursor WM3 latency not provided
> > > 
> > > To silence those please also backport
> > > commit 274dba1ae8ff ("drm/i915: Downgrade Gen9 Plane WM latency error")
> > 
> > That commit id is not in Linus's tree, are you sure it is correct?
> 
> Sorry. Picked the wrong sha by accident.
> 
> 86c1c87d0e62 ("drm/i915: Downgrade Gen9 Plane WM latency error")

Thanks, now queued up for 4.19.y

greg k-h
