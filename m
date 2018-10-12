Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61BFC28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 02:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAF520835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 02:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAF520835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeJLJsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 05:48:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45169 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeJLJsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 05:48:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id y15-v6so5120854plr.12;
        Thu, 11 Oct 2018 19:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jvihXHv05MFy2mCQqpPYSRu+gKBsljuKMX5ryrCl8ag=;
        b=gOf6XhSpWMjHYUTMPUU04RV0yTwJ2kzFmWS1PwOKj1MpH4Gqzs3z1DbjsHgtDlwt+F
         7RRy31f0Qjng239509IEQNx6LVOPuyU8eeF7Yy9dcshwND/aGiUQejllOkBNOXIKfDZx
         7b8oAXYL7QCljxqcqKthIb4ynSZFh+UNShbaCDuma4g5J2LLDd9y7dCeAIYArDMcm73Y
         rIwTh0du190HaRnBRu2ndDBfjQ6cKjbKQV6KoFHMR8S8Q0vFpU5SY0RakgExeFCQOfTO
         D8nj5USXsNlqyLF3OfRKa8n+UlLaVJLMhHK4p7zZdCY4DcYJoLu0EnYqFFGiQojxsL67
         Xh4Q==
X-Gm-Message-State: ABuFfoh12YQ/H3UduuLuHupUhepCOEOceOV84QbxTBfD3fLGd/x0SrTb
        F1uZ//+E3gKHlUG6stzMM3E=
X-Google-Smtp-Source: ACcGV627aupojocS584a9BrChGeEVYAnozgNXRR5eXPOdnjXdZYL+2HF41NTGjz385EILtuNiALT6A==
X-Received: by 2002:a17:902:1101:: with SMTP id d1-v6mr4011881pla.131.1539310683830;
        Thu, 11 Oct 2018 19:18:03 -0700 (PDT)
Received: from asus.site ([2601:647:4601:42b4:3842:3e31:3bb6:cf62])
        by smtp.gmail.com with ESMTPSA id g5-v6sm21477217pfb.130.2018.10.11.19.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 19:18:03 -0700 (PDT)
Subject: Re: [PATCH 1/2] sched/wait: Add wait_event_lock_irq_timeout for
 TASK_UNINTERRUPTIBLE usage
To:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        target-devel <target-devel@vger.kernel.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <1539141790-13557-1-git-send-email-nab@linux-iscsi.org>
 <1539141790-13557-2-git-send-email-nab@linux-iscsi.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <91f50300-5e36-73a5-379d-9c82004947bb@acm.org>
Date:   Thu, 11 Oct 2018 19:18:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1539141790-13557-2-git-send-email-nab@linux-iscsi.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/18 8:23 PM, Nicholas A. Bellinger wrote:
> Short of reverting commit 00d909a107 for v4.19, target-core needs a
> wait_event_t marco can be executed using TASK_UNINTERRUPTIBLE to
> function correctly with existing fabric drivers that expect to run
> with signals pending during session shutdown and active se_cmd I/O
> quiesce.
> 
> The most notable is iscsi-target/iser-target, while ibmvscsi_tgt invokes
> session shutdown logic from userspace via configfs attribute that could
> also potentially have signals pending.
> 
> So go ahead and introduce wait_event_lock_irq_timeout() to achieve this,
> and update + rename __wait_event_lock_irq_timeout() to make it accept
> 'state' as a parameter.
> 
> Fixes: 00d909a107 ("scsi: target: Make the session shutdown code also wait for commands that are being aborted")
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Mike Christie <mchristi@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Nicholas Bellinger <nab@linux-iscsi.org>
> Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
