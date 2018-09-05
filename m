Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E33FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329D32064D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329D32064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeIEMcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:32:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58794 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeIEMcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:32:01 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxSlo-00064p-BU; Wed, 05 Sep 2018 10:02:36 +0200
Date:   Wed, 5 Sep 2018 10:02:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Baoquan He <bhe@redhat.com>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH 1/3] x86/boot: Add bit fields into xloadflags for 5-level
 kernel checking
In-Reply-To: <7a1147d7-05af-98fe-3a14-b18ea445c2b5@zytor.com>
Message-ID: <alpine.DEB.2.21.1809051002020.1416@nanos.tec.linutronix.de>
References: <20180829141624.13985-1-bhe@redhat.com> <20180829141624.13985-2-bhe@redhat.com> <6ea94875-ae07-6220-eb3e-d3f830cdac03@zytor.com> <20180904034414.GI1740@192.168.1.3> <4546fc39-4982-4c91-c812-0df1e9bc9e20@zytor.com> <20180904052036.GJ1740@192.168.1.3>
 <c4f65956-ad99-84ee-d4bf-044a6f0c5010@zytor.com> <20180904084231.ubyjaqp4xhqcnper@kshutemo-mobl1> <7a1147d7-05af-98fe-3a14-b18ea445c2b5@zytor.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018, H. Peter Anvin wrote:

> On 09/04/18 01:42, Kirill A. Shutemov wrote:
> > 
> > Switching between 4- and 5-level paging modes (in either direction)
> > requires paing disabling. It means the code that does the switching has to
> > be under 4G otherwise we would lose control.
> > 
> > We handle the switching correctly in kernel decompression code, but not on
> > kexec caller side.
> > 
> > XLF_5LEVEL indicates that kernel decompression code can deal with
> > switching between paging modes and it's safe to jump there in 5-level
> > paging mode.
> > 
> > As an alternative we can change kexec to switch to 4-level paging mode
> > before starting the new kernel. Not sure how hard it will be.
> > 
> 
> Have a flag saying entering in 5-level mode is fine.  However, you really
> should support returning to 4-level mode in kexec.  It is *much* easier to do
> on the caller side as you have total control of memory allocation there.

Works for a regular kexec, but not for starting a crash kernel....

Thanks,

	tglx
