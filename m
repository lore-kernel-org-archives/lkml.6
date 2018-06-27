Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80825C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BCE25EDE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F+7z1qmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BCE25EDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965471AbeF0Qke (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:40:34 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39272 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964784AbeF0Qkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:40:32 -0400
Received: by mail-qt0-f196.google.com with SMTP id b20-v6so1592331qtp.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iW5feYO/YqMxFQgYbF6rhcKQI8eGjFXMAs6sYYPdnTY=;
        b=F+7z1qmMXz1g0EhJ6Gpv5zUvdI5dmhvmAw+mHg0ecZ9G4DtAqT9V2wr70oLkGNPorx
         t1evY4WY4DyqwZq2AoIw9QcSNPQq7H1zJj0iGfxLozjNBEArRF7soP0jbZPGE747Btx7
         SHnp2ZWMifxF7Yolho+ZuKogTZ5hLiC279N+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iW5feYO/YqMxFQgYbF6rhcKQI8eGjFXMAs6sYYPdnTY=;
        b=h1uF2ANlFRQJQIMzY2Ov0M83/4pkHJAmQqGAQ+2Q9jEsEUqkguL5ShL4H1lleFdPWm
         vpDZcxWNy77+0eUJrpU/4k+mTx0jntjQjoIRCjjK0rvLtrwmb6z5Otjg9wo4gGP4fN6k
         jAKYA2dic/2468qVMCoJ3NMZ2Qz3PbwEkKyWUxRkeGrjAqgzU7cj9hgb5SMBMXu4JGpY
         jkhiqAGJSyMP5/JHZtDIlOmui7IMgzM1pwMmaTgXG/l2MTRfr2AVzebj7vT9QlrJAO/m
         rADbFuyNafZowAt6PLJHOy3LXVq2tvW5qOiKfZL4Pe8Xp7jMoC0wVuy4PmkZFeno84SJ
         qkTg==
X-Gm-Message-State: APt69E1mx5VSO3MCG9ODh49YeEipKkNMUUe55t5QleZ1ClXfWrnp7KfT
        G/ndoi4/QYaSdatLBjEJN2axD7jh/24=
X-Google-Smtp-Source: AAOMgpf85GKp/gLK1iVqmwNwoWLfR7uzO64FXeEWScc3eAiIzGXwHt3J35/N63GxDVkW/NPwLJWl2A==
X-Received: by 2002:aed:21ce:: with SMTP id m14-v6mr6240502qtc.292.1530117632175;
        Wed, 27 Jun 2018 09:40:32 -0700 (PDT)
Received: from [10.75.249.192] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id o71-v6sm1845879qki.55.2018.06.27.09.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 09:40:31 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] nvme: cache struct nvme_ctrl reference to struct
 nvme_request
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
References: <20180627125324.22064-1-jthumshirn@suse.de>
 <20180627125324.22064-2-jthumshirn@suse.de>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <7233e4f1-eee9-9849-be44-604aa11fffb3@broadcom.com>
Date:   Wed, 27 Jun 2018 09:40:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627125324.22064-2-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/2018 5:53 AM, Johannes Thumshirn wrote:
> From: Sagi Grimberg <sagi@grimberg.me>
>
> We will need to reference the controller in the setup and completion
> time for tracing and future traffic based keep alive support.
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>
> ---
> Changes to v4:
> - Move caching from nvme_setup_cmd to .init_request (Keith)
> ---
>   drivers/nvme/host/core.c   | 1 +
>   drivers/nvme/host/fc.c     | 1 +
>   drivers/nvme/host/nvme.h   | 1 +
>   drivers/nvme/host/pci.c    | 2 ++
>   drivers/nvme/host/rdma.c   | 1 +
>   drivers/nvme/target/loop.c | 1 +
>   6 files changed, 7 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e541fe268bcf..99dd62c1076c 100644
>

good for the fc side...

Reviewed-by:  James Smart  <james.smart@broadcom.com>


