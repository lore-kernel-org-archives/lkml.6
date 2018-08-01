Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CD3C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192F5208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192F5208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732914AbeHACJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 22:09:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:53042 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732846AbeHACJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 22:09:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2018 17:26:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,429,1526367600"; 
   d="scan'208";a="250045147"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.255.77.135]) ([10.255.77.135])
  by fmsmga005.fm.intel.com with ESMTP; 31 Jul 2018 17:26:23 -0700
Subject: Re: [PATCH] device-dax: avoid hang on error before
 devm_memremap_pages()
To:     Stefan Hajnoczi <stefanha@redhat.com>, linux-nvdimm@lists.01.org
Cc:     linux-kernel@vger.kernel.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20180731143246.16915-1-stefanha@redhat.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <499a3093-3781-7a8a-abd0-8b240db11dce@intel.com>
Date:   Tue, 31 Jul 2018 17:26:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180731143246.16915-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/31/2018 7:32 AM, Stefan Hajnoczi wrote:
> dax_pmem_percpu_exit() waits for dax_pmem_percpu_release() to invoke the
> dax_pmem->cmp completion.  Unfortunately this approach to cleaning up
> the percpu_ref only works after devm_memremap_pages() was successful.
>
> If devm_add_action_or_reset() or devm_memremap_pages() fails,
> dax_pmem_percpu_release() is not invoked.  Therefore
> dax_pmem_percpu_exit() hangs waiting for the completion:
>
>    rc = devm_add_action_or_reset(dev, dax_pmem_percpu_exit,
>    				&dax_pmem->ref);
>    if (rc)
>    	return rc;
>
>    dax_pmem->pgmap.ref = &dax_pmem->ref;
>    addr = devm_memremap_pages(dev, &dax_pmem->pgmap);
>
> Avoid the hang by calling percpu_ref_exit() in the error paths instead
> of going through dax_pmem_percpu_exit().
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Applied


> ---
> Found by code inspection.  Compile-tested only.
> ---
>   drivers/dax/pmem.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
> index fd49b24fd6af..99e2aace8078 100644
> --- a/drivers/dax/pmem.c
> +++ b/drivers/dax/pmem.c
> @@ -105,15 +105,19 @@ static int dax_pmem_probe(struct device *dev)
>   	if (rc)
>   		return rc;
>   
> -	rc = devm_add_action_or_reset(dev, dax_pmem_percpu_exit,
> -							&dax_pmem->ref);
> -	if (rc)
> +	rc = devm_add_action(dev, dax_pmem_percpu_exit, &dax_pmem->ref);
> +	if (rc) {
> +		percpu_ref_exit(&dax_pmem->ref);
>   		return rc;
> +	}
>   
>   	dax_pmem->pgmap.ref = &dax_pmem->ref;
>   	addr = devm_memremap_pages(dev, &dax_pmem->pgmap);
> -	if (IS_ERR(addr))
> +	if (IS_ERR(addr)) {
> +		devm_remove_action(dev, dax_pmem_percpu_exit, &dax_pmem->ref);
> +		percpu_ref_exit(&dax_pmem->ref);
>   		return PTR_ERR(addr);
> +	}
>   
>   	rc = devm_add_action_or_reset(dev, dax_pmem_percpu_kill,
>   							&dax_pmem->ref);
