Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55086C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 11:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F9121903
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 11:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeLWLzk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 06:55:40 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21809 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeLWLzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 06:55:40 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1545566120; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=gpIzxCl2h2I2IVdUNSAOkl3zOwnJQO23mzfbw654bV+vNQHxfYqH0E4GxDQEJIpwSi0xmwFsRBnKernyGjyFsuup4bj4QIXYwaaFoqwn9noklR39cb2eSJPHz2YMoftB0Os+RMeyLl5ajt3W1z6UQUj9+u4UBYpUnifX8zhGkqk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1545566120; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=UoiFJDU8XiY5dY/+Vx1c8JaYwOenU+JjvJkjCJjzSRg=; 
        b=Xby31Ogkw1Xm1p6WKK5EvtH84pPMRnRy/gkgMVz+a2FQoyUmqtibzn+rT8aPJGdLerrR7Pyj1j6GgSTj0dgKwMttvdOvzZRO1eaNA5YZzpkIS8OFZ+qZQ6ELv596Y2Sg4CVdvYrXRoykWF0QGIT4AN6eLG5+yIMLsHRQHXzBBDA=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 1545566116613982.8197549476132; Sun, 23 Dec 2018 03:55:16 -0800 (PST)
Message-ID: <e7ec38d7cade9aa76384aa2781eab307d2cd5a7b.camel@mniewoehner.de>
Subject: Re: tpm_tis TPM2.0 not detected on cold boot
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <1545519232.3940.115.camel@linux.ibm.com>
References: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
         <1f281756bb1f041e55be8dd090670a1a7b1d1c94.camel@mniewoehner.de>
         <1545519232.3940.115.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 23 Dec 2018 12:55:12 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

On Sat, 2018-12-22 at 17:53 -0500, Mimi Zohar wrote:
> On Sat, 2018-12-22 at 14:47 +0100, Michael Niewöhner wrote:
> 
> > When I remove the timeout and boot directly to the linux kernel, I get that
> > "2314 TPM-self test error" since it has not finished, yet. The TPM is
> > detected
> > by IMA and works fine then.
> > 
> > Some more tests showed that any delay before booting the kernel causes the
> > TPM
> > to not get detected. I tested, 10, 15, 20, 30, 60... seconds. Only in some
> > very
> > rare cases the TPM got detected.
> > 
> > I wanted to know if the TPM is in an well initialized state at the time of
> > that
> > error. Since I was not able to get some test/debug kernel patches working I
> > decided to try kexec. It turned out that the TPM is indeed correctly working
> > and
> > will be detected just fine by linux after kexec!
> 
> No surprise here.  kexec would be the equivalent of a soft reboot.

Well, I am not that deep in kexec internals but isn't a soft reboot much more
than a kexec? I thought kexec would "just" load the new kernel to memory and
executes it while a soft reboot goes at least through some UEFI initialization.
For example, my pwm fans - in fact the EC - get resetted on a soft reboot, while
a kexec does not touch them.

That is why I wanted to test if there is a different behaviour on kexec compared
to a "real" soft reboot. If there was such difference I would have assumed a
UEFI bug that does not initialize the TPM correctly.
Kexec AFAIK does not invoke any UEFI initialization, so the TPM should be in the
same state as before kexec and since there is no difference between sr and kexec
I have the feeling there is something wrong in the kernel.

Correct me if I am wrong here, please.

My current workaround is to do a machine_emergency_reboot() when TPM isn't
detected correctly. That is a pretty hard workaround but it seems to work for
now...

> 
> > 
> > Is there anyone having an idea what could be wrong here? I am willing to
> > debug
> > this but I have really no idea where to start :-(
> 
> A while ago, I was "playing" with a pi.  Commenting out
> tpm2_do_selftest() seemed to resolve a similar problem, but that was
> before James' patches.  I don't know if that would make a difference
> now.

Hm, I will try that..


> Mimi
> 

There is another issue but I don't know if both are related. Maybe that's just a
timing issue...

root@debian:~# dd if=/dev/hwrng bs=1 count=1
dd: error reading '/dev/hwrng': Operation not permitted
0+0 records in
0+0 records out
0 bytes copied, 0.755958 s, 0.0 kB/s
root@debian:~# dd if=/dev/hwrng bs=1 count=1 | xxd; dd if=/dev/hwrng bs=1
count=1 | xxd
dd: error reading '/dev/hwrng': Operation not permitted
0+0 records in
0+0 records out
0 bytes copied, 0.755697 s, 0.0 kB/s
1+0 records in
1+0 records out
00000000: 52                                       R
1 byte copied, 0.0106268 s, 0.1 kB/s


Michael


