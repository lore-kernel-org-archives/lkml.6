Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DBEC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006842086B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIw1BZrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006842086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbeKGFx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:53:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbeKGFx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:53:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BC332086B;
        Tue,  6 Nov 2018 20:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541536021;
        bh=+uUAz4IjuLEXvuXKA/5Mf3aj/nXLrD/DKguShCPCDMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EIw1BZrrLAL7snbRltfGhMnYfUoYfUw2VY0hWkdMss/Ff1/InjihznPHNqaOOVLdh
         6kt8D2oaDBRtU1Csom91rVQQOPzRYj/P9LebBgSeeGdXutdrvJTiBaYUEI+2+pxtO2
         /TuWdpLBq0zmoFIINQbLTy9gkUi28Bv2gv0iB+Aw=
Date:   Tue, 6 Nov 2018 21:26:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Muchun Song <smuchun@gmail.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Add branch prediction hints in
 really_probe()
Message-ID: <20181106202658.GA26208@kroah.com>
References: <20181106134630.29591-1-smuchun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106134630.29591-1-smuchun@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 09:46:30PM +0800, Muchun Song wrote:
> If condition is false in most cases. So, add an unlikely() to the if
> condition, so that the optimizer assumes that the condition is false.
> 
> Signed-off-by: Muchun Song <smuchun@gmail.com>

As Rafael said, don't do stuff like this unless you can actually measure
the difference.  Last time we tested the kernel for this a few years
ago, about 75% of the unlikely/likely additions were incorrect, removing
them made the kernel faster.  Turns out the compiler and cpu know better
than developers do :)

Also, the probe() path is never a hot-path to worry about stuff like
this.

thanks,

greg k-h
