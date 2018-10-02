Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD5BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9957120645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dxmP8ZE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9957120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeJBPDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:03:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39394 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbeJBPDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:03:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id w21-v6so760466lff.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 01:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wE+BvKsJkLdkPJp/ba16f33yHNu6JUmQduE9ppUGyhY=;
        b=dxmP8ZE4uF2YUhdOazJfBI26guKgvVohSgUIkX2JbgVkzSJDrlo9RxVPZQQ4hznBpO
         mGOv0ZvFkE6tHTOEtfJ3nCjy17BEJkSK9FsOKae/I4Hr4rH875JCjoorCTelhhBfQSjs
         iSQBKXXaOgeE3OJEtA5Z5hNKrHSLpwHEWSmlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wE+BvKsJkLdkPJp/ba16f33yHNu6JUmQduE9ppUGyhY=;
        b=V/mxEwV3TcG4zsIJydShAdcfgEQZXfFGDaY6by2rEPf1dnr8TqNGx9g+m9YnkL7swe
         5RnC0VUH8z7V5CbAbTTiISlXtUyNnkpBvKCacYYfbXhQ0MY3l7scZgELBtyjKdk9eNxo
         NQYj1JDAVSNOlu+8uR6+5ZEsONUf9+2AygEPtGSmQDZ3VlJXSBP11MHYyzExe2Wb2IDc
         xrhQdCOTO5mO77PG5zBq1TSl797IgNswFMwCNpnqpDN59PNiDKfu+lgTEPPvezByFkvv
         a5YT2/DeLeZ5Z3Y5qYSyUm8AEjbFjSkXHcZRnOj7i4K3aJfNB4SqrdqjUxwf2u/DyV+h
         vTPQ==
X-Gm-Message-State: ABuFfohNc81uIr7NvQiMVMa7Clgu8HdlhKPmwcMT+m9pnoEbDHxG9gpQ
        ctSOTqjmD38QgRKwDnifURQ6jMcwQprc3wPd
X-Google-Smtp-Source: ACcGV60m5IINNqD1hHWQGuOZcg0yV8X9TlA9AUTDSuiqcMOE3k/C9YRJ19ls5eqjkLBlDjYjT3WkZQ==
X-Received: by 2002:a19:7409:: with SMTP id v9-v6mr1821371lfe.147.1538468486537;
        Tue, 02 Oct 2018 01:21:26 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l14-v6sm3172529ljh.91.2018.10.02.01.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 01:21:25 -0700 (PDT)
Subject: Re: [PATCH 21/22] x86: jump_label: introduce
 ASM_STATIC_KEY_INIT_{TRUE,FALSE}
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20180919220444.23190-22-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <395d8874-40c7-3703-48a8-2a7ee232f49b@rasmusvillemoes.dk>
Date:   Tue, 2 Oct 2018 10:21:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919220444.23190-22-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-20 00:04, Rasmus Villemoes wrote:
> These will be useful when defining the contents of (a struct containing)
> a static key in inline assembly.

May I politely ask someone in the x86 camp to comment on patches
21,22,23 in this series? If the memory savings is deemed
not-worth-the-asm-complexity, a number of preparatory patches become
pointless, and I'd like to figure out which ones I should ask Andrew to
pick up.

Thanks,
Rasmus
