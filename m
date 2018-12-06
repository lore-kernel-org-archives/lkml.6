Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C33C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348A520892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348A520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bristot.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbeLFN74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:59:56 -0500
Received: from smtp-sp200-217.kinghost.net ([177.185.200.217]:48091 "EHLO
        smtp-sp200-217.kinghost.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727737AbeLFN7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:59:55 -0500
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Dec 2018 08:59:54 EST
Received: from smtp200-farm64.kinghost.net (smtp200-farm64 [127.0.0.1])
        (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-sp200-217.kinghost.net (Postfix) with ESMTPS id 48F351432A975;
        Thu,  6 Dec 2018 11:54:30 -0200 (BRST)
Received: from smtpi-sp-234.kinghost.net (smtpi-sp-234.kinghost.net [177.185.201.234])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp200-farm64.kinghost.net (Postfix) with ESMTPS id 3C25136EFD108;
        Thu,  6 Dec 2018 11:54:30 -0200 (BRST)
Received: from t460s.bristot.redhat.com (host252-226-dynamic.249-95-r.retail.telecomitalia.it [95.249.226.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daniel@bristot.eti.br)
        by smtpi-sp-234.kinghost.net (Postfix) with ESMTPSA id 1251D6000DAA;
        Thu,  6 Dec 2018 11:54:24 -0200 (-02)
Subject: Re: [PATCH RT] hrtimer: move state change before hrtimer_cancel in
 do_nanosleep()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
References: <20181206101555.xqrz2fl6k36bvezm@linutronix.de>
From:   Daniel Bristot de Oliveira <daniel@bristot.me>
Message-ID: <42567e6b-87b4-9b9e-6442-97e4b7428d71@bristot.me>
Date:   Thu, 6 Dec 2018 14:54:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181206101555.xqrz2fl6k36bvezm@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SND-ID: E3DhL4HZvWApxdeEu0+R3k19tF2vhIUMcvigv4x0qidpkEMv/61pVU+Ic2kX
        C2E5z/9xJ4WEtUyKW/eV3FZ7zkN1fvCQFye4Vp0qZLm01phzRuCHcYzGX6db
        56jvpI9m1fQjNQMTXV4j69f6fy//yJHRtdkZqjKW2KeVgsAZDx+dmFZnFMCt
        1ywTBz0NBWGuenef2iOzqlsKhiA6mNVrhfIAr3nrIsZ61RHRhM7mvpmMlUSJ
        lrfzred1lJ984GxmrUdaUXU4fagoStxoqfZNJcTJfzFqGRFqRyiiHZJ9VeVM
        S/b3n16ceyL7anXDakBu0XFhRFBUWIOq6CMYHLBYQ0nrbRN73VhgroNnlMPE
        zlMH+PMFAWLxGj4bE1kZxqPhO8N1I7e7iWYiaA8eUupZpl58+pWL2r1rXp0Y
        mSjX+8AMoXILfIsD4Cu8Bs4JGkf/jlMTm8KWGzLby96/FD65F7XZzhGm82lT
        iVET03jJDX0+mqwAqWFQt60U/lo6r0mX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/18 11:15 AM, Sebastian Andrzej Siewior wrote:
> There is a small window between setting t->task to NULL and waking the
> task up (which would set TASK_RUNNING). So the timer would fire, run and
> set ->task to NULL while the other side/do_nanosleep() wouldn't enter
> freezable_schedule(). After all we are peemptible here (in
> do_nanosleep() and on the timer wake up path) and on KVM/virt the
> virt-CPU might get preempted.
> So do_nanosleep() wouldn't enter freezable_schedule() but cancel the
> timer which is still running and wait for it via
> hrtimer_wait_for_timer(). Then wait_event()/might_sleep() would complain
> that it is invoked with state != TASK_RUNNING.
> This isn't a problem since it would be reset to TASK_RUNNING later
> anyway and we don't rely on the previous state.
> 
> Move the state update to TASK_RUNNING before hrtimer_cancel() so there
> are no complains from might_sleep() about wrong state.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!

-- Daniel
