Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1ABC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4548220659
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4548220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeK1Wjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:39:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42040 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbeK1Wjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:39:51 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5ABAD2D7F8;
        Wed, 28 Nov 2018 11:38:30 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-28.pek2.redhat.com [10.72.12.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 434266FEE7;
        Wed, 28 Nov 2018 11:38:22 +0000 (UTC)
Date:   Wed, 28 Nov 2018 19:38:19 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Bhupesh Sharma <bhsharma@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>,
        x86@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Dave Anderson <anderson@redhat.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bhupesh.linux@gmail.com,
        Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to
 vmcoreinfo
Message-ID: <20181128113819.GA19079@dhcp-128-65.nay.redhat.com>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <20181121113944.GD27797@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121113944.GD27797@zn.tnic>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 28 Nov 2018 11:38:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > now possible to use the vmcoreinfo present inside kcore as the standard
> > ABI which can be used by the user-space utilities for reading
> > the machine specific information (and hence for debugging a
> > live kernel).
> > 
> > User-space utilities like makedumpfile, kexec-tools and crash
> > are either already using this ABI or are discussing patches
> > which look to add the same feature. This helps in simplifying the
> > overall code and also in reducing code-rewrite across the
> > user-space utilities for getting values of these kernel
> > symbols/variables.
> 
> > Accordingly this patch allows appending 'page_offset_base' for
> > x86_64 platforms to vmcoreinfo, so that user-space tools can use the
> > same as a standard interface to determine the start of direct mapping
> > of all physical memory.
> > 

[snip]

> All above are only nitpicks though.
> 
> My opinion is this: people are exporting all kinds of kernel-internal
> stuff in vmcoreinfo and frankly, I'm not crazy about this idea.
> 
> And AFAICT, this thing basically bypasses KASLR completely but you need
> root for it so it probably doesn't really matter.
> 
> Now, on another thread we agreed more or less that what gets exported in
> vmcoreinfo is so tightly coupled to the running kernel so that it is not
> even considered an ABI. I guess that is debatable but whatever.

We do not regard this strictly as an ABI, but we also carefully review
every new extra exported thing and only export when we have to do so eg.
something breaks.

Seems this change only make userspace tools handling on the kaslr case
easier but since everything works without this patch I would prefer not to
do it.

> 
> So my only request right now would be to have all those things being
> exported, documented somewhere and I believe Lianbo is working on that.
> 
> But I'm sure others will have more to say about it.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave
