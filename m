Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EFBC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E9120883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E9120883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeKIR36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:29:58 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:41765 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728141AbeKIR36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:29:58 -0500
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.52 with ESMTP; 9 Nov 2018 16:50:34 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO WMRRD11NA101CK) (10.178.32.163)
        by 156.147.1.151 with ESMTP; 9 Nov 2018 16:50:33 +0900
X-Original-SENDERIP: 10.178.32.163
X-Original-MAILFROM: chanho.min@lge.com
From:   "Chanho Min" <chanho.min@lge.com>
To:     "'Oleg Nesterov'" <oleg@redhat.com>
Cc:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Pavel Machek'" <pavel@ucw.cz>,
        "'Len Brown'" <len.brown@intel.com>,
        "'Andrew Morton'" <akpm@linux-foundation.org>,
        "'Eric W. Biederman'" <ebiederm@xmission.com>,
        "'Christian Brauner'" <christian@brauner.io>,
        "'Anna-Maria Gleixner'" <anna-maria@linutronix.de>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Seungho Park'" <seungho1.park@lge.com>,
        "'Jongsung Kim'" <neidhard.kim@lge.com>,
        "'Inkyu Hwang'" <inkyu.hwang@lge.com>,
        "'donghwan.jung'" <donghwan.jung@lge.com>
References: <1541671796-8725-1-git-send-email-chanho.min@lge.com> <20181108105030.GB9939@redhat.com> 
In-Reply-To: 
Subject: RE: [PATCH] freezer: fix freeze timeout on exec
Date:   Fri, 9 Nov 2018 16:50:33 +0900
Message-ID: <05cd01d47800$e52669a0$af733ce0$@lge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQDMxpYjKJ+WuoJrEZbXJl5GJ1YyTAISrvFpp0VR2WCAAIt64A==
Content-Language: ko
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Can't we simply change de_thread() to use freezable_schedule() ?
> >
> > Oleg.
> 
> We need to change freezable_schedule_timeout() instead.
> freezable_schedule also can't be frozen if sub-threads can't stop
> schedule().
> Furthermore, I'm not sure if it is safe to freeze it at de_thread().
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 9c5ee2a..291cbd6 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -942,7 +942,7 @@ static int de_thread(struct task_struct *tsk)
>         while (sig->notify_count) {
>                 __set_current_state(TASK_KILLABLE);
>                 spin_unlock_irq(lock);
> -               schedule();
> +               while (!freezable_schedule_timeout(HZ));
>                 if (unlikely(__fatal_signal_pending(tsk)))
>                         goto killed;
>                 spin_lock_irq(lock);
> 
> Chanho

Sorry, I might misunderstand freezer.
Changes to freezable_schedule() works fine. It looks safe.
I'll apply patch again.

Chanho

