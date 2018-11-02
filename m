Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89825C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D46F20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fmHmgWsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D46F20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbeKCBph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:45:37 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40161 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeKCBpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:45:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id t22-v6so2285503lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 09:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YMtQVwW5HLRJnJy+IgvXD+FW8D0Noi+dI/SWfC0ibEk=;
        b=fmHmgWskuZcMw1lEzD3UvRrQDeleRHT8o+fUqDmA3QHCwvjMD2kwfOpygzeVkdSH39
         halRBw43KzA6uvxxELLh6nE9pRiHlT4EY07kdFtmsY7Kxrrp5pZ51SR9erkRAM0wWaii
         D13Yg1kHWhdWCUoKh/E8wxCURpjOOCs5EsXe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YMtQVwW5HLRJnJy+IgvXD+FW8D0Noi+dI/SWfC0ibEk=;
        b=F8bz5hPkhg2RXnEnkxh1GW9EEpZAF/pt+q2WbAIHUtHG//HAIiDvgT2Ws86nMMevN7
         G1IpApcaoO8JYLqD+TAZTrxJgIF6ro2YKh0BFMEQ2a9blbJWhYTjPeb0KuYah7Q535xc
         h7K+6BsJ5B/lbl5v/xr1vEmNuSJ6DZnbUsFQAZ2wc1x24v3+ns0sHj0oBPuSRX7eyaM4
         h9uA7jaLAqCUyX/coImen2nEQKtFG4+OEfRs9/63zmO45C1XH3QzhcwxEAee0NJGBhS2
         VfTPJJY+TmwQDVkelKDDdXCQRgi1R62kdLoTB5hmCNenfuIDb7lmQyERegGwRgA/Ur+V
         IE0w==
X-Gm-Message-State: AGRZ1gJ6wV1lh84xC5eEPKQlcD9vXUwVY8iAiVDncCZce5IR1ZEmeXUL
        8xk51nHXIcxJeOe4M8mTfXoR9vt8p2T9LQ==
X-Google-Smtp-Source: AJdET5eSq6ejipNGg5ChsHO5wYzctiTcxcdx3aq3IfbS83i07A4J+uNIpWvK9DfRyINacuV4NsP7oQ==
X-Received: by 2002:a2e:4218:: with SMTP id p24-v6mr8049148lja.58.1541176671733;
        Fri, 02 Nov 2018 09:37:51 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id t6-v6sm5048918ljd.2.2018.11.02.09.37.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 09:37:50 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id m18-v6so1733691lfl.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 09:37:50 -0700 (PDT)
X-Received: by 2002:a19:982:: with SMTP id 124mr1705724lfj.138.1541176669963;
 Fri, 02 Nov 2018 09:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <874lczemmh.fsf@concordia.ellerman.id.au>
In-Reply-To: <874lczemmh.fsf@concordia.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Nov 2018 09:37:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAtG1mQ0usihPbAgvo=R_z8fpkePsZfE8ozg=H2VME_g@mail.gmail.com>
Message-ID: <CAHk-=wiAtG1mQ0usihPbAgvo=R_z8fpkePsZfE8ozg=H2VME_g@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.20-2 tag
To:     mpe@ellerman.id.au
Cc:     aravinda@linux.vnet.ibm.com, camelia.groza@nxp.com,
        christophe.leroy@c-s.fr, felipe.rechia@datacom.com.br,
        joel@jms.id.au, leitao@debian.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, naveen.n.rao@linux.vnet.ibm.com,
        oss@buserror.net, paulus@ozlabs.org, segher@kernel.crashing.org,
        tyreld@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 4:37 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> powerpc fixes for 4.20 #2

Pulled,

                    Linus
