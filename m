Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C375C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236422152A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ByGzEMvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236422152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbeI0Uov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:44:51 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42791 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI0Uov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:44:51 -0400
Received: by mail-io1-f65.google.com with SMTP id n18-v6so2066886ioa.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jx/Yw2jAwCRr+817KCbU5DlwUdU/0vB+9VGXL3ZqI9c=;
        b=ByGzEMvsL8rR8IpG0SeGS0I57qBvj55a4WNy+e9kObpHnka4q7NaTuaMZZTiwqIbT2
         Hf5UNGWrH/Q3C5tE0ANbPr2fX5QhpL+SuX5ko0X697T99pc09oZ/hWPWozuUaP2BAUuI
         OvTNG+gwGdGcJvxoUamAY7atADgE7vUP1J3nINVlfT3Icota7UcEu8mBR/zJsKRcWBIv
         jNHlXyvDj0rnO/90Zh9DyorcRkdi5s/zpmC0/kPX9gN/K63MOxRDrqss0tP9suErCOLi
         SHD7mauE0M94dAxpE7hxBVMMOx3RLme0GmgP3X4bIkCJgFs3XK9bRFU4gOyXcV0twpvI
         tX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jx/Yw2jAwCRr+817KCbU5DlwUdU/0vB+9VGXL3ZqI9c=;
        b=Y9y01PvveYtaGX0aV8DvsePeTPgrplvWTwykmAjMM+RXjL3QiaortBbh4DlNetbjm2
         LvFnzYdl5j7EP05XEzRqAzOqm59zhzqSaY7WQMJVt4Cj1R97Thmkfgu8S6UoOyXeq/1p
         iHJAx4NcntTFwmy/m+Qr3jhDRIXAnVb7a2ueFNmPEIPWE6MVlIa0vxo/CdZfy6aN38Xh
         Zex7Fe0p72Sd60BJyir6smYntbBsZhoy8JlpetzcAXwgDd1C7KUmZBsTU6rKO/lz4WGi
         CeEh7Y8Tmr3HZFLIEWBXs08c5u9+wKE8gKtHU8w8TRAbXiycHWdzZBxHW+wgBbWH/xEs
         d/cA==
X-Gm-Message-State: ABuFfoiB9VO73llAfRjbEUoYuBhSAfbyWL+kvVXm7ZZ/PfNi3xAON/+k
        SqyTzFtD4eaJ1M2MDwcOeD/tANh9PC8=
X-Google-Smtp-Source: ACcGV60t+A0GUKDyzsNcWPD2IRpVgDCnCjrJtRRaXn9kmYDWPw3UkA/9ZI2j868G19weaGJi+uWsdw==
X-Received: by 2002:a6b:7c4b:: with SMTP id b11-v6mr9219811ioq.251.1538058378709;
        Thu, 27 Sep 2018 07:26:18 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b28-v6sm1161899itd.37.2018.09.27.07.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 07:26:17 -0700 (PDT)
Subject: Re: [PATCH] xen/blkfront: When purging persistent grants, keep them
 in the buffer
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        konrad.wilk@oracle.com, roger.pau@citrix.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20180922195549.27953-1-boris.ostrovsky@oracle.com>
 <28aa9249-7406-21c6-f509-65411828e2d7@suse.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5bd1a695-50c6-e79f-38dd-c980fc2138ad@kernel.dk>
Date:   Thu, 27 Sep 2018 08:26:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <28aa9249-7406-21c6-f509-65411828e2d7@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/18 1:12 AM, Juergen Gross wrote:
> On 22/09/18 21:55, Boris Ostrovsky wrote:
>> Commit a46b53672b2c ("xen/blkfront: cleanup stale persistent grants")
>> added support for purging persistent grants when they are not in use. As
>> part of the purge, the grants were removed from the grant buffer, This
>> eventually causes the buffer to become empty, with BUG_ON triggered in
>> get_free_grant(). This can be observed even on an idle system, within
>> 20-30 minutes.
>>
>> We should keep the grants in the buffer when purging, and only free the
>> grant ref.
>>
>> Fixes: a46b53672b2c ("xen/blkfront: cleanup stale persistent grants")
>> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>

Since Konrad is out, I'm going to queue this up for 4.19.

-- 
Jens Axboe

