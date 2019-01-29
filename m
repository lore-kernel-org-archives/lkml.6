Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE04C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E8D2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfA2XCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:02:50 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45371 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfA2XCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:02:50 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gocOs-0008SZ-9b; Wed, 30 Jan 2019 00:02:38 +0100
Date:   Wed, 30 Jan 2019 00:02:37 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?ISO-8859-15?Q?Jan_H=2E_Sch=F6nherr?= <jan@schnhrr.de>
cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpu/hotplug: Unfreeze sibling CPU first on resume
 from S3
In-Reply-To: <20190129102329.27610-3-jan@schnhrr.de>
Message-ID: <alpine.DEB.2.21.1901292331380.1950@nanos.tec.linutronix.de>
References: <20190129102329.27610-1-jan@schnhrr.de> <20190129102329.27610-3-jan@schnhrr.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-486840556-1548802958=:1950"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-486840556-1548802958=:1950
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Jan,

On Tue, 29 Jan 2019, Jan H. Schönherr wrote:

> At least one system declares the TSC unstable after resume from S3,
> because the TSC is observed going backwards up to roughly 500 cycles
> every now and then, when bringing secondary CPUs back online.
> 
> The system in question is an AMD Ryzen Threadripper 2950X, microcode
> 0x800820b, on an ASRock Fatal1ty X399 Professional Gaming, BIOS P3.30.
> 
> This unexplained behavior goes away as soon as the sibling CPU of the
> boot CPU is brought back up. Hence, add a hack to restore the sibling
> CPU before all others on unfreeze. This keeps the TSC stable.

Uurgh, no. As you said that's a hack and I'm pretty sure that it just works
by chance. It makes the underlying wreckage not longer observable.

I'm pretty sure this is a BIOS bug and I'm really not going to make a
special case here just to accomodate with that particular broken
firmware. This would just set precedence for random ordering requests based
on DMI strings and other data to make it work on all kind of broken
motherboard/firmware/microcode combinations.

Surely nice detective work, but we really don't want to open this can of
worms.

Too bad that AMD does not have the TSC_ADJUST register. It would tell you
immediately what's wrong and the code we have for that would probably cure
the mess.

Sigh, it's more than 20 years by now that I'm complaining to both Intel and
AMD about the complete trainwreck they made out of TSC and it's still not
fixed. Though I still have the illusion that by the time I retire I get my
hands on a machine with a sane TSC implementation. Hope dies last ....

Oh well, enough ranted and with that I hand off the further proceedings to
Tom Lendacky who surely can give you more technical help than me in that
particular matter.

Thanks,

	tglx






--8323329-486840556-1548802958=:1950--
