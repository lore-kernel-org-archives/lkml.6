Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC35C41536
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 12:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F274821480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 12:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F274821480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391440AbeHPPo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 11:44:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbeHPPo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 11:44:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DDB392635A;
        Thu, 16 Aug 2018 12:46:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF3272026D7E;
        Thu, 16 Aug 2018 12:46:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 86E2022425E; Thu, 16 Aug 2018 08:46:32 -0400 (EDT)
Date:   Thu, 16 Aug 2018 08:46:32 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     Yannik Sembritzki <yannik@sembritzki.me>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH 2/2] [FIXED v2] Replace magic for trusting the secondary
 keyring with #define
Message-ID: <20180816124632.GA24061@redhat.com>
References: <20180815194244.29564-3-yannik@sembritzki.me>
 <201808160443.5h16PxVs%fengguang.wu@intel.com>
 <1bfa03ed-c9f8-d0f2-700c-c93e96d5b99c@sembritzki.me>
 <CA+55aFw1oaRiqAU_61BwqS5QWS2VtZ6o9cAF3YEVx2NfMkmHpQ@mail.gmail.com>
 <fcc28be0-f066-9c7a-7a4e-05d0cc1c0967@sembritzki.me>
 <20180816011106.GC5915@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180816011106.GC5915@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 16 Aug 2018 12:46:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 16 Aug 2018 12:46:34 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vgoyal@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 09:11:06AM +0800, Dave Young wrote:
> On 08/16/18 at 12:07am, Yannik Sembritzki wrote:
> > Signed-off-by: Yannik Sembritzki <yannik@sembritzki.me>
> > ---
> >  arch/x86/kernel/kexec-bzimage64.c       | 2 +-
> >  certs/system_keyring.c                  | 3 ++-
> >  crypto/asymmetric_keys/pkcs7_key_type.c | 2 +-
> >  include/linux/verification.h            | 3 +++
> >  4 files changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/kexec-bzimage64.c
> > b/arch/x86/kernel/kexec-bzimage64.c
> > index 74628275..97d199a3 100644
> > --- a/arch/x86/kernel/kexec-bzimage64.c
> > +++ b/arch/x86/kernel/kexec-bzimage64.c
> > @@ -532,7 +532,7 @@ static int bzImage64_cleanup(void *loader_data)
> >  static int bzImage64_verify_sig(const char *kernel, unsigned long
> > kernel_len)
> >  {
> >      return verify_pefile_signature(kernel, kernel_len,
> > -                       ((struct key *)1UL),
> > +                       TRUST_SECONDARY_KEYRING,
> 
> Instead of fix your 1st patch in 2nd patch, I would suggest to
> switch the patch order.  In 1st patch change the common code to use
> the new macro and in 2nd patch you can directly fix the kexec code
> with TRUST_SECONDARY_KEYRING.

I agree. It looks cleaner that first patch change the common code and
introduce the macro to replace 1UL. And second patch makes use of that
macro in kexec bzImage64 verification.

Thanks
Vivek
