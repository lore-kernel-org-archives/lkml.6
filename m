Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33E0C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F162084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F162084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeLLGtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 01:49:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41120 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLGtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 01:49:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id 70so7875340pgh.8;
        Tue, 11 Dec 2018 22:49:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Aaoyp8TSXz/xL4gAZloCtKAYRkqodqOELccKZZnTGI=;
        b=r827pElaSc3jR4n6c1NEKKFgMLsbVbxK3wQuEZ5lTEtI3yYPdymxQ8a4RgS5aW1e4H
         Psnky9UTfg2cdG3reFiFQV6yiirNGdG50rni/x8KXewJjVnKKbvYSU1RS+GYDffQur5M
         Aqxltcth4V2HfY51SBso3SBey+EQJw4ukm0wo8BH8PdcHx2UX32kUXWE+buHGCF/9cA3
         vc1PDsVfOn6RchmWzTCsNGfuxBqbqT3SHRcCB5FQ86x01Bc5rrIoJGZG0Uf+MLy/fvn2
         JgT5giUd67zvg2cEvDIAOPjNEZdmWusJ2hj0BRqA/sOK5oDfI9YUuVQ64poJ1w6kz3oa
         7GmQ==
X-Gm-Message-State: AA+aEWbwaWpf/9tQxWBp5/ds7a3fg75x3w8ytzOhJWnQmyAdVhsJis+6
        H51yDvTpFT7FAir0fm0yGnn6OBD1
X-Google-Smtp-Source: AFSGD/VaU0Mr9NpB7+WCUrJ9C3xNqnWpDDs/2MmGHGnBr4T+aghS1kEDiZZRQTMqN3dffDYKXM1Nsw==
X-Received: by 2002:a63:b218:: with SMTP id x24mr16796574pge.223.1544597358971;
        Tue, 11 Dec 2018 22:49:18 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id h82sm42104847pfa.105.2018.12.11.22.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 22:49:18 -0800 (PST)
Subject: Re: [PATCH] scatterlist: Update size type to support greater then 4GB
 size.
To:     David Miller <davem@davemloft.net>, amhetre@nvidia.com
Cc:     axboe@kernel.dk, ulf.hansson@linaro.org,
        herbert@gondor.apana.org.au, mmaddireddy@nvidia.com,
        Snikam@nvidia.com, adrian.hunter@intel.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        vdumpa@nvidia.com, linux-crypto@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
 <20181211.222950.1995970751331458343.davem@davemloft.net>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5f70fc16-e3cd-37c1-e7ed-e131ad79d387@grimberg.me>
Date:   Tue, 11 Dec 2018 22:49:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211.222950.1995970751331458343.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>   struct nvme_sgl_desc {
>>   	__le64	addr;
>> -	__le32	length;
>> +	__le64	length;
>>   	__u8	rsvd[3];
>>   	__u8	type;
>>   };
> 
> Isn't this a device or protocol defined datastructure?  You can't just
> change it like this.

You're correct, we can't...
[Replied before seeing this issue was already highlighted]

The positive side is that it can safely be removed without affecting the
rest of the patch...
