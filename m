Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE8FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A035215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A035215F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeI1BUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:20:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39764 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI1BUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:20:19 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3DADC1018;
        Thu, 27 Sep 2018 19:00:37 +0000 (UTC)
Date:   Thu, 27 Sep 2018 21:00:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lyude Paul <lyude@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH 4.18 74/88] drm/atomic: Use drm_drv_uses_atomic_modeset()
 for debugfs creation
Message-ID: <20180927190034.GA1895@kroah.com>
References: <20180927090300.631426620@linuxfoundation.org>
 <20180927090309.614592493@linuxfoundation.org>
 <42cbbf9c-3076-0c49-36c2-b6fd09628694@applied-asynchrony.com>
 <20180927123706.GA23563@kroah.com>
 <f54355c2-4eeb-9b7a-3964-57ca465dae17@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f54355c2-4eeb-9b7a-3964-57ca465dae17@applied-asynchrony.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 03:26:37PM +0200, Holger Hoffstätte wrote:
> On 09/27/18 14:37, Greg Kroah-Hartman wrote:
> > On Thu, Sep 27, 2018 at 12:43:33PM +0200, Holger Hoffstätte wrote:
> > > On 09/27/18 11:03, Greg Kroah-Hartman wrote:
> > > > 4.18-stable review patch.  If anyone has any objections, please let me know.
> > > > 
> > > > ------------------
> > > > 
> > > > From: Lyude Paul <lyude@redhat.com>
> > > > 
> > > > commit 3c499ea0c662e2f38aafbd4f516b08aab8cfa0e5 upstream.
> > > > 
> > > > As pointed out by Daniel Vetter, we should be usinng
> > > > drm_drv_uses_atomic_modeset() for determining whether or not we want to
> > > > make the debugfs nodes for atomic instead of checking DRIVER_ATOMIC, as
> > > > the former isn't an accurate representation of whether or not the driver
> > > > is actually using atomic modesetting internally (even though it might
> > > > not be exposing atomic capabilities).
> > > > 
> > > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > > Cc: stable@vger.kernel.org
> > > > Reviewed-by: Sean Paul <seanpaul@chromium.org>
> > > > Link: https://patchwork.freedesktop.org/patch/msgid/20180917173733.21293-1-lyude@redhat.com
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > This patch breaks switching the console to high resolution during boot on my
> > > workstation with a Radeon card; it worked fine with 4.18.10 and reverting it
> > > fixes the problem:
> > 
> > Is 4.19-rc5 also a problem?
> > 
> 
> No, 4.19-rc5 with the same config works fine and properly switches the
> console during boot.
> 
> Interestingly another machine with i915 chip seemed to work fine with this
> patch included (rebooted that one first), so it might well be related to
> different motherboard/chipset or the Radeon card (an admittedly old, but
> otherwise completely functional fanless r600).
> 
> I'll try to find more clues, but for now that's all I got.

Ok, I'll go delete this, but this implies a much deeper problem with the
code here.  No logic should ever change based on a debugfs file creation
failing or succeeding.  The error checks here are all not needed at all.
I'll work on a patch to clean it up for future kernels...

thanks,

greg k-h
