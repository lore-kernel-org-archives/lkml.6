Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2821CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8B020870
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8B020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeJKHyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:54:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeJKHyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:54:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6D7888319;
        Thu, 11 Oct 2018 00:30:03 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1704D89E6A;
        Thu, 11 Oct 2018 00:30:01 +0000 (UTC)
Date:   Thu, 11 Oct 2018 08:29:55 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-acpi@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, rjw@rjwysocki.net, lenb@kernel.org,
        ard.biesheuvel@linaro.org, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181011002955.GJ25297@MiWiFi-R3L-srv>
References: <20181010084119.17539-1-fanc.fnst@cn.fujitsu.com>
 <20181010085920.GB5533@zn.tnic>
 <20181010090620.GF25297@MiWiFi-R3L-srv>
 <alpine.DEB.2.21.1810101113070.10278@nanos.tec.linutronix.de>
 <20181010091923.GC5533@zn.tnic>
 <20181010093057.GA22088@MiWiFi-R3L-srv>
 <20181010194443.sgdvplwdnltshwwi@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010194443.sgdvplwdnltshwwi@gabell>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 11 Oct 2018 00:30:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 at 03:44pm, Masayoshi Mizuma wrote:
> On Wed, Oct 10, 2018 at 05:30:57PM +0800, Baoquan He wrote:
> > On 10/10/18 at 11:19am, Borislav Petkov wrote:
> > > On Wed, Oct 10, 2018 at 11:14:26AM +0200, Thomas Gleixner wrote:
> > > > Yes, it's different, but if the SRAT information is available early, then
> > > > the command line parameter can go away because then the required
> > > > information for Masa's problem is available as well.
> > > 
> > > Exactly. And I'd prefer we delayed the command line parameter until we
> > > figure out we really need it and not expose it to upstream and then
> > > remove it shortly after.
> > > 
> > > So I'd suggest we move Masa's patches to a separate branch and not send
> > > it up this round.
> > 
> > Yes, sounds more reasonable if we can reuse functions in Chao's patch 1/3
> > to solve the padding issue.
> 
> Thanks for your comments! Yes, immovable_mem[num_immovable_mem] in Chao's
> patch may be useful for calculating the padding size. If so, we don't
> need the new kernel parameter. It's nice!
> 
> Do you happen to have ideas how we access immovable_mem[num_immovable_mem]
> from arch/x86/mm/kaslr.c ? It is located to arch/x86/boot/compressed/*, so
> I suppose it is not easy to access it... 
> I would appreciate if you could give some advice.

Hmm, they are living in different life cycle and space. So we can only
reuse the code from Chao's patch, but not the variable. Means we need
go through the SRAT accessing again in arch/x86/mm/kaslr.c and fill
immovable_mem[num_immovable_mem] for mm/kaslr.c usage, if we decide to
do like that.

Thanks
Baoquan
