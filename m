Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FE3C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDC220891
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vVe5GsjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDC220891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbeGYNlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbeGYNlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:41:47 -0400
Received: from localhost (unknown [122.178.229.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B859E20882;
        Wed, 25 Jul 2018 12:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532521818;
        bh=Pbj4sKdHi3tUbX5TMgboNq0R39zxO1QwPs+S+k5bblc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vVe5GsjMxoe3BzHMkhr3fGIK1yEy2zFlhNCaX4RpwchC7Cd7tS58UhbCvmAl4ycMT
         +zGtOULFqksPNvkpy0fqJO4ExNHwaLsVqUbULd6W/wrlsR2dgfHHCWJt6+P+2oDGHj
         tHMDjfpOIMRYwYk9kl79/JYZ/BLLOYrc6zBVL4fc=
Date:   Wed, 25 Jul 2018 18:00:10 +0530
From:   Vinod <vkoul@kernel.org>
To:     John Keeping <john@metanate.com>
Cc:     dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: pl330: fix irq race with terminate_all
Message-ID: <20180725123010.GR3661@vkoul-mobl>
References: <20180717104816.17044-1-john@metanate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717104816.17044-1-john@metanate.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-07-18, 11:48, John Keeping wrote:
> In pl330_update() when checking if a channel has been aborted, the
> channel's lock is not taken, only the overall pl330_dmac lock.  But in
> pl330_terminate_all() the aborted flag (req_running==-1) is set under
> the channel lock and not the pl330_dmac lock.
> 
> With threaded interrupts, this leads to a potential race:
> 
>     pl330_terminate_all	        pl330_update
>     -------------------         ------------
>     lock channel
>                                 entry
>     lock pl330
>     _stop channel
>     unlock pl330
>                                 lock pl330
>                                 check req_running != -1
>     req_running = -1
>                                 _start channel
> 

Applied, thanks

-- 
~Vinod
