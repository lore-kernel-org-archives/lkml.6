Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbeEOHoK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:44:10 -0400
Received: from verein.lst.de ([213.95.11.211]:40469 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752059AbeEOHoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:44:09 -0400
Date: Tue, 15 May 2018 09:48:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/5] nvme: don't hold nvmf_transports_rwsem for more
        than transport lookups
Message-ID: <20180515074826.GA23659@lst.de>
References: <20180515074043.22843-1-jthumshirn@suse.de> <20180515074043.22843-3-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515074043.22843-3-jthumshirn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 7ae732a77fe8..febf82639b40 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -957,16 +957,17 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
>  
>  	down_read(&nvmf_transports_rwsem);
>  	ops = nvmf_lookup_transport(opts);
> +	up_read(&nvmf_transports_rwsem);

And what protects us from the transport getting unregister right here
from anothet thread waiting to acquire nvmf_transports_rwsem?
