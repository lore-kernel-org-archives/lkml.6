Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E5AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A28218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548352419;
	bh=L7djGP8cqnlHynGq84ONY74rM6TdaKbww/YpUW+NGgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q8OUPazgjdUV+Z6bF+d1Fcc1wdzXvmdyk2iAMokT2ivt+uwS9aupVErkQQaAtZgid
	 9RWQw2P2ogtNEUPm1vGLKGyG3wMcwzPpXM8vryvsTAiWZouG4zvDaaYqdyc+0Igib9
	 cWx0azGWLURRksuW9iZu5ZlSFOmpGPmpmTonhGZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfAXRxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:53:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbfAXRxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:53:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA22A218A6;
        Thu, 24 Jan 2019 17:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548352414;
        bh=L7djGP8cqnlHynGq84ONY74rM6TdaKbww/YpUW+NGgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WryrZT0n7Po3tduuYrWuC5ebSLSnsWjeyzeCUKFt1Lnk5IE53fU7orlB7oxmKcQPT
         cp2m8T8L676yoISWRqrNr5eMMTIFsxof+OSydS94z5bqd+9w0KA0LeMJjDeeSC4T7s
         erMUtU6Av3K92HXV5QNWwOksrK0x6iHT2752URto=
Date:   Thu, 24 Jan 2019 18:53:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     stable@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>, it+lkml@molgen.mpg.de
Subject: Re: [PATCH v2] ipmi:pci: Blacklist a Realtek "IPMI" device
Message-ID: <20190124175331.GC7484@kroah.com>
References: <8520014d-6805-ce87-143d-fffbeb94d11d@molgen.mpg.de>
 <78de72f8-e218-f91f-97b2-768ff5a920e4@acm.org>
 <9ca94005-e2e4-cd5a-67bd-30c3d8680281@molgen.mpg.de>
 <fe18b975-a577-8b09-c1cc-488356fc60a7@molgen.mpg.de>
 <20190123163211.GA31955@kroah.com>
 <cc8b4831-73bf-5f18-ebaa-e0fa6c3d5366@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc8b4831-73bf-5f18-ebaa-e0fa6c3d5366@molgen.mpg.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 05:44:57PM +0100, Paul Menzel wrote:
> From: Corey Minyard <cminyard@mvista.com>
> Date: Thu, 15 Feb 2018 16:58:26 -0600
> 
> [ upstream commit bc48fa1b9d3b04106055b27078da824cd209865a ]
> 
> Realtek has some sort of "Virtual" IPMI device on the PCI bus as a
> KCS controller, but whatever it is, it's not one.  Ignore it if seen.
> 
> Reported-by: Chris Chiu <chiu@endlessm.com>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Tested-by: Daniel Drake <drake@endlessm.com>
> 
> [ Commit 13d0b35c (ipmi_si: Move PCI setup to another file) from Linux
>   4.15-rc1 has not been back ported, so the PCI code is still in
>   `drivers/char/ipmi/ipmi_si_intf.c`, requiring to apply the commit
>   manually.
> 
>   This fixes a 100 s boot delay on the HP EliteDesk 705 G4 MT with Linux
>   4.14.94. ]
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> 
> v2: Use tabs. Sorry for messing that up.

That worked, thanks.

greg k-h
