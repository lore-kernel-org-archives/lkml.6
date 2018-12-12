Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F9CC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C9D20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C9D20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeLLOle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:41:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:58160 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726223AbeLLOle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:41:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5511BAFB6;
        Wed, 12 Dec 2018 14:41:33 +0000 (UTC)
Date:   Wed, 12 Dec 2018 08:41:30 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Avi Kivity <avi@scylladb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, linux-aio@kvack.org
Subject: Re: Spurious EIO on AIO+DIO+RWF_NOWAIT
Message-ID: <20181212144130.pifm7w7eznw6jtwn@merlin>
References: <9bab0f40-5748-f147-efeb-5aac4fd44533@scylladb.com>
 <20181210124823.iw4mxmdqpsdfeap4@merlin>
 <8fb27ba4-c100-5d08-71b6-ef393d7bcae1@scylladb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fb27ba4-c100-5d08-71b6-ef393d7bcae1@scylladb.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:05 12/12, Avi Kivity wrote:
> On 12/10/18 2:48 PM, Goldwyn Rodrigues wrote:
> > On 13:19 09/12, Avi Kivity wrote:
> > > I have an application that receives spurious EIO when running with
> > > RWF_NOWAIT enabled. Removing RWF_NOWAIT causes those EIOs to disappear. The
> > > application uses AIO+DIO, and errors were seen on both xfs and ext4.
> > > 
> > > 
> > > I suspect the following code:
> > > 
> > > 
> > > /*
> > >   * Process one completed BIO.  No locks are held.
> > >   */
> > > static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
> > > {
> > >          struct bio_vec *bvec;
> > >          unsigned i;
> > >          blk_status_t err = bio->bi_status;
> > > 
> > >          if (err) {
> > >                  if (err == BLK_STS_AGAIN && (bio->bi_opf & REQ_NOWAIT))
> > >                          dio->io_error = -EAGAIN;
> > >                  else
> > >                          dio->io_error = -EIO;
> > >          }
> > > 
> > > Could it be that REQ_NOWAIT was dropped from bio->bi_opf? or that
> > > bio->bi_status got changed along the way?
> > > 
> > I don't think REQ_NOWAIT is dropped. I am assuming bio->bi_status error
> > is set differently. Is the blk queue being stopped? Is it possible to
> > instrument the kernel in your testcase?
> > 
> 
> I traced the function, and I see bio->bi_status == BLK_STS_NOTSUPP and
> bio->bi_opf == REQ_OP_WRITE|REQ_SYNC|REQ_NOMERGE|REQ_FUA|REQ_NOWAIT.
> Presumably the NOTSUPP is the result of NOWAIT not being supported down the
> stack, but shouldn't it be detected earlier? And not converted to EIO?
> 

I don't think there is a way to detect it earlier. However, I think we should
return -EOPNOTSUPP if the lower layers do not support REQ_NOWAIT. I will write
a patch to modify this.

-- 
Goldwyn
