Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D12C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475BC2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=explicate.org header.i=@explicate.org header.b="MbYXLfqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbeLSVdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:33:02 -0500
Received: from www.explicate.org ([71.19.157.6]:34591 "EHLO
        smtp.svc.explicate.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbeLSVdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:33:01 -0500
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2018 16:33:01 EST
Received: (qmail 455 invoked by uid 1000); 19 Dec 2018 21:25:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=explicate.org; 
 i=@explicate.org; q=dns/txt; s=v01.y2019; t=1545254737; 
 h=date : from : to : cc : subject : message-id : 
 mime-version : content-type : date : from : subject; 
 bh=+eubUdSQt4QBstvSvK+iLlr6a/+yAgIx/tB5PTy+mtw=; 
 b=MbYXLfqUgBq6Q0PzELADeCC3SMpIAw/zBh8UqYP4oADudyfR0u+XJMY8
 Xq0/4JMs6LhO5+8Jj3QZjCOGerSLHFhqnV6eEDRmirSAitWKj6BiPHUP+F
 z77CCuA9IPtsQMU+5mj8j1CJ1qRME/pQaTsbODUBOmzFTxNaVBxiDab+4=
Date:   Wed, 19 Dec 2018 13:25:37 -0800
From:   Ken Pizzini <kkpp@explicate.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: PROBLEM: Xen paging-request boot failure since 4.19.5
Message-ID: <20181219212537.GA25174@144vak35.msa.explicate.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 4.19.5 I have not been able to boot kernels on my Xen-hosted VM on
a system with an Intel Xeon L5520 processor (microcode 0x1d).

4.19.4 worked fine; I've tried kernels 4.19.5, 4.19.6, 4.19.7 4.19.9, 4.19.10,
4.20-rc7, and they all throw:
     BUG: unable to handle kernel paging request at ffff88903fffc000
     PGD 1c0c067 P4D 1c0c067 PUD 0
     Oops: 0000 [#1] PREEMPT SMP NOPTI
     ... [register dump and call trace omitted, since I believe I located the
          offending source code]
     Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
     Kernel Offset: disabled
early in the system boot (fine details might differ; I did not carefully
record the result of each test).

I finally had time to do some bisection, and the problem traces back to commit
    d52888aa2753e3063a9d3a0c9f72f94aa9809c15
    in tree fbbb33771ac6c392caeb283163a594f1a7e6d04d
(x86/mm: Move LDT remap out of KASLR region on 5-level paging).

After backing-out this one commit, I have successfully built and booted
4.19.5, 4.19.10 and 4.20-rc7 (I haven't bothered trying other versions).
(The VM is currently running my patched 4.19.10 without any apparent problem.)

Notes: all 4.19.* builds are of Gentoo's "gentoo-sources" tree (which include
standard Gentoo patches), plus wireguard; the 4.20-rc7 build was unpatched.
I have been successfully running a different build of each 4.19.* version
on my laptop (with many more device drivers enabled), so the problem
is unlikely to be due to the build toolchain (which is common to both
of my build trees).


Let me know if there is more information that you would find helpful,
or if you have patches that you'd like me to test.

		--Ken Pizzini
