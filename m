Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD4DC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEF320672
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GK4S4Ygk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEF320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeJWJBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:01:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43126 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeJWJBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:01:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id k9so41962223otl.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 17:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=9kye/8u0dWShCxn+JUHAUOeePnl2nc5861b/EDfdSIU=;
        b=GK4S4YgkZxs/I12zAZr8EqoHLxVVvNYbY+xqB44aUabK2xpNPLLafJgvX3Oz6NEFXS
         D6GqeecbSlAHP3c2xSG3V8+NJe2iB2+6rK2FoFID8qU8CouTdVuKy7heh2LMBaJMuEd/
         Rlbklh9FidlI093umcrw0cxyZVxnCiLlMbI48YTjKQ/2zqhBr1cQxh1LX3mVisXFczKk
         2qIcMb0cL5kVn7I5BiYhK3hyQVqWJ2+gtp1g9A0+E7NVVMU7vYonuzvzkcjTCJXOIooQ
         CzuRrnPxRDX7xjqroGL0+iA1gzkpI13gRzriM1hYNApaN13utszU+MYtdhB+xJ8/a1Ax
         VpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=9kye/8u0dWShCxn+JUHAUOeePnl2nc5861b/EDfdSIU=;
        b=L9UPXZwAbEKm/MhkESbim4WkzKBaYzmjYNHpUaT87PaB0oPdww5HfhoWZNhRnb3xNB
         6tQQEzqCtoO2pIVmEIy19YJL5zzPg8D73e6kvYYIoz2Wf7cs7eemMkNe/Zn58YQkJWyz
         4l5SUzbdIlyaGDa2CMGxzgJpakw5sPbmYQY4oLBlAzruux3Th6RBVRJqkMorEas6gdai
         a/1z4zDbrqFOI32M2AdJeXdEPQGbMaagA06TOVU2480B3jUNKaqX7SKh/Z01OnRL3P+C
         yK037lkoLDQQeAc+/zC91kFCAS37TXEd+WJ0S7WJSJjn+FEX5/wzcWcLfewYu/OhhJou
         Nd7w==
X-Gm-Message-State: ABuFfoiwLZalwtPSYLQT5QET8zRstL+CNVIWBcNSah1hZx6SyJ/jxS6p
        5lSm2MpU/MTYZJW7slKtSamIHQ4x
X-Google-Smtp-Source: ACcGV60U/0dVsFGprVIt4OGOr4VrQrIwFlwciVD9djs0Kb7D9f9OvgmdB2OU7Q41Ym54h7UTyf/cRg==
X-Received: by 2002:a9d:4a4e:: with SMTP id d14mr29720294otj.25.1540255231721;
        Mon, 22 Oct 2018 17:40:31 -0700 (PDT)
Received: from [192.168.8.200] ([104.237.80.63])
        by smtp.gmail.com with ESMTPSA id i15sm11080395otj.53.2018.10.22.17.40.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 17:40:31 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
From:   Mark Anthony Paul Hammond <maphammond@gmail.com>
Subject: kernel 4.19.0 on arm64 raspberry pi disrupts tmux panes on raspberry
 pi aarch64 only.
Message-ID: <ad6bc690-0fcf-8cf9-7a57-35ea00dc37c1@gmail.com>
Date:   Mon, 22 Oct 2018 20:40:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been running Debian Sid (unstable) on a Raspberry Pi 3B+. The 4.18 
kernel series made it possible for me to finally get the Ethernet eth0 
to work, thank you. The native wireless did not work so I added USB 
dongles and the kernel 4.18 and 4.19-rc's would cause kernel panics on 
boot up and would only boot if I unplugged the wireless dongles. The 
4.19 series would however, tolerate the wifi dongles if inserted after 
the booting process. However, the kernel would become unstable depending 
what v4.19-rc* one used. Wireless seems to be stable so far with the 
current stable v4.19.0. My main concern is, that, even though I tested 
all the v4.19-rc's I always reverted to the 4.18 series because, using 
the aarch64 arch, on the Raspberry Pi I use the console exclusively, for 
obvious reasons, it is quicker. The problem started with the 
introduction of the 4.19-rc's. I use tmux and I noticed since day one, 
v4.19-rc1 that when I would switch from one window to another, 
especially to a window with four panes the text from the previous window 
would remain, be transferred to the arriving window to the panes on the 
left side of the screen. I hoped that this would be resolved once 
v4.19.0 became stable and established but upon building the kernel this 
morning, the issue is still present. It seems to be an anomaly only 
affecting the arm64 port because all my x86 machines react normally with 
the 4.19 series kernels running tmux, it only affects my Pi machines 
running arm64 linux kernels since v4.19-rc1. Thank you I hope someone 
can point me to a solution. It takes 8 hours to rebuild a kernel with 
all the modules one could hope to encounter on a Raspberry pi, and 3 
hours for a kernel with only specific modules, just in case anyone 
cared. Thanks for your time and help.

Mark Anthony Paul Hammond.


