Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7XerIjfOGlvfdAAAmS7hNA
	; Fri, 08 Jun 2018 18:43:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7D1E0607DC; Fri,  8 Jun 2018 18:43:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DB3E46074D;
	Fri,  8 Jun 2018 18:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB3E46074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752968AbeFHSnA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:43:00 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:59995 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752623AbeFHSm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:42:58 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fRMLY-0006mU-8R; Fri, 08 Jun 2018 19:42:48 +0100
Message-ID: <1528483367.2289.105.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 038/268] Btrfs: fix scrub to repair raid6 corruption
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liu Bo <bo.li.liu@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Cc: stable@vger.kernel.org, David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Date: Fri, 08 Jun 2018 19:42:47 +0100
In-Reply-To: <20180528100206.374694208@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
         <20180528100206.374694208@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-28 at 12:00 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Liu Bo <bo.li.liu@oracle.com>
> 
> [ Upstream commit 762221f095e3932669093466aaf4b85ed9ad2ac1 ]

The diff here is actually from commit 8810f7517a3b ("Btrfs: make raid6
rebuild retry more", mentioned in this commit message).  (Sasha, please
try to work out why commit messages and descriptions are getting mixed
up in your auto-selections.)

Maybe stable branches should get the real commit 762221f095e3 as well?

Ben.

> The raid6 corruption is that,
> suppose that all disks can be read without problems and if the content
> that was read out doesn't match its checksum, currently for raid6
> btrfs at most retries twice,
> 
> - the 1st retry is to rebuild with all other stripes, it'll eventually
>   be a raid5 xor rebuild,
> - if the 1st fails, the 2nd retry will deliberately fail parity p so
>   that it will do raid6 style rebuild,
> 
> however, the chances are that another non-parity stripe content also
> has something corrupted, so that the above retries are not able to
> return correct content.
> 
> We've fixed normal reads to rebuild raid6 correctly with more retries
> in Patch "Btrfs: make raid6 rebuild retry more"[1], this is to fix
> scrub to do the exactly same rebuild process.
> 
> [1]: https://patchwork.kernel.org/patch/10091755/
> 
> Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/btrfs/raid56.c  |   18 ++++++++++++++----
>  fs/btrfs/volumes.c |    9 ++++++++-
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -2160,11 +2160,21 @@ int raid56_parity_recover(struct btrfs_r
>  	}
>  
>  	/*
> -	 * reconstruct from the q stripe if they are
> -	 * asking for mirror 3
> +	 * Loop retry:
> +	 * for 'mirror == 2', reconstruct from all other stripes.
> +	 * for 'mirror_num > 2', select a stripe to fail on every retry.
>  	 */
> -	if (mirror_num == 3)
> -		rbio->failb = rbio->real_stripes - 2;
> +	if (mirror_num > 2) {
> +		/*
> +		 * 'mirror == 3' is to fail the p stripe and
> +		 * reconstruct from the q stripe.  'mirror > 3' is to
> +		 * fail a data stripe and reconstruct from p+q stripe.
> +		 */
> +		rbio->failb = rbio->real_stripes - (mirror_num - 1);
> +		ASSERT(rbio->failb > 0);
> +		if (rbio->failb <= rbio->faila)
> +			rbio->failb--;
> +	}
>  
>  	ret = lock_stripe_add(rbio);
>  
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5056,7 +5056,14 @@ int btrfs_num_copies(struct btrfs_fs_inf
>  	else if (map->type & BTRFS_BLOCK_GROUP_RAID5)
>  		ret = 2;
>  	else if (map->type & BTRFS_BLOCK_GROUP_RAID6)
> -		ret = 3;
> +		/*
> +		 * There could be two corrupted data stripes, we need
> +		 * to loop retry in order to rebuild the correct data.
> +		 *
> +		 * Fail a stripe at a time on every retry except the
> +		 * stripe under reconstruction.
> +		 */
> +		ret = map->num_stripes;
>  	else
>  		ret = 1;
>  	free_extent_map(em);

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
