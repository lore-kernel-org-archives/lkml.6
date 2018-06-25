Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5CEC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01E426039
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01E426039
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965074AbeFYSvO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 14:51:14 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34416 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964944AbeFYSvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 14:51:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id l15-v6so13251367wmc.1;
        Mon, 25 Jun 2018 11:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ai3UErSE2HrtLR5xlIQP7TxlrXVVqmedYvwFLqB3lX4=;
        b=eCNXxAh8tvT6XRc5fFDld4vpJZjiUSW9zQoeQaqMLkqBZkWcguyQk4CDtzDvh0Ib7G
         wmCbCNQXr4f99S6oURX9WzUdSsMXVoQJry1hsrRJRyG4AJQJNkZKSKQj5IZOfYhQjtwu
         Kh72VeJm7a9z2m2n5igCaydzWCvCSbmeZWCyocaodPDrzhmUQQvVjdhFagp124XmJu7G
         MtIbvaaUixh8zbVQEj6NH9zBToxUkOPfTRtVsbCNUbc+5RNRHsWexJQfP72SKOwXuRxF
         /x0TdmeAXIf8KKIST/yKqU4oUdPGx0fcrgGrcHTIpV3t40uaIzoh6kFbodK5wm1Jr94g
         VYkA==
X-Gm-Message-State: APt69E0Opxz2NKrXBr5BY8zV+zgyZ7msg5LcNsiE7mPL3TLSxTmhuUq9
        KBv8GeSYRIhbNN2y1QBdD36yB3dL
X-Google-Smtp-Source: AAOMgpcvR9stc7meeUheiUhH9IwSH6jmkRlNpGhGpUhdwe0VfFMcpwbsdM5ol81o/TkeTDfaCv+3hw==
X-Received: by 2002:a1c:7141:: with SMTP id m62-v6mr1808772wmc.157.1529952670285;
        Mon, 25 Jun 2018 11:51:10 -0700 (PDT)
Received: from [192.168.64.169] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 14-v6sm921784wmh.8.2018.06.25.11.51.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 11:51:09 -0700 (PDT)
Subject: Re: [PATCH 5/5] nvme: use __blk_mq_complete_request in timeout path
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com, keith.busch@intel.com,
        josef@toxicpanda.com, ulf.hansson@linaro.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com>
 <1529500964-28429-6-git-send-email-jianchao.w.wang@oracle.com>
 <20180620143956.GA20950@lst.de>
 <42583ee2-fe9d-39da-b82a-38a27b03fdb3@oracle.com>
 <1817441e-6810-ed40-a8fd-403742818aae@grimberg.me>
 <cc93effe-8e97-d4a8-851e-33208cf837a7@oracle.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <80d1be8f-859e-5feb-a53e-c8be9c3e0213@grimberg.me>
Date:   Mon, 25 Jun 2018 21:51:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <cc93effe-8e97-d4a8-851e-33208cf837a7@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Given the amount of fixes (and fixes of fixes) we had in the timeout handler, maybe it'd be a good idea to step back and take a another look?
>>
>> Won't it be better to avoid disabling the device and return
>> BLK_EH_RESET_TIMER if we are not aborting in the timeout handler?
>>
> 
> Yes, that would be an ideal status for nvme-pci.
> But we have to depend on the timeout handler to handle the timed out request from nvme_reset_work.

Yes, so if the timeout handler is invoked from the reset, it should
simply set a proper failed status and return BLK_EH_DONE.
