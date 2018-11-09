Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278ABC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEFF20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ZeTXhse9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEEFF20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbeKJJOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:14:40 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38629 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbeKJJOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:14:39 -0500
Received: by mail-lj1-f196.google.com with SMTP id q186-v6so2997126ljb.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z0l0SdMTYNNTHU04lMS5cs5ZttICkchRvRart0qeZJY=;
        b=ZeTXhse9O5xoFXb/D/v3EfJBV0FkmCr5V41lSDwsKQd4FXxsiBAJ0KX0Fmkicr6zBY
         FFF23OqwWj6eHFeurSeSlIF5KVYtSZkHdIU+adRNKyYxpmiQAFelNxdOYHOPE6Sz2OHQ
         7h1VrJGqhTEc5NV+n+cIBONj1V7RsNbCczRvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z0l0SdMTYNNTHU04lMS5cs5ZttICkchRvRart0qeZJY=;
        b=CPXjd7FuuL1CWyyb035fqRmVYLhAkynsVnGJdQ3LM1VUKkahU2+c4AByrcBQBVm9n7
         02H8Vt4YtJ58oFdGQQLY9kJOmQV6kJTkgUm1/bSYhCatVGbCWcBapZVjDN/wEdujDzjG
         RyaL0bh245VJ1Vtg1hvEptqBl224XbIA2qe7D59FhC+zpJjjw3JuHynf8GnCpOoNQk/f
         eppDdLVoi4m7HDbpwBXqrYgKGh5TOQ3eQfx8pSV4/OivWQLYqj1wIVuEHFgbFV8MyUjy
         O1qG2t/JzMlZF+EqeXqnmPnJBGk4DH2fo2WNUP2WaZqKJjGOFxKmGyk/58LAqDGGIs9V
         KSSQ==
X-Gm-Message-State: AGRZ1gJsRgLgec26ol9DH0Xy1mKOcnkM265JE4oPfyFi/SPwArraux1q
        68QoZVf9JwvuRabPR8HNnCzJjg==
X-Google-Smtp-Source: AJdET5e7SnJUfE4+SiCzw7a5wxM8lvwYATF+8tRux9EJ07FgIDLbvfxPWjuOh+Vjw03mdsWaMyvEQg==
X-Received: by 2002:a2e:4745:: with SMTP id u66-v6mr6540665lja.37.1541806310375;
        Fri, 09 Nov 2018 15:31:50 -0800 (PST)
Received: from [192.168.0.189] (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id h2sm1666692lfb.49.2018.11.09.15.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 15:31:49 -0800 (PST)
Subject: Re: [PATCH v3 04/23] linux/net.h: use unique identifier for each
 struct _ddebug
To:     Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
 <20181109231021.11658-1-linux@rasmusvillemoes.dk>
 <20181109231021.11658-5-linux@rasmusvillemoes.dk>
 <2358250f27022be9eb5c4e6a3d95ee869c3af45f.camel@perches.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e35f20ed-d93b-89ca-4123-a088c65df902@rasmusvillemoes.dk>
Date:   Sat, 10 Nov 2018 00:31:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2358250f27022be9eb5c4e6a3d95ee869c3af45f.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2018 00.22, Joe Perches wrote:
> On Sat, 2018-11-10 at 00:10 +0100, Rasmus Villemoes wrote:
>> Changes on x86-64 later in this series require that all struct _ddebug
>> descriptors in a translation unit uses distinct identifiers. Realize
>> that for net_dbg_ratelimited by generating such an identifier via
>> __UNIQUE_ID and pass that to an extra level of macros.
>>
>> No functional change.
> 
> Why does this require an extra indirection _<macro>?
> 

Because the identifier used in the

>>  	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);

line must be the same as the one in the

>>  	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&	

line. That identifier used to be simply "descriptor", with C scope rules
making that ok. But because of the asm games I'm playing later, I need
to generate a fresh identifier for each instance. That identifier must
be referenced in two places in the C source - hence the need to use an
extra level of macros to have the __UNIQUE_ID() expanded before
_net_dbg_ratelimited gets expanded.

More or less every use of __UNIQUE_ID requires such an extra level
(because one very rarely needs to use an identifier exactly once - the
point of giving stuff a name is to refer to it again.)

Rasmus
