Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0B3A2C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE78F208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE78F208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754097AbeFLDnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:43:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750895AbeFLDnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:43:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C406A401EF07;
        Tue, 12 Jun 2018 03:43:08 +0000 (UTC)
Received: from ming.t460p (ovpn-12-16.pek2.redhat.com [10.72.12.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BA9663F47;
        Tue, 12 Jun 2018 03:42:53 +0000 (UTC)
Date:   Tue, 12 Jun 2018 11:42:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V6 00/30] block: support multipage bvec
Message-ID: <20180612034242.GC26412@ming.t460p>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180611164806.GA7452@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180611164806.GA7452@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 12 Jun 2018 03:43:08 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 12 Jun 2018 03:43:08 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 09:48:06AM -0700, Christoph Hellwig wrote:
> І think the new naming scheme in this series is a nightmare.  It
> confuses the heck out of me, and that is despite knowing many bits of
> the block layer inside out, and reviewing previous series.

In V5, there isn't such issue, since bio_for_each_segment* is renamed
into bio_for_each_page* first before doing the change.

> 
> I think we need to take a step back and figure out what names what we
> want in the end, and how we get there separately.

Right, I agree, last year I told people that naming may be the biggest
issue for this patchset.

> 
> For the end result using bio_for_each_page in some form for the per-page
> iteration seems like the only sensible idea, as that is what it does.

Yeah, I agree, but except for renaming bio_for_each_segment* into
bio_for_each_page* or whatever first, I don't see any way to deal with
it cleanly.

Seems Jens isn't fine with the big renaming, then I follow the suggestion
of taking 'chunk' for representing multipage bvec in V6.

> 
> For the bio-vec iteration I'm fine with either bio_for_each_bvec as that
> exactly explains what it does, or bio_for_each_segment to keep the
> change at a minimum.

If bio_for_each_segment() is fine, that is basically what this patch is doing,
then could you share me what the actual naming issue is in V6? And
basically the name of 'chunk' is introduced for multipage bvec.

> 
> And in terms of how to get there: maybe we need to move all the drivers
> and file systems to the new names first before the actual changes to
> document all the intent.

That is exactly what I have done in V5, but that way is refused.

Guys, so what can we do to make progress for this naming issue? 


Thanks,
Ming
