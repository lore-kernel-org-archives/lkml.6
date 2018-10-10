Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAAFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96148214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96148214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeJJQmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:42:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJJQmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:42:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78FF1300206A;
        Wed, 10 Oct 2018 09:21:21 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A20268D36;
        Wed, 10 Oct 2018 09:21:19 +0000 (UTC)
Date:   Wed, 10 Oct 2018 17:21:17 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        rjw@rjwysocki.net, lenb@kernel.org, ard.biesheuvel@linaro.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181010092117.GG25297@MiWiFi-R3L-srv>
References: <20181010084119.17539-1-fanc.fnst@cn.fujitsu.com>
 <20181010085920.GB5533@zn.tnic>
 <20181010090620.GF25297@MiWiFi-R3L-srv>
 <20181010091205.GA10618@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010091205.GA10618@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 10 Oct 2018 09:21:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 at 05:12pm, Chao Fan wrote:
> On Wed, Oct 10, 2018 at 05:06:20PM +0800, Baoquan He wrote:
> >Hi Boris,
> >
> >On 10/10/18 at 10:59am, Borislav Petkov wrote:
> >> ... and we just picked up
> >> 
> >> https://lkml.kernel.org/r/20181001140843.26137-1-msys.mizuma@gmail.com
> >> 
> >> and without having looked at the rest of your stuff, if people accept
> >> your solution, we don't need the silly parameter anymore, right?
> >> 
> >> Which means, we should not rush the whole thing yet until the whole
> >> KASLR vs movable memory gets solved properly.
> >
> >Masa's patches solves the problem in memory region KASLR which later hot
> >added memory may be big than the default padding 10 TB.
> >
> >Chao's patches is trying to fix a conflict between 'movable_node' and
> >kernel text KASLR. If 'movable_node' specified, we rely on SRAT to get
> >which memory region is movable or immovable, and movable region can be
> >hot removed. But if kernel is randomized into movable memory, it can't
> >be hot removed any more, this is a regression after KASLR introduced.
> >So this is a different issue than Masa's.
> 
> Yes, they are two issues.
> But if we can get more memory information by the function in
> the new file acpi.c, semms it's helfpul to Masa's issue.

Hmm, reading SRAT three times during x86 kernel boot? Maybe we try this
after the function has run a time and proved very stable?

Thanks
Baoquan
