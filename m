Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F77DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC51921531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="OqcQ7sUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC51921531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbeITTzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:55:38 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32854 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730955AbeITTzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:55:38 -0400
Received: by mail-lf1-f67.google.com with SMTP id m26-v6so8506008lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 07:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yu9Vf3J413awo9c8mDxDjIKx2yaWoAPF7CJzp5PikOs=;
        b=OqcQ7sUSxStC6sPtYhEd7bJ8Yf96vuCLuS9XHevLWHxB4X9xt5hudXz+slanns3gBf
         98+AHltnjsN/R9JeSMvx5m7Lc9+g5cf6bpkjH18t/VdqQ7/fhon39BaeFDw/C4Z2NBPd
         w7sXVHavTvZneS8y/kukExn3tJ0nzVRFwa8iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yu9Vf3J413awo9c8mDxDjIKx2yaWoAPF7CJzp5PikOs=;
        b=CAAtWv9B/SMH7EEm04K5+211tTmpYWY/kIPpm4v6t87+dTjRTzRaOwkgZzuLLcPYAV
         mMAt7yBfcE/XNW9Z0dpRMBXor6EevAc2ksS0gPZ2FZL+xwa+etOf8xldJFpFE4G4kENq
         +vR/EuFtOTeX7mIRC9wEz0U3oTlgPxAigyJMXvzWS7EzQdJxMVDv4bIcqO59MSzXR2sW
         AyG63+RzphwkhOugrsnlBQMzZDmB5PNe221WK+WcSHW4G3vYU8a3q5CvHRU1btkYp1KZ
         O2OT9CBk7ZDWOw3dgaGaGvFU/owmn7LOmR06MCR0GNtkG1CYpFEv58aBlze1w0lrZfuT
         Vkwg==
X-Gm-Message-State: APzg51ChQb1dTLrRwOV4NHt6SdGdtTvpUcxlDi6XQ1g+0xAbblkmvImZ
        fveL44TFN2RfC8qs4Ds6YfGFXXLTEtcrxH3b
X-Google-Smtp-Source: ANB0VdYzIR9W2/ziMjgJOGQv4IiL1E8QDV/U7l6IYkz/VN9KBY2oL1pDfdnziciUhKiq42M7OANrIw==
X-Received: by 2002:a19:ae15:: with SMTP id f21-v6mr9719275lfc.86.1537452715784;
        Thu, 20 Sep 2018 07:11:55 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l14-v6sm4378925ljh.91.2018.09.20.07.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 07:11:55 -0700 (PDT)
Subject: Re: [PATCH 14/22] btrfs: implement btrfs_debug* in terms of helper
 macro
To:     dsterba@suse.cz, Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20180919220444.23190-15-linux@rasmusvillemoes.dk>
 <20180920131039.GY5847@twin.jikos.cz>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <53ae56ab-2d98-4b74-1143-9959f5341205@rasmusvillemoes.dk>
Date:   Thu, 20 Sep 2018 16:11:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920131039.GY5847@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-20 15:10, David Sterba wrote:
> On Thu, Sep 20, 2018 at 12:04:36AM +0200, Rasmus Villemoes wrote:
>> First, the btrfs_debug macros open-code (one possible definition of)
>> DYNAMIC_DEBUG_BRANCH, so they don't benefit from the HAVE_JUMP_LABEL
>> optimization.
>>
>> Second, changes on x86-64 later in this series require that all struct
>> _ddebug descriptors in a translation unit use distinct identifiers.
>>
>> Using the new _dynamic_func_call_no_desc helper macro from
>> dynamic_debug.h takes care of both of these.
>>
>> Cc: linux-btrfs@vger.kernel.org
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> Acked-by: David Sterba <dsterba@suse.com>
> 
> Per the cover letter, I assume you'll take it through your git tree.

Thanks. I don't have a git tree feeding to -next myself, but these will
probably be routed through akpm or x86.

Rasmus

