Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FC8C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DED2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="aNxd4+4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DED2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933464AbeGJNUD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:20:03 -0400
Received: from 8bytes.org ([81.169.241.247]:45288 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933169AbeGJNUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:20:01 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0707EA21; Tue, 10 Jul 2018 15:19:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531228800; bh=XhP7x0z4CKZiZdaK5vs2fGMJNnKRNNkQL3WzSbaPz0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aNxd4+4B7k3g5/She6y69jSJ8+YqC0/KjcgAqSYP0yQDoyqb60W9EKCDjkxyHUDgG
         PRGcvy8IwpLDz+dzjKhqlE6o+BAkt06qH96dtl3TPvEDIaYLX1IKFpNq7U/6J5Ju8X
         4kWR1+gFdnbolkmJd0oDJR8JHQDIuQkepRnDNYw9BMm2rO+f2a6TlLGZbMv2ok0G+j
         OAOS0QmbwVXIywVTFR9L1EA+nlpORRt5pyNjQmIkMGd7nAN1obdeacWhn3PKosbTwC
         XlQvVRV5rUWyehs0il9HOxNeUtnRgm1tGWB//BJ663wMt5ap7IJODuM6pwsfbDg0Ty
         wO01YhdDp0S4w==
Date:   Tue, 10 Jul 2018 15:19:59 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     hpa@zytor.com, Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [PATCH 0/3] x86/pti: Call pti_init() after mark_readonly()
Message-ID: <20180710131959.GG13903@8bytes.org>
References: <1530618746-23116-1-git-send-email-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530618746-23116-1-git-send-email-joro@8bytes.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Thomas,

On Tue, Jul 03, 2018 at 01:52:23PM +0200, Joerg Roedel wrote:
> Joerg Roedel (3):
>   x86/pti: Move pti_init() code out of __init
>   x86/mm/pti: Call pti_init() after mark_readonly()
>   x86/pti: Call pti_clone_kernel_text() from pti_init()

Please ignore this patch-set. It turned out that some code in the kernel
executes user-space even before /init is started. I just ran into a
problem where request_module calls usermode-helper and then
triple-faults when it tries to go to user-space and finds the
user-pagetable still empty.

I need to look into another solution for this then.


Thanks,

	Joerg
