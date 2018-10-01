Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35B2C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882D4208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="cIRkRGPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882D4208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbeJAS4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:56:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43068 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbeJAS4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:56:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id a4-v6so123752eds.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 05:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E41UMtMQq9iPtauKHLfE4KgGHiN671APeZaC9H2EG7w=;
        b=cIRkRGPXdzMJ6YWtYmFXLzHmGNpFhqNnF69GmSmXZwBK3n4OUxMpgzR14LnOOWoIIS
         K+ldBpCnFBxMuGK2oLLcpViL/49aTD29ZKm1Usy7MY7G4j7jZs4CRa5kejSmrgtTXm7I
         TNAF4VJ8tZT6xBi7pEx1ShvidZgfGbAwPBHhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E41UMtMQq9iPtauKHLfE4KgGHiN671APeZaC9H2EG7w=;
        b=TU+am/IKY73bGUXb6VHUay3iPALW5632C2o1uzSqzCcif0SmNTmvJL7On3AFusjTut
         tL0k1epsOCZbMeepLjpd8yWs9f+1Rva27LiWNEkw0+bkW/p/3RQnxS9Gykh080L+bo5m
         naVaKdolf9PIoB4m5TEEyv4VvKblgTHZInvQNk8oy+YEsvJbjui/IPoLUTrButAKWAJR
         pO5VqPlfPAaMDzvumlmsl6LVQ4Gs3HVeTR2IxWWKel5Q2FOITvqpiSMLqzl6qTbBmP1l
         kwwYurgZaJA8NMAGoxYpIqzwcl2B8RV+4Ztbs2UPTUJohOscCcGgdJzLyP0hatZfUDg+
         yb4A==
X-Gm-Message-State: ABuFfog+1EvRLlMWsvEOy8Auk7Q5LxD1ffqVP8HMznrs5/CYXK/UEcIp
        6sAQGQT4eQ00i4PMeX6fzS7KF5+G4VO2cQ==
X-Google-Smtp-Source: ACcGV60bkGixSTVGVmUlpo3mRzh4LACdLveLX45cZzS5OXESbZIqsUSdDVO3s4IjAiunuU9ikKt/zA==
X-Received: by 2002:a17:906:6812:: with SMTP id k18-v6mr10085783ejr.47.1538396356874;
        Mon, 01 Oct 2018 05:19:16 -0700 (PDT)
Received: from [192.168.0.189] (dhcp-5-186-116-96.cgn.ip.fibianet.dk. [5.186.116.96])
        by smtp.gmail.com with ESMTPSA id t44-v6sm5001655edd.96.2018.10.01.05.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 05:19:16 -0700 (PDT)
Subject: Re: [PATCH 0/3] Kbuild: Some fixdep tweaks
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180815142749.18804-1-linux@rasmusvillemoes.dk>
 <CAKwiHFj5yGtsR+s0Ukjy0Pe1pDpd_euyT0MRZdTt0H3ssXqYXQ@mail.gmail.com>
 <CAK7LNATmw1Tic2mDybRd-5CbZK_6J1+=3j31q8K9hONVoRHrdA@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0d8735ad-0672-3a76-d199-faf6717af730@rasmusvillemoes.dk>
Date:   Mon, 1 Oct 2018 14:19:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNATmw1Tic2mDybRd-5CbZK_6J1+=3j31q8K9hONVoRHrdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-28 04:21, Masahiro Yamada wrote:
> Hi Rasmus,
> 
> This patch set actually sits on the fence.
> I tend to choose not-apply when I cannot make up my mind.
> 
> If you have something more to convince me, please let me know.

No, that's fine. I agree that the overall performance improvement for
whole kernel builds is hard to measure, but that can be said for many
small optimizations. Anyway, as I said, it's up to you, so let's just
drop it.

Thanks,
Rasmus

