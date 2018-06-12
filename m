Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B6359C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E40320891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E40320891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754374AbeFLStF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:49:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44104 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754110AbeFLStD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:49:03 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 88C531AF8;
        Tue, 12 Jun 2018 18:49:02 +0000 (UTC)
Date:   Tue, 12 Jun 2018 20:49:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Daney <david.daney@cavium.com>,
        David Miller <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Nitin Gupta <nitin.m.gupta@oracle.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 051/268] asm-generic: provide generic_pmdp_establish()
Message-ID: <20180612184901.GC24187@kroah.com>
References: <20180528100202.045206534@linuxfoundation.org>
 <20180528100207.739905012@linuxfoundation.org>
 <1528721717.2289.114.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1528721717.2289.114.camel@codethink.co.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 01:55:17PM +0100, Ben Hutchings wrote:
> On Mon, 2018-05-28 at 12:00 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> > [ Upstream commit c58f0bb77ed8bf93dfdde762b01cb67eebbdfc29 ]
> > 
> > Patch series "Do not lose dirty bit on THP pages", v4.
> > 
> > Vlastimil noted that pmdp_invalidate() is not atomic and we can lose
> > dirty and access bits if CPU sets them after pmdp dereference, but
> > before set_pmd_at().
> > 
> > The bug can lead to data loss, but the race window is tiny and I haven't
> > seen any reports that suggested that it happens in reality.  So I don't
> > think it worth sending it to stable.
> [...]
> > This patch (of 12):
> > 
> > This is an implementation of pmdp_establish() that is only suitable for
> > an architecture that doesn't have hardware dirty/accessed bits.  In this
> > case we can't race with CPU which sets these bits and non-atomic
> > approach is fine.
> [...]
> 
> There's no point in applying just this patch, since it adds a new
> function that nothing will call.
> 
> I tend to think that since this is fixing a potential data loss, the
> whole series should be backported.  But the commit message here says it
> shouldn't.

Hm, I thought there was some reason for this patch, as I thought it came
up before.  Sasha do you remember?  Should I just revert it?

thanks,

greg k-h
