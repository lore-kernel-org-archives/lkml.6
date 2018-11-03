Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF602C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 08:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D36420833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 08:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKA4/xG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D36420833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeKCRux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 13:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbeKCRux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 13:50:53 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B78B82081B;
        Sat,  3 Nov 2018 08:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541234419;
        bh=Ai5LCiSyW870ZupbSGP9tRPlW/l6NFbJhV9AUv/a37g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pKA4/xG8ntOmLZmE9gaZT/TwDsFfQBx05qnQ1EtaOPvPaGxOGQrbmYS5EA3ukXZYL
         VSJdkrPYVx4KKYonb17+h9Z2Z8nT9vO0hz22VlyXdMcyovs17ZkfN8ki7uv0KQgfjO
         JZ0/aH4r4/6oqWSfdXeSH/DFGzHD4hw0Rd/+N/9E=
Date:   Sat, 3 Nov 2018 09:40:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, a.p.zijlstra@chello.nl,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 4.14 053/143] x86/power: Fix some ordering bugs in
 __restore_processor_context()
Message-ID: <20181103084016.GA9057@kroah.com>
References: <20181102182857.064326086@linuxfoundation.org>
 <20181102182901.303280657@linuxfoundation.org>
 <CADVatmNE4VcpjoEKdXTf_d0_M27shgB+x6FiXo1-JzRf+0sw9w@mail.gmail.com>
 <20181102231734.GI194472@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102231734.GI194472@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 07:17:34PM -0400, Sasha Levin wrote:
> On Fri, Nov 02, 2018 at 08:19:36PM +0000, Sudip Mukherjee wrote:
> > Hi Greg,
> > 
> > On Fri, Nov 2, 2018 at 6:51 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > 
> > > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > 
> > This has been fixed by another upstream commit:
> > 7ee18d677989 ("x86/power: Make restore_processor_context() sane")
> > 
> > You can not directly apply it, will need backporting.
> 
> It depends on the following commits:
> 
> 5b06bbcfc2c6 x86/power: Fix some ordering bugs in __restore_processor_context()
> 090edbe23ff5 x86/power/64: Use struct desc_ptr for the IDT in struct saved_context
> 896c80bef4d3 x86/power/32: Move SYSENTER MSR restoration to fix_processor_context()
> 7ee18d677989 x86/power: Make restore_processor_context() sane
> 
> Greg, any objections to pulling them all in?

No objection, but can I just drop this patch here (it's also in the 4.9
queue) and then all of these be added to your next round of patches to
be pulled in after this release?

That should make it easier, and more ovbious to test this all together.

thanks,

greg k-h
