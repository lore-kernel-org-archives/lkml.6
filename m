Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BCDECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C53214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPqvm23U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C53214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbeIQVxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:53:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728455AbeIQVxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:53:04 -0400
Received: from dhcp-113.nfsv4bat.org (unknown [66.187.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24FEE20883;
        Mon, 17 Sep 2018 16:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537201499;
        bh=lWzEIInDgcqPHHTp+ynYzTDcqBaWOhrbfE3+MFa3KII=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fPqvm23UEO8rYGBmOvF5MssgsaUKkE6clytHPQZKXFU+Fnuqg+GKLz24uiLO8xnMy
         9gyRG8+k1t4jHBqZTM3dFnE7mqwqHnrBAL3ZTzPftsUYW9U8NjL9Ljj3RJ9WFth+yT
         kZVI7wWolEpGR0PTU4fyDBLJdcS4Wt6Z3HULgNnM=
Message-ID: <c7e4a674b86760e7878aa8dc66988f38db235ec3.camel@kernel.org>
Subject: Re: [RFC][PATCH 0/3] exec: Moving unshare_files_struct
From:   Jeff Layton <jlayton@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     viro@zeniv.linux.org.uk, berrange@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>
Date:   Mon, 17 Sep 2018 12:24:57 -0400
In-Reply-To: <87a7ohs5ow.fsf@xmission.com>
References: <20180914105310.6454-1-jlayton@kernel.org>
         <87a7ohs5ow.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-09-16 at 19:38 +0200, Eric W. Biederman wrote:
> Paired with Oleg's patch to reduce the number of callers of
> get_files_struct it looks like we can simplify the basic idea of moving
> unshare_files in exec by quite a bit so that in net we have fewer lines
> of code.
> 
> The big simplification from Jeff's verion is that we take advantage
> of calling unshare_files past the point of no return.  Which removes
> the need for cleanup, and restoring ->files.  Which removes the
> need for blocking clone and unshare.
> 
> Oleg's patch to remove get_files_struct from proc means we don't need
> two counts in files_struct.
> 
> Which leaves us with the question of what are the races in fs/exec.c
> with respect to accessing files.  Semantically I don't think we care
> but we do need to be certain the implementation of exec is still robust.
> 
> These patches are still rough and ready and only compile tested but I
> believe they demonstrate what is possible.
> 
> Eric W. Biederman (3):
>       exec: Move unshare_files down to avoid locks being dropped on exec.
>       exec: Simplify unshare_files
>       exec: Remove reset_files_struct
> 
>  fs/coredump.c           |  5 +----
>  fs/exec.c               | 16 +++++-----------
>  fs/file.c               | 12 ------------
>  include/linux/fdtable.h |  3 +--
>  kernel/fork.c           | 12 ++++++------
>  5 files changed, 13 insertions(+), 35 deletions(-)
> 
> Eric

Much better than what I had proposed and I do like that diffstat. You
can add this from me too:

    Reviewed-by: Jeff Layton <jlayton@kernel.org>

Maybe get this into -next soon once it has passed some sanity tests?

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

