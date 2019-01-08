Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE48C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491BC2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfAHJrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:47:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60289 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbfAHJrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:47:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1F4BF87A6;
        Tue,  8 Jan 2019 09:47:36 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 310807ED7F;
        Tue,  8 Jan 2019 09:47:35 +0000 (UTC)
Date:   Tue, 8 Jan 2019 10:47:32 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        Laura Abbott <labbott@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio_pci: set TRACE_INCLUDE_PATH to fix the build error
Message-ID: <20190108104732.42c1e2a9.cohuck@redhat.com>
In-Reply-To: <1546916883-25911-1-git-send-email-yamada.masahiro@socionext.com>
References: <1546916883-25911-1-git-send-email-yamada.masahiro@socionext.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 08 Jan 2019 09:47:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Jan 2019 12:08:03 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> drivers/vfio/pci/vfio_pci_nvlink2.c cannot be compiled for in-tree
> building.
> 
>     CC      drivers/vfio/pci/vfio_pci_nvlink2.o
>   In file included from drivers/vfio/pci/trace.h:102,
>                    from drivers/vfio/pci/vfio_pci_nvlink2.c:29:
>   ./include/trace/define_trace.h:89:42: fatal error: ./trace.h: No such file or directory
>    #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>                                           ^
>   compilation terminated.
>   make[1]: *** [scripts/Makefile.build;277: drivers/vfio/pci/vfio_pci_nvlink2.o] Error 1
> 
> To fix the build error, let's tell include/trace/define_trace.h the
> location of drivers/vfio/pci/trace.h
> 
> Fixes: 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver")
> Reported-by: Laura Abbott <labbott@redhat.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/vfio/pci/trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/trace.h b/drivers/vfio/pci/trace.h
> index 228ccdb..4d13e51 100644
> --- a/drivers/vfio/pci/trace.h
> +++ b/drivers/vfio/pci/trace.h
> @@ -94,7 +94,7 @@ TRACE_EVENT(vfio_pci_npu2_mmap,
>  #endif /* _TRACE_VFIO_PCI_H */
>  
>  #undef TRACE_INCLUDE_PATH
> -#define TRACE_INCLUDE_PATH .
> +#define TRACE_INCLUDE_PATH ../../drivers/vfio/pci
>  #undef TRACE_INCLUDE_FILE
>  #define TRACE_INCLUDE_FILE trace
>  

I think both this and the other fix option via the Makefile are fine
(even though I still slightly prefer the latter), so I'll leave the
choice to the maintainer.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
