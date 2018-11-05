Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D6FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799D320819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799D320819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbeKEOj3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 09:39:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:20549 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbeKEOj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 09:39:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 21:21:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,466,1534834800"; 
   d="scan'208";a="103431151"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga004.fm.intel.com with ESMTP; 04 Nov 2018 21:21:38 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 4 Nov 2018 21:21:37 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.117]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.199]) with mapi id 14.03.0415.000;
 Mon, 5 Nov 2018 13:21:35 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 1/1] iommu/vtd: Fix NULL pointer dereference in
        prq_event_thread()
Thread-Topic: [PATCH 1/1] iommu/vtd: Fix NULL pointer dereference in
        prq_event_thread()
Thread-Index: AQHUdK5G5oGO3pmqp0mUcSJfurI3mKVAoM+A
Date:   Mon, 5 Nov 2018 05:21:35 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D5DF53@SHSMSX104.ccr.corp.intel.com>
References: <20181105021858.16958-1-baolu.lu@linux.intel.com>
In-Reply-To: <20181105021858.16958-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzZlODNmYzUtYmRjZS00ZTJhLWFjMjUtMGNhMGQ5YTYwZjk1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoick1uMTFUVVFRYjdSV0xya3NSTDZueW9SMW1rQStrcXpyNGpcLzVsWXhDbThLa3c3endlYnI1djVLY0o0Z2ZpRWgifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> bounces@lists.linux-foundation.org] On Behalf Of Lu Baolu
> Sent: Monday, November 5, 2018 10:19 AM
> To: Joerg Roedel <joro@8bytes.org>; David Woodhouse <dwmw2@infradead.org>
> Cc: Raj, Ashok <ashok.raj@intel.com>; linux-kernel@vger.kernel.org;
> iommu@lists.linux-foundation.org
> Subject: [PATCH 1/1] iommu/vtd: Fix NULL pointer dereference in prq_event_thread()
> 
> When handling page request without pasid event, go to "no_pasid"
> branch instead of "bad_req". Otherwise, a NULL pointer deference will happen there.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c index
> db301efe126d..887150907526 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -595,7 +595,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  			pr_err("%s: Page request without PASID: %08llx %08llx\n",
>  			       iommu->name, ((unsigned long long *)req)[0],
>  			       ((unsigned long long *)req)[1]);
> -			goto bad_req;
> +			goto no_pasid;
>  		}
> 
>  		if (!svm || svm->pasid != req->pasid) {
> --

I'm afraid it is still necessary to goto "bad_req". The following code behind
"bad_req" will trigger fault_cb registered by in-kernel drivers. It is reasonable
that PRQ without PASID can be handled by such callbacks. So I would suggest
to keep the existing logic.

                if (sdev && sdev->ops && sdev->ops->fault_cb) {
                        int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
                                 (req->exe_req << 1) | (req->priv_req);
                        sdev->ops->fault_cb(sdev->dev, req->pasid, req->addr, req->private, rwxp, result);
                 }

Thanks,
Yi Liu
