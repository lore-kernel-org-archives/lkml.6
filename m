Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89364C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DF420659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BT2m0P8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DF420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeLELal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:30:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42494 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbeLELal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:30:41 -0500
Received: from zn.tnic (p200300EC2BC0990030B9A0F23022A8BF.dip0.t-ipconnect.de [IPv6:2003:ec:2bc0:9900:30b9:a0f2:3022:a8bf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 96E6E1EC0B69;
        Wed,  5 Dec 2018 12:30:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544009439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JLhqjsfa2CquKOYmT6utM3/cei0NP7DCwshiiuRa9uk=;
        b=BT2m0P8zCuEuqwbmNVsCQ9X3Y/1cVabKr2HcdwKAl8875grp64ktRFVO7pQALx1RifhPr5
        Y34i+imZ19sad+7bMoX0YBQWkwxPLVgQPlLSiSJhvzooh0dQOPa0OucShO17XeafjcXHDa
        K8wwtNJwyNMFaihjyjOCvGnb4fw67jg=
Date:   Wed, 5 Dec 2018 12:30:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] kdump: add the vmcoreinfo documentation
Message-ID: <20181205113032.GF29510@zn.tnic>
References: <20181202030839.29945-1-lijiang@redhat.com>
 <20181202030839.29945-2-lijiang@redhat.com>
 <20181203150809.GA4794@zn.tnic>
 <779dbae7-f6e2-e9e4-bdd0-0a9e6ec62487@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <779dbae7-f6e2-e9e4-bdd0-0a9e6ec62487@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 05:35:09PM +0800, lijiang wrote:
> There are more people to review and improve this document together, that would
> be fine.

That's basically kernel development :)

> Generating VMCOREINFO is easy in the first kernel, for example:
> # makedumpfile -g VMCOREINFO -x vmlinux

I get:

$ makedumpfile -g VMCOREINFO -x vmlinux
The kernel version is not supported.
The makedumpfile operation may be incomplete.

The vmcoreinfo is saved to VMCOREINFO.

makedumpfile Completed.

But the text file looks ok AFAICT. Please add that command to the
documentation file.

> For these two *why*, it should be easy to understand. Because user-space tools
> need to know basic information, such as the symbol values, field offset, structure
> size, etc. Otherwise, these tools won't know how to analyze the memory of the crash
> kernel.

That's clear. The question is *why* *exactly* is every piece of export
needed.

> For the second question 'how they are used', we can get the answer
> from user-space tools, such as makedumpfile, crash tools. Therefore,
> it may not need to explain any more in kernel document. On the other
> hand, if we must put these contents into kernel document, i have to
> say, that would be a hard task.

You can put one or two sentences for each, stating what they're used
for. This way, people can go and look up makedumpfile source code for
further info and people trying to add new items to VMCOREINFO can look
in this documentation here first to figure out whether maybe the info
they need has been exported already.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
