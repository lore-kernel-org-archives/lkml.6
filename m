Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31738C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87542086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87542086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeIDJoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:44:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726312AbeIDJoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:44:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C60898573A;
        Tue,  4 Sep 2018 05:20:40 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECC06A9EB5;
        Tue,  4 Sep 2018 05:20:39 +0000 (UTC)
Date:   Tue, 4 Sep 2018 13:20:36 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH 1/3] x86/boot: Add bit fields into xloadflags for 5-level
 kernel checking
Message-ID: <20180904052036.GJ1740@192.168.1.3>
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180829141624.13985-2-bhe@redhat.com>
 <6ea94875-ae07-6220-eb3e-d3f830cdac03@zytor.com>
 <20180904034414.GI1740@192.168.1.3>
 <4546fc39-4982-4c91-c812-0df1e9bc9e20@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4546fc39-4982-4c91-c812-0df1e9bc9e20@zytor.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 04 Sep 2018 05:20:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 04 Sep 2018 05:20:40 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/18 at 09:13pm, H. Peter Anvin wrote:
> On 09/03/18 20:44, Baoquan He wrote:
> > 
> > 1) in arch/x86/kernel/relocate_kernel_64.S, we set X86_CR4_LA57 into cr4
> > if the 1st kernel is in 5-level mode. Then in
> > arch/x86/boot/compressed/head_64.S, paging_prepare() is called to decide
> > if 5-level mode will be enabled, and prepare the trampoline. If
> > kexec/kdump kernel is expected to be in 4-level, e.g with 'nolv5'
> > specified, it still can handle well. But for the old kernel w/o these
> >  5-level codes, it will ignore the fact that X86_CR4_LA57 has been set
> > in CR4 and proceed anyway, then #GP is triggered. That's why XLF_5LEVEL
> > is used to mark. 
> > 
> 
> That's what I'm saying, don't do that.  Always jump into the second kernel in
> 4-level mode, i.e. X86_CR4_LA57 unset.  That's the only sane thing.

Well, this might not be suggested. Kexec has been a formal feature in
our distro, our customers usually use it to reboot high end servers
because those machines may take one hour to boot up from firmware. And
5-level may be also supported very soon, if people want to do a fast
reboot from the current kernel in 5-level, and expect to see it's in
5-level too in the 2nd kernel, this always kexec jumping to the 2nd
kernel in 4-level mode might be unaccepted.

Thanks
Baoquan
