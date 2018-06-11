Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Oep5OUBxHlsTewAAmS7hNA
	; Mon, 11 Jun 2018 12:55:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DEA6B607BB; Mon, 11 Jun 2018 12:55:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 71919601C3;
	Mon, 11 Jun 2018 12:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71919601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933131AbeFKMz1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 08:55:27 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:53767 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932913AbeFKMzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:55:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fSMLv-0000ci-48; Mon, 11 Jun 2018 13:55:19 +0100
Message-ID: <1528721717.2289.114.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 051/268] asm-generic: provide
 generic_pmdp_establish()
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
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
Date: Mon, 11 Jun 2018 13:55:17 +0100
In-Reply-To: <20180528100207.739905012@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
         <20180528100207.739905012@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-28 at 12:00 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> [ Upstream commit c58f0bb77ed8bf93dfdde762b01cb67eebbdfc29 ]
> 
> Patch series "Do not lose dirty bit on THP pages", v4.
> 
> Vlastimil noted that pmdp_invalidate() is not atomic and we can lose
> dirty and access bits if CPU sets them after pmdp dereference, but
> before set_pmd_at().
> 
> The bug can lead to data loss, but the race window is tiny and I haven't
> seen any reports that suggested that it happens in reality.  So I don't
> think it worth sending it to stable.
[...]
> This patch (of 12):
> 
> This is an implementation of pmdp_establish() that is only suitable for
> an architecture that doesn't have hardware dirty/accessed bits.  In this
> case we can't race with CPU which sets these bits and non-atomic
> approach is fine.
[...]

There's no point in applying just this patch, since it adds a new
function that nothing will call.

I tend to think that since this is fixing a potential data loss, the
whole series should be backported.  But the commit message here says it
shouldn't.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
