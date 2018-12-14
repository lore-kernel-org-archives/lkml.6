Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DD3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164D12086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Sbotano6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbeLNUYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:24:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58098 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730123AbeLNUYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:24:14 -0500
Received: from zn.tnic (p200300EC2BCFEF006DA1B19390C695FF.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:ef00:6da1:b193:90c6:95ff])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE2841EC0B7A;
        Fri, 14 Dec 2018 21:24:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544819052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Gm5cxsWSVEV/ThlxMkaaYEa3j2W/OwiuPA8Z7t+b30w=;
        b=Sbotano6Uh88Drn2iCrxx1mZPeHpXGsWCc8VLXJWhvwYSS0xsNqhCQ4mMbefLejVez9Y+e
        XORVypZiqmChN02omnWTLufSoCADut34v0dJwQQ2e9syvMpf3KZWKPH/Ga6z8oxq18tn77
        3oddrXQKWCaP1xX3UE23h2Vhz6PSCH0=
Date:   Fri, 14 Dec 2018 21:24:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Schoebel-Theuer <tst@schoebel-theuer.de>
Cc:     linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] acpi / apei: fix NULL deref during init
Message-ID: <20181214202406.GI11710@zn.tnic>
References: <20181214181514.29891-1-tst@schoebel-theuer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181214181514.29891-1-tst@schoebel-theuer.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 07:15:14PM +0100, Thomas Schoebel-Theuer wrote:
> Reason is a conditional initialization of variable arch_res, which happens
> only under a specific precondition. When the condition is false, the
> variable remains uninitialized.

Are you talking about the precondition

	if (arch_apei_filter_addr)

?

Because apei_resources_fini() happens under the same condition check and
if arch_apei_filter_addr was false, it should not become true, all of a
sudden. Or?

Or does that function ptr get set in the meantime on your machine? I.e., this
hackery:

#define set_apei_filter() (arch_apei_filter_addr = pci_mmcfg_for_each_region)

being called in pci_mmcfg_early_init()...

?

Hmmm.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
