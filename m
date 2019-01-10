Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3303CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010C521783
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfAJOrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:47:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:54362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbfAJOrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:47:09 -0500
Received: from home.goodmis.org (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5379720660;
        Thu, 10 Jan 2019 14:47:08 +0000 (UTC)
Date:   Thu, 10 Jan 2019 09:47:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        Laura Abbott <labbott@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio_pci: set TRACE_INCLUDE_PATH to fix the build error
Message-ID: <20190110144701.ah3hmedqmyqf5uzt@home.goodmis.org>
References: <1546916883-25911-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546916883-25911-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 12:08:03PM +0900, Masahiro Yamada wrote:
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

Note, the reason why I did not show this method in the samples/trace_events/
is that there's one "gotcha" that you need to be careful about. It may not be
an issue here, but please be aware of it.

The words in TRACE_INCLUDE_PATH can be updated by C preprocessor defines. For
example, if for some reason you had:

#define pci special_pci

The above would turn into:

 ../../drivers/vfio/special_pci

and it wont build, and you will be left scratching your head wondering why.

-- Steve

>  #undef TRACE_INCLUDE_FILE
>  #define TRACE_INCLUDE_FILE trace
>  
> -- 
> 2.7.4
