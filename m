Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752847AbeC3VWJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:22:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:27342 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752797AbeC3VWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:22:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,383,1517904000";
   d="scan'208";a="46714908"
Date: Fri, 30 Mar 2018 15:24:39 -0600
From: Keith Busch <keith.busch@intel.com>
To: "Rodrigo R. Galvao" <rosattig@linux.vnet.ibm.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: fix nvmet_execute_write_zeroes function
Message-ID: <20180330212439.GA28945@localhost.localdomain>
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
> When trying to issue write_zeroes command against TARGET the nr_sector is
> being incremented by 1, which ends up hitting the following condition at
> __blkdev_issue_zeroout:
> 
>      if ((sector | nr_sects) & bs_mask)
>                 return -EINVAL;
> 
> Causing the command to always fail. Removing the increment makes the
> command to work properly.

Doesn't that mean your host is using this command wrong? The NLB is a
0's based value, we're supposed to +1 to get the correct block count.
