Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E50C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E3B21722
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E3B21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbeHHMF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:05:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:48096 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726998AbeHHMF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:05:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB458AE17;
        Wed,  8 Aug 2018 09:47:01 +0000 (UTC)
Date:   Wed, 8 Aug 2018 11:46:59 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     kernel test robot <lkp@intel.com>
Cc:     LKP <lkp@01.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 30514effc9 ("x86/mm/pti: Don't clear permissions in .."):
 WARNING: CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:283 note_page
Message-ID: <20180808094659.rcnxq32v3p2mdrwt@suse.de>
References: <5b6ab75d.0adGiApE+ajF886e%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b6ab75d.0adGiApE+ajF886e%lkp@intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for the report!

On Wed, Aug 08, 2018 at 05:26:53PM +0800, kernel test robot wrote:
> [   16.937839] Freeing unused kernel image memory: 556K
> [   16.954368] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [   16.956696] x86/mm: Checking user space page tables
> [   16.973108] ------------[ cut here ]------------
> [   16.975052] x86/mm: Found insecure W+X mapping at address (____ptrval____)/native_usergs_sysret64+0x0/0x10
> [   16.978787] WARNING: CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:283 note_page+0xdd/0x890

I think this is caused by debug_checkrwx() running before
pti_finalize(). The check runs on the user page-tables before they are
finished. I prepare a patch to move the check for the user page-table to
pti_finilize() after the page-tables are updated. That should fix the
warning.


Thanks,

	Joerg
