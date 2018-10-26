Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D22C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADDB20856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ZqxUbK7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADDB20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeJZTXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:23:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35593 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeJZTXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:23:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id o14-v6so710497ljj.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 03:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7c7zvZDvbMIWNJn67ZT2BrvcEgPHVbSf19EQyGqwpIo=;
        b=ZqxUbK7urGG4miOCj851IvAZrbxeunnG8lIjL561/VheDPE9HsXh4XA1pgw0KzRD2f
         E2NRm6WTf4r8oR29txpAPoSl3OpZ6GkMMXA4OSS/Y+4RxQQpnhN5s3do8DsI+llYzg0S
         n6rLlhPRsL9l+xoP8GfQlcoLWyXbcyo6ljZvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7c7zvZDvbMIWNJn67ZT2BrvcEgPHVbSf19EQyGqwpIo=;
        b=oLtFd1vp/bqVrQEWmYRpma0V2WdvZz6dscm7KDJabIGSskBjG/anrQlGIk6BUwbl+I
         0VoBqcoS9jKusb6fi2UJdgLD5P40l1QF66zl3GsNHqYKelJmRlwX+1btBX1h+poVFWK1
         8+M8iKeick2VpL0YQNvBHoszkkf76J2tr/VbPG6tTlLBu4s4cyo+IKCWV+4TCDrcahxW
         WnI70EuOz1BMovYhj5f9NyXzYV0QBClKBf96XV5nByI7O7l6/tCa473qLI7RnoZn+jDv
         lZiXIpD++NdNwJs1ij7+vPk1FUyP7KTsG0TNZQH4gQa9yLBSf8wUMwQJOXWIAa2P9Wa9
         t39Q==
X-Gm-Message-State: AGRZ1gLC4lYAKztMqIUFObdnAOmDkKqovD7d+w2z33NEusKbpVAkGuMB
        VaDdh9vQhxg5epLnkG/a23asRw==
X-Google-Smtp-Source: AJdET5fBseFn38CS8sAOdBKs9cS4sdZeZd1ehfxyBXKF/w2Lf3YKuzMxEfPPzpYWqHPMspXnyVi1fw==
X-Received: by 2002:a2e:710c:: with SMTP id m12-v6mr2023765ljc.66.1540550835648;
        Fri, 26 Oct 2018 03:47:15 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id b123-v6sm1705408lfe.54.2018.10.26.03.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 03:47:15 -0700 (PDT)
Subject: Re: [PATCH AUTOSEL 3.18 15/98] usb: musb: Fix a few off-by-one
 lengths
To:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@ti.com>
References: <20181025141853.214051-1-sashal@kernel.org>
 <20181025141853.214051-15-sashal@kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <1acd4b7f-d13c-5ad6-3e9f-c58bcd0469f3@rasmusvillemoes.dk>
Date:   Fri, 26 Oct 2018 12:47:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025141853.214051-15-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-25 16:17, Sasha Levin wrote:
> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> [ Upstream commit e87c3f80ad0490d26ffe04754b7d094463b40f30 ]
> 
> !strncmp(buf, "force host", 9) is true if and only if buf starts with
> "force hos". This was obviously not what was intended. The same error
> exists for "force full-speed", "force high-speed" and "test
> packet". Using strstarts avoids the error-prone hardcoding of the
> prefix length.

Not sure this qualifies for -stable, but if some other "real" -stable
patch depends textually on this, it should be ok/harmless. Just my 2c.

Rasmus


