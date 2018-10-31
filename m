Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017CEC6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66352082B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66352082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbeJaJ0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 05:26:53 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:41134 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeJaJ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 05:26:53 -0400
Received: by mail-pf1-f182.google.com with SMTP id e22-v6so3669747pfn.8;
        Tue, 30 Oct 2018 17:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lpJF+lkYOlnZdp/3ozTJkPI4wjEErififBV3Fle9JMc=;
        b=Z9rGKSEq71HvGoMpOUy7aNVay/sJKt5dJEtUOFmJGbf0sS6lWSja7/wCRSwiDc1qz2
         wsC/Ub4I0IgtSa704pnRq8yLyh1LGtUi+vLxhKOmcJgb1psPZwtVQ7g5DyW/dFa26ufJ
         O8txWlzRBOuogwiJWs35i1i9h+Um4IMgnrceF0rjXxKYjzkEryfLL4q3GkahmeFuKbbq
         LfWMFtcNp+XkXbrIFYJcsPTOwNgnnffRy1JC+QNlc4TUfauYuWiW98SpUhmIY771gQjV
         zYEAjNQEuS+ZxGSeF7nArypIazBu+TjVnnOXy1N75vh+R+wLyc/lIXIsyygXV6A2t+wH
         MQiw==
X-Gm-Message-State: AGRZ1gL7uTNLbCtODBU+0hxjwOqZu11x++4scMzGsbl5osXuBBBtXL70
        VPog10jf6WocvxKWBl8Y+g05Z1/7
X-Google-Smtp-Source: AJdET5c9HX9oWMHMREsWjqb+/gnqVShmEZmI72N0shV6/6JAoK/31ht1Tbd1NlCzQbJ+mlMNxPtd8Q==
X-Received: by 2002:a63:3dcb:: with SMTP id k194-v6mr885189pga.191.1540945869982;
        Tue, 30 Oct 2018 17:31:09 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:e9fd:d0f6:3e3:43a5? ([2601:647:4800:973f:e9fd:d0f6:3e3:43a5])
        by smtp.gmail.com with ESMTPSA id t3-v6sm15613516pfk.59.2018.10.30.17.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 17:31:09 -0700 (PDT)
Subject: Re: [PATCH 02/16] blk-mq: abstract out queue map
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-3-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <725b4d35-2390-58d9-4041-0bac6de6cd77@grimberg.me>
Date:   Tue, 30 Oct 2018 17:31:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-3-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -41,12 +41,12 @@ int blk_mq_rdma_map_queues(struct blk_mq_tag_set *set,
>   			goto fallback;
>   
>   		for_each_cpu(cpu, mask)
> -			set->mq_map[cpu] = queue;
> +			set->map[0].mq_map[cpu] = queue;

Any reason not to change the signature like the other mappers?
