Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2D5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92413208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92413208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755212AbeFRHeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:34:06 -0400
Received: from ozlabs.org ([203.11.71.1]:33129 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754865AbeFRHeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:34:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418NBd4frgz9s2L;
        Mon, 18 Jun 2018 17:34:01 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Constant ata messages on console with commit 28361c403683 ("libata: add extra internal command") (was Re: [GIT PULL 2/2] libata changes for v4.18-rc1)
In-Reply-To: <20180605191525.GF1351649@devbig577.frc2.facebook.com>
References: <20180605190807.GE1351649@devbig577.frc2.facebook.com> <20180605191525.GF1351649@devbig577.frc2.facebook.com>
Date:   Mon, 18 Jun 2018 17:33:57 +1000
Message-ID: <87bmc8a6qi.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo <tj@kernel.org> writes:
...
> Jens Axboe (10):
>       libata: introduce notion of separate hardware tags
>       libata: convert core and drivers to ->hw_tag usage
>       libata: bump ->qc_active to a 64-bit type
>       libata: use ata_tag_internal() consistently
>       libata: remove assumption that ATA_MAX_QUEUE - 1 is the max
>       sata_nv: set host can_queue count appropriately
>       libata: add extra internal command

Replying here because I can't find the original mail.

The above commit is causing one of my machines to constantly spew ata
messages on the console, according to bisect:

# first bad commit: [28361c403683c2b00d4f5e76045f3ccd299bf99d] libata: add extra internal command

To get it to boot I have to also apply:

  88e10092f6a6 ("sata_fsl: use the right type for tag bitshift")


The system boots OK and seems fine, except that it's just printing
multiple of these per second:

  ata2: Signature Update detected @ 0 msecs
  ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  ata2.00: configured for UDMA/100
  ata2: Signature Update detected @ 0 msecs
  ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  ata2.00: configured for UDMA/100
  ata2: Signature Update detected @ 0 msecs
  ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  ata2.00: configured for UDMA/100
  ata2: Signature Update detected @ 0 msecs
  ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  ata2.00: configured for UDMA/100
  ata2: Signature Update detected @ 0 msecs

And it never seems to stop.

The machine is a Freescale/NXP P5020ds, using the sata_fsl driver
presumably. Any ideas?

cheers
