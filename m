Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED6DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB3721582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oBxBTm31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB3721582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeKPFiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:38:14 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34484 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeKPFiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:38:14 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so3619675pfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 11:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Eqc/Pon4MNVoaIo8PdTa/Xx833WtBJojuWOPFGIysf0=;
        b=oBxBTm31MjNMefXDlRqs0KFrhOFAfAjAZdxoPZxCVWw6K42TTe1XI9BRvSO8Pja7d0
         O/SQVY+8RFcoMoPFlo+V9GMXHopeZT/wx1Dr80j7z9Ob0GBrecQZfF5sK2bO+yexY/uz
         FNXchY7SE3evI9sGFeTpm1KlWzjCzkyck1lsUhRCR36viNdYvyzb5Tmsw2M/pJWtdEBF
         DqXihBsMBHml6qnaJET375kVKcISXuZv2+RqFDqU8bQSSvfw5Ndg4aPpNIGeHr4b0hW6
         GrUjVoii07AqRtAEBit0cqz/Q6jCjBZzn+MEbS9dGRAYEl7FlKMIsmRakb/YRUPE6quW
         LWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Eqc/Pon4MNVoaIo8PdTa/Xx833WtBJojuWOPFGIysf0=;
        b=psCYI1ZzT6siJa3XuDT90mkpOScw2Ebb1iB2KogSCzbr7BO2WPVifIvsnt0TLAUWuR
         d9OER7Est2oRhmNgwsUZfHzeuGu9u/diCc5aqXQQARF1jjrDu1byTJaFBpdTiCTTvAvJ
         hiQ3qPEGJScTHJPTMPn1vsGHMv2mpgamB3kp1iAXnBhti6P6neVICM7h/ImhYho2QOSP
         KGsUQbAoBNAoa7aDvmb3jZDU0PnefxvaNIe2/bvoP9mMBFS5ytu2trDID9Eb3pRhtsW8
         /qu64prvDHayH1GrnjjvhQr5ItFypEp+rF7nVOsoFjqu1Hr9gx0QypCISXrJuQAM9CgK
         HVzw==
X-Gm-Message-State: AGRZ1gI6a7gPvvUwb7AiPHQKYy32WfMl43ei1NTUgD9SPVb5IReyzYu7
        9mrlBnax/DK3yhcJ6ZCIa4lhRDEbYFo=
X-Google-Smtp-Source: AJdET5cc+yW/GBM5CZdp0qXqrbI1HDt+ZdFHe0tRejz2S/gnlmw99XuUvx8JgIn8IOslIYUOMlqp+g==
X-Received: by 2002:a62:1f9d:: with SMTP id l29mr7824538pfj.14.1542310147013;
        Thu, 15 Nov 2018 11:29:07 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::11f6? ([2620:10d:c090:180::1:7813])
        by smtp.gmail.com with ESMTPSA id v84-v6sm38179382pfd.182.2018.11.15.11.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:29:06 -0800 (PST)
Subject: Re: [PATCH] nvme: utilize two queue maps, one for reads and one for
 writes
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181115191126.GA16973@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e7f72ebb-68e8-29f4-121b-4053ec8b537e@kernel.dk>
Date:   Thu, 15 Nov 2018 12:29:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115191126.GA16973@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 12:11 PM, Guenter Roeck wrote:
> On Wed, Nov 14, 2018 at 10:12:44AM -0700, Jens Axboe wrote:
>>
>> I think the below patch should fix it.
>>
> 
> I spoke too early. sparc64, next-20181115:
> 
> [   14.204370] nvme nvme0: pci function 0000:02:00.0
> [   14.249956] nvme nvme0: Removing after probe failure status: -5
> [   14.263496] ------------[ cut here ]------------
> [   14.263913] WARNING: CPU: 0 PID: 15 at kernel/irq/manage.c:1597 __free_irq+0xa4/0x320
> [   14.264265] Trying to free already-free IRQ 9
> [   14.264519] Modules linked in:
> [   14.264961] CPU: 0 PID: 15 Comm: kworker/u2:1 Not tainted 4.20.0-rc2-next-20181115 #1
> [   14.265555] Workqueue: nvme-reset-wq nvme_reset_work
> [   14.265899] Call Trace:
> [   14.266118]  [000000000046944c] __warn+0xcc/0x100
> [   14.266375]  [00000000004694b0] warn_slowpath_fmt+0x30/0x40
> [   14.266635]  [00000000004d4ce4] __free_irq+0xa4/0x320
> [   14.266867]  [00000000004d4ff8] free_irq+0x38/0x80
> [   14.267092]  [00000000007b1874] pci_free_irq+0x14/0x40
> [   14.267327]  [00000000008a5444] nvme_dev_disable+0xe4/0x520
> [   14.267576]  [00000000008a69b8] nvme_reset_work+0x138/0x1c60
> [   14.267827]  [0000000000488dd0] process_one_work+0x230/0x6e0
> [   14.268079]  [00000000004894f4] worker_thread+0x274/0x520
> [   14.268321]  [0000000000490624] kthread+0xe4/0x120
> [   14.268544]  [00000000004060c4] ret_from_fork+0x1c/0x2c
> [   14.268825]  [0000000000000000]           (null)
> [   14.269089] irq event stamp: 32796
> [   14.269350] hardirqs last  enabled at (32795): [<0000000000b624a4>] _raw_spin_unlock_irqrestore+0x24/0x80
> [   14.269757] hardirqs last disabled at (32796): [<0000000000b622f4>] _raw_spin_lock_irqsave+0x14/0x60
> [   14.270566] softirqs last  enabled at (32780): [<0000000000b64c18>] __do_softirq+0x238/0x520
> [   14.271206] softirqs last disabled at (32729): [<000000000042ceec>] do_softirq_own_stack+0x2c/0x40
> [   14.272288] ---[ end trace cb79ccd2a0a03f3c ]---
> 
> Looks like an error during probe followed by an error cleanup problem.

Did it previous probe fine? Or is the new thing just the fact that
we spew a warning on trying to free a non-existing vector?

-- 
Jens Axboe

