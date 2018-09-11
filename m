Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5E7C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0229E20833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0229E20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeIKRL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:11:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:60896 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726678AbeIKRL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:11:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 16E5FAFC3;
        Tue, 11 Sep 2018 12:12:23 +0000 (UTC)
Date:   Tue, 11 Sep 2018 14:12:22 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Meelis Roos <mroos@linux.ee>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 32-bit PTI with THP = userspace corruption
Message-ID: <20180911121128.ikwptix6e4slvpt2@suse.de>
References: <alpine.LRH.2.21.1808301639570.15669@math.ut.ee>
 <20180830205527.dmemjwxfbwvkdzk2@suse.de>
 <alpine.LRH.2.21.1808310711380.17865@math.ut.ee>
 <20180831070722.wnulbbmillxkw7ke@suse.de>
 <alpine.DEB.2.21.1809081223450.1402@nanos.tec.linutronix.de>
 <20180911114927.gikd3uf3otxn2ekq@suse.de>
 <alpine.LRH.2.21.1809111454100.29433@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1809111454100.29433@math.ut.ee>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 02:58:10PM +0300, Meelis Roos wrote:
> The machines where I have PAE off are the ones that have less memory. 
> PAE is off just for performance reasons, not lack of PAE. PAE should be 
> present on all of my affected machines anyway and current distributions 
> seem to mostly assume 686 and PAE anyway for 32-bit systems.

Right, most distributions don't even provide a non-PAE kernel for their
users anymore.

How big is the performance impact of using PAE over legacy paging? It
shouldn't be too big because the top-level of the page-table only has 4
entries and is completly cached in the CPU. This makes %cr3 switches
slower, but the page-walk itself still only needs 2 memory accesses.

The page-table entries are also 8 bytes instead of 4 bytes, so that
there is less locality in page-walks and probably a higher cache-miss
rate.

Regards,

	Joerg
