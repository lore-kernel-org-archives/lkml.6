Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2C2ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1A52086B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1A52086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeGPGKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:10:46 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:40353 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbeGPGKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:10:46 -0400
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Mon, 16 Jul 2018 05:44:35 +0000
Received: from [10.20.78.133] (10.20.78.133) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Sun, 15
 Jul 2018 22:44:42 -0700
Date:   Mon, 16 Jul 2018 06:44:23 +0100
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Paul Burton <paul.burton@mips.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/3] binfmt_elf: Respect error return from
 `regset->active'
In-Reply-To: <20180629171330.4giikc5x2cbxxuyc@pburton-laptop>
Message-ID: <alpine.DEB.2.00.1807151824230.30992@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1804301557320.11756@tp.orcam.me.uk> <alpine.DEB.2.00.1805102009380.10896@tp.orcam.me.uk> <20180629171330.4giikc5x2cbxxuyc@pburton-laptop>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.133]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1531719874-298552-23289-155744-1
X-BESS-VER: 2018.9-r1807111811
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Envelope-From: maciej.rozycki@uk.mips.com
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.195800
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-Orig-Rcpt: viro@zeniv.linux.org.uk,jhogan@kernel.org,ralf@linux-mips.org,linux-fsdevel@vger.kernel.org,linux-mips@linux-mips.org,linux-kernel@vger.kernel.org,stable@vger.kernel.org
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> > --- linux-jhogan-test.orig/fs/binfmt_elf.c	2018-03-21 17:14:55.000000000 +0000
> > +++ linux-jhogan-test/fs/binfmt_elf.c	2018-05-09 23:25:50.742255000 +0100
> > @@ -1739,7 +1739,7 @@ static int fill_thread_core_info(struct 
> >  		const struct user_regset *regset = &view->regsets[i];
> >  		do_thread_regset_writeback(t->task, regset);
> >  		if (regset->core_note_type && regset->get &&
> > -		    (!regset->active || regset->active(t->task, regset))) {
> > +		    (!regset->active || regset->active(t->task, regset) > 0)) {
> >  			int ret;
> >  			size_t size = regset_size(t->task, regset);
> >  			void *data = kmalloc(size, GFP_KERNEL);
> > 
> 
> This looks obviously right to me, although I don't think it affects
> anything until commit 25847fb195ae ("powerpc/ptrace: Enable support for
> NT_PPC_CGPR") in v4.8-rc1 & even then not in a harmful way so I'd drop
> the stable tag.

 I'm fine with dropping the tag FWIW.  Thanks for taking care of my patch.

  Maciej
