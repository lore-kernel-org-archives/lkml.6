Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D593C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30011213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544042572;
	bh=+pNzHB3PKcNBoN8mDtlxAuhSxNxHq7elljOmLW/EOYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VTXwfGAy66aAy/Ieh6fsl26/1+NOOIOfqKx2tYXg2Sum1yK0/ks7BzXh5cYgDSOaV
	 2tYKHfEZtbxeU5zuhO6NJHVx8ugAV74JA4Iewi0bGEFkgLixk/4uguLBvfZ4+MuoWb
	 wIY/r2hqw76GXMvBL9HYWXjY1abgL1TpwSI6WvvY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30011213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbeLEUmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:42:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:55904 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727257AbeLEUmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:42:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A2A2AEE5;
        Wed,  5 Dec 2018 20:42:48 +0000 (UTC)
Date:   Wed, 5 Dec 2018 21:42:47 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, davem@davemloft.net,
        pavel.tatashin@microsoft.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org,
        vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
Subject: Re: [mm PATCH v6 6/7] mm: Add reserved flag setting to set_page_links
Message-ID: <20181205204247.GY1286@dhcp22.suse.cz>
References: <154361452447.7497.1348692079883153517.stgit@ahduyck-desk1.amr.corp.intel.com>
 <154361479877.7497.2824031260670152276.stgit@ahduyck-desk1.amr.corp.intel.com>
 <20181205172225.GT1286@dhcp22.suse.cz>
 <19c9f0fe83a857d5858c386a08ca2ddeba7cf27b.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19c9f0fe83a857d5858c386a08ca2ddeba7cf27b.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-12-18 09:55:17, Alexander Duyck wrote:
> On Wed, 2018-12-05 at 18:22 +0100, Michal Hocko wrote:
> > On Fri 30-11-18 13:53:18, Alexander Duyck wrote:
> > > Modify the set_page_links function to include the setting of the reserved
> > > flag via a simple AND and OR operation. The motivation for this is the fact
> > > that the existing __set_bit call still seems to have effects on performance
> > > as replacing the call with the AND and OR can reduce initialization time.
> > > 
> > > Looking over the assembly code before and after the change the main
> > > difference between the two is that the reserved bit is stored in a value
> > > that is generated outside of the main initialization loop and is then
> > > written with the other flags field values in one write to the page->flags
> > > value. Previously the generated value was written and then then a btsq
> > > instruction was issued.
> > > 
> > > On my x86_64 test system with 3TB of persistent memory per node I saw the
> > > persistent memory initialization time on average drop from 23.49s to
> > > 19.12s per node.
> > 
> > I have tried to explain why the whole reserved bit doesn't make much
> > sense in this code several times already. You keep ignoring that and
> > that is highly annoying. Especially when you add a tricky code to
> > optimize something that is not really needed.
> > 
> > Based on that I am not going to waste my time on other patches in this
> > series to review and give feedback which might be ignored again.
> 
> I got your explanation. However Andrew had already applied the patches
> and I had some outstanding issues in them that needed to be addressed.
> So I thought it best to send out this set of patches with those fixes
> before the code in mm became too stale. I am still working on what to
> do about the Reserved bit, and plan to submit it as a follow-up set.

From my experience Andrew can drop patches between different versions of
the patchset. Things can change a lot while they are in mmotm and under
the discussion.
-- 
Michal Hocko
SUSE Labs
