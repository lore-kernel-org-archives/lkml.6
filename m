Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A91FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED2E2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfBKHC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:02:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKHC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:02:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 032BD80F7B;
        Mon, 11 Feb 2019 07:02:27 +0000 (UTC)
Received: from localhost (ovpn-12-138.pek2.redhat.com [10.72.12.138])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 20ADB5D97A;
        Mon, 11 Feb 2019 07:02:25 +0000 (UTC)
Date:   Mon, 11 Feb 2019 15:02:23 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, bp@alien8.de,
        hpa@zytor.com, kirill.shutemov@linux.intel.com, dyoung@redhat.com,
        x86@kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH RESEND 1/3] x86/boot: Add bit fields into xloadflags for
 5-level kernel checking
Message-ID: <20190211070223.GA2332@localhost>
References: <20190125022817.29506-1-bhe@redhat.com>
 <20190125022817.29506-2-bhe@redhat.com>
 <alpine.DEB.2.21.1901292059260.1950@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901292059260.1950@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 11 Feb 2019 07:02:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing. I was in vacation, sorry for late reply.

On 01/29/19 at 09:05pm, Thomas Gleixner wrote:
> On Fri, 25 Jan 2019, Baoquan He wrote:
> 
> > Add two bit fields XLF_5LEVEL and XLF_5LEVEL_ENABLED for 5-level kernel.
> 
> These are not bit fields. These are simple bits.

Indeed, they are only xloadflags bits, will change. Thanks.

> 
> > Bit XLF_5LEVEL indicates if 5-level related code is contained
> > in this kernel.
> > Bit XLF_5LEVEL_ENABLED indicates if CONFIG_X86_5LEVEL=y is set.
> 
> I'm confused. 
> 
> > -			.word XLF0 | XLF1 | XLF23 | XLF4
> > +#ifdef CONFIG_X86_64
> > +#ifdef CONFIG_X86_5LEVEL
> > +#define XLF56 (XLF_5LEVEL|XLF_5LEVEL_ENABLED)
> > +#else
> > +#define XLF56 XLF_5LEVEL
> > +#endif
> > +#else
> > +#define XLF56 0
> > +#endif
> > +
> > +			.word XLF0 | XLF1 | XLF23 | XLF4 | XLF56
> 
> So this actually stores the bits, but looking at the following patch which
> fixes the real issue:
> 
> > +	if (!(header->xloadflags & XLF_5LEVEL) && pgtable_l5_enabled()) {
> > +		pr_err("Can not jump to old 4-level kernel from 5-level kernel.\n");
> > +		return ret;
> > +	}
> 
> So what is XLF_5LEVEL_ENABLED used for and why does it exist at all?

Yes, this is a little bit confusing. I explained it in the v1 cover
letter:
http://lists.infradead.org/pipermail/kexec/2018-August/021419.html

As told at above, XLF_5LEVEL marks the new kernel containing 5level
code, while XLF_5LEVEL_ENABLED marking the CONFIG_X86_5LEVEL option
enabling. Hence if XLF_5LEVEL is set, XLF_5LEVEL_ENABLED not, means it's
new kernel but can't be switched into 5-level.

For kexec_load and kexec_file_load, there's difference in loading
behaviour. kexec_load will search available area top down to put
kernel in system RAM, we need check if the kexec-ed kernel is in
leve-5 paging mode, and limit the loading postion below 64 TB if
not. But for kexec_file_load, it's searching area bottom up to put
kernel, most of time area found below 4G. We don't have worry about the
kexec_file_load interface which implements the loading functionality in
kernel. That's why the XLF_5LEVEL_ENABLED bit is not used in this kernel
patch set, I would like to post patch to kexec-tools for kexec_load
after these patches have been accepted.

I ever tried to unify the behavious of these two interfaces on loading
kernel, to make both kexec_load and kexec_file_load search and put
kernel top to down, but that involves many lines of code change, seems
people are worried about it and hesitated to offere ack, I just gave up.
Please check below link:

https://lore.kernel.org/lkml/20180718024944.577-1-bhe@redhat.com/T/#u

Sorry for the inconvenience because of my missing explanation.

Thanks
Baoquan

