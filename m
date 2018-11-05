Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211DAC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D380120854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BwDJ6BHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D380120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbeKESa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:30:28 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44925 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeKESa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:30:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id j17-v6so3449739wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 01:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ZaoArPrTwYU4hI21Rt0EWf2M/5RvCoKRpba4MYaagb4=;
        b=BwDJ6BHthF7TMNlQsPCz6bgbiKLuNmzOMK2n0Ui7qvtP/tYJOcD49BX8zNT6nLlZ+1
         kGNOJ8ObUA5StkfGgnSfnFA/jMO55epnNPclj0LT7aAvCN2e6iUgteBSyD6LrSNEbfiF
         /3WQzzWdqPa3OwAUf6/k4hLEGwBQAnxqFUbwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ZaoArPrTwYU4hI21Rt0EWf2M/5RvCoKRpba4MYaagb4=;
        b=pVeSePANKf3tOD/K1RwmBqcGrzJhXILD6dvQ3eOZb1rbKo3jfz2PYJoEk055nMiXOh
         qOFRzDwBeEmy3w69rKeQl5ePXeb5NL9zknY7mOjXkmyVSbCjQDG7fZRFOJmDLmJyV/uN
         FWCaciF+BaljVq9NWvJaGL2hOazukQxk0D7GqS7MVgaR1gnsLUD/ejlSozb4dnDSTCxS
         4zQgxmDGV4Z3P/9472RWz8LPfQ2ePpyXr7FAGJTE/u0C5teirk+602arNTog+NEmgFoN
         W/792awkrRe0frMrCUPmlEnTXHIAxnVDPv0scd6SDxqw1Aw4xOJnicS7Pl2jJOwokOqg
         hf5Q==
X-Gm-Message-State: AGRZ1gItzHz2euVznByuaKnl+csxu+jpGHbdUGUYkB5bXZnhSjcH2apk
        x+yMnjasNIBkfP/SbX+uO8Eg7okLGJLfoQ==
X-Google-Smtp-Source: AJdET5fiqP7FzSHEWO/x9nnBWrz/2BcOoBq50gBNzJ9RuCd7M4BGIycXWjXshw0PKhcSsgDsbbhvmQ==
X-Received: by 2002:adf:fb4b:: with SMTP id c11-v6mr18093152wrs.117.1541409103326;
        Mon, 05 Nov 2018 01:11:43 -0800 (PST)
Received: from [10.176.68.125] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id i7-v6sm66453201wrb.30.2018.11.05.01.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 01:11:42 -0800 (PST)
Subject: Re: [PATCH 5/5] b43: Drop internal cordic algorithm implementation
To:     Kalle Valo <kvalo@codeaurora.org>, Priit Laes <plaes@plaes.org>
References: <cover.f21c8e62e188620d586edb3f77514e6237122c4c.1541238842.git-series.plaes@plaes.org>
 <51f98dbd0efe48c315d8e7876074aeaa22fde580.1541238842.git-series.plaes@plaes.org>
 <87y3a7gaag.fsf@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        netdev@vger.kernel.org
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <dff744c6-8256-cd52-dc69-37ea51106950@broadcom.com>
Date:   Mon, 5 Nov 2018 10:11:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <87y3a7gaag.fsf@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/2018 10:09 AM, Kalle Valo wrote:
> Priit Laes <plaes@plaes.org> writes:
>
>> Signed-off-by: Priit Laes <plaes@plaes.org>
>
> No empty commit logs, please.
>
> And IMHO you could fold patch 5 into patch 4.

Similarly 2 and 3.

Regards,
Arend

