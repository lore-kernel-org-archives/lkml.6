Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E98C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 08:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4992086C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 08:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4992086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeJ0Qx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 12:53:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbeJ0Qx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 12:53:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6804D753E8;
        Sat, 27 Oct 2018 08:13:49 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD35166D46;
        Sat, 27 Oct 2018 08:13:45 +0000 (UTC)
Date:   Sat, 27 Oct 2018 16:13:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Petr Tesarik <ptesarik@suse.cz>, lijiang <lijiang@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, mingo@redhat.com, tglx@linutronix.de,
        dyoung@redhat.com
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181027081343.GA1884@MiWiFi-R3L-srv>
References: <20181026093630.8520-1-lijiang@redhat.com>
 <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de>
 <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
 <20181026182440.20a4b107@ezekiel.suse.cz>
 <20181026222517.GB26927@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026222517.GB26927@nazgul.tnic>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sat, 27 Oct 2018 08:13:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/18 at 12:25am, Borislav Petkov wrote:
> On Fri, Oct 26, 2018 at 06:24:40PM +0200, Petr Tesarik wrote:
> > But we need the MSR value from the panic kernel environment, not while
> > the production kernel is still running, right?
> 
> Actually, we need only the encryption bit number (and it should be 0
> otherwise to denote SME wasn't enabled).
> 
> I guess something like
> 
> 	VMCOREINFO_NUMBER(sme_mask);

Yes, agree. So sme_me_mask itself or the encryption bit number, both is
fine.

We need read and parse the memory content of crashed kernel which
is mapped to /prov/vmcore by user space makedumpfile. Not only is it
because user space makedumpfile can't access and get if it's sme
enabled from system, we may use cp to copy /proc/vmcore to a file
directly, then analyze it in another compupter. This often happen when
there's something wrong with makedumpfile, we need debug makedumpfile
with the complete copied file.

And only telling whether sme is enabled might be not enough. Since AMD
CPU might extend to support 5-level, then the current fixed bit positon
47 would need be changed.

Thanks
Baoquan
