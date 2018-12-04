Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DD3C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F9420850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F9420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbeLDAJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:09:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeLDAJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:09:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC05283F51;
        Tue,  4 Dec 2018 00:09:17 +0000 (UTC)
Received: from redhat.com (ovpn-120-188.rdu2.redhat.com [10.10.120.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 910F45D738;
        Tue,  4 Dec 2018 00:09:15 +0000 (UTC)
Date:   Mon, 3 Dec 2018 19:09:12 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <zwisler@kernel.org>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/mmu_notifier: use structure for
 invalidate_range_start/end calls
Message-ID: <20181204000911.GB20742@redhat.com>
References: <20181203201817.10759-1-jglisse@redhat.com>
 <20181203201817.10759-3-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181203201817.10759-3-jglisse@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 04 Dec 2018 00:09:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 03:18:16PM -0500, jglisse@redhat.com wrote:
> diff --git a/mm/migrate.c b/mm/migrate.c
> index f7e4bfdc13b7..4896dd9d8b28 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2303,8 +2303,13 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>   */
>  static void migrate_vma_collect(struct migrate_vma *migrate)
>  {
> +	struct mmu_notifier_range range;
>  	struct mm_walk mm_walk;
>  
> +	range.start = migrate->start;
> +	range.end = migrate->end;
> +	range.mm = mm_walk.mm;

Andrew can you replace above line by:

+	range.mm = migrate->vma->vm_mm;

I made a mistake here when i was rebasing before posting. I checked
the patchset again and i believe this is the only mistake i made.

Do you want me to repost ?

Sorry for my stupid mistake.

Cheers,
Jérôme
