Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73018C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4401A2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsRzDfPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfAWR2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:28:42 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44658 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfAWR2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:28:41 -0500
Received: by mail-oi1-f195.google.com with SMTP id m6so2435140oig.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 09:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=6uDiqMq26X/QdPGEYHQNDPTktTU2QNg1q0563PlXOhQ=;
        b=FsRzDfPoBDNvi867kQzF+hMqEokoHyTR7NoDS2XlWGIPYZpjWz+8XuSWb5Z9yMsTQh
         RDtEsOyibfRCMiVMTLqolbPEZohrr/O82E88mVmBfVwzDWgmbAuX9PLiNGmzMSQiUeft
         rXoYQjKPifLcwH9prRgmYiQspCq8K3uU19XETdaZuSqQnH2E2SUfJ4hKiAvDHLF0IkGR
         Tz/WKZHfz2xzuyGyS90iq4bChzNVIqz9HABZoCqgcHErUPexoHIqf00hjlz7pq9Z/n1M
         5cM5vB7TztmMwyeVvUSWJ5BMFJ5L+9iZCr/bljzaEmiuvekVcNlF4avAx4KUFg5sLDvY
         MiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:to:cc:from:subject:message-id
         :date:user-agent:mime-version:content-transfer-encoding
         :content-language;
        bh=6uDiqMq26X/QdPGEYHQNDPTktTU2QNg1q0563PlXOhQ=;
        b=hoSOmVIZxzMXjczMSCYe+6KphkcZHY8FT4V9SzmfHKBXh4zm786kWFdRiFyz81SETT
         ZV00MGJC0KAFYEYPNK15J24mW1z3LLdMkUPgqUjE5keW1+ImNk8jgPMHlcnqpD21M7k3
         4kdo3cdChcvTe5ANIOahOiDR8HJT87fmNRpB1hLT5/ldQfaO9iIIVggUaFGBKJBaIuhJ
         C0uTYTE/hw+gIUQckDkGdkwc9rSCE8BdnZQyB6W/35Jiarg2eSw7F/YISZRScWedACLi
         6rLSt63DKqO5+8xORBPIMPLqc7IPIp7/ZL/ZZZe6tA7CqThknRbuA+ql4/lf0cHHvJSF
         XRPw==
X-Gm-Message-State: AJcUuke3prSC87bdskCCeUs8eY9csy7d6it5RYZDvXLO6iItY0dRM/uw
        KQBHcgj597mdQt1N7WOaLQ==
X-Google-Smtp-Source: ALg8bN7ZdKmKkp41OaRjtnPTxIzWOiURm1H5Vyf/ofcozK2uRsSXpUDncsAt11jBUygUAfgbmD1u/Q==
X-Received: by 2002:aca:b4c5:: with SMTP id d188mr1932532oif.309.1548264520162;
        Wed, 23 Jan 2019 09:28:40 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id c9sm7876591otp.24.2019.01.23.09.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 09:28:39 -0800 (PST)
Received: from [IPv6:2001:470:b8f6:1b:a64e:31ff:fe14:d744] (unknown [IPv6:2001:470:b8f6:1b:a64e:31ff:fe14:d744])
        by serve.minyard.net (Postfix) with ESMTPSA id 4791E39C;
        Wed, 23 Jan 2019 11:28:38 -0600 (CST)
Reply-To: minyard@acm.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>
From:   Corey Minyard <minyard@acm.org>
Subject: [GIT PULL] IPMI serious bugfixes for 5.0
Message-ID: <200450ff-49dd-da74-53b6-b0a0d71b4c8a@acm.org>
Date:   Wed, 23 Jan 2019 11:28:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7b55851367136b1efd84d98fea81ba57a98304cf:

   fork: record start_time late (2019-01-08 09:40:53 -0800)

are available in the Git repository at:

   https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.0

for you to fetch changes up to 913a89f009d98c85a902d718cd54bb32ab11d167:

   ipmi: Don't initialize anything in the core until something uses it 
(2019-01-23 11:09:32 -0600)

----------------------------------------------------------------
I missed the merge window, which wasn't really important at the time
as there was nothing that critical that I had for 5.0.

However, I say that,and then a number of critical fixes come in:

   ipmi: fix use-after-free of user->release_barrier.rda
   ipmi: Prevent use-after-free in deliver_response
   ipmi: msghandler: Fix potential Spectre v1 vulnerabilities

which are obvious candidates for 5.0.  Then there is:

   ipmi:ssif: Fix handling of multi-part return messages

which is less critical, but it still has some off-by-one things that
are not great, so it seemed appropriate.  Some machines are broken
without it.  Then:

   ipmi: Don't initialize anything in the core until something uses it

It turns out that using SRCU causes large chunks of memory to be used
on big iron machines, even if IPMI is never used.  This was causing
some issues for people on those machines.

Everything here is destined for stable.

----------------------------------------------------------------
Corey Minyard (2):
       ipmi:ssif: Fix handling of multi-part return messages
       ipmi: Don't initialize anything in the core until something uses it

Fred Klassen (1):
       ipmi: Prevent use-after-free in deliver_response

Gustavo A. R. Silva (1):
       ipmi: msghandler: Fix potential Spectre v1 vulnerabilities

Yang Yingliang (1):
       ipmi: fix use-after-free of user->release_barrier.rda

  drivers/char/ipmi/ipmi_msghandler.c | 173 
+++++++++++++++++++++---------------
  drivers/char/ipmi/ipmi_ssif.c       |  25 ++++--
  2 files changed, 117 insertions(+), 81 deletions(-)

