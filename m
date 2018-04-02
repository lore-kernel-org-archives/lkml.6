Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeDBNpH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 09:45:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:49436 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751384AbeDBNpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 09:45:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,395,1517904000";
   d="scan'208";a="30886364"
Date: Mon, 2 Apr 2018 07:47:40 -0600
From: Keith Busch <keith.busch@intel.com>
To: "Rodrigo R. Galvao" <rosattig@linux.vnet.ibm.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: fix nvmet_execute_write_zeroes function
Message-ID: <20180402134740.GB28945@localhost.localdomain>
References: <1522444730-2060-1-git-send-email-rosattig@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522444730-2060-1-git-send-email-rosattig@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 06:18:50PM -0300, Rodrigo R. Galvao wrote:
>  	sector = le64_to_cpu(write_zeroes->slba) <<
>  		(req->ns->blksize_shift - 9);
>  	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length)) <<
> -		(req->ns->blksize_shift - 9)) + 1;
> +		(req->ns->blksize_shift - 9));

I see what's wrong here. The +1 needs to be on the native format prior
to converting to 512b, so the fix needs to be:

---
 	sector = le64_to_cpu(write_zeroes->slba) <<
 		(req->ns->blksize_shift - 9);
-	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length)) <<
-		(req->ns->blksize_shift - 9)) + 1;
+	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length + 1)) <<
+		(req->ns->blksize_shift - 9));
 
 	if (__blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
 				GFP_KERNEL, &bio, 0))
--
