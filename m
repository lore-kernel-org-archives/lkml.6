Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752B7C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBD926235
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBD926235
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934117AbeF0NRQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:17:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752144AbeF0NRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:17:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B7FA070206;
        Wed, 27 Jun 2018 13:17:12 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 272382026D5B;
        Wed, 27 Jun 2018 13:17:12 +0000 (UTC)
Date:   Wed, 27 Jun 2018 09:17:11 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH V7 01/24] dm: use bio_split() when splitting out the
 already processed bio
Message-ID: <20180627131711.GA11531@redhat.com>
References: <20180627124548.3456-1-ming.lei@redhat.com>
 <20180627124548.3456-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627124548.3456-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 27 Jun 2018 13:17:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 27 Jun 2018 13:17:12 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'msnitzer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27 2018 at  8:45am -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> From: Mike Snitzer <snitzer@redhat.com>
> 
> Use of bio_clone_bioset() is inefficient if there is no need to clone
> the original bio's bio_vec array.  Best to use the bio_clone_fast()
> variant.  Also, just using bio_advance() is only part of what is needed
> to properly setup the clone -- it doesn't account for the various
> bio_integrity() related work that also needs to be performed (see
> bio_split).
> 
> Address both of these issues by switching from bio_clone_bioset() to
> bio_split().
> 
> Fixes: 18a25da8 ("dm: ensure bio submission follows a depth-first tree walk")
> Cc: stable@vger.kernel.org
> Reported-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: NeilBrown <neilb@suse.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>

FYI, I'll be sending this to Linus tomorrow.

Mike
