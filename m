Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tc0xHqHDG1tHFwAAmS7hNA
	; Sat, 09 Jun 2018 12:20:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9DF30607A4; Sat,  9 Jun 2018 12:20:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 12056602FC;
	Sat,  9 Jun 2018 12:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12056602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753232AbeFIMUo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 08:20:44 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:35532 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753101AbeFIMUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 08:20:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 8D8B527256;
        Sat,  9 Jun 2018 08:20:39 -0400 (EDT)
Date: Sat, 9 Jun 2018 22:21:06 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Michael Schmitz <schmitzmic@gmail.com>
cc: Andreas Schwab <schwab@linux-m68k.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
In-Reply-To: <e1006b0a-a429-4744-7525-203cb91f1d5f@gmail.com>
Message-ID: <alpine.LNX.2.21.1806092140410.26@nippy.intranet>
References: <cover.1528423341.git.fthain@telegraphics.com.au> <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au> <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com> <m2h8mc4ejw.fsf@linux-m68k.org>
 <e1006b0a-a429-4744-7525-203cb91f1d5f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Is this enum used by any user space code? If so, perhaps rather 
> > > leave the PMU_68K_V1 in there to avoid upsetting that?
> > 
> > It also changes the value of PMU_68K_V2, which is an ABI break.
> 
> Yes, that's what I worry about - but do we know of any users of that 
> particular interface?

There is no ABI issue AFAIK. The value of pmu_kind is visible to userland 
only on powerpc. /dev/pmu and /proc/pmu/* do not exist on m68k. This patch 
series will make these UAPIs available on m68k, and for that reason I've 
chosen the value PMU_UNKNOWN for pmu_kind.

New pmu_kind values can be defined as and when the need arises. But that 
would imply a useful classification scheme for pre-PCI powerbooks, and I 
don't know what that scheme will look like because at this stage there is 
neither userland nor kernel code to support backlight, buttons and battery 
for pre-PCI powerbooks.

In anycase, the "v1" and "v2" scheme is obviously inadequate when you 
consider the range of m68k powerbook models. Also, consider the 
out-of-tree adaptation of via-pmu by the Nubus-PMac project, which has 
this ABI break:

diff --git a/include/linux/pmu.h b/include/linux/pmu.h
index cafe98d9694..9882a185a52 100644
--- a/include/linux/pmu.h
+++ b/include/linux/pmu.h
@@ -90,6 +90,7 @@ enum {
         PMU_HEATHROW_BASED,     /* PowerBook G3 series */
         PMU_PADDINGTON_BASED,   /* 1999 PowerBook G3 */
         PMU_KEYLARGO_BASED,     /* Core99 motherboard (PMU99) */
+        PMU_NUBUS_BASED,        /* 1400, 2300, 5300 */
         PMU_68K_V1,             /* 68K PMU, version 1 */
         PMU_68K_V2,             /* 68K PMU, version 2 */
 };

(BTW, these powerbooks are not "nubus based", they are "pre-PCI", so I 
wouldn't want this to go upstream in this form. It could be that 
PMU_NUBUS_BASED should be PMU_UNKNOWN too.)

-- 
