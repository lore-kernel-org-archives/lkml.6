Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B1EECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D78521486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D78521486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbeIXUGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:06:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36098 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728096AbeIXUGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:06:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4685180D;
        Mon, 24 Sep 2018 07:03:42 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14DE03F5B7;
        Mon, 24 Sep 2018 07:03:40 -0700 (PDT)
Date:   Mon, 24 Sep 2018 15:03:38 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jun Yao <yaojun8558363@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] arm64/mm: Introduce the init_pg_dir.
Message-ID: <20180924140338.nu7jn3hfcwwoztnt@lakrids.cambridge.arm.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
 <20180917044333.30051-2-yaojun8558363@gmail.com>
 <20180924130137.re3nftpsi2dx2da2@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924130137.re3nftpsi2dx2da2@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 02:01:37PM +0100, Mark Rutland wrote:
> On Mon, Sep 17, 2018 at 12:43:28PM +0800, Jun Yao wrote:
> > To make the swapper_pg_dir read only, we will move it to the rodata
> > section. And force the kernel to set up the initial page table in
> > the init_pg_dir. After generating all levels page table, we copy
> > only the top level into the swapper_pg_dir during paging_init().

> > +#define INIT_PG_TABLES					\
> > +	. = ALIGN(PAGE_SIZE);				\
> > +	init_pg_dir = .;				\
> > +	. += SWAPPER_DIR_SIZE;				\
> > +	init_pg_end = .;
> 
> This will allocate a full set of PGD + PUD + PMD (+ PTE) levels, but the
> commit message says we only copy the top level table.
> 
> The memory for otjher levels of table can be re-allocated once the
> kernel init phase is over, so that seems a bit worrying.
> 
> Do we switch over to new copies of those levels, or do we continue using
> the entries from INIT_PG_TABLES?

I now see that we already allocate copies of those levels of table (and
free the originals in paging_init), so this is not a problem.

Sorry for the noise!

Mark.
