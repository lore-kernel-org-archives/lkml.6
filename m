Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65520C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4036220859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfAGLMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:12:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbfAGLMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:12:33 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97BA72D7E4;
        Mon,  7 Jan 2019 11:12:32 +0000 (UTC)
Received: from gondolin (ovpn-117-50.ams2.redhat.com [10.36.117.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1CEA4608C1;
        Mon,  7 Jan 2019 11:12:26 +0000 (UTC)
Date:   Mon, 7 Jan 2019 12:12:24 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alex Williamson <alex.williamson@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio_pci: Add local source directory as include
Message-ID: <20190107121224.6cdb1a9b.cohuck@redhat.com>
In-Reply-To: <20190104195714.30045-1-labbott@redhat.com>
References: <20190104195714.30045-1-labbott@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 07 Jan 2019 11:12:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Jan 2019 11:57:14 -0800
Laura Abbott <labbott@redhat.com> wrote:

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
> ---
>  drivers/vfio/pci/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index 9662c063a6b1..08d4676a8495 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -1,3 +1,4 @@
> +ccflags-y                               += -I$(src)
>  
>  vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
>  vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
