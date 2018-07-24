Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357DCC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72D2205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72D2205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388451AbeGXIep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:34:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:55296 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388351AbeGXIep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:34:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82846AE1E;
        Tue, 24 Jul 2018 07:29:38 +0000 (UTC)
Date:   Tue, 24 Jul 2018 09:29:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, pasha.tatashin@oracle.com,
        dalias@libc.org, Jan Kara <jack@suse.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        daniel.m.jordan@oracle.com, Ingo Molnar <mingo@redhat.com>,
        fenghua.yu@intel.com, Jerome Glisse <jglisse@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/14] mm: Asynchronous + multithreaded memmap init
 for ZONE_DEVICE
Message-ID: <20180724072937.GD28386@dhcp22.suse.cz>
References: <153176041838.12695.3365448145295112857.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAGM2rea9AwQGaf1JiV_SDDKTKyP_n+dG9Z20gtTZEkuZPFnXFQ@mail.gmail.com>
 <CAPcyv4jo91jKjwn-M7cOhG=6vJ3c-QCyp0W+T+CtmiKGyZP1ng@mail.gmail.com>
 <CAGM2reacO1HF91yH8OR5w5AdZwPgwfSFfjDNBsHbP66v1rEg=g@mail.gmail.com>
 <20180717155006.GL7193@dhcp22.suse.cz>
 <CAA9_cmez_vrjBYvcpXT_5ziQ2CqRFzPbEWMO2kdmjW0rWhkaCA@mail.gmail.com>
 <20180718120529.GY7193@dhcp22.suse.cz>
 <3f43729d-fd4e-a488-e04d-026ef5a28dd9@intel.com>
 <20180723110928.GC31229@dhcp22.suse.cz>
 <510a1213-e391-bad6-4239-60fa477aaac0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <510a1213-e391-bad6-4239-60fa477aaac0@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-07-18 09:15:32, Dave Hansen wrote:
> On 07/23/2018 04:09 AM, Michal Hocko wrote:
> > On Thu 19-07-18 11:41:10, Dave Hansen wrote:
> >> Are you looking for the actual end-user reports?  This was more of a
> >> case of the customer plugging in some persistent memory DIMMs, noticing
> >> the boot delta and calling the folks who sold them the DIMMs (Intel).
> > But this doesn't sound like something to rush a solution for in the
> > upcoming merge windown, does it?
> 
> No, we should not rush it.  We'll try to rework it properly.

Thanks a lot Dave! I definitely do not mean to block this at all. I just
really do not like to have the code even more cluttered than we have
now.
-- 
Michal Hocko
SUSE Labs
