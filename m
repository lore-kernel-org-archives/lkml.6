Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ED2C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570DC20843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570DC20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeIZOGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:06:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbeIZOGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:06:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 100F8C058CA5;
        Wed, 26 Sep 2018 07:54:37 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 492B617ADC;
        Wed, 26 Sep 2018 07:54:35 +0000 (UTC)
Date:   Wed, 26 Sep 2018 15:54:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, mingo@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH 1/3] x86/boot: Add bit fields into xloadflags for 5-level
 kernel checking
Message-ID: <20180926075433.GD2555@MiWiFi-R3L-srv>
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180829141624.13985-2-bhe@redhat.com>
 <6ea94875-ae07-6220-eb3e-d3f830cdac03@zytor.com>
 <20180904034414.GI1740@192.168.1.3>
 <4546fc39-4982-4c91-c812-0df1e9bc9e20@zytor.com>
 <20180904052036.GJ1740@192.168.1.3>
 <c4f65956-ad99-84ee-d4bf-044a6f0c5010@zytor.com>
 <20180904084231.ubyjaqp4xhqcnper@kshutemo-mobl1>
 <7a1147d7-05af-98fe-3a14-b18ea445c2b5@zytor.com>
 <alpine.DEB.2.21.1809051002020.1416@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809051002020.1416@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 26 Sep 2018 07:54:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/18 at 10:02am, Thomas Gleixner wrote:
> On Tue, 4 Sep 2018, H. Peter Anvin wrote:
> 
> > On 09/04/18 01:42, Kirill A. Shutemov wrote:
> > > 
> > > Switching between 4- and 5-level paging modes (in either direction)
> > > requires paing disabling. It means the code that does the switching has to
> > > be under 4G otherwise we would lose control.
> > > 
> > > We handle the switching correctly in kernel decompression code, but not on
> > > kexec caller side.
> > > 
> > > XLF_5LEVEL indicates that kernel decompression code can deal with
> > > switching between paging modes and it's safe to jump there in 5-level
> > > paging mode.
> > > 
> > > As an alternative we can change kexec to switch to 4-level paging mode
> > > before starting the new kernel. Not sure how hard it will be.
> > > 
> > 
> > Have a flag saying entering in 5-level mode is fine.  However, you really
> > should support returning to 4-level mode in kexec.  It is *much* easier to do
> > on the caller side as you have total control of memory allocation there.
> 
> Works for a regular kexec, but not for starting a crash kernel....

Agree, it's not appropriate to do this after normal kernel crashed and
prepare to jump to 2nd kernel.

Can this patchset be merged? I will post patches to kexec-tools utility
since it will make use of these flags.

Thanks
Baoquan
