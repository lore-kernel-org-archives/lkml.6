Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D337C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD1721479
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD1721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeKUBDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:03:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:35316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725968AbeKUBDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:03:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9170AFE5;
        Tue, 20 Nov 2018 14:34:22 +0000 (UTC)
Date:   Tue, 20 Nov 2018 15:34:22 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] mm, memory_hotplug: deobfuscate migration part
 of offlining
Message-ID: <20181120143422.GN22247@dhcp22.suse.cz>
References: <20181120134323.13007-1-mhocko@kernel.org>
 <20181120134323.13007-3-mhocko@kernel.org>
 <f25bfa30-96cf-799c-6885-86a3a537a977@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f25bfa30-96cf-799c-6885-86a3a537a977@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 20-11-18 15:26:43, David Hildenbrand wrote:
[...]
> > +	do {
> > +		for (pfn = start_pfn; pfn;)
> > +		{
> 
> { on a new line looks weird.
> 
> > +			/* start memory hot removal */
> > +			ret = -EINTR;
> 
> I think we can move that into the "if (signal_pending(current))"
> 
> (if my eyes are not wrong, this will not be touched otherwise)

Better?

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9cd161db3061..6bc3aee30f5e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1592,11 +1592,10 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	}
 
 	do {
-		for (pfn = start_pfn; pfn;)
-		{
+		for (pfn = start_pfn; pfn;) {
 			/* start memory hot removal */
-			ret = -EINTR;
 			if (signal_pending(current)) {
+				ret = -EINTR;
 				reason = "signal backoff";
 				goto failed_removal_isolated;
 			}
-- 
Michal Hocko
SUSE Labs
