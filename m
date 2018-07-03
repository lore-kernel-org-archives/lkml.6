Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31914C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E8D21906
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FkdIozkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E8D21906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754783AbeGCKdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:33:31 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:42043 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754665AbeGCKd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:33:29 -0400
Received: by mail-wr0-f171.google.com with SMTP id p1-v6so1417617wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 03:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p9kgCCWdAP+1RgRGftkfXoA3gcHHPdUAj73KdeK9204=;
        b=FkdIozkY5+8603disN4C1NZ11XXrNUh62CJPrzZa70glEakXUnSvDj6mSW+EobjIZs
         fJq9LPqDgadAe7fqHYk0hjmOKuEQ/8O9Nzybu9XYLnzlVSMZIy3/WaIGkYWHG/OO71y9
         rTEulGxs11B/CouWj0YwZ8/22zFqq0BgXur4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p9kgCCWdAP+1RgRGftkfXoA3gcHHPdUAj73KdeK9204=;
        b=MrnIvju5/CMKc315W6ocsRFQQ/yZR59uo5QwL+j2T0VEQHs7+xLDHn6cen3tqE2ZQv
         R/CGVzGCxLp3Z0UA/A/E68AbRbHFspV0/NfopZYC1GrQiJqXFJVnSZa7ZupVnG9rd00A
         DtJjPjcZWMth3/G9LtgjJ/EC1dIwE96//Mof2TdpaUQZ07dkTMYYDyPHxcok9gLYjIy7
         8dctoTu/5HM3VXyM2pelMCiQAbHlk+fpp3SOipU4dsV8OZaQmnqB8n6IsorEbzUqWhAs
         K5s1rAymXmeXjQXiW3bQaar4QdzlBDLiB7rumUa6KZYsGXA0ZSxeSmv1jZ1lHcEr9DDY
         UAOQ==
X-Gm-Message-State: APt69E10MZ8G3GYAJ1oUzvTkqxekFy5O4kI1n6WCiMdyZ8x5X/dq3f2Z
        48pRho11JnIyaGlsnw9vc3qBNQ==
X-Google-Smtp-Source: AAOMgpeoO/9cIw3Rp2jCwaNstenGZDl+gOQmySha5CDAR4ZPeztIPUn3xkS/iRC9357QeVjaN2zxJw==
X-Received: by 2002:adf:f342:: with SMTP id e2-v6mr22234415wrp.161.1530614007936;
        Tue, 03 Jul 2018 03:33:27 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id n10-v6sm974092wrs.64.2018.07.03.03.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 03:33:27 -0700 (PDT)
Date:   Tue, 3 Jul 2018 12:33:20 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] refcount: always allow checked forms
Message-ID: <20180703103320.GA17809@andrea>
References: <20180703100102.16615-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703100102.16615-1-mark.rutland@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

a typo below:


>  /**
> - * refcount_inc - increment a refcount
> + * refcount_inc_checked - increment a refcount
>   * @r: the refcount to increment
>   *
>   * Similar to atomic_inc(), but will saturate at UINT_MAX and WARN.
> @@ -148,14 +146,14 @@ EXPORT_SYMBOL(refcount_inc_not_zero);
>   * Will WARN if the refcount is 0, as this represents a possible use-after-free
>   * condition.
>   */
> -void refcount_inc(refcount_t *r)
> +void refcount_inc_chcked(refcount_t *r)

s/chcked/checked

  Andrea
