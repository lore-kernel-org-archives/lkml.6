Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754891AbeBBS20 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:28:26 -0500
Received: from mga07.intel.com ([134.134.136.100]:51540 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754625AbeBBS1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:27:16 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,450,1511856000";
   d="scan'208";a="14914174"
Date: Fri, 2 Feb 2018 11:31:04 -0700
From: Keith Busch <keith.busch@intel.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] nvme-pci: break up nvme_timeout and nvme_dev_disable
Message-ID: <20180202183103.GI24417@localhost.localdomain>
References: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
 <1517554849-7802-5-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517554849-7802-5-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 03:00:47PM +0800, Jianchao Wang wrote:
> Currently, the complicated relationship between nvme_dev_disable
> and nvme_timeout has become a devil that will introduce many
> circular pattern which may trigger deadlock or IO hang. Let's
> enumerate the tangles between them:
>  - nvme_timeout has to invoke nvme_dev_disable to stop the
>    controller doing DMA access before free the request.
>  - nvme_dev_disable has to depend on nvme_timeout to complete
>    adminq requests to set HMB or delete sq/cq when the controller
>    has no response.
>  - nvme_dev_disable will race with nvme_timeout when cancels the
>    outstanding requests.

Your patch is releasing a command back to the OS with the
PCI controller bus master still enabled. This could lead to data or
memory corruption.

In any case, it's not as complicated as you're making it out to
be. It'd be easier to just enforce the exisiting rule that commands
issued in the disabling path not depend on completions or timeout
handling. All of commands issued in this path already do this except
for HMB disabling. Let'sjust fix that command, right?
