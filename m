Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A318C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 15:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0262420865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 15:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jr5msybb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0262420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbeLIPlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 10:41:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36973 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbeLIPlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 10:41:37 -0500
Received: by mail-ot1-f65.google.com with SMTP id 40so8170120oth.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 07:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KDIGYHKNMtE3j4moEPlaO/mHBiOVfDpfNQGNkGsMr6c=;
        b=jr5msybbQPH8aGCVuHeZCYGs098eCgi6wlCl4iFdq4H+rmDoNZxeZsahBvwCDYYS2l
         06sJaI+HaiBy6deSj8XPr2g/po7r95kx711acIUqPANomGQzTo3W454SfEGZwpE2Alem
         zcU3rbzpUb3M1LLi/pwx16wm2W38QhQmVwXwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KDIGYHKNMtE3j4moEPlaO/mHBiOVfDpfNQGNkGsMr6c=;
        b=klmWH+PA3BvAP0+bRgrn8nmH4hs+5pkKe/O/Ad+RDnzjv1k9MiqxChr7YHRrHfSPjX
         JtIvj9cQEmdw8QvSrPlnqS8Z2Nq0706RAwadTZ07zoxUEP6uh991FI5XgStTbdiRNdpZ
         tzJ2ivSIK214StgN/2JWraiAMX7Pq8x7UQfIcSyUkgwR6avV4u4egV254OpMZT5fcsWy
         y/9AZbCgAnY2zysUIaUhnOBOJ33LE+2ayI9kr1/M3jE0ZyLABApBCIGLt1LubL6oJG98
         Bac0XT4NgeDghtkCOUZuvJ/B7wWoGvhScYTK/MknOb1zmC7N9a2JqIns60jRSROjhTB/
         lu3Q==
X-Gm-Message-State: AA+aEWboC/FLE3fDmupvi0Lh2WGJ/VUTCsvRqj2qCbGaHOyb1nCOCiKY
        ki1RtmjHOre7HW3xvPBPVaU72bWDC5Jfdw==
X-Google-Smtp-Source: AFSGD/UD01cJ69ofg0Ch+KWA6qiHRtyKnjJbZXQgPaDGWS2ig8jK3KgE+jo71jhev7PErbqn7RnVZA==
X-Received: by 2002:a9d:588c:: with SMTP id x12mr6696735otg.139.1544370095951;
        Sun, 09 Dec 2018 07:41:35 -0800 (PST)
Received: from cloudburst.twiddle.net ([187.217.227.243])
        by smtp.gmail.com with ESMTPSA id b18sm4353201oii.51.2018.12.09.07.41.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 07:41:34 -0800 (PST)
Subject: Re: [PATCH v6 08/13] arm64: expose user PAC bit positions via ptrace
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
 <20181207183931.4285-9-kristina.martsenko@arm.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a31ca10a-ee1a-71fb-2c3d-a6184e12b543@linaro.org>
Date:   Sun, 9 Dec 2018 09:41:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181207183931.4285-9-kristina.martsenko@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/18 12:39 PM, Kristina Martsenko wrote:
> When pointer authentication is in use, data/instruction pointers have a
> number of PAC bits inserted into them. The number and position of these
> bits depends on the configured TCR_ELx.TxSZ and whether tagging is
> enabled. ARMv8.3 allows tagging to differ for instruction and data
> pointers.

At this point I think it's worth starting a discussion about pointer tagging,
and how we can make it controllable and not mandatory.

With this patch set, we are enabling 7 authentication bits: [54:48].

However, it won't be too long before someone implements support for
ARMv8.2-LVA, at which point, without changes to mandatory pointer tagging, we
will only have 3 authentication bits: [54:52].  This seems useless and easily
brute-force-able.

I assume that pointer tagging is primarily used by Android, since I'm not aware
of anything else that uses it at all.

Unfortunately, there is no obvious path to making this optional that does not
break compatibility with Documentation/arm64/tagged-pointers.txt.

I've been thinking that there ought to be some sort of global setting, akin to
/proc/sys/kernel/randomize_va_space, as well as a prctl which an application
could use to selectively enable TBI/TBID for an application that actually uses
tagging.

The global /proc setting allows the default to remain 1, which would let any
application using tagging to continue working.  If there are none, the sysadmin
can set the default to 0.  Going forward, applications could be updated to use
the prctl, allowing more systems to set the default to 0.

FWIW, pointer authentication continues to work when enabling TBI, but not the
other way around.  Thus the prctl could be used to enable TBI at any point, but
if libc is built with PAuth, there's no way to turn it back off again.



r~
