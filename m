Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DD4ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D868B21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D868B21547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390009AbeIURsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:48:12 -0400
Received: from ozlabs.org ([203.11.71.1]:33023 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389862AbeIURsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:48:12 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42GsbF1vw9z9sCR; Fri, 21 Sep 2018 21:59:37 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 85682a7e3b9c664995ad477520f917039afdc330
In-Reply-To: <3c4cddf185438cc7200908b4f971a8e6ed7472fd.1536558233.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jianlin Shi <jishi@redhat.com>, Xin Long <lucien.xin@gmail.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: powerpc: fix csum_ipv6_magic() on little endian platforms
Message-Id: <42GsbF1vw9z9sCR@ozlabs.org>
Date:   Fri, 21 Sep 2018 21:59:37 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-10 at 06:09:04 UTC, Christophe Leroy wrote:
> On little endian platforms, csum_ipv6_magic() keeps len and proto in
> CPU byte order. This generates a bad results leading to ICMPv6 packets
> from other hosts being dropped by powerpc64le platforms.
> 
> In order to fix this, len and proto should be converted to network
> byte order ie bigendian byte order. However checksumming 0x12345678
> and 0x56341278 provide the exact same result so it is enough to
> rotate the sum of len and proto by 1 byte.
> 
> PPC32 only support bigendian so the fix is needed for PPC64 only
> 
> Fixes: e9c4943a107b ("powerpc: Implement csum_ipv6_magic in assembly")
> Reported-by: Jianlin Shi <jishi@redhat.com>
> Reported-by: Xin Long <lucien.xin@gmail.com>
> Cc: <stable@vger.kernel.org> # 4.18+
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Tested-by: Xin Long <lucien.xin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/85682a7e3b9c664995ad477520f917

cheers
