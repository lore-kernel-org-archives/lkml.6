Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbeEOHqj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:46:39 -0400
Received: from verein.lst.de ([213.95.11.211]:40499 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752219AbeEOHqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:46:38 -0400
Date: Tue, 15 May 2018 09:50:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/5] nvme: call nvmf_create_ctrl before checking for
        duplicate assignment
Message-ID: <20180515075055.GB23659@lst.de>
References: <20180515074043.22843-1-jthumshirn@suse.de> <20180515074043.22843-4-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515074043.22843-4-jthumshirn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 09:40:41AM +0200, Johannes Thumshirn wrote:
> In nvmf_dev_write we did check if the /dev/nvme-fabrics device node's
> private data is already set and then create a controller data
> structure afterwards. The private data is protected by the
> nvmf_dev_mutex, but there is no need to hold it while calling
> nvmf_create_ctrl().
> 
> This also reduces the number of lockdep complaints in the 'nvme
> connect' with fcloop scenario.

Something looks seriously fishy in fcloop.  How do we and up in
a RCU critical section here?

In general it seems like fc loop needs to offload any I/O to a workqueue
just like nvme-loop does, but even then I can't see how that is going to
cause an issue in this area.
