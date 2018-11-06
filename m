Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD339C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC9520685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC9520685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388949AbeKGASz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:18:55 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:40300 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388855AbeKGASx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:18:53 -0500
Received: by mail-pg1-f170.google.com with SMTP id z10so4041225pgp.7;
        Tue, 06 Nov 2018 06:53:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wowXkJrNNllE+wUt5dDaHT4PYvgFObX5kgKCtJkxZso=;
        b=NVE9v2iqwasf277v+NiviUHFf/YKolnryj03EK6tu0hHvPphHW4UH1aMtP+T2klws6
         xVt9UfCvsaeRHo7NQ9zP+33HZwCNBxIBW7lmWvB/c3JGF4ExMFD+w6MDTXlXp1wXOvZJ
         xRceGGIOt8M5GDhqtBYYM63s/uSmqsLi3FuLAgdSxB9mCAC3F/naDoAb7quYiYWX2v7j
         U5AtYBt/vf2N2S8ewVY30S9bGy3N/FUjmX9NGpydXtnHCxSf9YuKf3pcPeP8jcNbxAkd
         0u3L6AiExc6FVfJ3/0VRBK6v+AAKvBj6YGzgwOizbd4MdS2GoT5ew/SShIost4WJKtLK
         fc4g==
X-Gm-Message-State: AGRZ1gLUWtZi+cz+d/gnbbFeEoX2j7fBouzlkLj6jce/Jx+K0zg0srAv
        N/V8Z8u5UInk/ub7Cu8KwSc=
X-Google-Smtp-Source: AJdET5eDQ4z25L6kdZbC7qIcf8y66MuXMIGzNuQLAYJcupK3DD1uSQgp6jKJxrHwd9QCvAOYgQqdHQ==
X-Received: by 2002:a63:5a08:: with SMTP id o8mr23708759pgb.185.1541515998237;
        Tue, 06 Nov 2018 06:53:18 -0800 (PST)
Received: from asus.site ([2601:647:4601:5d98:fb3c:91c5:1423:24cd])
        by smtp.gmail.com with ESMTPSA id p2sm10210269pgc.94.2018.11.06.06.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 06:53:17 -0800 (PST)
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
To:     Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@fb.com>
Cc:     Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Sagi Grimberg <sagi@grimberg.me>
References: <20181105102301.9752-1-jthumshirn@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a97f3d77-d23b-b418-abce-2d93ed725bdb@acm.org>
Date:   Tue, 6 Nov 2018 06:53:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105102301.9752-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18 2:23 AM, Johannes Thumshirn wrote:
> @@ -169,7 +169,7 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
>   static inline bool __bvec_gap_to_prev(struct request_queue *q,
>   		struct bio_vec *bprv, unsigned int offset)
>   {
> -	return offset ||
> +	return (offset & queue_virt_boundary(q)) ||
>   		((bprv->bv_offset + bprv->bv_len) & queue_virt_boundary(q));
>   }

How about changing that expression into the following to make it easier 
for the compiler to optimize this code?

(offset | (bprv->bv_offset + bprv->bv_len)) & queue_virt_boundary(q)

Thanks,

Bart.
