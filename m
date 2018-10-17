Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1EBC5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E3D214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E3D214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeJQLS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 07:18:27 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:53812 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbeJQLS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 07:18:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id D191F28E1A;
        Tue, 16 Oct 2018 23:24:47 -0400 (EDT)
Date:   Wed, 17 Oct 2018 14:24:47 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ips: fix missing break in switch
In-Reply-To: <yq1r2gppdyf.fsf@oracle.com>
Message-ID: <alpine.LNX.2.21.1810171327290.8@nippy.intranet>
References: <20181016091223.GA19765@embeddedor.com>        <yq1ftx5sgw1.fsf@oracle.com>        <alpine.LNX.2.21.1810170922480.130@nippy.intranet> <yq1r2gppdyf.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018, Martin K. Petersen wrote:

> 
> Finn,
> 
> > This looks wrong to me. I think you've just prevented all START STOP 
> > commands sent to logical volumes from reaching
> >
> >         return ((*ha->func.issue) (ha, scb));
> >
> > I think a better patch is to add a "fall though" comment not a "break" 
> > statement. (I no longer have access to a ServeRAID board so I can't 
> > test.)
> 
> When I looked at this a few days ago, it seemed that the fallthrough to 
> the TUR/INQUIRY case statement was accidental and that the intent was to 
> quickly complete START_STOP unit (which probably doesn't make much sense 
> for a RAID device anyway).
> 
> See the case statements above for another fast exit scenario.
> 

But that's an error path.

Also note that START_STOP also appears in ips_chkstatus(), which suggests 
to me that this command may be submitted legitimately.

> Sadly I have no way to test this. It just stuck out like a false 
> positive in Gustavo's fallthrough markup patch.
> 

Without testers, and without another maintainer to review this, I'd 
advocate a more prudent approach. I wonder whether there is another 
maintainer to do a review. The MAINTAINERS file seems to contradict 
itself.

$ grep -C5 drivers/scsi/ips MAINTAINERS 
...
IBM ServeRAID RAID DRIVER
S:      Orphan
F:      drivers/scsi/ips.*
...
IPS SCSI RAID DRIVER
M:      Adaptec OEM Raid Solutions <aacraid@microsemi.com>
L:      linux-scsi@vger.kernel.org
W:      http://www.adaptec.com/
S:      Maintained
F:      drivers/scsi/ips*
...

Note that 'drivers/scsi/ips*' got assigned to Microsemi by a janitorial 
change, as part of commit 679655daffdd ("MAINTAINERS - Add file patterns") 
in 2009. But for ips.c, the last acked-by from the vendor was in 2008.

-- 
