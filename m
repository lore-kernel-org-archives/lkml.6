Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59876C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1180208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ObiCseUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbeLNWyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:54:33 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53078 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbeLNWyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:54:32 -0500
Received: from zn.tnic (p200300EC2BCFEF00117646AD7F85DA05.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:ef00:1176:46ad:7f85:da05])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 91AAD1EC08EA;
        Fri, 14 Dec 2018 23:54:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544828070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X5QPIDGpFXvPdowA99C8HW9vrLj+xIGOPAL3LaZXfw0=;
        b=ObiCseUG//wLZcTExpmzztCE8P/BlxtU5k4F5J3Thiptpq2vZz50TNqHTx4Ivf7dDOryGB
        Otdm6FtJgIhtBVdE1xMTUOvkZhlMoM26XszlMsQVACzNmi9UbFn0ovGSRw0XHLNgX1yYs8
        CN+sSeRU6oPBsL7enmh6iqsIEVhikhQ=
Date:   Fri, 14 Dec 2018 23:54:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas =?utf-8?Q?Sch=C3=B6bel-Theuer?= <thomas@schoebel-theuer.de>
Cc:     Thomas Schoebel-Theuer <tst@schoebel-theuer.de>,
        linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        linux-acpi@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] acpi / apei: fix NULL deref during init
Message-ID: <20181214225428.GL11710@zn.tnic>
References: <20181214181514.29891-1-tst@schoebel-theuer.de>
 <20181214202406.GI11710@zn.tnic>
 <c8d62037-4a26-e18b-51a3-73fc99e76e5b@schoebel-theuer.de>
 <5ec69dad-7943-343b-5ced-9a962652e14c@schoebel-theuer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ec69dad-7943-343b-5ced-9a962652e14c@schoebel-theuer.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 11:42:01PM +0100, Thomas Schöbel-Theuer wrote:
> Ah, I overlooked that commit e56c92565dfe2 is already providing a different
> solution to the same problem in newer kernels _only_, as a _side_ effect
> (not clear to me from the description, but clear from reading the code).

Damn, I missed the fact that this is not the upstream kernel:

CPU: 0 PID: 1 UID: 0 Comm: swapper/0 Not tainted 4.4.0-ui18344.004-uiabi1-infong-amd64 #1

> So another alternative would be backporting e56c92565dfe2 to the 4.4 LTS
> series. Also fine for me.

That looks like the right fix.

A note for the next time: do not send a fix for a stable kernel which is
not upstream:

From Documentation/process/stable-kernel-rules.rst:

" - It or an equivalent fix must already exist in Linus' tree (upstream)."

The stable kernels track upstream so if a stable kernel has a problem,
the first thing one needs to do is to check whether this has been fixed
upstream and if so, to backport it. This is the case most of the time.
In the very seldom cases where a separate fix is needed, it needs to be
handled by asking Greg what to do. :-)

Adding stable@ folks to CC to set me straight if I'm missing something.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
