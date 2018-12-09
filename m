Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154D1C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 12:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3EA20837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 12:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544359494;
	bh=rCWDA+ZDbSpzlhOykRuLW5bERIZWw4iTBbBtykQnc8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I0o89HhP1bcFcftTrwWpJT9LuCwd5cFitHMAcShu9LPCbGi7xLTcKSZ0g1WllwBGZ
	 +hsbX5unFC0EBvnEb2exlkp2Pml1ST5uZYI7CBc8nhHWWXQnPXjKozF+j+XsgiQKZi
	 c2iF2mSfDPOdGRocYrHdGlifLTU5MjZ6P9cobghc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3EA20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeLIMow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 07:44:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbeLIMov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 07:44:51 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9240820672;
        Sun,  9 Dec 2018 12:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544359491;
        bh=rCWDA+ZDbSpzlhOykRuLW5bERIZWw4iTBbBtykQnc8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dc/a/Mt8bAxRjwnvrbWPvWwb8Tk687m3uBrjl6pGrw3BwzsdkZYkJv4WXNxT/X+8n
         kbn8M+oz3MSvUH3URmBiT3/cM96OOTrphZd1xeD985bkPe0GerncByVnG092Sl5ZWA
         kF18sDNX+cXRbnMxfXNYnKLNJbzxIsEsU+mqlxLs=
Date:   Sun, 9 Dec 2018 20:43:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Russell King <linux@armlinux.org.uk>, suzuki.poulose@arm.com,
        robin.murphy@arm.com, Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v3 06/12] arm: perf/core: use PERF_PMU_CAP_NO_EXCLUDE for
 exclude incapable PMUs
Message-ID: <20181209124358.GC22960@dragon>
References: <1544114849-47266-1-git-send-email-andrew.murray@arm.com>
 <1544114849-47266-7-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544114849-47266-7-git-send-email-andrew.murray@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 04:47:23PM +0000, Andrew Murray wrote:
> For drivers that do not support context exclusion let's advertise the
> PERF_PMU_CAP_NO_EXCLUDE capability. This ensures that perf will
> prevent us from handling events where any exclusion flags are set.
> Let's also remove the now unnecessary check for exclusion flags.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  arch/arm/mach-imx/mmdc.c     | 9 ++-------

For imx mmdc changes:

Acked-by: Shawn Guo <shawnguo@kernel.org>
