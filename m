Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B38C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73FD20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73FD20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeK3CZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:25:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:17860 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbeK3CZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:25:13 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 07:19:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,295,1539673200"; 
   d="scan'208";a="96787606"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga008.jf.intel.com with SMTP; 29 Nov 2018 07:19:29 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 29 Nov 2018 17:19:28 +0200
Date:   Thu, 29 Nov 2018 17:19:28 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Ahsan Hussain <ahsan_hussain@mentor.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: drm: understanding the kernel warning during drm_vblank_cleanup()
Message-ID: <20181129151928.GM9144@intel.com>
References: <6198455d-59b4-c4b0-94c1-6e0d460f2451@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6198455d-59b4-c4b0-94c1-6e0d460f2451@mentor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 07:30:45PM +0500, Ahsan Hussain wrote:
> Hi folks,
> 
> I'm new to DRM and trying to understand the warning in 
> drivers/gpu/drm/drm_vblank.c during drm_vblank_cleanup().
> 
> WARN_ON(READ_ONCE(vblank->enabled) &&
>      drm_core_check_feature(dev, DRIVER_MODESET));
> 
> Is the drm driver responsible for making sure that !(vblank->enabled) in 
> the .unbind operation, or is this something related to userspace? What 
> does the warning signify? Git history did not help here at all.

It signifies you haven't cleaned up things properly. Usually what
you would do is call drm_atomic_helper_shutdown() which will also
end up turnng vblank interrupts off, assuming you use
drm_vblank_on()/off() properly.

-- 
Ville Syrjälä
Intel
