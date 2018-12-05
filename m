Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F95C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC60214C1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC60214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeLERzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:55:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:41942 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbeLERzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:55:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 09:55:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,318,1539673200"; 
   d="scan'208";a="257070458"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga004.jf.intel.com with ESMTP; 05 Dec 2018 09:55:17 -0800
Message-ID: <19c9f0fe83a857d5858c386a08ca2ddeba7cf27b.camel@linux.intel.com>
Subject: Re: [mm PATCH v6 6/7] mm: Add reserved flag setting to
 set_page_links
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, davem@davemloft.net,
        pavel.tatashin@microsoft.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org,
        vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
Date:   Wed, 05 Dec 2018 09:55:17 -0800
In-Reply-To: <20181205172225.GT1286@dhcp22.suse.cz>
References: <154361452447.7497.1348692079883153517.stgit@ahduyck-desk1.amr.corp.intel.com>
         <154361479877.7497.2824031260670152276.stgit@ahduyck-desk1.amr.corp.intel.com>
         <20181205172225.GT1286@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-05 at 18:22 +0100, Michal Hocko wrote:
> On Fri 30-11-18 13:53:18, Alexander Duyck wrote:
> > Modify the set_page_links function to include the setting of the reserved
> > flag via a simple AND and OR operation. The motivation for this is the fact
> > that the existing __set_bit call still seems to have effects on performance
> > as replacing the call with the AND and OR can reduce initialization time.
> > 
> > Looking over the assembly code before and after the change the main
> > difference between the two is that the reserved bit is stored in a value
> > that is generated outside of the main initialization loop and is then
> > written with the other flags field values in one write to the page->flags
> > value. Previously the generated value was written and then then a btsq
> > instruction was issued.
> > 
> > On my x86_64 test system with 3TB of persistent memory per node I saw the
> > persistent memory initialization time on average drop from 23.49s to
> > 19.12s per node.
> 
> I have tried to explain why the whole reserved bit doesn't make much
> sense in this code several times already. You keep ignoring that and
> that is highly annoying. Especially when you add a tricky code to
> optimize something that is not really needed.
> 
> Based on that I am not going to waste my time on other patches in this
> series to review and give feedback which might be ignored again.

I got your explanation. However Andrew had already applied the patches
and I had some outstanding issues in them that needed to be addressed.
So I thought it best to send out this set of patches with those fixes
before the code in mm became too stale. I am still working on what to
do about the Reserved bit, and plan to submit it as a follow-up set.



