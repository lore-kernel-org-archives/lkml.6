Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776EAC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E36220846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ueyiyf0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E36220846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388577AbeGZTGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:06:31 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50741 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbeGZTGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:06:31 -0400
Received: by mail-it0-f66.google.com with SMTP id w16-v6so3962335ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 10:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YV4Iyf+zJjemmOtDJfblJDZkMbPxDyH8hNIs7mHje9g=;
        b=Ueyiyf0G8YmtIZg2aYY12L0eiUJ88k9aIa3XrUIdrDrt7901J1udCvHXCZnkmRMfnW
         +CAWu1faT3cxx7uwLJLyEWY54C9REWeWST1KQZUmtJo7wUfxIBQKDZakuqxRjARhwHgY
         xU8oj9192P0ZQeoPu9+94YTnJou8H5+2G2ddP3HK4qHOliikddbA83lylvmpbymkoDum
         D0O4gHK7py2ElSVb18VlNDLo/KKw/d8f+pBee8lZ4QzafvzYQ8HNKmpAoCazimwhzwhX
         oLnCI85HfSQwGvekoLOEYR+5IgRIM9uO0FgpnRD23lp3S0jYkXRvDbzTk8dDYKvqS0oD
         FG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YV4Iyf+zJjemmOtDJfblJDZkMbPxDyH8hNIs7mHje9g=;
        b=qMU1CesFCH1unzVhua//L6thbQT5K7bcgfregny7Pa/L4ASj4UtZw7I5T6cdK2zJj2
         Psmdxtng2BSMMhRyztyHY/Si8oykBD7Lrpf/f8OFiTKKTvN6FUfv8Nvz0yzyfJS6JHd+
         9uCX9ii28L08Ax4gossoANCKfVcgW0o39fYX59axwNklU2t3ZDA0IE/i25lmQHBZ9VBM
         EN2grzQliY6Jo6qVGymjTQgUMITVvcdooz16Kesj8Ca/9niT8zc8lHt/9LBrveXe2I4X
         AE12kZ3unOEFLHuBOXH/FGcWTVZ3zhQSGUn53CFC2oZBz3mWjWePNbnNUgPG1znzxpiS
         tg4A==
X-Gm-Message-State: AOUpUlE3ShVJBJKuAGEk9CyEl51TY80xZVpCQSjUImO0Kjybn55gnN+t
        w2Rhp7Q8B2Pf/6ZxWMduJQkvpw==
X-Google-Smtp-Source: AAOMgpdyZ/w2tPriXTY6YZDS+t0aa5Ts6tYePBKl6JIVT9GSShGNCo3NW98VibkRj+Kj7IumZMO1WQ==
X-Received: by 2002:a24:6b15:: with SMTP id v21-v6mr2846575itc.52.1532627319091;
        Thu, 26 Jul 2018 10:48:39 -0700 (PDT)
Received: from [172.19.131.53] ([8.46.76.29])
        by smtp.gmail.com with ESMTPSA id 84-v6sm1263410ita.35.2018.07.26.10.48.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 10:48:37 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the block tree
To:     Christoph Hellwig <hch@lst.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Wise <swise@opengridcomputing.com>
References: <20180726145624.13a604ed@canb.auug.org.au>
 <20180726084833.GA23310@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a65a6023-a527-b9c6-0d78-a175d47f55cf@kernel.dk>
Date:   Thu, 26 Jul 2018 10:48:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180726084833.GA23310@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/18 1:48 AM, Christoph Hellwig wrote:
> On Thu, Jul 26, 2018 at 02:56:24PM +1000, Stephen Rothwell wrote:
>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index 86121a7a19b2..8c30ac7d8078 100644
>> --- a/drivers/nvme/target/rdma.c
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -891,7 +891,7 @@ nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
>>  
>>  	inline_page_count = num_pages(port->inline_data_size);
>>  	inline_sge_count = max(cm_id->device->attrs.max_sge_rd,
>> -				cm_id->device->attrs.max_sge) - 1;
>> +				cm_id->device->attrs.max_send_sge) - 1;
> 
> This should be max_recv_sge.

Why do we even have this conflicts to begin with?


-- 
Jens Axboe

