Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03685C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 09:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE7520856
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 09:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE7520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeJ0STp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 14:19:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbeJ0STp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 14:19:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C15B53082AF3;
        Sat, 27 Oct 2018 09:39:24 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E98291001944;
        Sat, 27 Oct 2018 09:39:21 +0000 (UTC)
Date:   Sat, 27 Oct 2018 17:39:17 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Petr Tesarik <ptesarik@suse.cz>, lijiang <lijiang@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, mingo@redhat.com, tglx@linutronix.de,
        dyoung@redhat.com
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181027093917.GA14493@MiWiFi-R3L-srv>
References: <20181026093630.8520-1-lijiang@redhat.com>
 <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de>
 <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
 <20181026182440.20a4b107@ezekiel.suse.cz>
 <20181026222517.GB26927@nazgul.tnic>
 <20181027081343.GA1884@MiWiFi-R3L-srv>
 <20181027091007.GB1046@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181027091007.GB1046@nazgul.tnic>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Sat, 27 Oct 2018 09:39:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/18 at 11:10am, Borislav Petkov wrote:
> On Sat, Oct 27, 2018 at 04:13:43PM +0800, Baoquan He wrote:
> > Yes, agree. So sme_me_mask itself or the encryption bit number, both is
> > fine.
> 
> You need the encryption bit position and it better be properly formatted
> and extracted into a vmcoreinfo-specific variable because we don't
> expose arch-specific details like sme_me_mask to the outside.

Not very sure about this, we have arch_crash_save_vmcoreinfo() in
arch/x86/kernel/machine_kexec_64.c to export arch-specific stuffs
outside. Is there any special reason about a mask in one architecture
when expose it out? In fact it's only that bit position set mask, no
other information. Surely it's also fine if we export encryption bit
position, then convert it to mask in makedumpfile.

> 
> >  we may use cp to copy /proc/vmcore to a file directly, then analyze
> > it in another compupter. This often happen when there's something
> > wrong with makedumpfile, we need debug makedumpfile with the complete
> > copied file.
> 
> So for the analyze-on-another-computer scenario you absolutely must copy
> anything from the first kernel decrypted because you can't decrypt it on
> the other machine.
> 
> Which means, in a sensitive environment, you probably should copy and
> *encrypt* the dump again with gpg or so.

Hmm, no matter it's makedumpfile or cp directly, when we read
/proc/vmcore in kdump kernel, it will call __read_vmcore() or related
functions in fs/proc/vmcore.c. With regarding to SME memory reading,
Lianbo should have handle it in previous SME support in kdump patches.
Just those page tables in crashed kernel are also memory content, they
are decrypted and copied out, while with SME bit position enabled to
indicate encryption, that bit position is added by kernel, now the 1st
kernel is dead, we need wipe it out in makedumpfile when parsing. So
this 'cp', it's still need be done in kdump kernel by 'cp' /proc/vmcore.

Thanks
Baoquan
