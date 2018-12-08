Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF8DC07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E4F2083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E4F2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeLHAdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 19:33:14 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:35915 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeLHAdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 19:33:13 -0500
Received: by mail-qt1-f170.google.com with SMTP id t13so6546774qtn.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 16:33:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=p4aFA3JRm9jcKe8gVZHo7QN7/OWHXpjkjYBUikNOkTA=;
        b=dR3I609FbXqa55EqbsRSmdBcDEh7Iq0hNHsVXBwbkNJb8BWWGwIkYGK/GKsFWTWE01
         M038rWZGLCx8g7SarzubwiaypNlFXyZ8mQKsTXqMNzTKNblz8lg7jnae6kz7IjbUrsXU
         OSbgSB4fb/Y7ufOe5gS5oruVf0kh7OBzczhb1xr/0QZUgzBmTKxdWPIdBEnofTA3ZPiB
         DyO633NlwZJ6aidNtDbLqwJSdZ4Jv8FZryGxaCsq3Pe0uNMXJDLrvCxecplZAwEjAJoE
         y5lmVVwi5dW/MB+yoeZgK2O+bInBk3MZ8bzZNTy81Iif2N1fZ4DEwGGOeLqmdCXTDj5u
         X+aw==
X-Gm-Message-State: AA+aEWaTQdh2ADgw2mQZGT/smpsOf+ertA9wPUFAtppKlE9Z8t2eanVC
        II3IaqauanjJ0dd4VYplptlU/SzKkZA=
X-Google-Smtp-Source: AFSGD/Wnhi2t0gWQ/D8ewIcZrA32RnN77msr/UO6YDpg7WxHnJUvNre5bIwm12O3scs3M7hf3+htqw==
X-Received: by 2002:ac8:498c:: with SMTP id f12mr4010896qtq.130.1544229192436;
        Fri, 07 Dec 2018 16:33:12 -0800 (PST)
Received: from ?IPv6:2601:602:9802:a8dc::5a45? ([2601:602:9802:a8dc::5a45])
        by smtp.gmail.com with ESMTPSA id j36sm3435459qtk.15.2018.12.07.16.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 16:33:11 -0800 (PST)
To:     stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Laura Abbott <labbott@redhat.com>
Subject: Process for severe early stable bugs?
Message-ID: <c04ea7b1-23f3-f1e0-4f31-07b62abdee24@redhat.com>
Date:   Fri, 7 Dec 2018 16:33:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest file system corruption issue (Nominally fixed by
ffe81d45322c ("blk-mq: fix corruption with direct issue") later
fixed by c616cbee97ae ("blk-mq: punt failed direct issue to dispatch
list")) brought a lot of rightfully concerned users asking about
release schedules. 4.18 went EOL on Nov 21 and Fedora rebased to
4.19.3 on Nov 23. When the issue started getting visibility,
users were left with the option of running known EOL 4.18.x
kernels or running a 4.19 series that could corrupt their
data. Admittedly, the risk of running the EOL kernel was pretty
low given how recent it was, but it's still not a great look
to tell people to run something marked EOL.

I'm wondering if there's anything we can do to make things easier
on kernel consumers. Bugs will certainly happen but it really
makes it hard to push the "always run the latest stable" narrative
if there isn't a good fallback when things go seriously wrong. I
don't actually have a great proposal for a solution here other than
retroactively bringing back 4.18 (which I don't think Greg would
like) but I figured I should at least bring it up.

Thanks,
Laura
