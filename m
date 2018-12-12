Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045A1C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5DF20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5DF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbeLLIDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:03:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbeLLIDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:03:15 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2912308421A;
        Wed, 12 Dec 2018 08:03:15 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EDE61054FD4;
        Wed, 12 Dec 2018 08:03:14 +0000 (UTC)
Date:   Wed, 12 Dec 2018 16:03:12 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v13 1/6] x86/boot: Introduce kstrtoull() to boot
 directory instead of simple_strtoull()
Message-ID: <20181212080312.GP17340@MiWiFi-R3L-srv>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
 <20181212031053.1815-2-fanc.fnst@cn.fujitsu.com>
 <20181212041218.GA28286@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212041218.GA28286@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 12 Dec 2018 08:03:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/18 at 12:12pm, Chao Fan wrote:
> On Wed, Dec 12, 2018 at 11:10:48AM +0800, Chao Fan wrote:
> >Introduce kstrtoull() from lib/kstrtox.c to boot directory so that code
> >in boot/ can use kstrtoull() and the old simple_strtoull() can be
> >replaced.
> >
> 
> Hi all,
> 
> Thanks for Boris, Baoquan and Masa's help, this PATCHSET has proceeded to
> this step. With the talking in community, the key problem has been turned
> from ACPI issue to kstrtoull() issue.
> In this version, following the suggestion of Boris, I copy the kstrtoull()
> to boot/string.c
> But from last week, I was working on kstrtoull() issue in different methods
> and try many times, there are several methods:
> 1. Copy kstrtoull() to boot/string.c
> 2. Include kstrtoull() to boot/string.c.
> 3. Use existing simple_strtoull() for now, and proceed to include kstrtoull()
>    as a next work.

If can incalude it to boot/string.c, that's surely the best. Since we
don't need to worry about update kstrtoull() update from /lib/kstrtox.c.
Currently simple_strtoull() is called in arch/x86/boot/compressed/kaslr.c
and arch/x86/boot/early_serial_console.c, if not easy to include kstrtoull()
to boot/string.c, copying it is also fine. 

Surely, using the old simple_strtoull() is fine too, we can take its
replacement into TODO list. This fix has blocked KASLR&hotplug
combination long time, now we have to ask customsers to add 'nokaslr'
always if they want to do memory hot add/remove on bare metal system.

See what other reviewers will say.

Thanks
Baoquan
