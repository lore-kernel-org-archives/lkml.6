Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1740EECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59BE20883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59BE20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeKIAC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:02:28 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40241 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbeKIAC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:02:28 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 41D872080C; Thu,  8 Nov 2018 15:26:43 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0AC38206A1;
        Thu,  8 Nov 2018 15:26:43 +0100 (CET)
Date:   Thu, 8 Nov 2018 15:26:42 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, juergen.lachmann@harman.com,
        linux-kernel@vger.kernel.org, thomas.roeder@harman.com
Subject: Re: [PATCH 2/2] ubi: Expose the bitrot interface
Message-ID: <20181108152642.03178c6c@bbrezillon>
In-Reply-To: <20181107221619.32498-2-richard@nod.at>
References: <20181107221619.32498-1-richard@nod.at>
        <20181107221619.32498-2-richard@nod.at>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Nov 2018 23:16:19 +0100
Richard Weinberger <richard@nod.at> wrote:

> +/**
> + * ubi_bitflip_check - Check an eraseblock for bitflips and scrub it if needed.
> + * @ubi: UBI device description object
> + * @pnum: the physical eraseblock to schedule
> + * @force_scrub: force scrubbing if non-zero, schedule erase otherwise

Are you sure about the "schedule erase otherwise"? I'd say force_scrub
only influence when the scrub operation is done: either unconditionally
or depending on the result of ubi_io_read().

> + *
> + * This function reads the given eraseblock and checks if bitflips occured.
> + * In case of bitflips, the eraseblock is scheduled for scrubbing.
> + * If scrubbing is forced with @force_scrub, the eraseblock is not read,
> + * but scheduled for scrubbing right away.
> + *
> + * Returns:
> + * %EINVAL, PEB is out of range
> + * %ENOENT, PEB is no longer used by UBI
> + * %EBUSY, PEB cannot be checked now or a check is currently running on it
> + * %EAGAIN, bit flips happened but scrubbing is currently not possible
> + * %EUCLEAN, bit flips happened and PEB is scheduled for scrubbing
> + * %0, no bit flips detected
> + */
> +int ubi_bitflip_check(struct ubi_device *ubi, int pnum, int force_scrub)

