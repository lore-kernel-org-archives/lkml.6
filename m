Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFDDECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4398F21470
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4398F21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeJRKgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 06:36:06 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:43844 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbeJRKgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 06:36:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 5369D28F2C;
        Wed, 17 Oct 2018 22:37:24 -0400 (EDT)
Date:   Thu, 18 Oct 2018 13:37:24 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ips: fix missing break in switch
In-Reply-To: <yq1tvlkkr02.fsf@oracle.com>
Message-ID: <alpine.LNX.2.21.1810181319590.8@nippy.intranet>
References: <20181016091223.GA19765@embeddedor.com> <yq1ftx5sgw1.fsf@oracle.com> <alpine.LNX.2.21.1810170922480.130@nippy.intranet> <yq1r2gppdyf.fsf@oracle.com> <alpine.LNX.2.21.1810171327290.8@nippy.intranet> <yq1tvlkkr02.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018, Martin K. Petersen wrote:

> 
> >> See the case statements above for another fast exit scenario.
> >> 
> >
> > But that's an error path.
> 
> Look further down. Several other SCSI commands are completed as NOPs the 
> same way.
> 

That's true, but it doesn't indicate a bug to me.

On the contrary, the entire switch (scb->scsi_cmd->cmnd[0]) statement in 
ips_send_cmd() appears to be carefully constructed, just like the matching 
statement in ips_chkstatus().

But none of these indications can decide the question. We just don't have 
enough information. (I'm sure that someone somewhere does have the 
relevant technical information...)

If this really is undecidable, then I think the right patch is the more 
prudent one. That is, add a "fall through" comment, not a "break" 
statement.

Or perhaps a "fall through (TODO: check this)" comment.

> Also, I don't see how the case statement for TUR/INQUIRY would do 
> anything meaningful in terms of preparing a START STOP UNIT for the 
> firmware.
> 

If SSU case doesn't do anything meaningful, then neither does the 
TUR/INQUIRY case, and then you can just delete all of that code:

                        } else {
                                scb->cmd.logical_info.op_code = IPS_CMD_GET_LD_INFO;
                                scb->cmd.logical_info.command_id = IPS_COMMAND_ID(ha, scb);
                                scb->cmd.logical_info.reserved = 0;
                                scb->cmd.logical_info.reserved2 = 0;
                                scb->data_len = sizeof (IPS_LD_INFO);
                                scb->data_busaddr = ha->logical_drive_info_dma_addr;
                                scb->flags = 0;
                                scb->cmd.logical_info.buffer_addr = scb->data_busaddr;
                                ret = IPS_SUCCESS;
                        }

FWIW, I think this line of reasoning is mistaken.

-- 
