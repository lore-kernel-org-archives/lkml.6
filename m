Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E314C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7C62152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7C62152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbeHWPxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:53:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40060 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbeHWPxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:53:46 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id obxZkdwr4Hue; Thu, 23 Aug 2018 14:23:57 +0200 (CEST)
Received: from nazgul.tnic (77-85-47-250.ip.btc-net.bg [77.85.47.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6835C1EC03C0;
        Thu, 23 Aug 2018 14:23:57 +0200 (CEST)
Date:   Thu, 23 Aug 2018 14:24:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 1/2] Revert "x86/mce/AMD: Collect error info even if
 valid bits are not set"
Message-ID: <20180823122410.GA17393@nazgul.tnic>
References: <20180326191526.64314-1-Yazen.Ghannam@amd.com>
 <20180326193052.GJ25548@pd.tnic>
 <DM5PR12MB191603A2AACAE6F7F923C6F3F8AD0@DM5PR12MB1916.namprd12.prod.outlook.com>
 <20180326200742.GF28372@pd.tnic>
 <DM5PR12MB191601AF532C84190049AD04F8AC0@DM5PR12MB1916.namprd12.prod.outlook.com>
 <DM5PR12MB19162C0D9FF144D311ADC22FF8AC0@DM5PR12MB1916.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM5PR12MB19162C0D9FF144D311ADC22FF8AC0@DM5PR12MB1916.namprd12.prod.outlook.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviving an old issue while cleaning my inbox.

On Tue, Mar 27, 2018 at 03:59:37PM +0000, Ghannam, Yazen wrote:
> > > On Mon, Mar 26, 2018 at 07:58:51PM +0000, Ghannam, Yazen wrote:
> > > > So at a minimum, we should always save and report as much as we can.
> > >
> > > Only on Zen or all AMD families?
> > >
> > 
> > I'll confirm with the HW folks. I understand it as a change in philosophy
> > rather than a change in hardware.
> > 
> 
> So this recommendation could apply to all families, but it's okay if we just

Ok, so I think we should do this, still, as it is exactly what the
recommendation says: read the MSRs even if the valid bits are not set and it
doesn't set any Valid bits to confuse error handling downstream.

This way we'll collect all possible info and then mce_amd.c should stop looking
at the valid bits too and dump whatever has been logged.

Ok?

---
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 4b767284b7f5..c14674025615 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -639,10 +639,12 @@ static struct notifier_block mce_default_nb = {
  */
 static void mce_read_aux(struct mce *m, int i)
 {
-	if (m->status & MCI_STATUS_MISCV)
+	bool is_amd = m->cpuvendor == X86_VENDOR_AMD;
+
+	if (m->status & MCI_STATUS_MISCV || is_amd)
 		m->misc = mce_rdmsrl(msr_ops.misc(i));
 
-	if (m->status & MCI_STATUS_ADDRV) {
+	if (m->status & MCI_STATUS_ADDRV || is_amd) {
 		m->addr = mce_rdmsrl(msr_ops.addr(i));
 
 		/*
@@ -668,7 +670,7 @@ static void mce_read_aux(struct mce *m, int i)
 	if (mce_flags.smca) {
 		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
 
-		if (m->status & MCI_STATUS_SYNDV)
+		if (m->status & MCI_STATUS_SYNDV || is_amd)
 			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
 	}
 }

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
