Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1060BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B4F20644
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B4F20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=petrovitsch.priv.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeHXAZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:25:19 -0400
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:1883 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbeHXAZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:25:18 -0400
X-Greylist: delayed 3660 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Aug 2018 20:25:18 EDT
Received: from thorin.petrovitsch.priv.at (80-110-98-250.cgn.dynamic.surfer.at [80.110.98.250] (may be forged))
        (authenticated bits=0)
        by esgaroth.tuxoid.at (8.15.2/8.15.2) with ESMTPSA id w7NJqZ5p029965
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 23 Aug 2018 21:52:36 +0200
Message-ID: <d47f1f4b828e6099c7db2ca4a4728536b3ad2723.camel@petrovitsch.priv.at>
Subject: Re: Kernel-only deployments?
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
To:     paulmck@linux.vnet.ibm.com, nicolas.pitre@linaro.org,
        josh@joshtriplett.org
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 23 Aug 2018 21:52:17 +0200
In-Reply-To: <20180823174359.GA13033@linux.vnet.ibm.com>
References: <20180823174359.GA13033@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-DCC-debian-Metrics: esgaroth.tuxoid.at 1169; Body=4 Fuz1=4 Fuz2=4
X-Virus-Scanned: clamav-milter 0.97 at esgaroth.tuxoid.at
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

On Thu, 2018-08-23 at 10:43 -0700, Paul E. McKenney wrote:
> [...]
> Does anyone do kernel-only deployments, for example, setting up an
> embedded device having a Linux kernel and absolutely no userspace
> whatsoever?
[...]
> You see, rcutorture runs entirely out of initrd, never mounting a real
> root partition.  The user has been required to supply the initrd, but

IMHO running programs from the initrd is in user-space, but anyways:

Ages ago at some former employer, we built an embedded Linux device on
an MPC-860 board (but that shouldn't make a significant difference to
other architectures) based on the (at that time) brand new 2.4 kernel
which ran completely out of the initrd (which obviously contained the
whole root filesystem).

[...]
> by throwing out everything not absolutely needed by the dash and sleep
> binaries, which got me down to about 2.5MB, 1.8MB of which was libc.

We had a working glibc binary (which as the largest binary on the
filesystem) and just used it (and never got time and/or necessity to
use something else like ulibc, newlibc or build glibc ourselves to
leave all unneeded stuff out).

We basically built the filesystem - the distribution as such;-) - from
scratch (only self-crafted `configure` calls around[0]) and - thus -
used busybox and ash (IIRC) - so throw dash, core-utils etc. away and
just use busybox (or something similar) for further space savings.

The whole startup and daemon management was done with busybox' "init"
via a simple /etc/inittab (that were the good old times;-) and it was
enough as one can start one-time programs at boot time (e.g. to load
kernel modules (and remove the file in the filesystem from the
filesystem[0]) or configure stuff via sysctl) and restart daemons. We
didn't need run-levels ...

> This situation of course prompted me to create an initrd containing
> a statically linked binary named "init" and absolutely nothing else
> (not even /dev or /tmp directories), which weighs in at not quite 800KB.

That is probably the smallest solution - if it's enough. If it's all
GPL, just link it statically against dietlibc ....

We had all of the usual directories and a somewhat filled /dev
(completely static in the initrd IIRC, no udev or similar dynamic stuff
was needed) as we had dropbear as ssh-server, a small webserver+CGI-
script for a web interface and a SNMP agent (hacked net-smtp as we had
our own configuration daemon and needed SNMP only as a transport
protocol).

[...]

MfG,
	Bernd

[0]: Every byte counts and size does matter;-)
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at

