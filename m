Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8158C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA77520892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="byCecOgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA77520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeKKBJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 20:09:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:59888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbeKKBJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 20:09:40 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A70620818;
        Sat, 10 Nov 2018 15:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541863458;
        bh=Ni9vssCQUlZAx13EQXVigqCI0CdPc1ExJ3oRUiYAkYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=byCecOgB3+GX/060AxQ0jb1j7SJxYq9bmuoriDyCiTFIoB2RKTIPG5SA7HOqXo4RI
         9gEYM3R9b08cO5xv9WQU6z8nqZ+9p/0WKGo2itne5UrhqCnWoJkPFt1787g1k4rCtd
         pAOc1+8YWAk/hHRi1O0Gak6/7otj5Cq3JqfA+m74=
Date:   Sat, 10 Nov 2018 07:24:17 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.14 07/31] clk: tegra: Add quirk for getting CDEV1/2
 clocks on Tegra20
Message-ID: <20181110152417.GC24724@kroah.com>
References: <20181108215129.641434673@linuxfoundation.org>
 <20181108215130.285950754@linuxfoundation.org>
 <16709e1c-16d4-cf22-2218-5bc9c12151bb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16709e1c-16d4-cf22-2218-5bc9c12151bb@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 09:32:15PM +0300, Dmitry Osipenko wrote:
> On 09.11.2018 0:52, Greg Kroah-Hartman wrote:
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > [ Upstream commit 5d797111afe12e488e08432fd9b372fae2cc7e93 ]
> > 
> > CDEV1 and CDEV2 clocks are a bit special case, their parent clock is
> > created by the pinctrl driver. It should be possible for clk user to
> > request these clocks before pinctrl driver got probed and hence user will
> > get an orphaned clock. That might be undesirable because user may expect
> > parent clock to be enabled by the child, so let's return -EPROBE_DEFER
> > till parent clock appears.
> > 
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> 
> [snip]
> 
> Hello Greg,
> 
> You should either pick up c59487075659 in addition or don't backport
> anything at all. The original problem was gone while we were trying to
> fix it and these commits only helping to ensure that the problem won't
> re-occur, AFAIK it shouldn't be necessary to backport any of these
> patches.

Thanks, I've now just dropped this patch from the 4.14.y queue.

greg k-h
