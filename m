Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2A3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906B720684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906B720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbeGSWKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 18:10:47 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:50076 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeGSWKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 18:10:47 -0400
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Thu, 19 Jul 2018 21:25:13 +0000
Received: from [10.20.78.160] (10.20.78.160) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Thu, 19
 Jul 2018 14:25:23 -0700
Date:   Thu, 19 Jul 2018 22:25:04 +0100
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Paul Burton <paul.burton@mips.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] MIPS: DSP ASE regset support
In-Reply-To: <20180719205630.osfdzk7gqv4djvqc@pburton-laptop>
Message-ID: <alpine.DEB.2.00.1807192214500.30992@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1804301557320.11756@tp.orcam.me.uk> <20180719205630.osfdzk7gqv4djvqc@pburton-laptop>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.160]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1532035513-321458-1221-22561-1
X-BESS-VER: 2018.9-r1807111811
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Envelope-From: maciej.rozycki@uk.mips.com
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.196061
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-Orig-Rcpt: viro@zeniv.linux.org.uk,jhogan@kernel.org,ralf@linux-mips.org,linux-fsdevel@vger.kernel.org,linux-mips@linux-mips.org,linux-kernel@vger.kernel.org
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> Thanks - applied to mips-next for 4.19, though I removed the stable tags
> on patches 1/3 & 3/3 & it's worth noting that the ELF note numbers are
> changed to from 0x70X to 0x80X, since 0x700 has been used already.

 Great, thanks!  No code has used the note numbers yet as I ran out of 
time for doing the GDB side, so the change is not going to affect 
anything.

> If you really care about a stable backport for 3/3 let's talk, but I'm
> doubtful as to its use when we've been missing this for so long.

 I guess it can be backported if a need arises.  There's been clearly some 
move on the 64-bit DSP side as indicated by this GDB bug report (mentioned 
previously): <https://sourceware.org/bugzilla/show_bug.cgi?id=22286>, 
which ultimately prompted me to write this patch series, however given 
that GDB has also been broken for years it looks like just the beginning.
So maybe people will cope with the requirement to upgrade.  They need to 
notice the missing GDB part first anyway. ;)

  Maciej
