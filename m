Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A65ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C7B21531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C7B21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390038AbeIURsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:48:16 -0400
Received: from ozlabs.org ([203.11.71.1]:35897 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389873AbeIURsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:48:15 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42GsbJ6bPwz9sC7; Fri, 21 Sep 2018 21:59:40 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c716a25b9b70084e1144f77423f5aedd772ea478
In-Reply-To: <20180920043858.28773-1-bauerman@linux.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: powerpc/pkeys: Fix reading of ibm, processor-storage-keys property
Message-Id: <42GsbJ6bPwz9sC7@ozlabs.org>
Date:   Fri, 21 Sep 2018 21:59:40 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-09-20 at 04:38:58 UTC, Thiago Jung Bauermann wrote:
> scan_pkey_feature() uses of_property_read_u32_array() to read the
> ibm,processor-storage-keys property and calls be32_to_cpu() on the
> value it gets. The problem is that of_property_read_u32_array() already
> returns the value converted to the CPU byte order.
> 
> The value of pkeys_total ends up more or less sane because there's a min()
> call in pkey_initialize() which reduces pkeys_total to 32. So in practice
> the kernel ignores the fact that the hypervisor reserved one key for
> itself (the device tree advertises 31 keys in my test VM).
> 
> This is wrong, but the effect in practice is that when a process tries to
> allocate the 32nd key, it gets an -EINVAL error instead of -ENOSPC which
> would indicate that there aren't any keys available
> 
> Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/c716a25b9b70084e1144f77423f5ae

cheers
