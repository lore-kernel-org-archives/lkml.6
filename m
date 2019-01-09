Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1CCC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C27214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfAIByD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:54:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729120AbfAIByD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 20:54:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7109337E85;
        Wed,  9 Jan 2019 01:54:02 +0000 (UTC)
Received: from sky.random (ovpn-120-73.rdu2.redhat.com [10.10.120.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ABFF60E3F;
        Wed,  9 Jan 2019 01:54:01 +0000 (UTC)
Date:   Tue, 8 Jan 2019 20:53:59 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org, Michal Hocko <mhocko@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>, mpe@ellerman.id.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V6 3/4] powerpc/mm/iommu: Allow migration of cma
 allocated pages during mm_iommu_get
Message-ID: <20190109015359.GE20586@redhat.com>
References: <20190108045110.28597-1-aneesh.kumar@linux.ibm.com>
 <20190108045110.28597-4-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108045110.28597-4-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 09 Jan 2019 01:54:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jan 08, 2019 at 10:21:09AM +0530, Aneesh Kumar K.V wrote:
> @@ -187,41 +149,25 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
>  		goto unlock_exit;
>  	}
>  
> +	ret = get_user_pages_cma_migrate(ua, entries, 1, mem->hpages);

In terms of gup APIs, I've been wondering if this shall become
get_user_pages_longerm(FOLL_CMA_MIGRATE). So basically moving this
CMA migrate logic inside get_user_pages_longerm.

It depends if powerpc will ever need to bail on dax and/or if other
non-powerpc vfio drivers which are already bailing on dax may also
later optionally need to avoid interfering with CMA.

Aside from the API detail above, this CMA page migration logic seems a
good solution for the problem.

Thanks,
Andrea
