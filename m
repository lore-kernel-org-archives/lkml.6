Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B8BECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E22208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E22208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbeGQHUi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:20:38 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:37664 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbeGQHUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:20:38 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w6H6nQ0U032601
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 15:49:26 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6H6nQ9q016962;
        Tue, 17 Jul 2018 15:49:26 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6H6ltO1027684;
        Tue, 17 Jul 2018 15:49:26 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-2024306; Tue, 17 Jul 2018 15:47:39 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0319.002; Tue,
 17 Jul 2018 15:47:38 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/13] mm, madvise_inject_error: Disable
 MADV_SOFT_OFFLINE for ZONE_DEVICE pages
Thread-Topic: [PATCH v6 05/13] mm, madvise_inject_error: Disable
 MADV_SOFT_OFFLINE for ZONE_DEVICE pages
Thread-Index: AQHUGy+CnxxJQOMWZEWRbp9wlx02hKSSZtmA
Date:   Tue, 17 Jul 2018 06:47:37 +0000
Message-ID: <20180717064736.GA27953@hori1.linux.bs1.fc.nec.co.jp>
References: <153154376846.34503.15480221419473501643.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153154379606.34503.17311881160518829077.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153154379606.34503.17311881160518829077.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <05DD4241F5D8DF4F92EBBCDB6A7040AD@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 09:49:56PM -0700, Dan Williams wrote:
> Given that dax / device-mapped pages are never subject to page
> allocations remove them from consideration by the soft-offline
> mechanism.
> 
> Reported-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  mm/memory-failure.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 9d142b9b86dc..988f977db3d2 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1751,6 +1751,14 @@ int soft_offline_page(struct page *page, int flags)
>  	int ret;
>  	unsigned long pfn = page_to_pfn(page);
>  
> +	if (is_zone_device_page(page)) {
> +		pr_debug_ratelimited("soft_offline: %#lx page is device page\n",
> +				pfn);
> +		if (flags & MF_COUNT_INCREASED)
> +			put_page(page);

put_hwpoison_page(), which is just an alias of put_page(), is better
for consistency.
With this adjustment, feel free to add my ack.

Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

Thanks,
Naoya Horiguchi

> +		return -EIO;
> +	}
> +
>  	if (PageHWPoison(page)) {
>  		pr_info("soft offline: %#lx page already poisoned\n", pfn);
>  		if (flags & MF_COUNT_INCREASED)
> 
> 
