Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CA9C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 16:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389B6208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 16:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389B6208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934166AbeFQQ0o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 12:26:44 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:46626 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933955AbeFQQ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 12:26:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fUaVi-0004qW-JH; Sun, 17 Jun 2018 17:26:38 +0100
Message-ID: <1529252797.2289.206.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 181/268] Btrfs: fix copy_items() return value when
 logging an inode
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 17 Jun 2018 17:26:37 +0100
In-Reply-To: <20180528100222.864980245@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
         <20180528100222.864980245@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-28 at 12:02 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Filipe Manana <fdmanana@suse.com>
> 
> [ Upstream commit 8434ec46c6e3232cebc25a910363b29f5c617820 ]

Should stable branches also get a backport of commit
4ee3fad34a9cc2cf33303dfbd0cf554248651c86?  It looks like 4.4 and 4.9
would need a minor change (inode->root to BTRFS_I(inode)->root) but I
don't know whether that's really sufficient.

Ben.

> When logging an inode, at tree-log.c:copy_items(), if we call
> btrfs_next_leaf() at the loop which checks for the need to log holes, we
> need to make sure copy_items() returns the value 1 to its caller and
> not 0 (on success). This is because the path the caller passed was
> released and is now different from what is was before, and the caller
> expects a return value of 0 to mean both success and that the path
> has not changed, while a return value of 1 means both success and
> signals the caller that it can not reuse the path, it has to perform
> another tree search.
> 
> Even though this is a case that should not be triggered on normal
> circumstances or very rare at least, its consequences can be very
> unpredictable (especially when replaying a log tree).
> 
> Fixes: 16e7549f045d ("Btrfs: incompatible format change to remove hole extents")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/btrfs/tree-log.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3835,6 +3835,7 @@ fill_holes:
>  			ASSERT(ret == 0);
>  			src = src_path->nodes[0];
>  			i = 0;
> +			need_find_last_extent = true;
>  		}
>  
>  		btrfs_item_key_to_cpu(src, &key, i);

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
