Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD602C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B81E2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aNBzrQR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B81E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeLJTNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:13:24 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36816 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbeLJTNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:13:23 -0500
Received: from zn.tnic (p200300EC2BCAD0002992494E33A10E64.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:d000:2992:494e:33a1:e64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 773FC1EC0322;
        Mon, 10 Dec 2018 20:13:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544469202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kYGf9ljFdC21WxX7B4iVKV+oTufb61AIwY9O5Tuv17M=;
        b=aNBzrQR0QFgvf/5LZtK928duvaF21VWWKml0r1kNPtsjiWSrkQeQw4U/ubpIgVxn/R/MaH
        MibgQWzmF8rjDRQ6uYFEySlEVqigtAwr7rpUtgIvNo44K54i7EHX3t20+Jmpw7//XqKKyl
        tZ86214mFnViUbsNyZr7lLzkiWs7c3M=
Date:   Mon, 10 Dec 2018 20:13:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        jithu.joseph@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/resctrl: Fix rdt_find_domain() return value checks
Message-ID: <20181210191311.GC5482@zn.tnic>
References: <d932648504b745cb51c4a440710c7a1ca9830eca.1543427858.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d932648504b745cb51c4a440710c7a1ca9830eca.1543427858.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 10:20:27AM -0800, Reinette Chatre wrote:
> rdt_find_domain() may return an ERR_PTR(), NULL, or a pointer to struct
> rdt_domain. It is thus required that the return value be checked for the
> possibility of an ERR_PTR as well as NULL.

Well, it returns ERR_PTR(id) but code which uses ERR_PTR passes in an -E
value, for example ERR_PTR(-EINVAL) or so, and not an id.

And that might work now if id fits within that MAX_ERRNO range - I'm
looking at include/linux/err.h - but that's still fragile.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
