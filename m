Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683D2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3189320871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3189320871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeKKW53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 17:57:29 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:47961 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeKKW53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 17:57:29 -0500
Received: from tarshish (unknown [10.0.8.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 1F5C6440205;
        Sun, 11 Nov 2018 15:08:54 +0200 (IST)
References: <20181109121112.xibwnc354wzsbovl@bars>
User-agent: mu4e 1.0; emacs 25.2.2
From:   Baruch Siach <baruch@tkos.co.il>
To:     Sergey Matyukevich <geomatsi@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [bug report] armada-8040-mcbin: 4.20-rc1 boot failure
In-reply-to: <20181109121112.xibwnc354wzsbovl@bars>
Date:   Sun, 11 Nov 2018 15:08:53 +0200
Message-ID: <877ehj7od6.fsf@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey, Gregory,

Sergey Matyukevich writes:
> MacchiatoBin board fails to boot v4.20-rc1 kernel built using arm64
> defconfig. According to quick bisection of the board dts file, the
> root cause is in dts patch enabling CPU deep idle states:
> see 8ed46368776b3bc. Is there any pending fix other than reverting
> deep idle state support ?

I reproduced the same boot failure on the Armada 8K based Clearfog
GT-8K. Revert of commit 8ed46368776b3bc on top of v4.20-rc1 makes the
system boot again.

Here is the splat I get:

[   87.358425] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   87.364556] rcu: 	3-...!: (1 ticks this GP) idle=d04/0/0x0 softirq=79/79 fqs=1
[   87.371897] rcu: 	(detected by 2, t=21490 jiffies, g=-1035, q=179)
[   87.378106] Task dump for CPU 3:
[   87.381347] swapper/3       R  running task        0     0      1 0x00000028
[   87.388428] Call trace:
[   87.390892]  __switch_to+0x78/0xb4
[   87.394310]  arm_enter_idle_state+0x38/0x4c
[   87.398512]  cpuidle_enter_state+0xc8/0x15c
[   87.402713]  cpuidle_enter+0x18/0x20
[   87.406304]  call_cpuidle+0x30/0x34
[   87.409807]  do_idle+0x19c/0x224
[   87.413048]  cpu_startup_entry+0x20/0x24
[   87.416988]  secondary_start_kernel+0x158/0x168

baruch

--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
