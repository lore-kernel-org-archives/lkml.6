Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754721AbeBGVIF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 16:08:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:33242 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754422AbeBGVIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 16:08:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000";
   d="scan'208";a="16417344"
Date: Wed, 7 Feb 2018 14:12:02 -0700
From: Keith Busch <keith.busch@intel.com>
To: wenxiong@linux.vnet.ibm.com
Cc: linux-nvme@lists.infradead.org, axboe@fb.com,
        linux-kernel@vger.kernel.org, wenxiong@us.ibm.com
Subject: Re: [PATCH V2]nvme-pci: Fixes EEH failure on ppc
Message-ID: <20180207211202.GD1337@localhost.localdomain>
References: <1518034178-26176-1-git-send-email-wenxiong@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518034178-26176-1-git-send-email-wenxiong@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 02:09:38PM -0600, wenxiong@linux.vnet.ibm.com wrote:
> @@ -1189,6 +1183,12 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  	struct nvme_command cmd;
>  	u32 csts = readl(dev->bar + NVME_REG_CSTS);
>  
> +	/* If PCI error recovery process is happening, we cannot reset or
> +	 * the recovery mechanism will surely fail.
> +	 */
> +	if (pci_channel_offline(to_pci_dev(dev->dev)))
> +		return BLK_EH_RESET_TIMER;

So reading csts is what triggers EEH to be detected and get the channel
set offline? If so, don't we need a memory barrier before calling
pci_channel_offline? Otherwise it looks like the compiler optimization
could reorder these.
