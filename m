Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0C3C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEC42184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfACVko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:40:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbfACVkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 16:40:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 205F0C7C27;
        Thu,  3 Jan 2019 21:40:43 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D98B60C47;
        Thu,  3 Jan 2019 21:40:41 +0000 (UTC)
Message-ID: <6152b478ea77dacf57eef6f758ba795f756cd3da.camel@redhat.com>
Subject: Re: [PATCH] scsi: associate bio write hint with WRITE CDB
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     dgilbert@interlog.com, Randall Huang <ihhuang@abmail.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     huangrandall@google.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 03 Jan 2019 16:40:41 -0500
In-Reply-To: <e5bc96cd-1b48-3b7e-706f-4cbbd1a040a4@interlog.com>
References: <20181226041504.66283-1-huangrandall@google.com>
         <20190103075133.GA5141@infradead.org> <20190103094755.GA96532@google.com>
         <e5bc96cd-1b48-3b7e-706f-4cbbd1a040a4@interlog.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 03 Jan 2019 21:40:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-03 at 16:00 -0500, Douglas Gilbert wrote:
> On 2019-01-03 4:47 a.m., Randall Huang wrote:
> > On Wed, Jan 02, 2019 at 11:51:33PM -0800, Christoph Hellwig wrote:
> > > On Wed, Dec 26, 2018 at 12:15:04PM +0800, Randall Huang wrote:
> > > > In SPC-3, WRITE(10)/(16) support grouping function.
> > > > Let's associate bio write hint with group number for
> > > > enabling StreamID or Turbo Write feature.
> > > > 
> > > > Signed-off-by: Randall Huang <huangrandall@google.com>
> > > > ---
> > > >   drivers/scsi/sd.c | 14 ++++++++++++--
> > > >   1 file changed, 12 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> > > > index 4b49cb67617e..28bfa9ed2b54 100644
> > > > --- a/drivers/scsi/sd.c
> > > > +++ b/drivers/scsi/sd.c
> > > > @@ -1201,7 +1201,12 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
> > > >   		SCpnt->cmnd[11] = (unsigned char) (this_count >> 16) & 0xff;
> > > >   		SCpnt->cmnd[12] = (unsigned char) (this_count >> 8) & 0xff;
> > > >   		SCpnt->cmnd[13] = (unsigned char) this_count & 0xff;
> > > > -		SCpnt->cmnd[14] = SCpnt->cmnd[15] = 0;
> > > > +		if (rq_data_dir(rq) == WRITE) {
> > > > +			SCpnt->cmnd[14] = rq->bio->bi_write_hint & 0x3f;
> > > > +		} else {
> > > > +			SCpnt->cmnd[14] = 0;
> > > > +		}
> > > 
> > > No need for braces here.
> > 
> > Already send a new version
> > > 
> > > But what I'm more worried about is devices not recognizing the feature
> > > throwing up on the field.  Can you check what SBC version first
> > > references these or come up with some other decently smart conditional?
> > 
> > My reference is SCSI Block Commands – 3 (SBC-3) Revision 25.
> > Section 5.32 WRITE (10) and 5.34 WRITE (16)
> > 
> > > Maybe Martin has a good idea, too.
> 
> That is the GROUP NUMBER field. Also found in READ(16) at the same
> location within its cdb. The proposed code deserves at least an
> explanatory comment.
> 
> Since it is relatively recent, perhaps the above should only be done iff:
>     - the REPORT SUPPORTED OPERATION CODES (RSOC) command is supported, and
>     - in the RSOC entry for WRITE(16), the CDB USAGE DATA field (a bit mask)
>       indicates the GROUP NUMBER field is supported
> 
> That check can be done once, at disk attachment time where there is already
> code to fetch RSOC.
> 
> 
> Is there a bi_read_hint ? If not then the bi_write_hint should also be applied
> to READ(16). Makes that variable naming look pretty silly though.
> 
> Doug Gilbert
> 

SBC-5 says that support for the grouping function is indicated by the
GROUP_SUP bit in the Extended Inquiry VPD page (86h).  I'm not sure how
many devices actually support that page though.  Probably most don't.

What devices actually DO support the grouping and do something with it?

We'd probably need a blacklist flag to turn this off and/or some code in
the error path to discontinue setting the field if the device returns
INVALID FIELD IN CDB or something, like we do for disabling discard
commands if they don't actually work in sd_done().

-Ewan

