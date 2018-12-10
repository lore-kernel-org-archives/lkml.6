Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C1EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AEA20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="KgMC49wL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AEA20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbeLJSNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:13:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54938 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727842AbeLJSNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:13:40 -0500
Received: from zn.tnic (p200300EC2BCAD0009567F52EDB121050.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:d000:9567:f52e:db12:1050])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E2CE11EC0B1A;
        Mon, 10 Dec 2018 19:13:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544465618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=P19QeK6plAEIGvb1LDOsVLw3v1JZABEzVD/6ru26FRI=;
        b=KgMC49wLnDFBHHVSSRGoOQHZVMTGthQzIKyzJUKFrPkxf/yloTd7QNP0DAzXY1SeWJDs1b
        ahMokNmhHGhvjpXnsuPgDPcS+J9XQfTzOz++6M6tWKAUWyXw3yfMIiAJdHefVGSFTt6YZO
        I+btCLMnrhkR4IHDGF58pfDgv6pkMT0=
Date:   Mon, 10 Dec 2018 19:13:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Eduardo Habkost <ehabkost@redhat.com>,
        =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Andre Przywara <andre.przywara@arm.com>,
        kvm ML <kvm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: kvm: RDTSCP on AMD
Message-ID: <20181210181328.GA762@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviving an old thread here.

On Wed, Jul 06, 2016 at 11:27:16PM +0200, Paolo Bonzini wrote:
> On 06/07/2016 19:34, Eduardo Habkost wrote:
> >> > Nothing is needed in the kernel actually.  You can skip the intercept
> >> > by running the guest with MSR_TSC_AUX set to the guest's expected value.
> >> >  Which KVM does, except that it's botched so I need to apply the
> >> > patch in https://lkml.org/lkml/2016/4/13/802.
> > Do you mean -cpu Opteron_G*,+rdtscp will be buggy on Linux v4.5?
> > (v4.5 reports rdtscp as supported in GET_SUPPORTED_CPUID)
> > 
> > Can we do something to make QEMU detect the buggy kernel before
> > allowing rdtscp to be enabled, or should we just tell people to
> > upgrade their kernel?
> 
> We usually just tell people to use the latest stable kernel.
> 
> Adding new CPU models is not a big deal, in fact it's almost easier than
> getting compat properties right. :)

Ok, can we finally revert

  33b5e8c03ae7 ("target-i386: Disable rdtscp on Opteron_G* CPU models")

in the qemu tree?

Three years should be enough by now for

  46896c73c1a4 ("KVM: svm: add support for RDTSCP")

to have percolated downstream.

Btw, its commit message talks about Linux not using RDTSCP but that will
change soon. :-)

Oh, and the EPYC qemu CPU model has CPUID_EXT2_RDTSCP and works just
fine when patching in RDTSCP:

[    0.543197] apply_alternatives: feat: 3*32+18, old: (read_tsc+0x0/0x10 (ffffffff8101d1c0) len: 5), repl: (ffffffff824e6d33, len: 5), pad: 3
[    0.544448] ffffffff8101d1c0: old_insn: 0f 31 90 90 90
[    0.545023] ffffffff824e6d33: rpl_insn: 0f ae e8 0f 31
[    0.545598] ffffffff8101d1c0: final_insn: 0f ae e8 0f 31
[    0.546193] apply_alternatives: feat: 1*32+27, old: (read_tsc+0x0/0x10 (ffffffff8101d1c0) len: 5), repl: (ffffffff824e6d38, len: 3), pad: 3
[    0.547195] ffffffff8101d1c0: old_insn: 0f ae e8 0f 31
[    0.547775] ffffffff824e6d38: rpl_insn: 0f 01 f9
[    0.548307] ffffffff8101d1c0: final_insn: 0f 01 f9 66 90

That final_insn which gets patched to by the alternatives is

ffffffff8101d1c0:       0f 01 f9                rdtscp
ffffffff8101d1c3:       66 90                   xchg %ax,%ax

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
