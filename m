Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6B8C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A7A2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dkim.kinghost.net header.i=@dkim.kinghost.net header.b="liaR9XN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A7A2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bristot.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeKGXyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:54:37 -0500
Received: from smtp-sp200-202.kinghost.net ([177.185.200.202]:37728 "EHLO
        smtp-sp200-202.kinghost.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726688AbeKGXyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:54:37 -0500
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Nov 2018 18:54:35 EST
Received: from smtp200-farm64.kinghost.net (smtp200-farm64 [127.0.0.1])
        (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-sp200-202.kinghost.net (Postfix) with ESMTPS id 7A41C142BE512;
        Wed,  7 Nov 2018 12:18:03 -0200 (BRST)
Received: from smtpi-sp-232.kinghost.net (smtpi-sp-232.kinghost.net [177.185.201.232])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp200-farm64.kinghost.net (Postfix) with ESMTPS id 75A59191B0E0C;
        Wed,  7 Nov 2018 12:18:03 -0200 (BRST)
Received: from t460s.bristot.redhat.com (unknown [87.18.205.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daniel@bristot.eti.br)
        by smtpi-sp-232.kinghost.net (Postfix) with ESMTPSA id D36526000DA8;
        Wed,  7 Nov 2018 12:17:52 -0200 (-02)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; 
 d=dkim.kinghost.net; i=@dkim.kinghost.net; q=dns/txt; 
 s=king1; t=1541600280; h=subject : to : cc : references : 
 from : message-id : date : mime-version : in-reply-to : 
 content-type : content-transfer-encoding : subject : from 
 : date; bh=kA3lKBOvwG4+u9puoQFNp/cFMgxxLQVT+qFszYb0Y0w=; 
 b=liaR9XN36gQz0WVZsxFbNXl9apLSJEFSVhHHerD/DnUiyjyzCXbCazoO
 fiuR2zIsv4RMeoInLsmjiEmW3rWOEBSHwZg+ju52faZA29KI/pQfX6WcA6
 LzPiYjHn61o+R44OZkazBW1HEcsKXK0SoGg/yCpYteOP7wUekchkZW7VA=
Subject: Re: [PATCH] kernel/time/posix-cpu-timers: Remove useless call to
 check_dl_overrun
To:     Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org,
        mingo@redhat.com
Cc:     rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, bristot@redhat.com,
        linux-rt-users@vger.kernel.org, mtk.manpages@gmail.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20181107111032.32291-1-juri.lelli@redhat.com>
From:   Daniel Bristot de Oliveira <daniel@bristot.me>
Message-ID: <a2fabbe4-a3be-6d10-1634-a5b23036c6f0@bristot.me>
Date:   Wed, 7 Nov 2018 15:17:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107111032.32291-1-juri.lelli@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SND-ID: E3DhL4HZvWApxdeEu0+R3k19tF2vhIUMcvigv4x0qidpkEMv/61pVU+Ic2kX
        C2E5z/9xJ4WEtUyKW/eV3FZ7zrr9PQye0jkYrclvxeSQHWGy9TjpD0mQkndy
        oK2kvcFmZUsSA5pWn7C0bU4lAZlDgR1lRd3M+qg3U9a4Z2s0n1bWc/dYSo8E
        VsEpLYIaEGcmkEQK7yWp5XHdFIqFB5ZVz1or8CFqHiVAdspPX6vKEfXAPlqr
        txM8ISWpr1ms/9sqtMtIMkGCRIXj2qLzHWpORA9do1vP6HnSZ8CXpTqvK43u
        +i/OuXC7eixJPBRWaJXY2xT7Bx44FP5HgPXjZ3vwWrZtK87GThPnktE2CFNw
        7ZIrKcOabO1iDU1zSUosB1TR8eHapzBdbMnxOavlg1ezd2UZ0/vVb9KOIQnS
        7yuXRmDD+7zjjEwLPDi75pLnDx9J657I87woQ+nAwAxKDpdADwu50d50jzN2
        Ws7P4TTMori37Y30ydQSxPehYQSrWEB/Y1lpZiNxUHYi89bwTTGY73e/shNZ
        QTUHrf+jxPZrOj2XkekbJfo0Pge8cHshz8VPGdI/vVFc9bDfJQln52Y5JQSO
        w6jv9XIu6VQ4Ww/oMyLRAiljIwoF0kJZpqsJVVlxcTz31sWszEdVeUpmbtiq
        TaImq3IW9fVt/uIur0+2raf7+klNVGaPk43wcIAYrO/ihEuygQ+tfzF/FLyB
        lYvCljZ/o51DRKc3OBxwB86dkl8Yn1QXnriXq+TZV0HmYnvr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/18 12:10 PM, Juri Lelli wrote:
> check_dl_overrun is used to send a SIGXCPU to users that asked to be
> informed when SCHED_DEADLINE runtime overruns occur.
> 
> The function is called by check_thread_timers already, so the call in
> check_process_timers is redundant/wrong (even though harmless).
> 
> Remove it.
> 
> Fixes: 34be39305a77 ("sched/deadline: Implement "runtime overrun signal" support")
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Luca Abeni <luca.abeni@santannapisa.it>
> Cc: Claudio Scordino <claudio@evidence.eu.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!

-- Daniel

> ---
>  kernel/time/posix-cpu-timers.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
> index ce32cf741b25..8f0644af40be 100644
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -917,9 +917,6 @@ static void check_process_timers(struct task_struct *tsk,
>  	struct task_cputime cputime;
>  	unsigned long soft;
>  
> -	if (dl_task(tsk))
> -		check_dl_overrun(tsk);
> -
>  	/*
>  	 * If cputimer is not running, then there are no active
>  	 * process wide timers (POSIX 1.b, itimers, RLIMIT_CPU).
> 
