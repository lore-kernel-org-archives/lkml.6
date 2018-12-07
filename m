Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55A6C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988972146D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988972146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbeLGUFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:05:42 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44534 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGUFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:05:41 -0500
Received: by mail-oi1-f195.google.com with SMTP id m6so4329730oig.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 12:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SrD5V7i3XzpVTB6vFwreQ6ci8wRoV2qPngTUFYcqUCM=;
        b=g2puUEPR8Z3myC1eSqGJUqzzfhK4DxWSTGNfYtDWEpZVomLoXnD9dJCk9XWbikqLzP
         v76yCbn5T3/xu6H9N2ZQfdsymtpdauzliLFIm6umG+nI5U0iBv0krTuPJDGpSE0rdyHq
         0/TzcAABB1UYG7glhRLHAEgGsiKqFAtem58wkiHVxHxFhhh2WkKdf367W7ha1taQ1LWd
         p+fERR0VP6inH8jn9LHrmR7PyQ7ONkFvZTU1Hc6AEkmwqnJhAxNeQJaqG2C2flPKd0va
         JciITRjU3dk3am68zcSD75AajQyeDdb6AvW9NmGlG7KkZqOsgy0jE8cwi8oXsi7a1KNS
         txXA==
X-Gm-Message-State: AA+aEWaKKgVGiKV871NNOalBFWYSZjia+ad+MU7FPZy6cZx1LYrtNI5b
        000eEpamtqEW3UXdxtBOHGk=
X-Google-Smtp-Source: AFSGD/WayQDV0ebBy7wH7WDD3sKqu8jE2JTatJhTNcqIMt8QpbZrRlXrQ/sNhHe6s0Nv2ti9KbSlUQ==
X-Received: by 2002:aca:53cd:: with SMTP id h196mr2129759oib.355.1544213140831;
        Fri, 07 Dec 2018 12:05:40 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id d10sm1831665otl.62.2018.12.07.12.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 12:05:40 -0800 (PST)
Subject: Re: [PATCH] nvme-rdma: complete requests from ->timeout
To:     Jaesoo Lee <jalee@purestorage.com>
Cc:     keith.busch@intel.com, axboe@fb.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhath Sajeepa <psajeepa@purestorage.com>,
        Roland Dreier <roland@purestorage.com>,
        Ashish Karkare <ashishk@purestorage.com>
References: <1543535954-28073-1-git-send-email-jalee@purestorage.com>
 <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me>
 <CAJX3CtiBs6YOjkP5xGb5yPShvOdmhuD7kx-kBAVL7+YsyEGMyw@mail.gmail.com>
 <CAJX3CthC6KxH7ZtpSzEGGQTVUgKO6UVkjiMMBV6=OG__UVF43Q@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2055d5b5-2c27-b5a2-e3a0-75146c7bd227@grimberg.me>
Date:   Fri, 7 Dec 2018 12:05:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJX3CthC6KxH7ZtpSzEGGQTVUgKO6UVkjiMMBV6=OG__UVF43Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Could you please take a look at this bug and code review?
> 
> We are seeing more instances of this bug and found that reconnect_work
> could hang as well, as can be seen from below stacktrace.
> 
>   Workqueue: nvme-wq nvme_rdma_reconnect_ctrl_work [nvme_rdma]
>   Call Trace:
>   __schedule+0x2ab/0x880
>   schedule+0x36/0x80
>   schedule_timeout+0x161/0x300
>   ? __next_timer_interrupt+0xe0/0xe0
>   io_schedule_timeout+0x1e/0x50
>   wait_for_completion_io_timeout+0x130/0x1a0
>   ? wake_up_q+0x80/0x80
>   blk_execute_rq+0x6e/0xa0
>   __nvme_submit_sync_cmd+0x6e/0xe0
>   nvmf_connect_admin_queue+0x128/0x190 [nvme_fabrics]
>   ? wait_for_completion_interruptible_timeout+0x157/0x1b0
>   nvme_rdma_start_queue+0x5e/0x90 [nvme_rdma]
>   nvme_rdma_setup_ctrl+0x1b4/0x730 [nvme_rdma]
>   nvme_rdma_reconnect_ctrl_work+0x27/0x70 [nvme_rdma]
>   process_one_work+0x179/0x390
>   worker_thread+0x4f/0x3e0
>   kthread+0x105/0x140
>   ? max_active_store+0x80/0x80
>   ? kthread_bind+0x20/0x20
> 
> This bug is produced by setting MTU of RoCE interface to '568' for
> test while running I/O traffics.

I think that with the latest changes from Keith we can no longer rely
on blk-mq to barrier racing completions. We will probably need
to barrier ourselves in nvme-rdma...
