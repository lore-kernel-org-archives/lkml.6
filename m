Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C0AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1960218D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549966589;
	bh=AAlWMkasilpiQMUn/yEZByNHGtbIQ22Hd9QLQtPmXb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gz0drV+vUVRv7IORH0bEUmYd1aRfZKlP7+BRVqVVLOW4+y00DOPvcTby9J7XTixQ0
	 AW6+Wq19uyAJJhk7i2YaIB+g7IxqCNH2gnOCIzEDMws9S0EO7Y6en8A2yIyOdaU2y5
	 K9D6mPeg84i6yu8Pkf1CcXgxg1UK08JB/iGjqmKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfBLKQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:16:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbfBLKQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:16:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 737852077B;
        Tue, 12 Feb 2019 10:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549966587;
        bh=AAlWMkasilpiQMUn/yEZByNHGtbIQ22Hd9QLQtPmXb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JWJ0dyYL7NCJfoTlNl8/hDx5TcP9HBbyb91WBGiro4x4MFmhf7GjoX5rML/6RgIkr
         PvncXuKsQN/wOFkhxUWdu894rCaxqulzRJnbQKSxgcP7cb1P5PaZPKmCdz2fl2xXcO
         RFYig0h6U6XpRbICu+dtAXVAr4WZqnbBVlznZDLs=
Date:   Tue, 12 Feb 2019 11:16:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     jcrouse@codeaurora.org, robdclark@gmail.com, evgreen@chromium.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/a6xx: Add support for an interconnect path
Message-ID: <20190212101624.GA20915@kroah.com>
References: <20190212095238.12306-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212095238.12306-1-georgi.djakov@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 11:52:38AM +0200, Georgi Djakov wrote:
> From: Jordan Crouse <jcrouse@codeaurora.org>
> 
> Try to get the interconnect path for the GPU and vote for the maximum
> bandwidth to support all frequencies. This is needed for performance.
> Later we will want to scale the bandwidth based on the frequency to
> also optimize for power but that will require some device tree
> infrastructure that does not yet exist.
> 
> v6: use icc_set_bw() instead of icc_set()
> v5: Remove hardcoded interconnect name and just use the default
> v4: Don't use a port string at all to skip the need for names in the DT
> v3: Use macros and change port string per Georgi Djakov
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Acked-by: Rob Clark <robdclark@gmail.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> 
> Hi Greg,
> 
> If not too late, could you please take this patch into char-misc-next.
> It is adding the first consumer of the interconnect API. We are just
> getting the code in place, without making it functional yet, as some
> DT bits are still needed to actually enable it. We have Rob's Ack to
> merge this together with the interconnect code. This patch has already
> spent some time in linux-next without any issues.

I have a question about the interconnect code.  Last week I saw a
presentation about the resctrl/RDT code from ARM that is coming (MPAM),
and it really looks like the same functionality as this interconnect
code.  In fact, this code looks like the existing resctrl stuff, right?

So why shouldn't we just drop the interconnect code and use resctrl
instead as it's already merged?

thanks,

greg k-h
