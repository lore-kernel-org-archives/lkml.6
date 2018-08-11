Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E07C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 16:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DAE21AA7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 16:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DAE21AA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeHKTKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 15:10:30 -0400
Received: from smtprelay0159.hostedemail.com ([216.40.44.159]:56515 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727450AbeHKTKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 15:10:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 4C40318029585;
        Sat, 11 Aug 2018 16:35:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shelf61_320243dd6454c
X-Filterd-Recvd-Size: 2981
Received: from XPS-9350 (cpe-75-82-193-221.socal.res.rr.com [75.82.193.221])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sat, 11 Aug 2018 16:35:43 +0000 (UTC)
Message-ID: <8af0245c1efbec6ae4ac3d2b14d6e819cb28b98e.camel@perches.com>
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
From:   Joe Perches <joe@perches.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jeff Lien <jeff.lien@wdc.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        herbert@gondor.apana.org.au, tim.c.chen@linux.intel.com,
        david.darrington@wdc.com, jeff.furlong@wdc.com
Date:   Sat, 11 Aug 2018 09:35:42 -0700
In-Reply-To: <yq1in4gq5jf.fsf@oracle.com>
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
         <yq1in4gq5jf.fsf@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-08-11 at 11:36 -0400, Martin K. Petersen wrote:
> Jeff,
> 
> > This patch provides a performance improvement for the CRC16
> > calculations done in read/write workloads using the T10 Type 1/2/3
> > guard field.  For example, today with sequential write workloads (one
> > thread/CPU of IO) we consume 100% of the CPU because of the CRC16
> > computation bottleneck.  Today's block devices are considerably
> > faster, but the CRC16 calculation prevents folks from utilizing the
> > throughput of such devices.  To speed up this calculation and expose
> > the block device throughput, we slice the old single byte for loop
> > into a 16 byte for loop, with a larger CRC table to match.  The result
> > has shown 5x performance improvements on various big endian and little
> > endian systems running the 4.18.0 kernel version.
> 
> The reason I went with a simple slice-by-one approach was that the
> larger tables had a negative impact on the CPU caches. So while
> slice-by-N numbers looked better in synthetic benchmarks, actual
> application performance started getting affected as the tables grew
> larger.
> 
> These days we obviously use the hardware-accelerated CRC calculation so
> the software table approach mostly serves as a reference
> implementation. But given your big vs. little endian performance
> metrics, I'm assuming you guys are focused on embedded processors
> without support for CRC acceleration?
> 
> I have no problem providing a choice for bigger tables. My only concern
> is that the selection heuristics need to be more than one-dimensional.
> Latency and cache side effects are often more important than throughput.
> At least on the initiator side.
> 
> Also, I'd like to keep the original slice-by-one implementation for
> reference purposes.

Did you see the suggested patch that allows
either 1, 2, 4, 8 or 16 block table sizes?

Perhaps you have a comment on that?
