Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB7BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1636820883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1636820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbeGKCux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:50:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732292AbeGKCux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:50:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2FF224071186;
        Wed, 11 Jul 2018 02:48:50 +0000 (UTC)
Received: from xz-mi (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 555B6111AF30;
        Wed, 11 Jul 2018 02:48:46 +0000 (UTC)
Date:   Wed, 11 Jul 2018 10:48:43 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
        jacob.jun.pan@intel.com
Subject: Re: [PATCH v4 1/9] iommu/vt-d: Global PASID name space
Message-ID: <20180711024843.GC2359@xz-mi>
References: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
 <1531113778-28238-2-git-send-email-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1531113778-28238-2-git-send-email-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 11 Jul 2018 02:48:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 11 Jul 2018 02:48:50 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'peterx@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 01:22:50PM +0800, Lu Baolu wrote:

[...]

> +#ifndef __INTEL_PASID_H
> +#define __INTEL_PASID_H
> +
> +#define PASID_MIN			0x1
> +#define PASID_MAX			0x20000

Could I ask whether there's a reason to explicitly use 0x20000 for the
max value?  Asked since I saw that the example in the spec gave 20
bits for PASID (please refer to spec ver 3.0 section 3.4.3 figure
3-8).  Also I believe that's what I was told by Kevin.

I saw that the old per-iommu max value is set to 0x20000, though I'm
not sure whether that's still needed since if we're going to have
two-level pasid table then AFAIU we don't need physically continuous
memory any more (though I saw that we don't yet have two-level pasid
table implemented):

	/* Eventually I'm promised we will get a multi-level PASID table
	 * and it won't have to be physically contiguous. Until then,
	 * limit the size because 8MiB contiguous allocations can be hard
	 * to come by. The limit of 0x20000, which is 1MiB for each of
	 * the PASID and PASID-state tables, is somewhat arbitrary. */
	if (iommu->pasid_max > 0x20000)
		iommu->pasid_max = 0x20000;

Thanks,

-- 
Peter Xu
