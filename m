Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E89C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 23:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006342070C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 23:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfAFXf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 18:35:56 -0500
Received: from ozlabs.org ([203.11.71.1]:54359 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfAFXfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 18:35:55 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43XvzD45bCz9s7h;
        Mon,  7 Jan 2019 10:35:50 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnd Bergmann <arnd@arndb.de>,
        Finn Thain <fthain@telegraphics.com.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v8 24/25] powerpc: Adopt nvram module for PPC64
In-Reply-To: <CAK8P3a2p91XJfJuSCZqRLRgC-aP3LR1tMK2DDxTiSuD8_FOg8Q@mail.gmail.com>
References: <cover.1545784679.git.fthain@telegraphics.com.au> <2fe2b8e6395aeacfafcbde590a50922d4e632189.1545784679.git.fthain@telegraphics.com.au> <CAK8P3a2p91XJfJuSCZqRLRgC-aP3LR1tMK2DDxTiSuD8_FOg8Q@mail.gmail.com>
Date:   Mon, 07 Jan 2019 10:36:10 +1100
Message-ID: <8736q5xst1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:
> On Wed, Dec 26, 2018 at 1:43 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>
>> +static ssize_t ppc_nvram_get_size(void)
>> +{
>> +       if (ppc_md.nvram_size)
>> +               return ppc_md.nvram_size();
>> +       return -ENODEV;
>> +}
>
>> +const struct nvram_ops arch_nvram_ops = {
>> +       .read           = ppc_nvram_read,
>> +       .write          = ppc_nvram_write,
>> +       .get_size       = ppc_nvram_get_size,
>> +       .sync           = ppc_nvram_sync,
>> +};
>
> Coming back to this after my comment on the m68k side, I notice that
> there is now a double indirection through function pointers. Have you
> considered completely removing the operations from ppc_md instead
> by having multiple copies of nvram_ops?
>
> With the current method, it does seem odd to have a single
> per-architecture instance of the exported structure containing
> function pointers. This doesn't give us the flexibility of having
> multiple copies in the kernel the way that ppc_md does, but it adds
> overhead compared to simply exporting the functions directly.

Yeah TBH I'm not convinced the arch ops is the best solution.

Why can't each arch just implement the required ops functions? On ppc
we'd still use ppc_md but that would be a ppc detail.

Optional ops are fairly easy to support by providing a default
implementation, eg. instead of:

+	if (arch_nvram_ops.get_size == NULL)
+		return -ENODEV;
+
+	nvram_size = arch_nvram_ops.get_size();
+	if (nvram_size < 0)
+		return nvram_size;


We do in some header:

#ifndef arch_nvram_get_size
static inline int arch_nvram_get_size(void)
{
	return -ENODEV;
}
#endif

And then:

	nvram_size = arch_nvram_get_size();
	if (nvram_size < 0)
		return nvram_size;


But I haven't digested the whole series so maybe I'm missing something?

cheers
