Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753556AbeC1ORt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:17:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:17289 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeC1ORs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:17:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,371,1517904000";
   d="scan'208";a="46011552"
Date: Wed, 28 Mar 2018 08:20:14 -0600
From: Keith Busch <keith.busch@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: use upper_32_bits() instead of bit shift
Message-ID: <20180328142014.GB13039@localhost.localdomain>
References: <20180328135817.2419127-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328135817.2419127-1-arnd@arndb.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 03:57:47PM +0200, Arnd Bergmann wrote:
> @@ -2233,8 +2233,8 @@ int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  	c.get_log_page.lid = log_page;
>  	c.get_log_page.numdl = cpu_to_le16(dwlen & ((1 << 16) - 1));
>  	c.get_log_page.numdu = cpu_to_le16(dwlen >> 16);
> -	c.get_log_page.lpol = cpu_to_le32(offset & ((1ULL << 32) - 1));
> -	c.get_log_page.lpou = cpu_to_le32(offset >> 32ULL);
> +	c.get_log_page.lpol = cpu_to_le32(lower_32_bits(offset));
> +	c.get_log_page.lpou = cpu_to_le32(upper_32_bits(offset));
>  
>  	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
>  }

Right, Matias posted the same fix here:

 http://lists.infradead.org/pipermail/linux-nvme/2018-March/016474.html

In addition to the type safe shifting, a 64-bit type was used to match
the spec.
