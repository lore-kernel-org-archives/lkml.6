Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F684C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493F521783
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfAGI6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:58:09 -0500
Received: from ozlabs.org ([203.11.71.1]:50873 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfAGI6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:58:08 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Y8Ry2rHbz9sDP;
        Mon,  7 Jan 2019 19:58:06 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Laura Abbott <labbott@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Laura Abbott <labbott@redhat.com>, kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio_pci: Add local source directory as include
In-Reply-To: <20190104195714.30045-1-labbott@redhat.com>
References: <20190104195714.30045-1-labbott@redhat.com>
Date:   Mon, 07 Jan 2019 19:58:02 +1100
Message-ID: <874lakc09x.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laura Abbott <labbott@redhat.com> writes:
> Commit 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2]
> subdriver") introduced a trace.h file in the local directory but
> missed adding the local include path, resulting in compilation
> failures with tracepoints:
>
> In file included from drivers/vfio/pci/trace.h:102,
>                  from drivers/vfio/pci/vfio_pci_nvlink2.c:29:
> ./include/trace/define_trace.h:89:42: fatal error: ./trace.h: No such file or directory
>  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>
> Fix this by adjusting the include path.
>
> Fixes: 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver")
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> I'd still like to echo my sentiment that this should not be a def_bool.
> We hit this error on our internal testing and we couldn't even turn
> off the driver until we fixed this.

I assume there's some reason you can't commit a patch to your tree to
change it to bool, or turn it off entirely? That would change the SHA
which is perhaps reason enough.

In general we have far too many options and most of them never get
turned off (or on), so it just creates testing/bug surface for not much
benefit. This is one that will probably be turned on in all distro
kernels for example.

But I have no real objection to making it user configurable.


Alex I assume you'll merge this fix via the vfio tree?

cheers

> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index 9662c063a6b1..08d4676a8495 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -1,3 +1,4 @@
> +ccflags-y                               += -I$(src)
>  
>  vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
>  vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
> -- 
> 2.20.1
