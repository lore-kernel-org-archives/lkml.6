Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031821AbeCAPPY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:15:24 -0500
Received: from mga06.intel.com ([134.134.136.31]:19026 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031631AbeCAPPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:15:23 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,408,1515484800";
   d="scan'208";a="179107974"
Date: Thu, 1 Mar 2018 08:15:44 -0700
From: Keith Busch <keith.busch@intel.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        axboe@fb.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
Message-ID: <20180301151544.GA17676@localhost.localdomain>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de>
 <ddfc2ab4-1a51-c488-25e8-bc434edf8aba@grimberg.me>
 <66e4ad3e-4019-13ec-94c0-e168cc1d95b4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66e4ad3e-4019-13ec-94c0-e168cc1d95b4@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 06:05:53PM +0800, jianchao.wang wrote:
> When the adminq is free, ioq0 irq completion path has to invoke nvme_irq twice, one for itself,
> one for adminq completion irq action.

Let's be a little more careful on the terminology when referring to spec
defined features: there is no such thing as "ioq0". The IO queues start
at 1. The admin queue is the '0' index queue.

> We are trying to save every cpu cycle across the nvme host path, why we waste nvme_irq cycles here.
> If we have enough vectors, we could allocate another irq vector for adminq to avoid this.

Please understand the _overwhelming_ majority of time spent for IRQ
handling is the context switches. There's a reason you're not able to
measure a perf difference between IOQ1 and IOQ2: the number of CPU cycles
to chain a second action is negligible.
