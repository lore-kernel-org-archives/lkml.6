Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6D5C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306AB2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306AB2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeLMWIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:08:12 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:40286 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeLMWIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:08:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 00BA76083242;
        Thu, 13 Dec 2018 23:08:10 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id U2_Lk3krFlQO; Thu, 13 Dec 2018 23:08:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 930336083254;
        Thu, 13 Dec 2018 23:08:09 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gIq2BwI660Ha; Thu, 13 Dec 2018 23:08:09 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id F417A6083242;
        Thu, 13 Dec 2018 23:08:08 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     zhangjun <openzhangj@gmail.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] ubifs: fix page_count in ->ubifs_migrate_page()
Date:   Thu, 13 Dec 2018 23:08:08 +0100
Message-ID: <1683588.PnVoaTFAp1@blindfold>
In-Reply-To: <20181213220000.7b56wysed67y5iv6@kshutemo-mobl1>
References: <1544728817-2870-1-git-send-email-openzhangj@gmail.com> <8239265.3QN2sXB6kY@blindfold> <20181213220000.7b56wysed67y5iv6@kshutemo-mobl1>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 13. Dezember 2018, 23:00:00 CET schrieb Kirill A. Shutemov:
> > Let's wait a few days to give Kirill a chance to review, then I'll apply the patch.
> 
> I don't remmeber much context now...
> 
> Could you remind me why ubifs doesn't take additional pin when sets
> PG_private?

Because it does not use set_page_private(), it just sets the flag for
internal accounting purposes.

From UBIFS docs:
 * UBIFS uses 2 page flags: @PG_private and @PG_checked. @PG_private is set if
 * the page is dirty and is used for optimization purposes - dirty pages are
 * not budgeted so the flag shows that 'ubifs_write_end()' should not release
 * the budget for this page. The @PG_checked flag is set if full budgeting is
 * required for the page e.g., when it corresponds to a file hole or it is
 * beyond the file size. The budgeting is done in 'ubifs_write_begin()', because
 * it is OK to fail in this function, and the budget is released in
 * 'ubifs_write_end()'. So the @PG_private and @PG_checked flags carry
 * information about how the page was budgeted, to make it possible to release
 * the budget properly.

> Migration is not the only place where the additional pin is implied.
> See all users of page_has_private() helper. Notably reclaim path.

Hmmm, I need to dig into that.
I this is a problem then f2fs suffers from it too.
At least from what I can tell from reading f2fs_migrate_page().

Thanks,
//richard


