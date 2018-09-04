Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25C8C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA2720843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="cyypuamq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA2720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeIDOe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:34:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34819 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeIDOe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:34:28 -0400
Received: by mail-lf1-f68.google.com with SMTP id q13-v6so2487827lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sz6cG9Q2rP/pNkDJHqBSVjeSHUoo5LN6SR56wudLhis=;
        b=cyypuamq5ko0MPzm0tgXe48Ojbtko9ziKjX4GZeDgnTV07lnF8pZuXfVMcASXvNAkw
         /sMQKrHbKzsXboIb6NdF6eoFJI+Qqz3hax1wViB+jSkikIMvA3EyPRA/zUCM4MjJ6gAm
         dBEawMttylzYNxnsDPUZb+p0Y51sVfDKkYH9dke4q0Qy4PeGQgVHwXdf4JPcJPccHTGm
         YsIkWPVD6/lF2Okkia6Hu5g5RVxB8c6phTQTw8R+/zxmN7oPfJxHHsZM9qJpfZibsW/D
         E9sbIOYmUUDPVBChWjHnPqJHwDiBmBlEpQcGiYA5T1OSXGKXjlSIi7Gat/m6iD4beuDR
         IuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sz6cG9Q2rP/pNkDJHqBSVjeSHUoo5LN6SR56wudLhis=;
        b=cQ9GZzK97Y8WwH6X4Qx5KBGDjWdEKQ80yu1tNefEgpbGtpjJoplZqkQJNlON4wLhCf
         i4uJHMCjJ2F6iVBcWPzb5uNVfjbH+RgYSVt0+bk8XO+822EbVpE1BouOywo8iWA7ch+6
         uehiGqbMr6/v1Lwl8cTe/PT0Wcka2dN9uH3DMbL+7gAnzlrIdYQqv/i5hexkz5ipdYK1
         +xaI3cJ15coabFEhfTcmXa/JeEzhSkwCyXbiBYGoWtZtu71Gufq+vCltzCEcbiB4l8DW
         T8rUnp7C8stYarl+G4ruF3RvTiHti7VIyFvuS9xSRMVpYupChFQghDDQ2QaTfD1Er+11
         C+OQ==
X-Gm-Message-State: APzg51DkAECKmGE9ng8lEpTeb7ZgiCCaCCBWnf3B59SH9zrKl2AI1R5R
        xy0Te4Wom8DeZbb79XfJg9RgIQ==
X-Google-Smtp-Source: ANB0VdaOJ4EVYgFXe7ebyuQ7AgRywbp/osINw0yDLtfOoqE9q1FZXP2YqJ9WNZ9TmesFnpGznUMJfw==
X-Received: by 2002:a19:1dcf:: with SMTP id d198-v6mr19565617lfd.144.1536055801881;
        Tue, 04 Sep 2018 03:10:01 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id m8-v6sm3917896lfh.25.2018.09.04.03.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 03:10:00 -0700 (PDT)
Subject: Re: [PATCH 2/4] lightnvm: assign block address before slba
To:     javier@javigon.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
 <1535722477-31288-3-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <daf2443d-8d31-359e-02e7-f553eeca7b73@lightnvm.io>
Date:   Tue, 4 Sep 2018 12:09:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1535722477-31288-3-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018 03:34 PM, Javier González wrote:
> In 1.2, the chunk slba is set to the physical representation of the
> block. Thus, assigning the block to the ppa must occur before the slba
> is assign.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index e9f14c67f4f3..efb976a863d2 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -945,6 +945,8 @@ static int nvm_bb_to_chunk(struct nvm_dev *dev, struct ppa_addr ppa,
>   			}
>   		}
>   
> +		ppa.g.blk = blk;
> +
>   		meta->wp = 0;
>   		meta->type = NVM_CHK_TP_W_SEQ;
>   		meta->wi = 0;
> @@ -952,7 +954,6 @@ static int nvm_bb_to_chunk(struct nvm_dev *dev, struct ppa_addr ppa,
>   		meta->cnlb = dev->geo.clba;
>   
>   		if (blktype == NVM_BLK_T_FREE) {
> -			ppa.a.blk = blk;
>   			ret = nvm_bb_chunk_scan(dev, ppa, meta);
>   			if (ret)
>   				return ret;
> 

Thanks. I've folded 1 & 2 into the bb patch.
