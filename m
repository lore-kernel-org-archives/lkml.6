Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C36C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2432B20672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MyV8C+8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2432B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeLIOY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 09:24:26 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34816 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeLIOYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 09:24:25 -0500
Received: by mail-oi1-f196.google.com with SMTP id v6so7038518oif.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 06:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9l2Ypt9it1UDSDOXpZ8XxjCJ6XtWGFaSCksFQ49eel8=;
        b=MyV8C+8sTmfKiz7RQ8OsBqnzfBuNdICDzWnBYP8uQv2gjGWsr84kk/NIw1vBVUyedr
         BKdGOHG7SK4IBDJ8ytpTKATqusn9xkRLvUUWK5LECcRpY3pqaXGFYKye+uaSnYe2ihY4
         fEfpJdUMeOttjTEXq3Fk9WwUqWPQSdymDDkHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9l2Ypt9it1UDSDOXpZ8XxjCJ6XtWGFaSCksFQ49eel8=;
        b=TFLHMWPBQuchH8ZcRbV18kuTswlYhn+Ov4D+iN8fF/DzSlv04T1Dv+aAS+uqYPMc+7
         q19BTJjj7mz+L39lEMzzx4IGDhaP1V80z3feZ41lDxor0AWgHo1TErANEIHOWT+MyoIQ
         xElwUGx9eRoGTcPHu6C3VgmcYUREyj3LciwKMAPV7EEMPny3+ANi8cyQxQZrP1XCHpQf
         iJK49/qxvoMIk6M8/O4/DIJ4WomFIX5ivvtU4JdMSv3C0lkWTLu8nHtelJgMXR+guyjR
         NE3SS4fL8oAMtNz3Z7P5a8quGB+b6+SPpFi15ifn5SeY3vSgaVG/BhWScjvlt6lWsOQb
         D5ZA==
X-Gm-Message-State: AA+aEWaUORTKnw+N1fMjKH6/lXj7Me1KZnVPUy8PYmi4Pi6LXwxSXMrh
        JsTzmAY8UEI9puzloi+T+WsctVcgpS1d1Q==
X-Google-Smtp-Source: AFSGD/VYALGX6L0Twx1Cq1MRI0tuiC4ASvupfvYxumOh6Y1MHK6mUC97yxWYrc7p3hhIlAcobqXj9A==
X-Received: by 2002:aca:d509:: with SMTP id m9mr5338204oig.82.1544365464753;
        Sun, 09 Dec 2018 06:24:24 -0800 (PST)
Received: from cloudburst.twiddle.net ([187.217.227.243])
        by smtp.gmail.com with ESMTPSA id r203sm4148551oih.11.2018.12.09.06.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 06:24:24 -0800 (PST)
Subject: Re: [PATCH v6 02/13] arm64: add pointer authentication register bits
To:     Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave P Martin <dave.martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-3-kristina.martsenko@arm.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ef051a9b-d58f-07af-a446-4b7326ff9311@linaro.org>
Date:   Sun, 9 Dec 2018 08:24:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181207183931.4285-3-kristina.martsenko@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/18 12:39 PM, Kristina Martsenko wrote:
>  #define SCTLR_ELx_DSSBS	(1UL << 44)
> +#define SCTLR_ELx_ENIA	(1 << 31)

1U or 1UL lest you produce signed -0x80000000.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
