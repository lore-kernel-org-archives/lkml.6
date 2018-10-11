Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B21BC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDE32085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="M8bx2Kf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDE32085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeJKRiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:38:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34182 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeJKRiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:38:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id j17-v6so7693860lja.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 03:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/ibgMSyj1HCcQTQArgPjEnXVkQou6esZ4S8uNRZQ+Vo=;
        b=M8bx2Kf8FKA9CcBeWS2aSlX+Ry63UxUL35cotq7fGBqaOK9TmxBSNOxGw4aZFkWULX
         dk5v7uk23IadjOm85VnYR0tky60K+oxUlLuUO+Ycm+5F0i2J9bmFSDZWmeG6eY6XtuF2
         hlFA3iQ2TI9vVNgmURFDFpptBzNmLFlbbd1rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/ibgMSyj1HCcQTQArgPjEnXVkQou6esZ4S8uNRZQ+Vo=;
        b=ERR0FnToVvAePGrhUpEpnhjjh0QhlSm45MV4GnzbHpuviEUtjA2ZnD82N8Vhb+oQLV
         YCi1Eznf2OZQG7AIlfeH6IB9b+1ohyvJHM2uuLTKoOxce9WnygJ6sIJ2WZnv1zk0qbgW
         6a9CmKasWncSWhFTEKktieJQqRavJF/GT/p3VQs+QEHT1u84MHCwuC/SC6EfSwDwOorr
         p4wpaXH9a8iRgix/6csKQ8wQhvxru/FXGCiCImZnDB0b5Ck1x5Z3fHoUs+dJkIyKs4Fp
         YaydnZzxI9WhPZk+1FPPNHO55Hw6RvLKZOd9d28eyYKcI4oRVPegOp7oyuV5Ys1xahwi
         VgrA==
X-Gm-Message-State: ABuFfohBfGijh0rUJ98RLFnPmQ2JCVnzZ3c+SAL+c3xVNcCj0g+vqmnS
        sik0vMqBiKlEoxlFebU6FE/xE7emNk0=
X-Google-Smtp-Source: ACcGV61geVc1jtpLqOnd1uxDrKv3/bTaJj+RUzz3JzUAfgG1RadbGM9HbpPrHKorXAtWf/5os2DJqw==
X-Received: by 2002:a2e:7a19:: with SMTP id v25-v6mr773691ljc.147.1539252697098;
        Thu, 11 Oct 2018 03:11:37 -0700 (PDT)
Received: from [192.168.0.189] (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id z19-v6sm6039770ljk.20.2018.10.11.03.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 03:11:36 -0700 (PDT)
Subject: Re: [PATCH 2/3] staging: greybus: loopback.c: do insertion in O(n)
 instead of O(n lg n)
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20181005142826.26108-1-linux@rasmusvillemoes.dk>
 <20181005142826.26108-2-linux@rasmusvillemoes.dk>
 <b59cc4bf-3c43-8d35-8d1c-0700f6b4c604@nexus-software.ie>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f20353cc-15d9-5816-b466-8d1e30df9a2d@rasmusvillemoes.dk>
Date:   Thu, 11 Oct 2018 12:11:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b59cc4bf-3c43-8d35-8d1c-0700f6b4c604@nexus-software.ie>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-11 01:03, Bryan O'Donoghue wrote:
> On 05/10/2018 15:28, Rasmus Villemoes wrote:
>> Signed-off-by: Rasmus Villemoes<linux@rasmusvillemoes.dk>
>> ---
>> I have no idea if the performance matters (it probably doesn't). Feel
>> free to ignore this and the followup cleanup.
> 
> What's the problem you're fixing here ?

No problem, really, other than my inner Paul Hogan telling me "That's
not an insertion sort, ...".

> Is it tested ?

Compile-tested. As I said, if the performance (and inaccurate comment)
is irrelevant, just drop it.

Rasmus
