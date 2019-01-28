Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D95C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674E820856
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BOem2/Hc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfA1KSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:18:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51858 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfA1KSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:18:41 -0500
Received: from zn.tnic (p200300EC2BC5DE00D4243EB322571660.dip0.t-ipconnect.de [IPv6:2003:ec:2bc5:de00:d424:3eb3:2257:1660])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 146071EC04FB;
        Mon, 28 Jan 2019 11:18:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548670719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oooXZ2o4OWQE7sCytQbuXwA0Xc+sKCnxnLA85KIh8Iw=;
        b=BOem2/HcF+Ya292L9Azp/2WT/upvYuYm1HaWxmSQ7EpNUeMrQIui41Q6eQcWPxUAeP07d0
        fj3BZy8wQt+kCRLjnQm06/AfiqSmZRUoBAfXdSoR+blrK0nLbJwyGTaRBjHi1O5uPr57lu
        50QbhMJkVn5IKdisCW3t0ZzokLF/hBg=
Date:   Mon, 28 Jan 2019 11:18:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>, kexec@lists.infradead.org,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, yinghai@kernel.org,
        vgoyal@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190128101831.GA27154@zn.tnic>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
 <20190128095809.GC3732@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190128095809.GC3732@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 05:58:09PM +0800, Dave Young wrote:
> Another reason is in case ,high we will need automatically reserve a
> region in low area for swiotlb.  So for example one use
> crashkernel=256M,high,  actual reserved memory is 256M above 4G and
> another 256M under 4G for swiotlb.  Normally it is not necessary for
> most people.  Thus we can not make ,high as default.

And how is the poor user to figure out that we decided for her/him that
swiotlb reservation is something not necessary for most people and thus
we fail the crashkernel= reservation?

IOW, that "logic" above doesn't make a whole lot of sense to me from
user friendliness perspective.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
