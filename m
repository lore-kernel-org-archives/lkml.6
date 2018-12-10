Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0499C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9B72084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="V6kd+SnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9B72084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbeLJVEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:04:48 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53428 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728885AbeLJVEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:04:47 -0500
Received: from zn.tnic (p200300EC2BCAD0008C2BD5CFB617FD7B.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:d000:8c2b:d5cf:b617:fd7b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5359E1EC0322;
        Mon, 10 Dec 2018 22:04:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544475886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Tlonp/dgx12bwmWKaLu79S0tRJZaE6UYqCte4R37IHA=;
        b=V6kd+SnWgx5vnsu307INNUZsFb9+eG5BXA26XJTrMAAQspjRWOzDJEl+K4KwBM8zhyLIAN
        FUQ6vrQIE+56TtOuUSzEgI34MgpnS7LGdSw3rs/OEIfsxSXWDXiYr7s4dIiEPlJ6IuYDYk
        +e+ifIWAWWYkEJljiZw+9ch7lqpu0S0=
Date:   Mon, 10 Dec 2018 22:04:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        jithu.joseph@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/resctrl: Fix rdt_find_domain() return value checks
Message-ID: <20181210210436.GI5482@zn.tnic>
References: <d932648504b745cb51c4a440710c7a1ca9830eca.1543427858.git.reinette.chatre@intel.com>
 <20181210191311.GC5482@zn.tnic>
 <40422756-cef4-38b1-8554-c99e7bcb7765@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40422756-cef4-38b1-8554-c99e7bcb7765@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 12:42:14PM -0800, Reinette Chatre wrote:
> Would you be ok if the above is changed to
> 
> if (id < 0)
>         return ERR_PTR(-ENOENT);
> 
> as part of this patch?

Yap.

> Looking at rdtgroup_mondata_show() is does seem as though ENOENT is the
> actual intended error value,

#define ENOENT           2      /* No such file or directory */

> although ENODEV could perhaps also be considered since such a result
> reflects that a particular cache instance could not be found.

#define ENODEV          19      /* No such device */

Yeah, they both kinda look ok to me and in the end of the day, the thing
that matters most is pinpointing the place in the code which causes the
error.

And looking at that particular part:

        r = &rdt_resources_all[resid];
        d = rdt_find_domain(r, domid, NULL);
        if (!d) {
                ret = -ENOENT;
                goto out;
        }

You *could* put in there something like:

	seq_printf(m, "Cannot find a domain for resource ID: %d\n", domid);

and this way it is perfectly clear which error path it is.

:-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
