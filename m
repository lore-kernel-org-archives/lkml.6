Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29D1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A56620989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ETRk3QL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfBYJjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:39:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35630 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfBYJjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 04:39:55 -0500
Received: from zn.tnic (p200300EC2BC68000F50265612EF4EB95.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:8000:f502:6561:2ef4:eb95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 338D61EC0253;
        Mon, 25 Feb 2019 10:39:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551087594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2P4wfZlstgqqSw7lga+yhXzHy19NN3IOgak9to2Nwbs=;
        b=ETRk3QL9P10ZnXhhUl/wkevLTH3HVeiaVKBz3SzeU8YokiyrECFRdb1pA3jNleHTHrWaOE
        l2tx238ovYgvuAUkhf5BWSim6uvrMHKd3aqelFVAeFgR3hom78z1Di1obzQZ+AiE6GLgWn
        TrbpRIFlINEnlZj2pZmTV/dqZKT0xHo=
Date:   Mon, 25 Feb 2019 10:39:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Joerg Roedel <jroedel@suse.de>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>, x86@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com,
        iommu@lists.linux-foundation.org, konrad.wilk@oracle.com
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190225093950.GB26145@zn.tnic>
References: <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
 <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic>
 <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
 <20190221171321.GD12997@zn.tnic>
 <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
 <20190222084241.GC8380@suse.de>
 <20190222130026.GA30766@zn.tnic>
 <CAFgQCTtYJOU=rdpzMaxXxRFAHGkOWYXFD+XiHSHMhGdRFmK+9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFgQCTtYJOU=rdpzMaxXxRFAHGkOWYXFD+XiHSHMhGdRFmK+9Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 09:25:18PM +0800, Pingfan Liu wrote:
> Maybe I misunderstood you, but does "requested range failed" mean that
> user specify the range? If yes, then it should be the duty of user as
> you said later, not the duty of kernel"

No, it should say that it selected a different range only when the user
didn't specify it. Which would mean that the user didn't care about the
range - she/he only wanted to have *any* crashkernel range reserved.
I.e., crashkernel=X invocation.

> We do not know the memory layout of a system, maybe a system with
> memory less than 4GB. So it is better to try all the range of system
> memory.

Ok. If 4G fails, you set high and then try again.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
