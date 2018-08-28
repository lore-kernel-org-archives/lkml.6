Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A58AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3FF2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3FF2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeH1Whg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:37:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33332 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeH1Whg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:37:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id h9-v6so2128665edr.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 11:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PBRYW+J0UI/lmKD9xTmQZEnXxzE2i3mwTfLh35X3dzQ=;
        b=M6SvYzRkd/B12VNnKo4fcUsxxKd+W5SqPVpE3EDX+YUVf0CWxDlrzqM8RmPvKHpnT0
         mzfeNzCS2ZVkvmKV+j+HfAYx2zcCo92m1jUuE3pCDqhpduCtON5wAAntbtIQTWeFyFjP
         n1PWfc62C+3pnwUw0K0ys+fuZpKuG4Qu529e0Wv5ctJSdtOf/7PRxtF3Od+Kyw4RaMFd
         Lr7CREVNe6MsNw0yc6m8MMAimpcRz/pObqnO4/BdbfQKis4Zwuch9uEFomGwyVhS85cE
         un/Ax9pBRzf5qFvOjlHBZe8aB3OXPpJdPkN2d5D9R5aK5LMsddre96RyHQN+/70gk2ja
         S0Xw==
X-Gm-Message-State: APzg51Cb+57/9NIh+sKBYaFCr6IOdItfmYjEKvLr9BONqpA0us5YHNrQ
        p0W8MIKqAf+h+Ic5ExqM9FpJYHD6X1U=
X-Google-Smtp-Source: ANB0VdbWornLdzYi5pxL0YeI7S+mvR6JCwWCmxnBQaU/n2HZoEPByeegnA8sRCUIOUneWAPPWrJbOw==
X-Received: by 2002:a50:b2c6:: with SMTP id p64-v6mr3835558edd.293.1535481879281;
        Tue, 28 Aug 2018 11:44:39 -0700 (PDT)
Received: from kozik-lap (xdsl-188-155-58-14.adslplus.ch. [188.155.58.14])
        by smtp.googlemail.com with ESMTPSA id v14-v6sm1058933edm.97.2018.08.28.11.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 11:44:38 -0700 (PDT)
Date:   Tue, 28 Aug 2018 20:44:37 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: regression: broken ppc64le build with CONFIG_KERNEL_XZ=y
Message-ID: <20180828184437.nyqtlvswlylbpbfj@kozik-lap>
References: <20180827113037.gbtnbhcwebcwei57@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180827113037.gbtnbhcwebcwei57@unicorn.suse.cz>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 01:30:37PM +0200, Michal Kubecek wrote:
> Building 4.19-rc1 kernel with CONFIG_KERNEL_XZ=y fails with this error:
> 
>   BOOTCC  arch/powerpc/boot/decompress.o
> In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:233,
>                  from arch/powerpc/boot/decompress.c:42:
> arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:10: fatal error: linux/crc32poly.h: No such file or directory
>  #include <linux/crc32poly.h>
>           ^~~~~~~~~~~~~~~~~~~
> 
> This is caused by commit faa16bc404d7 ("lib: Use existing define with
> polynomial") which added include of <linux/crc32poly.h>; when compiling
> arch/powerpc/boot/decompress.c, the include/ directory is not searched
> so that the header file is not found.
> 
> The solution is probably adding -I directive to some place in
> arch/powerpc/boot/Makefile but I don't dare to guess where.

Hi,

Thanks for letting know. I wonder why kbuild test robot did not catch
this... I just got back from vacation so I will need few days to look
into it.

Best regards,
Krzysztof
