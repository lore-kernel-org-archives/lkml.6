Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1B736C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44D62089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YxxvAIpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44D62089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934236AbeFLUjQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:39:16 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42136 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933609AbeFLUjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:39:15 -0400
Received: by mail-pf0-f193.google.com with SMTP id w7-v6so132747pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YbqbxpHXMgOkPcRU271b+k3+L5rs3L5sRIZwOsMJeUE=;
        b=YxxvAIpkLLIICjg29pLNyX7Sd8oItkSP7vayrx8w4iRYkJSi2NTFvmATOigxnxI+d3
         Y8pvUD+f0i0Xw1i7h1046G1zvabdPzK06eD0JfJ8dIOf9ZLSu1dhIFWGcGiyABg1/Yts
         FiEWgCTJUmPkt8yiR2VGL3CY1sAkdn/fiy3sU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YbqbxpHXMgOkPcRU271b+k3+L5rs3L5sRIZwOsMJeUE=;
        b=iwB6XjERSNWGOYq1RjtHS5KulybZlqDa1yFgZ/qxOAAhoyurHHrPZWCsXfbNcrYZpm
         GQJ50gDhMPZG9tna4Ifn/vFznm1mbmDYmvhiDn0B0oesOS3vO2bqV00lDLB3Ha+xVWxc
         w8sgwiFmQHvPjsqUTC288NQz4wXATHGMlHzHgY1K4j70wZNJd3AOMb5otGNYeX70uXQt
         H1AJQD6vGr/P9KohPqfQH82KpqwqG4NbtuZk24g19wQxHvzxWgdJCG0SsCrK64kpdW0P
         SE7gPAxguy4d6WjeZzIT7eYXN1YYmUBitwVJlukedht6hEz2RFiVZzFQ1F8a7qBc4cMy
         RkZA==
X-Gm-Message-State: APt69E0IC0AkdubSwGIiryE+3kKApTZYJSk89ZmWj67ojTgZkyhtdH2M
        aRBSmnfQSoI5YuAUSUV278wHDQ==
X-Google-Smtp-Source: ADUXVKKMutPIyFy9kCPdxaQg//QaHEYR/7b6NRSPAfrPrwCXuZAzN309fjCFN3dJxYscXbopCJGKiw==
X-Received: by 2002:a63:7f4f:: with SMTP id p15-v6mr1633026pgn.312.1528835954913;
        Tue, 12 Jun 2018 13:39:14 -0700 (PDT)
Received: from [10.69.55.99] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id t5-v6sm1138042pfh.32.2018.06.12.13.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 13:39:14 -0700 (PDT)
Subject: Re: [PATCH 4/5] nvmet: use atomic allocations when allocating fc
 requests
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20180515074043.22843-1-jthumshirn@suse.de>
 <20180515074043.22843-5-jthumshirn@suse.de>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <d9dfaf4b-62ba-de74-61b0-a5ca5705582b@broadcom.com>
Date:   Tue, 12 Jun 2018 13:39:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180515074043.22843-5-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/15/2018 12:40 AM, Johannes Thumshirn wrote:
> fcloop_fcp_req() runs with the hctx_lock (a rcu_read_lock() locked
> section) held, so memory allocations done in this context have to be
> atomic.
...
>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>   drivers/nvme/target/fcloop.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 34712def81b1..d2209c60f95f 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -509,7 +509,7 @@ fcloop_fcp_req(struct nvme_fc_local_port *localport,
>   	if (!rport->targetport)
>   		return -ECONNREFUSED;
>   
> -	tfcp_req = kzalloc(sizeof(*tfcp_req), GFP_KERNEL);
> +	tfcp_req = kzalloc(sizeof(*tfcp_req), GFP_ATOMIC);
>   	if (!tfcp_req)
>   		return -ENOMEM;
>   

Reviewed-by:   James Smart  <james.smart@broadcom.com>
