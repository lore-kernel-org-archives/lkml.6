Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65D4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9508B2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ISzQgvg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391531AbeLUS7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:59:44 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51244 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731021AbeLUS7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:59:43 -0500
Received: from zn.tnic (p200300EC2BD180001911F64A521FA286.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:8000:1911:f64a:521f:a286])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D88EC1EC0987;
        Fri, 21 Dec 2018 19:59:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545418782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ae2sv8S/OzHcQlqPR29Y8PNqNGcrO0lS1WfbgYt1NSs=;
        b=ISzQgvg50f+2Y9UFmrd1VPpY8qNrivf8N+a5m09e9Y+3XUQh/4TfpqsGyuxmiIpqpm5lr1
        8QOZdjCMDsaIpmXshVC4M7+ki9Q48/1YGr3QGffE528ZzIxqUbydQMxf7VHZ31DPdq19o9
        nB1WzR1tVoRpWxA5HV1UTG9ZhlYee1g=
Date:   Fri, 21 Dec 2018 19:59:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     James Morse <james.morse@arm.com>
Cc:     David Arcari <darcari@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI/APEI: Clear GHES block_status before panic()
Message-ID: <20181221185937.GL1325@zn.tnic>
References: <1545238252-79630-1-git-send-email-darcari@redhat.com>
 <20181220192447.GG31403@zn.tnic>
 <1691682.ckC9UJvgEr@aspire.rjw.lan>
 <0bb80989-4fe5-c320-8ffc-0f39502110c9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0bb80989-4fe5-c320-8ffc-0f39502110c9@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 06:52:20PM +0000, James Morse wrote:
> Do we need to ghes_ack_error() too?

That's GHES v2 AFAICT.

> With the location cleared the new kernel will never find the records, and
> firmware can never re-use that location because it wasn't ack'd. The upshot is
> RAS records can't be generated for the kdump kernel. The acpi spec talks about
> use of the memory, so I don't think its fair for it to use this to disarm a
> watchdog.
> 
> I think we can live with this as the kdump kernel isn't going to handle RAS
> errors for the bulk of memory anyway.

Usually, handling hw errors is always better than not but the second
kernel can't do anything better in that respect than the first, right?
If it panics, it panics - no matter the kernel. Generally.

Therefore I think the role of the second kernel should be to be as
resilient as possible to hw errors - like, not even see them :-) - dump
the memory of the first kernel as quickly as possible and reboot for
analysis.

IMHO, of course.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
