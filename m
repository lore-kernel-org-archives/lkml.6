Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2279AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE532084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfBYIT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:19:28 -0500
Received: from mga05.intel.com ([192.55.52.43]:51317 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfBYIT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:19:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 00:19:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,410,1544515200"; 
   d="scan'208";a="136049663"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Feb 2019 00:19:24 -0800
Subject: Re: [PATCH v2 1/8] mmc: sdhci: Get rid of finish_tasklet
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kishon@ti.com, zhang.chunyan@linaro.org
References: <20190215192033.24203-1-faiz_abbas@ti.com>
 <20190215192033.24203-2-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <abcc1506-cd38-5ff4-aaeb-57e9a9622e90@intel.com>
Date:   Mon, 25 Feb 2019 10:17:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190215192033.24203-2-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/19 9:20 PM, Faiz Abbas wrote:
> sdhci.c has two bottom halves implemented. A threaded_irq for handling
> card insert/remove operations and a tasklet for finishing mmc requests.
> With the addition of external dma support, dmaengine APIs need to
> terminate in non-atomic context before unmapping the dma buffers.
> 
> To facilitate this, remove the finish_tasklet and move the call of
> sdhci_request_done() to the threaded_irq() callback.

The irq thread has a higher latency than the tasklet.  The performance drop
is measurable on the system I tried:

Before:

# dd if=/dev/mmcblk1 of=/dev/null bs=1G count=1 &
1+0 records in
1+0 records out
1073741824 bytes (1.1 GB) copied, 4.44502 s, 242 MB/s

After:

# dd if=/dev/mmcblk1 of=/dev/null bs=1G count=1 &
1+0 records in
1+0 records out
1073741824 bytes (1.1 GB) copied, 4.50898 s, 238 MB/s

So we only want to resort to the thread for the error case.
