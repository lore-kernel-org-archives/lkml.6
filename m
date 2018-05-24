Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969448AbeEXNgo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 09:36:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:49072 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965823AbeEXNgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 09:36:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,436,1520924400";
   d="scan'208";a="41881738"
Date: Thu, 24 May 2018 07:38:59 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-pci: don't send delete cq command when allocate
 sq return -EINTR
Message-ID: <20180524133859.GH11037@localhost.localdomain>
References: <1527155494-1891-1-git-send-email-jianchao.w.wang@oracle.com>
 <1527155494-1891-2-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527155494-1891-2-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 05:51:34PM +0800, Jianchao Wang wrote:
>  	result = adapter_alloc_sq(dev, qid, nvmeq);
> -	if (result < 0)
> +	/*
> +	 * If return -EINTR, it means the allocate sq command times out and is completed
> +	 * with NVME_REQ_CANCELLED. At the time, the controller has been disabled
> +	 * and admin request queue has been quiesced. So don't try to send delete cq
> +	 * command any more.
> +	 */
> +	if (result == -EINTR)
> +		goto out;
> +	else if (result < 0)
>  		goto release_cq;

Since you're touching this part anyway, you'd really only want to goto
the release_cq if result is > 0.
