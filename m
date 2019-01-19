Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1292EC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B332086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfASN2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 08:28:39 -0500
Received: from foss.arm.com ([217.140.101.70]:43564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbfASN2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 08:28:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63F0DA78;
        Sat, 19 Jan 2019 05:28:38 -0800 (PST)
Received: from MBP.local (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E13323F557;
        Sat, 19 Jan 2019 05:28:35 -0800 (PST)
Date:   Sat, 19 Jan 2019 13:28:33 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Qian Cai <cai@lca.pw>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: kmemleak panic
Message-ID: <20190119132832.GA29881@MBP.local>
References: <f6fbf528-8213-e3b8-6990-9fcf9dec04d6@free.fr>
 <20190118143434.GE118707@arrakis.emea.arm.com>
 <b7629ecf-757c-f8b5-df83-ba83d7036b2f@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7629ecf-757c-f8b5-df83-ba83d7036b2f@free.fr>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 04:36:59PM +0100, Marc Gonzalez wrote:
> mount -t debugfs nodev /sys/kernel/debug/ 
> echo scan > /sys/kernel/debug/kmemleak
> 
> Unable to handle kernel paging request at virtual address ffffffc021e00000
[...]
> Call trace:
>  scan_block+0x70/0x190
>  scan_gray_list+0x108/0x1c0
>  kmemleak_scan+0x33c/0x7c0
>  kmemleak_write+0x410/0x4b0

As per Robin's remark, this address seems to be pretty easy to
reproduce. It also happens via scan_gray_list() which indicates an
object kmemleak was informed about via kmemleak_alloc() (so this
excludes the pfn that Qian noticed).

Can you configure the kernel with CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN off
just to avoid the bug being triggered early and run:

  mount -t debugfs nodev /sys/kernel/debug/
  echo dump=0xffffffc021e00000 > /sys/kernel/debug/kmemleak

Then run another scan to make sure this is the address that triggered
the page fault:

  echo scan > /sys/kernel/debug/kmemleak

The above should tell us where the object that kmemleak is trying to
scan came from.

Of course, ideally we should bisect this but I haven't been able to
reproduce it.

-- 
Catalin
