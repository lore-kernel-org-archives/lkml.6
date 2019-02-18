Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524E9C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF092184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfBRBh6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 20:37:58 -0500
Received: from linux-libre.fsfla.org ([209.51.188.54]:51134 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfBRBh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 20:37:58 -0500
Received: from free.home (home.lxoliva.fsfla.org [172.31.160.164])
        by linux-libre.fsfla.org (8.15.2/8.15.2/Debian-3) with ESMTP id x1I1bO7W006827;
        Mon, 18 Feb 2019 01:37:26 GMT
Received: from livre (livre.home [172.31.160.2])
        by free.home (8.15.2/8.15.2) with ESMTP id x1I1b4jV007048;
        Sun, 17 Feb 2019 22:37:04 -0300
From:   Alexandre Oliva <lxoliva@fsfla.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Tom Li <tomli@tomli.me>, James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] On the Current Troubles of Mainlining Loongson Platform Drivers
Organization: Free thinker, not speaking for FSF Latin America
References: <20190208083038.GA1433@localhost.localdomain>
        <orbm3i5xrn.fsf@lxoliva.fsfla.org>
        <20190211125506.GA21280@localhost.localdomain>
        <orimxq3q9j.fsf@lxoliva.fsfla.org>
        <20190211230614.GB22242@darkstar.musicnaut.iki.fi>
        <orva1jj9ht.fsf@lxoliva.fsfla.org>
        <20190217235951.GA20700@darkstar.musicnaut.iki.fi>
Date:   Sun, 17 Feb 2019 22:37:03 -0300
In-Reply-To: <20190217235951.GA20700@darkstar.musicnaut.iki.fi> (Aaro
        Koskinen's message of "Mon, 18 Feb 2019 01:59:52 +0200")
Message-ID: <orpnrpj2rk.fsf@lxoliva.fsfla.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 17, 2019, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:

> I tested few older kernels, and it seems that the spurious IRQ issue has
> been always there after switching to libata (commit 7ff7a5b1bfff). It has
> been unnoticed as the 100000 irq limit wasn't reached during boot.

I see, thanks.  That would probably make it hard to bisect indeed.

>> The kernel still disables irq14 early on, and then runs slow.

> This hack works only for CONFIG_PATA_CS5536. You are probably using PATA_AMD.

That's a reasonable guess, but I don't think so.  I do have PATA_AMD
enabled as a module indeed, but it's not even loaded, much as I can
tell, whereas PATA_CS5536 is built into the kernel image, and dmesg
says:

[    4.460000] scsi host0: pata_cs5536
[    4.464000] scsi host1: pata_cs5536
[    4.464000] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x4c60 irq 14
[    4.464000] ata2: DUMMY
[    4.464000] pcnet32: [...]
[    4.644000] random: [...]
[    5.908000] irq 14: nobody cared (try booting with the "irqpoll" option)


Just to be sure, I added some printks to cs5536_noop_freeze, and here's
what I got in dmesg instead:

[    4.452000] pata_cs5536: freeze: checking status...
[    4.452000] pata_cs5536: freeze: checked, clearing...
[    4.452000] pata_cs5536: freeze: cleared
[    4.460000] scsi host0: pata_cs5536
[    4.464000] scsi host1: pata_cs5536
[    4.464000] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x4c60 irq 14
[    4.464000] ata2: DUMMY
[    4.464000] pcnet32: [...]
[    4.468000] pata_cs5536: freeze: checking status...
[    4.468000] pata_cs5536: freeze: checked, clearing...
[    4.468000] pata_cs5536: freeze: cleared
[    4.652000] random: [...]
[    5.920000] irq 14: nobody cared (try booting with the "irqpoll" option)

now, maybe I just don't understand what effects the patch was supposed
to have.

The system still feels very slow, but I haven't timed anything; could it
be that it had the effect of keeping the IRQ functional after all, but
5.0-rc6 is slower than earlier kernels for other reasons?  Like,
/proc/irq/14/pata_cs5536/ is there, but I haven't checked whether it was
there before the patch.

Do you suggest any way to tell whether it had the intended effect?

-- 
Alexandre Oliva, freedom fighter   https://FSFLA.org/blogs/lxo
Be the change, be Free!         FSF Latin America board member
GNU Toolchain Engineer                Free Software Evangelist
Hay que enGNUrecerse, pero sin perder la terGNUra jamás-GNUChe
