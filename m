Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BB7C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FAD9217CB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="oYox3bUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FAD9217CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbeHDX0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 19:26:33 -0400
Received: from imap.thunk.org ([74.207.234.97]:37872 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728889AbeHDX0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 19:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jN0bIPtmlxtxd+2BGp5uTQ8ax1Z/GZoHKjKaOhHjv40=; b=oYox3bUK1YbcuCoGeLWgKjukJv
        kxRYXk7mWkh2ekmC5e857c/4giLbK7rT/z0rLJWkjixiLCam7jRYbQ3TO1VKerb3jAfLbyEXhIHDC
        OBMHE2nDqjbDpUxG3Kc/8c6+9voogq0KsYm0TvBJo0xiyDIHhrtKA/IsSyouL6tBXn/E=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fm42F-0002Cr-Ic; Sat, 04 Aug 2018 21:24:27 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4D1FD7A64C9; Sat,  4 Aug 2018 17:24:26 -0400 (EDT)
Date:   Sat, 4 Aug 2018 17:24:26 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4/mballoc: Remove unneeded variable "err"
Message-ID: <20180804212426.GE4461@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        zhong jiang <zhongjiang@huawei.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533380696-16325-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533380696-16325-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 07:04:56PM +0800, zhong jiang wrote:
> The err is not used after initalization. So just remove the variable.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

I'll apply this patch, but how did you generate the diff?  The
function name here is all wrong:

> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 8b24d3d..e29fce2 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3801,7 +3801,6 @@ static int ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^

The lines in question are from ext4_mb_release_inode_pa(), *not*
ext4_mb_new_preallocation().  So when I inspected the patch visually,
my first reaction was, "there's no way this patch would apply".

But then I looked at the C code changed by the patch, and I was
surprised to see that it applied correctly in a completely different
function, and when I regenerated the patch, the line numbers matched
yours --- so the only thing "wrong" in your patch is the function name.

So that raises the question --- how did you create the diff in this
patch?  What version of git?  And what version of the kernel?

Regards,

					- Ted
