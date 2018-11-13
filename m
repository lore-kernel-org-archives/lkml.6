Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2667BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3257224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="ox0hDIYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3257224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbeKNAWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:22:15 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:57040 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbeKNAWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:22:15 -0500
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 8928E46A727;
        Tue, 13 Nov 2018 15:23:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1542119030;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references;
        bh=wgm6gey+f3ws2zmlqkX9o3gU/iYvoQHfgHIV4E13ko0=;
        b=ox0hDIYkv1p2Fjq/Hm9CqCagXiXractkZLTORRvRYjcqtA1Amcptu5Q0VdH4EdMegWcvfT
        +LZ0xndurYypujVSk0cQpymoKrOcDRNksPu6nT6YN9vph/E82wh/jINPxYnhHB7iWKX79e
        l36QWE8k7+pohYri6ktYaDiHnDqGr0I=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 13 Nov 2018 15:23:50 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     jannh@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, timofey.titovets@synesis.ru,
        willy@infradead.org
Subject: Re: [PATCH V3] KSM: allow dedup all tasks memory
In-Reply-To: <<CAG48ez0ZprqUYGZFxcrY6U3Dnwt77q1NJXzzpsn1XNkRuXVppw@mail.gmail.com>>
Message-ID: <d43da6ad1a3c164aa03e0f22f065591a@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1542119030;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references;
        bh=wgm6gey+f3ws2zmlqkX9o3gU/iYvoQHfgHIV4E13ko0=;
        b=EfMsPh0t52POejsE3ot0hiCoUH/comDhm2b/LZ3pqbKvBM6iBCRggPHR16pF4xh/Sfz8zA
        IoWpAGGYmG/eISPiGzogiP6resYwclssTA+YUnjkYRapXe+P09woRG5tQsNNjtRz3+j+TC
        5V43EVczPDZ6TMjsd7vKfaI32530EDE=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1542119030; a=rsa-sha256;
        cv=none;
        b=Sj/SZEixUX1evZEiMY5cVPmGNs0HJkekyzpaftizq64/M97myapUcxz6gdpSN5XJ/idX/HPIi7G2CTrR1G4UeyDmLoKA6r3bX7A3l8wHfx9UMALynzlrK0G3FdoKWAB/8GUSfR8IbuRAmgu5+lB61Ur6ROnfIooaVhCbitCq3UA=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> Yep. However, so far, it requires an application to explicitly opt in
> to this behavior, so it's not all that bad. Your patch would remove
> the requirement for application opt-in, which, in my opinion, makes
> this way worse and reduces the number of applications for which this
> is acceptable.

The default is to maintain the old behaviour, so unless the explicit 
decision is made by the administrator, no extra risk is imposed.

> As far as I know, basically nobody is using KSM at this point. There
> are blog posts from several cloud providers about these security risks
> that explicitly state that they're not using memory deduplication.

I tend to disagree here. Based on both what my company does and what 
UKSM users do, memory dedup is a desired option (note "option" word 
here, not the default choice).

Thanks.

-- 
   Oleksandr Natalenko (post-factum)
