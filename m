Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F20C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9D92086C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aUlx4RBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbeLPKGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 05:06:48 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39460 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbeLPKGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 05:06:48 -0500
Received: from zn.tnic (p200300EC2BE55900ADD97DAFC8659476.dip0.t-ipconnect.de [IPv6:2003:ec:2be5:5900:add9:7daf:c865:9476])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 83F9C1EC08EA;
        Sun, 16 Dec 2018 11:06:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544954806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EruzAkpiIwT2+8kHgKnBEwbHRt8xGPbZKMqtP7nnRQQ=;
        b=aUlx4RBRiPXULaXS0Y6kV5ziOPPXN3IcIuaMtKTTiIgkEyY9ChRaIi8BevLSH1AcGpjW2F
        UW+kXbk1bEVPAUA+ToYuJ/yWwLJOniZgXlWnkbMArOFdBTi5+l++EnZeosYPqkreyZOZwP
        qn3pI2q0RTUQJ6m9u6ZEI6vMa7GpNKI=
Date:   Sun, 16 Dec 2018 11:06:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with late AMD microcode reload/feedback
Message-ID: <20181216100645.GB815@zn.tnic>
References: <CACna6ryhfaOFS4qjZoLjJqcu5LQd05_jDndL5+GpADTHhu3_7Q@mail.gmail.com>
 <20181216000510.GC6693@zn.tnic>
 <bac495ca-ccfd-3551-97ca-1444a391fa40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bac495ca-ccfd-3551-97ca-1444a391fa40@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 09:08:00AM +0100, Rafał Miłecki wrote:
> Thanks! I had no idea microcode_amd_fam17h.bin is a container with few
> microcodes. I thought there is a single microcode for a whole family
> (e.g. 17h).

It is a container for all F17h - you're simply making the wrong
assumption that it would have microcode for *all* F17h out there. Which
is not the case, because, well, there's not microcode for all of them
... yet.

:-)

IOW, there are only two patches released:

file offset: 60 (0x3c)
Patch 00: type 1, size: 3200 (0xc80)
   ID: 0x08001227, CPU rev ID: 0x00008012

file offset: 3268 (0xcc4)
Patch 01: type 1, size: 3200 (0xc80)
   ID: 0x0800820b, CPU rev ID: 0x00008082

> Using hex also makes more sense indeed!
> [   44.127941] microcode: verify_and_add_patch: Added patch_id: 0x08001227, proc_id: 0x8012
> [   44.127948] microcode: verify_and_add_patch: Added patch_id: 0x0800820b, proc_id: 0x8082

Yap.

> For my hack tests I'd like to replace my 0x0810100b with a 0x08101007.

Why would you even want to downgrade the microcode?!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
