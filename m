Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEC0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEFB205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PEmZ+96T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbfBLNn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:43:58 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40836 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfBLNn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:43:58 -0500
Received: by mail-qt1-f196.google.com with SMTP id j36so2917225qta.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 05:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eq9wdECYMR6FfFXhYXIqDMoTxwHXZRqxPmhn7WTEhWM=;
        b=PEmZ+96TmrtUkddsIdG0S+vEeKfftnWa6W5pDhKJTyImN+jP3U7fuWuDGmaNvQaRn+
         Lr/tky/AqY6PkXnnqSOqT2uhLIU7VgGP6M8BnCIvSKicwiiwHBlliHGA+0T4nYh5kUt9
         l6iJ6aQfZuDar9SsoknWe/I0oeMLhu859hg357lOB8SjDNbKO5y5tf2iaOyAsAxARId3
         WTeZRRnTgMjwnsZcvl6v3kGf1VSqapq0qdQsMY6KA72M3j5LsfTC7RDwYKpundRM8TX8
         hjVvpITa70FG2KnceDBuqLTNHXE0y2EkFYNBo053H2oGQkfU/bTeKtH5Eq+m33BbrXlm
         l1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eq9wdECYMR6FfFXhYXIqDMoTxwHXZRqxPmhn7WTEhWM=;
        b=LxyahXK56AYdTXBh8R40VfHPneA5ocdmBNRDv0BLZckp1QwJqPXLuLq2Va7KvdR3at
         NaCeswh1kS8YJI0sl0RkIUdjM8Kwn7Pyvzy9yQa2gFl//mPMixBKDK+DoRwOiLQ/fCBC
         Ggg7nvfL1FD6mRKrT1VIlPNUBDRDe/fR9j4gGNvQzRxBBjSq7CPUrEJmSqw2lPOuzay7
         L5I/Kyy1uL5mSph9hJGAfwop7024DbZIJ+oS/jQI95DAJN2IghdxWZFBloofgP8/1nv+
         g/UHl1rgD+p9nAJo0fG7vbJGNztgXPrmGEONJrh/8vMPpPZCzNXmXbPG7R+heg45t9vo
         pyuw==
X-Gm-Message-State: AHQUAua5/zSDdmgYDhGSO/puh5xNt78jO7ykGtwkS+gpHEbFUDnRCYZA
        O26HznqLZDXMHr+nmir5RQyUww==
X-Google-Smtp-Source: AHgI3Iar74h4+BwVDj6515n4LqlgZMVGZCbmvTMKiewv5hmXfBmxQwUeP0Ioxi0oO6xi8orAKYo5Bw==
X-Received: by 2002:ac8:1413:: with SMTP id k19mr2845254qtj.134.1549979037461;
        Tue, 12 Feb 2019 05:43:57 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 41sm16627913qtm.71.2019.02.12.05.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 05:43:56 -0800 (PST)
Subject: Re: [PATCH 5/5] kasan, slub: fix conflicts with
 CONFIG_SLAB_FREELIST_HARDENED
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>
References: <cover.1549921721.git.andreyknvl@google.com>
 <3df171559c52201376f246bf7ce3184fe21c1dc7.1549921721.git.andreyknvl@google.com>
 <4bc08cee-cb49-885d-ef8a-84b188d3b5b3@lca.pw>
 <CAAeHK+zv5=oHJQg-bx7-tiD9197J7wdMeeRSgaxAfJjXEs3EyA@mail.gmail.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <c92d6890-a718-a968-9937-13bdfeda773c@lca.pw>
Date:   Tue, 12 Feb 2019 08:43:55 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAAeHK+zv5=oHJQg-bx7-tiD9197J7wdMeeRSgaxAfJjXEs3EyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/19 8:26 AM, Andrey Konovalov wrote:
> Hm, did you apply all 6 patches (the one that you sent and these five)
Yes.
