Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7FDECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EAD205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84EAD205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbeJYQmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:42:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbeJYQmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:42:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A2C63082A38;
        Thu, 25 Oct 2018 08:11:04 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FB695DD6C;
        Thu, 25 Oct 2018 08:11:02 +0000 (UTC)
Date:   Thu, 25 Oct 2018 16:11:00 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, willy@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] x86/mm: Move LDT remap out of KASLR region on
 5-level paging
Message-ID: <20181025081100.GA31346@MiWiFi-R3L-srv>
References: <20181024125112.55999-1-kirill.shutemov@linux.intel.com>
 <20181024125112.55999-2-kirill.shutemov@linux.intel.com>
 <20181025021809.GB2120@MiWiFi-R3L-srv>
 <20181025072429.k54aem37sefqonqy@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025072429.k54aem37sefqonqy@kshutemo-mobl1>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 25 Oct 2018 08:11:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/18 at 10:24am, Kirill A. Shutemov wrote:
> On Thu, Oct 25, 2018 at 10:18:09AM +0800, Baoquan He wrote:
> > > We don't touch 4 pgd slot gap just before the direct mapping reserved
> > > for a hypervisor, but move direct mapping by one slot instead.
> > > 
> > > The LDT mapping is per-mm, so we cannot move it into P4D page table next
> > > to CPU_ENTRY_AREA without complicating PGD table allocation for 5-level
> > > paging.
> > 
> > Here as discussed in private thread, at the first place you also agreed
> > to put it in p4d entry next to CPU_ENTRY_AREA, but finally you changd
> > mind, there must be some reasons when you implemented and investigated
> > further to find out. Could you please say more about how it will
> > complicating PGD table allocation for 5-level paging? Or give an use
> > case where it will complicate?
> 
> On 5-level machine all memory starting from CPU_ENTRY_AREA (and part of
> KASAN memory) is in the same P4D page table. All this memory is shared
> across all processes, we just copy PGD entry -- all proceses point to the
> same P4D page table. (I leave out PTI from the picture for simplicity.)

Yes, got it, I didn't notice this, thanks a lot.

