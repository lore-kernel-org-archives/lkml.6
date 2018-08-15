Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409B0C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8BB2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVeqj+9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8BB2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbeHPBbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 21:31:11 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40832 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730403AbeHPBbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 21:31:10 -0400
Received: by mail-pl0-f65.google.com with SMTP id s17-v6so1078716plp.7;
        Wed, 15 Aug 2018 15:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/1/iKFgTEaXpeeMtg3Y/NQrhx55prRh2rnpQH0HflkI=;
        b=sVeqj+9OXtdKd2XNtEgZ01ydVO+BROKlEElNIM7djK4OfDOMu5OgRVzmkoqPhVb8vP
         J/jOLG6zkc7oerdJ8ZtPd+0BfnlqmqHpvkXM2n5t+Fdk3O559WvPkW1CLxlxK3IrQHMj
         RrzknEiGHNEHGGmPuzfqsTn3rVOCTV7yhnyMQef9W22sRLFC9ZVmWTC5Z29VRjA8DWIk
         ihyQ0yPQ6+86m3FVnQb8gHbHN5yTBNgMJRsaqAKHO7HALIuqiaw9tNCLokLw0wOFpv5L
         hE1SdnvSE+Je24BOjJDK1RYtZzoYke3tQR/gNOaZmfjCouqgjdtXBjOa4eYCq+o0DjIR
         F+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/1/iKFgTEaXpeeMtg3Y/NQrhx55prRh2rnpQH0HflkI=;
        b=FWV5L+WwL7rZrCS/j1sdn5OxyCK/W/ldKA66LVw2Zn49zaDPlO6g2zDQ8M3oh2ZC4h
         Gjqr5B8PFptu97Q5osS3OqdiIBSbCg3jQUJdtSo9R1joQl/ahFKw8AfKzKFa0CM4I6GP
         huXMke00JJLi3rYK5iVdU18e6q4TkzAy/kbmGOn/lEWiqtUsIXfSpOvQyx+c3rsWWutY
         lFtUHzigwPAI+qJv9EyBOwwUJwnv1K5j/vom/TYEkY1l9ermkbIfZPDmdSFEm9PiAVFT
         ElKi/wMA2vdZtOv2nZ19LeDjSqE6hbhnoXcC+TGK1gMCnXmcx+ksQ4rk8zmHtowWkMDQ
         kidQ==
X-Gm-Message-State: AOUpUlFf8l1HIIqrWV9iMxQFIaSGEW4yzOdEYWISM13Hr/hgwxkSV1wp
        z0XJPWszzyqFXDaicsU2hfud/Tk6
X-Google-Smtp-Source: AA+uWPwxcGpzMrFCk+ahq10+zYYApcIGxRuZE0U7uT3lC3QNk3gaIudtdQYo8YrL1wmXtuEJLKempg==
X-Received: by 2002:a17:902:c6:: with SMTP id a64-v6mr23897557pla.180.1534372621094;
        Wed, 15 Aug 2018 15:37:01 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 14-v6sm48817514pft.93.2018.08.15.15.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 15:37:00 -0700 (PDT)
Date:   Wed, 15 Aug 2018 15:36:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86/speculation/l1tf: Add assembly guard for xtensa/ia64
Message-ID: <20180815223658.GA11323@roeck-us.net>
References: <20180815215646.12653-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815215646.12653-1-andi@firstfloor.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 02:56:46PM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The stable backport of the
> 
> x86/speculation/l1tf: Disallow non privileged high MMIO PROT_NONE mappings
> 
> patch for 4.4 and 4.9 put new C code for !__HAVE_ARCH_PFN_MODIFY_ALLOWED
> code outside the assembler ifdef. This breaks the xtensa and ia64
> build as reported by 0day which somehow include this file
> into assembler.
> 
> Just add an #ifdef __ASSEMBLY__ around the new code to fix this.
> 
> This patch is only needed for 4.9 and 4.4 stable, the newer stables
> don't have this problem.
> 
> Fixes: 7c5b42f82c13 ("x86/speculation/l1tf: Disallow non privileged high MMIO PROT_NONE mappings")
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

This should be fixed in the final stable releases.
The problem was caused by a couple of missing backports.

Guenter
