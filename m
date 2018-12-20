Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF858C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D6720811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IgFvZuYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389451AbeLTSif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:38:35 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:45386 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731506AbeLTSi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:38:27 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id CD80924E0772;
        Thu, 20 Dec 2018 10:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545331107; bh=ZniTcl6EZWBBaGdAu2K3uR86MPgYLB4cmv9UcgqcvjU=;
        h=From:To:CC:Subject:Date:References:From;
        b=IgFvZuYiE+AJZnv1Qoht5p4oYVh3balSM8GlTQCXZBOpjdDkVSQoaqRhZm/0yBaqJ
         bNQUMWtbQ9fVFZM2P7Iy0MyJe3zMrEmSjJneSXs0zLA5vLtnQS11nbfSqPeN7guLqN
         XhgL4jqQLQw9iOur1a4K3MwVEPULixdjcyZmQwgGD4Ep3RhixxwVCnGwvnb6B5VB+F
         qYmlP5juXYkSTHvzgvUtWr4PgnrFfdgdtDkGJpuPECY70D1tL0MZ381o2RTAdQceKb
         gLh2vmkqeGIwjAlLsztgoycLA9vU+L41/inVjqnISBqR2QeP9trMtx0A95WEDkQIyc
         DSB5E2iDebIwQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id C2F4D3A12;
        Thu, 20 Dec 2018 10:38:26 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000;
 Thu, 20 Dec 2018 10:38:26 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] ARC: show_regs: avoid page allocator
Thread-Topic: [PATCH 1/2] ARC: show_regs: avoid page allocator
Thread-Index: AQHUlwMR8PfsxZ55lUuwqgC40oqmmA==
Date:   Thu, 20 Dec 2018 18:38:26 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014642386D@US01WEMBX2.internal.synopsys.com>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
 <1545159239-30628-2-git-send-email-vgupta@synopsys.com>
 <20181220125730.GA17350@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 4:57 AM, Michal Hocko wrote:=0A=
>> Despite this, lockdep still barfs (see next change), but this patch=0A=
>> still has merit as in we use smaller/localized buffers now and there's=
=0A=
>> less instructoh trace to sift thru when debugging pesky issues.=0A=
> But show_regs is called from contexts which might be called from deep=0A=
> call chains (e.g WARN). Is it safe to allocate such a large stack there?=
=0A=
=0A=
ARC has 8K pages and 256 additional bytes of stack usage doesn't seem absur=
dly=0A=
high to me !=0A=
=0A=
-Vineet=0A=
