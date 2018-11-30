Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E38C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A24C2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A24C2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeK3Mh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:37:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37323 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeK3Mh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 07:37:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so1948490plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 17:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LxAiWu4SenEprLsXPavKBK+I9CkA6hZeDkKOIMWEF44=;
        b=H6pagDV+pi+/z0BvknFQ5xG3PwuHBl4JhowRHYmSBshbORDyiK+nYNDxZHXFmu8GdJ
         EGOeEgVhPw+BeeTIgedHoGWDvGXbW6YyQc0/gCeAbVzTj6mhC5dPOQRj06qz+AL2UzJ4
         0ZUKj6KBPeL3ZthY1MHb13rOPrtSCkMeDFwC+EL9tzyN6NoaOXVdHZoLj8G0w9XjYWt6
         dHofoPZ2IP+d5Iqkl9bXEf7pBPEDgc6briyfPt6JA1BQwfR9xsDwFBgfr9M40aR4myoP
         MwBkbni+tqGSj1KJrEpt6VBaOW2YDnW1R700bS1rAmNGCNipMFdOAb6NImDdPgHYY2Zx
         tSzA==
X-Gm-Message-State: AA+aEWbZIar17YFl7FIkzvbwOe2XGU5af3P2NpduPqH2fj2SCtiLmo6a
        1UVi39W9xO+WA/rRDSaSwrQ=
X-Google-Smtp-Source: AFSGD/W99N1/M7PNcxD8bfn8tl8qJnMMvYLaZMaUnDB6RyvuDzzUs4TiGpTLFVW1sEWenq9vcmoPHw==
X-Received: by 2002:a17:902:848d:: with SMTP id c13mr3760451plo.257.1543541427687;
        Thu, 29 Nov 2018 17:30:27 -0800 (PST)
Received: from [10.1.124.47] ([199.36.244.14])
        by smtp.gmail.com with ESMTPSA id 73-v6sm4987871pfl.142.2018.11.29.17.30.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 17:30:26 -0800 (PST)
Subject: Re: [PATCH] nvme-rdma: complete requests from ->timeout
To:     Jaesoo Lee <jalee@purestorage.com>, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        psajeepa@purestorage.com, roland@purestorage.com,
        ashishk@purestorage.com
References: <1543535954-28073-1-git-send-email-jalee@purestorage.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me>
Date:   Thu, 29 Nov 2018 17:30:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543535954-28073-1-git-send-email-jalee@purestorage.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> This does not hold at least for NVMe RDMA host driver. An example scenario
> is when the RDMA connection is gone while the controller is being deleted.
> In this case, the nvmf_reg_write32() for sending shutdown admin command by
> the delete_work could be hung forever if the command is not completed by
> the timeout handler.

If the queue is gone, this means that the queue has already flushed and
any commands that were inflight has completed with a flush error
completion...

Can you describe the scenario that caused this hang? When has the
queue became "gone" and when did the shutdown command execute?
