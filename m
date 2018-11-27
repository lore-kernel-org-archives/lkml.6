Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D26C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78D42086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DEZTxU42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78D42086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeK1HwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:52:09 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44636 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbeK1HwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:52:09 -0500
Received: by mail-qt1-f196.google.com with SMTP id n32so23408198qte.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 12:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AQUiIJOLWZFE4x01YNLwqqGKGYG9SZd26ZrvQsZHVPY=;
        b=DEZTxU42ksvBE6plXoiagaUiPdn6x3b0IiaN+DCuwMYDLcBfu6z486yDQ3cEdWRWhY
         Hx3EFzEq+NoA2ED3mbjUWpmng1QnOTmUosRFPaSBTEazgmMzWfNqFXfQb7iyDNb2O5BW
         cMZit1eMW9ddCVnQXazuOTPoYmNhA2wI0Cjo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AQUiIJOLWZFE4x01YNLwqqGKGYG9SZd26ZrvQsZHVPY=;
        b=cps6TjgCuNZY2m0Fo2PtCjynNvONIwsD8ypunDwLzRCn827NA00cyHcZMrnj8bIQkW
         sc6DsrhSVitsrhNVXBin5Ame9LHtTUqzUij9qBKrxcRwHoVNpGfGD4qUwVSisErM2AwP
         f2kL11jdEwrx9ox06LAk+qnR3KX2mQdBQj8VaL/RwjmWEj3wzwCDckdYRcq97KhIb8Sx
         BTl8RICsclstGhElRHoPGjMEuKFvTUKbO1iL8dnL+mjufs08Ww8w2wsrs6k0/GUBXf43
         QZKmFNvJzSsqTcKUe58dJjHZfY1kog4BgNL271aa4NP9bgunaf1kmTWmyGkXDYSniV+t
         5DIg==
X-Gm-Message-State: AA+aEWaFmjyscsP30dVjx30Dify7bAFvHb2Nesa3KW9hOj0ESOfu/YcF
        6KJn5s8Qh3zIr3iQsfv2apY2Qw==
X-Google-Smtp-Source: AFSGD/Uj/SgZ4k/FSm4nl5b49cr640sZt+6Bf50MtS3plBovNy07xEelqoZ0pdmi988rMm2+T7Maqw==
X-Received: by 2002:a0c:ed4f:: with SMTP id v15mr32075635qvq.237.1543351979601;
        Tue, 27 Nov 2018 12:52:59 -0800 (PST)
Received: from [192.168.49.18] ([138.204.25.29])
        by smtp.gmail.com with ESMTPSA id n26sm2001338qkg.74.2018.11.27.12.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 12:52:58 -0800 (PST)
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm: always update thread_info->syscall
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
References: <20181126225335.10477-1-rafael.tinoco@linaro.org>
 <20181126233303.GZ30658@n2100.armlinux.org.uk>
 <20181126234111.GA30658@n2100.armlinux.org.uk>
 <20181126234456.GB30658@n2100.armlinux.org.uk>
 <ad23e3dc-eee0-f9af-2f12-bfd7a14cd546@linaro.org>
 <20181127105620.GD30658@n2100.armlinux.org.uk>
 <20181127153553.GE30658@n2100.armlinux.org.uk>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <df0f7e94-8577-2789-a749-77855387909e@linaro.org>
Date:   Tue, 27 Nov 2018 18:52:54 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181127153553.GE30658@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/18 1:35 PM, Russell King - ARM Linux wrote:
> On x86 (32-bit app on 64-bit kernel), it has this behaviour:
> 
> $ ./syscall-test
> 162 0xffcc5a6c 0xffcc5a6c 0x48d09000 0x0 0xffcc5af4 0xffcc5a74 0xffcc5a2c 0xf77dfa59
> 162 0xffcc5a6c 0xffcc5a6c 0x48d09000 0x0 0xffcc5af4 0xffcc5a74 0xffcc5a2c 0xf77dfa59
> 
> which looks good, except:
> 
> $ strace -o /dev/null -f ./syscall-test
> 162 0xffc0070c 0xffc0070c 0x48d09000 0x0 0xffc00794 0xffc00714 0xffc006cc 0xf77f3a59
> 0 0xffc0070c 0xffc0070c 0x48d09000 0x0 0xffc00794 0xffc00714 0xffc006cc 0xf77f3a59
> 
> So, if we're syscall ptracing a program, __NR_restart_syscall gets
> exposed through this interface, but if we aren't, it isn't exposed.
> Which version is correct?  *shrug*, no documentation...

I looked around and could only find people using this interface as an
alternate mechanism - than ptracing - for discovering what a task was
doing a certain moment (Mostly during hangs. I haven't found a good
schematic way - or tool - that uses it, but I might be wrong there). For
that purpose, it would be better *not* to update when restart_syscall
happens, unless the hang is right there =o).

If you check:
https://bugs.linaro.org/show_bug.cgi?id=3783#c11

The only syscalls being updated now - that I could get, without any
workload - were 252 (epoll_wait) or 252 (sched_getaffinity):

252 0x7 0xbee80578 0x1b 0xffffffff 0xbee80578 0x7 0xbee80550 0xb6e9d286
252 0xa 0xbef3d930 0x9 0xffffffff 0x0 0x6c 0xbef3d908 0xb6e6f286
142 0x4 0x0 0xbea3eb2c 0x0 0x0 0x6c 0xbea3ea88 0xb6e40286
252 0x4 0xbe8d59e8 0x9 0xffffffff 0xbe8d59e8 0x4 0xbe8d59c0 0xb6e11286

All others I got zeroed, and that's where everything started.

Please, let me know if you still want a v2, or something else... like
fixing it and making it to ignore the restart_syscall for *at least*
having the same behavior across diff archs.

If it is not worth, I'll just blacklist those tests in our functional
tests environment and move on =).

Thanks a lot, very best rgds,
-- 
Rafael D. Tinoco
Linaro Kernel Validation
