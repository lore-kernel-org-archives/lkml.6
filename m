Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180CBC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F12223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="Bp5kEgTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F12223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbeKNCcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:32:41 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:14356 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeKNCcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:32:41 -0500
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 4D51846A934;
        Tue, 13 Nov 2018 17:33:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1542126829;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references;
        bh=mpOrte2CQPkKT6ryItVw/jcNlCUyZj+iSXrIF+TGVP0=;
        b=Bp5kEgTflHiQsYgfkm0Y4yCo4B7l4FXa4lZk6+oMmz2nYAd/nVnTLAnB7irR1ENaLEUwi9
        CDpUw5ZIbAhOxIraGKWj7M0OpwtUxsQN/alHzUO0U0mEJf2vUA3lvxqwNN+78630l3eZHo
        UyHFDAFbP+EshTEFnCKwZcMTJLDfu98=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 13 Nov 2018 17:33:49 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     timofey.titovets@synesis.ru
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, nefelim4ag@gmail.com, willy@infradead.org
Subject: Re: [PATCH V3] KSM: allow dedup all tasks memory
In-Reply-To:  <<20181112231344.7161-1-timofey.titovets@synesis.ru>>
Message-ID: <d45addefdf05b84af96fb494d52b4ec4@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1542126829;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references;
        bh=mpOrte2CQPkKT6ryItVw/jcNlCUyZj+iSXrIF+TGVP0=;
        b=0rcgSRFeNFgl513vH3xlIqH2QYx6iQyEkYnE2TDDAtsYInSotFNtUCOXB7GA3mN7AUlvPk
        kuvgA88SAl/yK5lPVeWbIj5+B0DKu7w3XNd0bwKVkl3pPRaDzuiie39whYmIDljpJm6344
        3DEr4lB1ZR7M+FKysFHWVb4wN3mbSF0=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1542126829; a=rsa-sha256;
        cv=none;
        b=Eqkx9SVfZV/EMbeNUYBbz6WHUH7wIT4f6mpgkjwAkeCyZKB2pMjSTCmSeqoXbyqh1qcT8OV/JV6ADQyB6EU5MhzST6OKJZRQGXeLBnoa/SIJNL8flMWxA+MT8F5H5FN+Py9aVHuo4TMbmWmDM7pH2V3YU/kHzh+xhHUYcEvgXuU=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So,

> …snip…
> +static int ksm_seeker_thread(void *nothing)
> +{
> +	pid_t last_pid = 1;
> +	pid_t curr_pid;
> +	struct task_struct *task;
> +
> +	set_freezable();
> +	set_user_nice(current, 5);
> +
> +	while (!kthread_should_stop()) {
> +		wait_while_offlining();
> +
> +		try_to_freeze();
> +
> +		if (!ksm_mode_always()) {
> +			wait_event_freezable(ksm_seeker_thread_wait,
> +				ksm_mode_always() || kthread_should_stop());
> +			continue;
> +		}
> +
> +		/*
> +		 * import one task's vma per run
> +		 */
> +		read_lock(&tasklist_lock);
> +
> +		/* Try always get next task */
> +		for_each_process(task) {
> +			curr_pid = task_pid_nr(task);
> +			if (curr_pid == last_pid) {
> +				task = next_task(task);
> +				break;
> +			}
> +
> +			if (curr_pid > last_pid)
> +				break;
> +		}
> +
> +		last_pid = task_pid_nr(task);
> +		ksm_import_task_vma(task);

This seems to be a bad idea. ksm_import_task_vma() may sleep with 
tasklist_lock being held. Thus, IIUC, you'll get this:

[ 1754.410322] BUG: scheduling while atomic: ksmd_seeker/50/0x00000002
…
[ 1754.410444] Call Trace:
[ 1754.410455]  dump_stack+0x5c/0x80
[ 1754.410460]  __schedule_bug.cold.19+0x38/0x51
[ 1754.410464]  __schedule+0x11dc/0x2080
[ 1754.410483]  schedule+0x32/0xb0
[ 1754.410487]  rwsem_down_write_failed+0x15d/0x240
[ 1754.410496]  call_rwsem_down_write_failed+0x13/0x20
[ 1754.410499]  down_write+0x20/0x30
[ 1754.410502]  ksm_import_task_vma+0x22/0x70
[ 1754.410505]  ksm_seeker_thread+0x134/0x1c0
[ 1754.410512]  kthread+0x113/0x130
[ 1754.410518]  ret_from_fork+0x35/0x40

I think you may want to get a reference to task_struct before releasing 
tasklist_lock, and then put it after ksm_import_task_vma() does its job.

> +		read_unlock(&tasklist_lock);
> +
> +		schedule_timeout_interruptible(
> +			msecs_to_jiffies(ksm_thread_seeker_sleep_millisecs));
> +	}
> +	return 0;
> +}
> …snip…

-- 
   Oleksandr Natalenko (post-factum)
