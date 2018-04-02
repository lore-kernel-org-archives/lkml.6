Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeDBOzi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 10:55:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:47287 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbeDBOzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 10:55:37 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,395,1517904000";
   d="scan'208";a="30418714"
Date: Mon, 2 Apr 2018 08:58:13 -0600
From: Keith Busch <keith.busch@intel.com>
To: "Rodrigo R. Galvao" <rosattig@linux.vnet.ibm.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvmet: fix nvmet_execute_write_zeroes function
Message-ID: <20180402145813.GE28945@localhost.localdomain>
References: <1522680581-10220-1-git-send-email-rosattig@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522680581-10220-1-git-send-email-rosattig@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 11:49:41AM -0300, Rodrigo R. Galvao wrote:
> When trying to issue write_zeroes command against TARGET with a 4K block
> size, it ends up hitting the following condition at __blkdev_issue_zeroout:
> 
>      if ((sector | nr_sects) & bs_mask)
>                 return -EINVAL;
> 
> Causing the command to always fail.
> Considering we need to add 1 to get the correct block count, that addition
> needs to be performed in the native format, so we moved the +1 to within
> le16_to_cpu prior to converting to 512b.
> 
> Signed-off-by: Rodrigo R. Galvao <rosattig@linux.vnet.ibm.com>
> ---
>  drivers/nvme/target/io-cmd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
> index 28bbdff..5292bc3 100644
> --- a/drivers/nvme/target/io-cmd.c
> +++ b/drivers/nvme/target/io-cmd.c
> @@ -173,8 +173,8 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
>  
>  	sector = le64_to_cpu(write_zeroes->slba) <<
>  		(req->ns->blksize_shift - 9);
> -	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length)) <<
> -		(req->ns->blksize_shift - 9)) + 1;
> +	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length + 1)) <<
> +		(req->ns->blksize_shift - 9));

I'm terribly sorry, but the +1 actually needs to be outside the
le16_to_cpu. The above will work on little-endian machines, but not big.
