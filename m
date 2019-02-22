Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF174C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C52E2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="rO7Rzy30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfBVK7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:59:21 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:31994 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbfBVK7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 05:59:20 -0500
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Feb 2019 05:59:19 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550833158;
        s=strato-dkim-0002; d=aepfle.de;
        h=Message-ID:Subject:Cc:To:From:Date:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=5SHITY41GPbEP8P9B/Ahl93k7CYPnvw/oHBJzInlIZs=;
        b=rO7Rzy307UL6MTyTStemmBe+eUfZxwyz/3fW++KxbNC9pJ3krmh/ee2mGcbIz0UzOS
        MeCEeSiko0mzG2qGKsv3N/2X7tTGyw6Ez1LrJStWXnLZV2gylEWRRgEFgILDntDQbh+O
        07+QDzbbLqc1zkjQQeBkFa4B58NsbdPj44CzQ=
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0mv9coXAgc09FajRctxF8avNjL8BIaOzrboMVGNhg5iLfM="
X-RZG-CLASS-ID: mo00
Received: from aepfle.de
        by smtp.strato.de (RZmta 44.12 AUTH)
        with ESMTPSA id R08017v1MAr6jHt
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 22 Feb 2019 11:53:06 +0100 (CET)
Date:   Fri, 22 Feb 2019 11:53:02 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: recalibrating x86 TSC during suspend/resume
Message-ID: <20190222105302.GA26398@aepfle.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (20190207T234809.c483d3c3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Is there a way to recalibrate the x86 TSC during a suspend/resume cycle?

While the frequency will remain the same on a Laptop, it may (or rather:
it definitly will) differ if a VM is migrated from one host to another.
The hypervisor may choose to emulate the expected TSC frequency on the
destination host, but this emulation comes with a significant
performance cost. Therefore it would be good if the kernel evaluates the
environment during resume.

The specific usecase I have is a workload within VMs that makes heavy
use of TSC. The kernel is booted with 'clocksource=tsc highres=off nohz=off'
because only this clocksource gives enough granularity. The default
paravirtualized clock will return the same values via
clock_gettime(CLOCK_MONOTONIC) if the timespan between two calls is too
short. This does not happen with 'clocksource=tsc'.

Right now it is not possible to migrate VMs to hosts with different CPU
speeds. This leads to "islands" of identical hardware, and makes
maintenance of hosts harder than it needs to be. If the VM kernel would
be able to cope with CPU/TSC frequency changes, the pool of potential
destination hosts will become significant larger.

The current result of a migration with non-emulated TSC between hosts of
different speed is:

[   42.452258] clocksource: timekeeping watchdog on CPU1: Marking clocksource 'tsc' as unstable because the skew is too large:
[   42.452270] clocksource:                       'xen' wd_now: 6d34a86adb wd_last: 6d1dc51793 mask: ffffffffffffffff
[   42.452272] clocksource:                       'tsc' cs_now: 1fd2ce46bb cs_last: 1f95c4ca75 mask: ffffffffffffffff
[   42.452273] tsc: Marking TSC unstable due to clocksource watchdog

Thanks,
Olaf

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXG/UigAKCRBdQqD6ppg2
fjYDAJ44u6MuRWhsXtF4PVDLElbIijREVwCgn5aRMuImqmD6dENxkObdTdBowqM=
=0dEX
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
