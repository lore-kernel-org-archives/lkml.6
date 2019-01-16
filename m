Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDE0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDB220859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388463AbfAPHjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 02:39:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfAPHjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 02:39:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9559058E59;
        Wed, 16 Jan 2019 07:39:36 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 921135C1B4;
        Wed, 16 Jan 2019 07:39:25 +0000 (UTC)
Date:   Wed, 16 Jan 2019 15:39:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: linux-next: manual merge of the block tree with the fscrypt tree
Message-ID: <20190116073915.GA1089@ming.t460p>
References: <20190116132522.1b756433@canb.auug.org.au>
 <ca843f39-3fcd-1a03-34c9-7284f10fe262@kernel.dk>
 <20190116031301.GC26146@ming.t460p>
 <a1ce4d1d-13e0-c765-bf22-55fd67c9f1d4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1ce4d1d-13e0-c765-bf22-55fd67c9f1d4@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 16 Jan 2019 07:39:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 08:17:36PM -0700, Jens Axboe wrote:
> On 1/15/19 8:13 PM, Ming Lei wrote:
> > On Tue, Jan 15, 2019 at 07:55:39PM -0700, Jens Axboe wrote:
> >> On 1/15/19 7:25 PM, Stephen Rothwell wrote:
> >>> Hi all,
> >>>
> >>> Today's linux-next merge of the block tree got a conflict in:
> >>>
> >>>   fs/ext4/readpage.c
> >>>
> >>> between commit:
> >>>
> >>>   acc9eb0a6073 ("ext4: add fs-verity read support")
> >>>
> >>> from the fscrypt tree and commit:
> >>>
> >>>   eb754eb2a953 ("block: allow bio_for_each_segment_all() to iterate over multi-page bvec")
> >>>
> >>> from the block tree.
> >>>
> >>> I fixed it up (see below - the former moved the code modified by the
> >>> latter) and can carry the fix as necessary. This is now fixed as far as
> >>> linux-next is concerned, but any non trivial conflicts should be mentioned
> >>> to your upstream maintainer when your tree is submitted for merging.
> >>> You may also want to consider cooperating with the maintainer of the
> >>> conflicting tree to minimise any particularly complex conflicts.
> >>
> >> Ming, I'm pulling this, I thought we agreed none of these bullshit
> >> renames? The fact that a patch looks like this:
> >>
> >> -               for_each_bvec(bv, (it)->bvecs, __cur_iter, __cur_iter)        \
> >> +               for_each_segment(bv, (it)->bvecs, __cur_iter, __cur_iter)     \
> >>
> >> is SUPER annoying and does NOTHING but to cause merge conflicts.
> >>
> >> Resend it without that.
> > 
> > We need to differentiate 'segment' with 'bvec' in bvec helpers, which is
> > usually seldom used by drivers. For example, only two in-tree users(ceph, iov_iter).
> > That is why I rename it, and seems Christoph prefers to do it too.
> 
> If you want to do a rename, then we do it after. I don't want to deal with
> weeks and weeks of fallout from this. Write a rename script that we can
> then run at the end of the next merge window. You're going to be playing
> catch-up until that happens if we go the current route, and honestly
> I'm not at all interested in the fallout from that.
> 
> I know exactly what will happen until 5.1-rc opens, and what my tree will
> look like from having to deal with this. And then I know exactly what Linus
> is going to say, and I can't even argue against it, since he'll be totally
> right.
> 
> Hence it's not going to happen this way.

I can remove the renaming in patch 'block: rename bvec helpers', but
change on bio_for_each_segment_all() is inevitable, and it is still an
API change, so merge conflict can't avoid too.

Thanks,
Ming
