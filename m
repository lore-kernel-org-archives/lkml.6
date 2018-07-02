Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0836C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E4125DC1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="W37IdbbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E4125DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeGBOW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:22:58 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55158 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeGBOW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:22:56 -0400
Received: by mail-it0-f67.google.com with SMTP id s7-v6so1466115itb.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=azMRHoLInUWIdz+nAR7Fx2nGwScHi8JPB58lsvATwco=;
        b=W37IdbbVgHNqCw16akFK2Ppg9F8PPCPx2wFxt73/AQv9Yr2iftiPz3GMX+/GB8sv0j
         ETDml1UQYkaNlndFOKGrWO3FGqGdxSocWGqvp3uthMqT073AJT/F9apylI9g/2vQ0m1F
         1LeYk9yIzMa2vvw4gXOCYcqsUS5ERPZYfpHPjrZHaN57d8i6O75n8CBEfNv6IQ17+hYi
         vtg0KwtflI5RZDKPTShdnB48S/Vgfgu/DClYBL4xUWbDZ98bPsQd2hG4OyrDUBoDbAT3
         FpwPfPasPuu3ti+GsCfvNmaCyxNUag8Q8SWT/mpWSi4k9mQv8hq0RM5ape1Plh8iCqh+
         XEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=azMRHoLInUWIdz+nAR7Fx2nGwScHi8JPB58lsvATwco=;
        b=Xwy31xu5mYRToi4evJfiUUuu/aN5zIYAR56vC91utKa8fTsbs+vs56k82yENDldwRs
         4bJGIIbFMz1wuT5lk8Iwgf/eO4AJw6mA4+RUmMZgzYI+vaEN6Geh7f6ACKysSrtTEQJc
         BuBC/Yth8SynRP4pB6dpxyOgVInSHz4B3kV7b4KJPeCAFR1ysy5vEqeQMdzvitfV75O+
         4B6hDUrS0ajeDX50zdMpcTf2lHH9PvkruL3NPhhJQv9h6tKtxBB/HnsDOraytknVmmbm
         MwvhshytSwSf2jAiuSONKCxLeT5QqcS67cP8hyJepDilsnYHldOt7vFbHkp45yzHC6Fi
         F6gA==
X-Gm-Message-State: APt69E2uzjadejGsE1FkP9g3U5QDQkSTtxfOo0xk7RPY8T2euG8ISvwC
        m9LlslfSZuFm7wfxVL84zFQSKw==
X-Google-Smtp-Source: AAOMgpfK3gCR6bLFfz3ST0bNEXnfeUojSee3mlce2NkbGJZDPotzU3XurwgRne0+gELov7sK7xKZ2w==
X-Received: by 2002:a02:9b9c:: with SMTP id p28-v6mr19893318jak.28.1530541376108;
        Mon, 02 Jul 2018 07:22:56 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t63-v6sm6768133iod.29.2018.07.02.07.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 07:22:33 -0700 (PDT)
Subject: Re: [PATCH] drbd: fix access after free
To:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>
References: <20180625093952.20220-1-lars.ellenberg@linbit.com>
 <20180702112703.GA10994@soda.linbit>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4a49baa0-f1fb-a593-ae11-443c8385494b@kernel.dk>
Date:   Mon, 2 Jul 2018 08:22:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180702112703.GA10994@soda.linbit>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/18 5:27 AM, Lars Ellenberg wrote:
> Jens, I had hoped you'd apply this "oneliner" into 4.18 already?
> Did you miss it?

I did miss it, applied it now, thanks.

-- 
Jens Axboe

