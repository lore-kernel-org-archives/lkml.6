Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A2BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EE620672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TMywv58c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EE620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbeLJUWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:22:07 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34368 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbeLJUWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:22:06 -0500
Received: by mail-oi1-f196.google.com with SMTP id h25so10135263oig.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 12:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ITwyA1ilb+xLe3ITBXhrAEwj01XyjVw7cJczqLzd8aM=;
        b=TMywv58cDbyz74X2fVktWd9KNCIRxRjGMPZmKnDO798MrBSj6XII/IBrgxmHv14eAW
         yHUfciBPAIKUi9mvcUWWhEQOAR841wLQnXntoCktGmT5IGKVf9WTcpmsKOu2MozV37u8
         EBs1tGzyidWTJ0Qt4j+g0NfHREb+gA0TQw9UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ITwyA1ilb+xLe3ITBXhrAEwj01XyjVw7cJczqLzd8aM=;
        b=K4C0KiB6AZG6aBkWnwzhWeU16rqq2BfXQEmhXDInCOtxgwYHTGT4QDxxPww9/LkxZ/
         mB4kleaq5Opw+LFweUl/sU1R2+0O/FJN/FTxkXlb4uN5XMuNQNfxARFhi8NuHIi72FLu
         30zjYu9r4KdfG59Q0HDoGBcXoblrGY15pU8RcCWO9ZcXXxbKT941qvjEWLOAetmHsDp9
         yjPoez0rh6b4IPJ0+8e771chA3ZgLNxM3M5M3ILtSz5O0tLRKVR4BKxpw2AgLRRnZb+L
         n8tHbIGxz/xM3phEOWE0ptA7Dl0/IRTiYYEcR8RB2bZ5qSgBwm7ZnzpsR9ZVG8C4G7lZ
         i6Rw==
X-Gm-Message-State: AA+aEWYgHjBRHKRmkbMpM0IxYyVdH/UrvuFFDKCvrCoT/3KVXGqpmsS1
        Rvw3NaJdXdmEsBUKDm1RQRCUxZO4n5eq4w==
X-Google-Smtp-Source: AFSGD/XIhsFJ2ATcmbuiOaS801akNcbIUkx/pmV001ZKV9jnbnfOH/yiKG6qYpcgprUKOxz6/N2A6Q==
X-Received: by 2002:aca:4a56:: with SMTP id x83mr7843904oia.11.1544473325046;
        Mon, 10 Dec 2018 12:22:05 -0800 (PST)
Received: from cloudburst.twiddle.net ([187.217.227.243])
        by smtp.gmail.com with ESMTPSA id l1sm5864845oib.10.2018.12.10.12.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 12:22:04 -0800 (PST)
Subject: Re: [PATCH v6 04/13] arm64/kvm: hide ptrauth from guests
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Adam Wallis <awallis@codeaurora.org>,
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
 <20181207183931.4285-5-kristina.martsenko@arm.com>
 <57966497-d21c-5439-e4ba-d75f5552282f@linaro.org>
 <a2eb07e5-6663-aede-fb75-cc91cf3fffa5@arm.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1f179017-4237-0d36-7adc-0a1470b5fd46@linaro.org>
Date:   Mon, 10 Dec 2018 14:22:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <a2eb07e5-6663-aede-fb75-cc91cf3fffa5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/18 2:12 PM, Kristina Martsenko wrote:
> The plan was to disable trapping, yes. However, after that thread there
> was a retrospective change applied to the architecture, such that the
> XPACLRI (and XPACD/XPACI) instructions are no longer trapped by
> HCR_EL2.API. (The public documentation on this has not been updated
> yet.) This means that no HINT-space instructions should trap anymore.

Ah, thanks for the update.  I'll update my QEMU patch set.

>> It seems like the header comment here, and
> Sorry, which header comment?

Sorry, the patch commit message.


r~
