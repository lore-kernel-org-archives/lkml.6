Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FCBC169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 02:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDCC218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 02:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBGC1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 21:27:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:44436 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726266AbfBGC1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 21:27:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A602AEBB;
        Thu,  7 Feb 2019 02:27:20 +0000 (UTC)
Subject: Re: bcache on XFS: metadata I/O (dirent I/O?) not getting cached at
 all?
To:     Andre Noll <maan@tuebingen.mpg.de>,
        Dave Chinner <david@fromorbit.com>
Cc:     Nix <nix@esperi.org.uk>, linux-bcache@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
References: <87h8dgefee.fsf@esperi.org.uk> <20190206234328.GH14116@dastard>
 <20190207002425.GX24140@tuebingen.mpg.de>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <b982a23b-7225-d20a-2802-60bce314ccc2@suse.de>
Date:   Thu, 7 Feb 2019 10:27:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207002425.GX24140@tuebingen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/7 8:24 上午, Andre Noll wrote:
> On Thu, Feb 07, 10:43, Dave Chinner wrote
>> File data readahead: REQ_RAHEAD Metadata readahead: REQ_META |
>> REQ_RAHEAD
>> 
>> drivers/md/bcache/request.c::check_should_bypass():
>> 
>> /* * Flag for bypass if the IO is for read-ahead or background, *
>> unless the read-ahead request is for metadata (eg, for gfs2). */ 
>> if (bio->bi_opf & (REQ_RAHEAD|REQ_BACKGROUND) && !(bio->bi_opf &
>> REQ_PRIO)) goto skip;
>> 
>> bcache needs fixing - it thinks REQ_PRIO means metadata IO.
>> That's wrong - REQ_META means it's metadata IO, and so this is a
>> bcache bug.
> 
> Do you think 752f66a75abad is bad (ha!) and should be reverted?

Hi Dave and Andre,

Correct me if I am wrong: REQ_META is used for blktrace to tag
metadata IO, and REQ_PRIO is used for block layer to handle metadata IO.

I discussed with Christoph Hellwig about this topic quite long time
ago, and got the above conclusion.

If different file system handles metadata flags in unified ways, it is
OK to me to change the code to: !(bio->bi_opf & (REQ_META |REQ_PRIO)).

Thanks in advance.

-- 

Coly Li
