Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63F3C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6367C2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6367C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeLLGQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 01:16:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:59844 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbeLLGQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 01:16:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 61FB6AF07;
        Wed, 12 Dec 2018 06:16:45 +0000 (UTC)
Message-ID: <1544595387.3125.2.camel@suse.de>
Subject: Re: [PATCH v2] mm, memory_hotplug: Don't bail out in
 do_migrate_range prematurely
From:   Oscar Salvador <osalvador@suse.de>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, david@redhat.com,
        pasha.tatashin@soleen.com, dan.j.williams@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 12 Dec 2018 07:16:27 +0100
In-Reply-To: <20181212033506.tyj747b7kzyvsp4c@master>
References: <20181211135312.27034-1-osalvador@suse.de>
         <20181212033506.tyj747b7kzyvsp4c@master>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-12 at 03:35 +0000, Wei Yang wrote:
> I see the above code is wrapped with CONFIG_DEBUG_VM on current Linus
> tree.
> This is removed by someone else?

Yes, e8abbd69957288 ("mm, memory_hotplug: be more verbose for memory
offline failures") got rid of the CONFIG_DEBUG_VM.
This commit is sitting in the -mmotm tree.

> 
> > -			put_page(page);
> > -			/* Because we don't have big zone->lock.
> > we should
> > -			   check this again here. */
> > -			if (page_count(page)) {
> > -				not_managed++;
> > -				ret = -EBUSY;
> > -				break;
> > -			}
> > 		}
> > +		put_page(page);
> > 	}
> > 	if (!list_empty(&source)) {
> > -		if (not_managed) {
> > -			putback_movable_pages(&source);
> > -			goto out;
> > -		}
> > -
> > 		/* Allocate a new page from the nearest neighbor node
> > */
> > 		ret = migrate_pages(&source, new_node_page, NULL, 0,
> > 					MIGRATE_SYNC,
> > MR_MEMORY_HOTPLUG);
> > @@ -1426,7 +1412,7 @@ do_migrate_range(unsigned long start_pfn,
> > unsigned long end_pfn)
> > 			putback_movable_pages(&source);
> > 		}
> > 	}
> > -out:
> > +
> > 	return ret;
> > }
> > 
> > -- 
> > 2.13.7
> 
> 
-- 
Oscar Salvador
SUSE L3
