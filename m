Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C7DC9C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7916E208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzqbtLyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7916E208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935265AbeFMRsK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:48:10 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37916 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752349AbeFMRsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:48:08 -0400
Received: by mail-pg0-f66.google.com with SMTP id c9-v6so1630032pgf.5;
        Wed, 13 Jun 2018 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eU+SVvVnYtc6vKfyLz1kM4XOUXAbrMS7u8BCEMVSm7s=;
        b=XzqbtLylqVnMYPC1L4rFOldZtPDdpAOrzo4EXjiP9kaNrKh6uMFpuZQSHTXBpbTlV1
         Ynes1A6vSTALOcpmkIUr1VyuqkvdjI6XLjKMr63rfcIS1Q1jIL734/8yaC6XqQusLqjo
         m+tB7w8iOwhdjoy4U7EU1u1lDs+PX+/CsXUmXXqwqOZ2jUZwq5eaMNPC6tUV6Kg/mD9V
         UN3lWI2fq2P9JHJv9K+eJAthlHtggR73v/CFXG0DYDjpdIS5x5d4ipydJAfpdnAm9TDj
         qLSs294K8156BMcnmeXEY2nKkJ22oyPG/F4bAP/bkkJcNd8bwOBSgWI0Ht5c/lWqX70R
         MQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eU+SVvVnYtc6vKfyLz1kM4XOUXAbrMS7u8BCEMVSm7s=;
        b=qMujhRmTX23B74lZtDXAg9kXGYOO5dvRltArXxK0o6noKJ5iAywLJTLY7as4m2vWoD
         K21AXV5tb8apnH43FZspX65zJwZjXdodJ3omCvRra39maqMa1kHgR0VmJVunadHItMQI
         dTphaLnKNxMJh7vbibZNPPh4FCFR2VlT4/638/NNsGgKvwV3RTMldG3X+7DoLy5yah6M
         ooMSNGTiozz2OEju5aoaUL0Q2ww/qgYZy1EnVq0t/BKkQ55DWFaIdmkrEx4DMWakMoUN
         1DH8RaaG/U1KdfXdxQeVGQimJmGHUyfWmYBQ6cNMRqrWhlF5IJPuDl6E3LsBW27MIDSA
         SlwA==
X-Gm-Message-State: APt69E1vjgC43ZtCkIj67E7bDCfrl76RGxD/2xzI6/RagY09tue4Ke5g
        6q/bSN3rge1Pxj2w3JKuK4vLjS3N
X-Google-Smtp-Source: ADUXVKJE2UWxX3gtQexl/lgvZlGjTn817rSoeqLXHGUCD+ooQv3/amZKct5FoUytvD8BQNA9Pbq2qw==
X-Received: by 2002:a62:9419:: with SMTP id m25-v6mr5883211pfe.120.1528912087916;
        Wed, 13 Jun 2018 10:48:07 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id w1-v6sm3812767pgp.3.2018.06.13.10.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 10:48:06 -0700 (PDT)
Subject: Re: [RFC PATCH RESEND] tcp: avoid F-RTO if SACK and timestamps are
 disabled
To:     Yuchung Cheng <ycheng@google.com>,
        Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ilpo Jarvinen <ilpo.jarvinen@helsinki.fi>,
        linux-kernel@vger.kernel.org
References: <20180613164802.99B89A09E2@unicorn.suse.cz>
 <20180613165543.0F92DA09E2@unicorn.suse.cz>
 <CAK6E8=eCOLU9AX0+bSrOg_UYBm1mFxrGT=ybksba9B0OUfp7jg@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <4cc1a197-abc0-8785-fb79-79e99bc25980@gmail.com>
Date:   Wed, 13 Jun 2018 10:48:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK6E8=eCOLU9AX0+bSrOg_UYBm1mFxrGT=ybksba9B0OUfp7jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/13/2018 10:32 AM, Yuchung Cheng wrote:
> On Wed, Jun 13, 2018 at 9:55 AM, Michal Kubecek <mkubecek@suse.cz> wrote:
>>
>> When F-RTO algorithm (RFC 5682) is used on connection without both SACK and
>> timestamps (either because of (mis)configuration or because the other
>> endpoint does not advertise them), specific pattern loss can make RTO grow
>> exponentially until the sender is only able to send one packet per two
>> minutes (TCP_RTO_MAX).

>> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> Acked-by: Yuchung Cheng <ycheng@google.com>
> 
> Thanks for the patch (and packedrill test)! 

Yes, thanks a lot Michal.

Signed-off-by: Eric Dumazet <edumazet@google.com>

