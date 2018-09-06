Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADADC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3DB2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3DB2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeIFKXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 06:23:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:46272 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725850AbeIFKXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 06:23:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05B54B00F;
        Thu,  6 Sep 2018 05:49:47 +0000 (UTC)
Date:   Thu, 6 Sep 2018 07:49:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        alexander.h.duyck@intel.com, pavel.tatashin@microsoft.com,
        dave.hansen@intel.com, akpm@linux-foundation.org, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v2 2/2] mm: Create non-atomic version of SetPageReserved
 for init use
Message-ID: <20180906054946.GK14951@dhcp22.suse.cz>
References: <20180905211041.3286.19083.stgit@localhost.localdomain>
 <20180905211334.3286.84435.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905211334.3286.84435.stgit@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-09-18 14:13:34, Alexander Duyck wrote:
[...]

just a nit

> @@ -1231,7 +1231,8 @@ void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
>  			/* Avoid false-positive PageTail() */
>  			INIT_LIST_HEAD(&page->lru);
>  
> -			SetPageReserved(page);
> +			/* no need for atomic set_bit at init time */
> +			__SetPageReserved(page);

OK but I guess it would be much more clear to say
			/*
			 * no need for atomic set_bit because the struct
			 * page is not visible yet so nobody should
			 * access it yet.
			 */
>  		}
>  	}
>  }
-- 
Michal Hocko
SUSE Labs
