Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2481EC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8CE2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K/3Dm0am"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8CE2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934558AbeFLUg1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:36:27 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39625 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933175AbeFLUgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:36:25 -0400
Received: by mail-pg0-f65.google.com with SMTP id w12-v6so122152pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LHo7fBBHDOTFCj5I1ZWDwsAXRQe84Ak97YbUzlqS5YQ=;
        b=K/3Dm0amJOrn/mtbLNYpnWJdoWoNEe9AsA9Uak9Ajs7N+tznZPMtulJ4SVTcnGy/mM
         fhbi0OVIOOwazbLEicCNbz36HRZYJYPrr+UUcsJsdEn+hrrHBJxiJtfx6RHtDJ6z1p1w
         V5zVLNtcfbRsbbe0HN2Rg3neT6S9WAYpdFvGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LHo7fBBHDOTFCj5I1ZWDwsAXRQe84Ak97YbUzlqS5YQ=;
        b=g1RYLNc8OVS5JKvbBdYMoGLoZJWKe3dV+NmDVPATJyAecKa5+narCe1aYm01zc8HWn
         7SiT14F+5KJH3Mrc7LjG1LF2HGJR2FeJ0/1eWqrviggQN8DaNjejIWNKBAcQhLnDjH71
         OPDYjJNKSpbaaJ91vp/JlWZoC3vNrRraM8evxLgz22oPwGC8NxBzKC0qJ7E5tEfypxJq
         i8a/Dye1CZX2e0RwdVAaJ0/daO4n9C+MymbFErCGdzlBZDihUZxW1+ohboLpCe8hm9/2
         rfCLdbwlwRqcwNQdNEp6xfePnE5N9RSqg+Tq38/A096IzoKYouDrB1R3Xhq2V3JwgQgy
         TzUg==
X-Gm-Message-State: APt69E049by6C4MLDU9zZ6WlSnpNYLA75fkIoDy+F6xd2x8DE4cd641r
        MDLNEAld9yqr8LbvMJvVJBk8JqVE0Cs=
X-Google-Smtp-Source: ADUXVKKRk2MlQlXNfnDnoXTPcZZJOYOrXyCr8aYX//NLzvfqQxo2lfG+qzXELcf0dA/GbW45AQ7tQw==
X-Received: by 2002:a65:5807:: with SMTP id g7-v6mr1582459pgr.259.1528835785165;
        Tue, 12 Jun 2018 13:36:25 -0700 (PDT)
Received: from [10.69.55.99] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id r188-v6sm1073387pgr.78.2018.06.12.13.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 13:36:24 -0700 (PDT)
Subject: Re: [PATCH 4/5] nvmet: use atomic allocations when allocating fc
 requests
To:     Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>
Cc:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <20180515074043.22843-1-jthumshirn@suse.de>
 <20180515074043.22843-5-jthumshirn@suse.de>
 <3c91cf45-aa85-e1a5-6d25-5654131626dd@grimberg.me>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <9331096f-8e5c-d029-e41c-96d5fa8b14fe@broadcom.com>
Date:   Tue, 12 Jun 2018 13:36:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <3c91cf45-aa85-e1a5-6d25-5654131626dd@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/2018 2:31 AM, Sagi Grimberg wrote:
>
> Question, why isn't tfcp_req embedded in fcpreq? don't they have
> the same lifetime?
>

no they don't.  To properly simulate cable-pulls, etc - the host side 
and controller side effectively have their own "exchange" structure. 
tfcp_req corresponds to the controller side. The lifetimes of the two 
halves can differ.

-- james

