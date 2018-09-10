Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100BBC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8C52087E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8C52087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeIJQ6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:58:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:37270 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728316AbeIJQ6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:58:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 03E8CADED;
        Mon, 10 Sep 2018 12:04:17 +0000 (UTC)
Date:   Mon, 10 Sep 2018 14:04:16 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v6 4/5] x86/kvm: use __decrypted attribute in shared
 variables
Message-ID: <20180910120416.GD21815@zn.tnic>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
 <1536343050-18532-5-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536343050-18532-5-git-send-email-brijesh.singh@amd.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:57:29PM -0500, Brijesh Singh wrote:
> Commit: 368a540e0232 (x86/kvmclock: Remove memblock dependency)
> caused SEV guest regression.

When mentioning a commit in the commit message, put it on a separate
line, like this:

"Commit

  368a540e0232 (x86/kvmclock: Remove memblock dependency)

caused a SEV guest regression."

> When SEV is active, we map the shared

Use passive tone in your commit message: no "we", etc...

> variables (wall_clock and hv_clock_boot) with C=0 to ensure that both
> the guest and the hypervisor are able to access the data. To map the
> variables we use kernel_physical_mapping_init() to split the large pages,

"... to potentially split large pages used for that mapping... "

> but splitting large pages requires allocating a new PMD, which fails now
> that kvmclock initialization is called early during boot.

"... before the memblock allocator is initialized."

> Recently we added a special .data..decrypted section to hold the shared
> variables.

You don't really need that sentence.

> This section is mapped with C=0 early during boot. Use
> __decrypted attribute to put the wall_clock and hv_clock_boot in
> .data..decrypted section so that they are mapped with C=0.

"... so that they're mapped decrypted." Readers don't care about C=0
- they simply wanna know what C=0 represents, i.e., memory is not
encrypted.

With that:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
