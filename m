Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6A5C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D9020820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D9020820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeKASPm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:15:42 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:41484 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeKASPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:15:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B60AA603C29B;
        Thu,  1 Nov 2018 10:13:31 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dQ1C4J9dZmvW; Thu,  1 Nov 2018 10:13:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6ABBC603C29D;
        Thu,  1 Nov 2018 10:13:31 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dgV7-KxFJdby; Thu,  1 Nov 2018 10:13:31 +0100 (CET)
Received: from blindfold.localnet (089144197035.atnat0006.highway.a1.net [89.144.197.35])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id D0936603C29B;
        Thu,  1 Nov 2018 10:13:30 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell Senior <russell@personaltelco.net>,
        Stable <stable@vger.kernel.org>
Subject: Re: [PATCH] ubifs: Handle re-linking of inodes correctly while recovery
Date:   Thu, 01 Nov 2018 10:13:29 +0100
Message-ID: <6483105.q6B1KMqZtl@blindfold>
In-Reply-To: <CACna6rxJBR=uUfVv3tBfwyKHvK_4HhEy7rD6f66n0o8FkPmmhQ@mail.gmail.com>
References: <20181028214407.20965-1-richard@nod.at> <CACna6rxJBR=uUfVv3tBfwyKHvK_4HhEy7rD6f66n0o8FkPmmhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 1. November 2018, 09:55:53 CET schrieb Rafał Miłecki:
> On Sun, 28 Oct 2018 at 22:44, Richard Weinberger <richard@nod.at> wrote:
> > UBIFS's recovery code strictly assumes that a deleted inode will never
> > come back, therefore it removes all data which belongs to that inode
> > as soon it faces an inode with link count 0 in the replay list.
> > Before O_TMPFILE this assumption was perfectly fine. With O_TMPFILE
> > it can lead to data loss upon a power-cut.
> >
> > Consider a journal with entries like:
> > 0: inode X (nlink = 0) /* O_TMPFILE was created */
> > 1: data for inode X /* Someone writes to the temp file */
> > 2: inode X (nlink = 0) /* inode was changed, xattr, chmod, … */
> > 3: inode X (nlink = 1) /* inode was re-linked via linkat() */
> >
> > Upon replay of entry #2 UBIFS will drop all data that belongs to inode X,
> > this will lead to an empty file after mounting.
> >
> > As solution for this problem, scan the replay list for a re-link entry
> > before dropping data.
> >
> > Fixes: 474b93704f32 ("ubifs: Implement O_TMPFILE")
> > Cc: stable@vger.kernel.org
> > Reported-by: Russell Senior <russell@personaltelco.net>
> > Reported-by: Rafał Miłecki <zajec5@gmail.com>
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> 
> Thank you Richard!!!
> 
> Tested-by: Rafał Miłecki <rafal@milecki.pl>

Thanks for testing and providing the reproducer!
I'll send a v2 of the patch soon where I've optimized the list scanning more.
In fact, the correct and fasted approach is walking the replay list backwards
to find the final link state of an inode.

Thanks,
//richard


