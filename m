Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF33C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDE120BF2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b="lqJhgzWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDE120BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wylie.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732797AbeGJTiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:38:25 -0400
Received: from wylie.me.uk ([82.68.155.94]:45264 "EHLO mail.wylie.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732245AbeGJTiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:38:25 -0400
X-Greylist: delayed 565 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Jul 2018 15:38:25 EDT
Received: from frodo.localnet (frodo.localnet [192.168.21.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.wylie.me.uk (Postfix) with ESMTPS id 851D0120083;
        Tue, 10 Jul 2018 20:28:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wylie.me.uk;
        s=mydkim005; t=1531250884;
        bh=AneZIymGh95LgxqAV4GKAZQX0hXFsWFiuC5Ke0EN2Oc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To;
        b=lqJhgzWEcp9RDSMxgrARf5mID5YCVMHfH99aP7LBwU+vHeF3IKSvp95QE9QrX2RR2
         TGAwNaLLXCJWf0lonyDcQy1+6oOYGYn3JiXSKH4BTWcgJ65rGm9dAfmcAofEMEHljZ
         n6FQCLvhMeMtALYofYx9Vjz1LeXlXK+RMg+QgJgY9oRLVrpNDRB6fM5/s1rXmPFIdA
         ZkL4DA1qLfOqo91p3uP4ZCv8xriiqptyDhlBfUBq2YQ91gfMTErgYab6mGPaPGaJfI
         9p2aKTLalXw5GsZatmTQD8mgC2761+HyaUjuCgDhmONrTDLhssBe58EalfAseGkd3E
         4wwQoVU6JWMqQ==
Received: from wylie.me.uk (localhost [IPv6:::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by frodo.localnet (Postfix) with ESMTPS id 470F5440058;
        Tue, 10 Jul 2018 20:28:04 +0100 (BST)
From:   alan@wylie.me.uk (Alan J. Wylie)
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, christoffer.dall@arm.com,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com,
        will.deacon@arm.com
Subject: Re: [PATCH 0/2] arm64: spectre-v1 write fixes (CVE-2018-3693)
References: <20180710180123.56461-1-mark.rutland@arm.com>
Date:   Tue, 10 Jul 2018 20:28:04 +0100
In-Reply-To: <20180710180123.56461-1-mark.rutland@arm.com> (Mark Rutland's
        message of "Tue, 10 Jul 2018 19:01:21 +0100")
Message-ID: <87d0vuao1n.fsf@wylie.me.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rutland <mark.rutland@arm.com> writes:

> These patches inhibit spectre-v1-write gadgets found in arch/arm64, using the
> same mitigation applied to existing spectre-v1-read gadgets.
>
> This issue is also known as CVE-2018-3693, or "bounds check bypass store".
> More details can be found in the Arm Cache Speculation Side-channels
> whitepaper, available from the Arm security updates site [1].

> [1] https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability

From that web page:

| Variant 1: bounds check bypass store (CVE-2017-5753) and bounds check
| bypass store (CVE-2018-3693)

Isn't -5753 a "read" vulnerability, not "store"?

-- 
Alan J. Wylie                                          https://www.wylie.me.uk/

Dance like no-one's watching. / Encrypt like everyone is.
Security is inversely proportional to convenience
