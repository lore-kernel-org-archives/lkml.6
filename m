Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnIfFgQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1126660764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752114AbeFFNra (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:47:30 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34248 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751575AbeFFNr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:47:28 -0400
X-Google-Smtp-Source: ADUXVKL4lUlmj0FuPvSx7hCDa8+X28Qq27ya7KFhDb/l58jkJpNCCqxKPigZJBTOMUhq/viqoZwA0dSB2OE0gHdmKUo=
MIME-Version: 1.0
In-Reply-To: <20180606204116.5b01ed36@canb.auug.org.au>
References: <20180606204116.5b01ed36@canb.auug.org.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 6 Jun 2018 15:47:25 +0200
X-Google-Sender-Auth: QYFso4fqB6O_2PjNuBClBo0h99I
Message-ID: <CAK8P3a3YmgpSNC3m8vW=tkMXxVVVR+riuw4=snwhYYW-rP_htg@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the y2038 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 12:41 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> After merging the y2038 tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>
> fs/pstore/ram.c: In function 'ramoops_read_kmsg_hdr':
> fs/pstore/ram.c:39:29: warning: format '%ld' expects argument of type 'long int *', but argument 3 has type 'time64_t * {aka long long int *}' [-Wformat=]
>  #define RAMOOPS_KERNMSG_HDR "===="
>                              ^
> fs/pstore/ram.c:167:21: note: in expansion of macro 'RAMOOPS_KERNMSG_HDR'
>   if (sscanf(buffer, RAMOOPS_KERNMSG_HDR TVSEC_FMT ".%lu-%c\n%n",
>                      ^~~~~~~~~~~~~~~~~~~
> fs/pstore/ram.c:42:23: note: format string is defined here
>  # define TVSEC_FMT "%ld"
>                      ~~^
>                      %lld
> fs/pstore/ram.c:39:29: warning: format '%ld' expects argument of type 'long int *', but argument 3 has type 'time64_t * {aka long long int *}' [-Wformat=]
>  #define RAMOOPS_KERNMSG_HDR "===="
>                              ^
> fs/pstore/ram.c:174:28: note: in expansion of macro 'RAMOOPS_KERNMSG_HDR'
>   } else if (sscanf(buffer, RAMOOPS_KERNMSG_HDR TVSEC_FMT ".%lu\n%n",
>                             ^~~~~~~~~~~~~~~~~~~
> fs/pstore/ram.c:42:23: note: format string is defined here
>  # define TVSEC_FMT "%ld"
>                      ~~^
>                      %lld
> fs/pstore/ram.c: In function 'ramoops_write_kmsg_hdr':
> fs/pstore/ram.c:39:29: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'time64_t {aka long long int}' [-Wformat=]
>  #define RAMOOPS_KERNMSG_HDR "===="
>                              ^
> fs/pstore/ram.c:370:30: note: in expansion of macro 'RAMOOPS_KERNMSG_HDR'
>   hdr = kasprintf(GFP_ATOMIC, RAMOOPS_KERNMSG_HDR TVSEC_FMT ".%lu-%c\n",
>                               ^~~~~~~~~~~~~~~~~~~
> fs/pstore/ram.c:42:23: note: format string is defined here
>  # define TVSEC_FMT "%ld"
>                      ~~^
>                      %lld
>
> Introduced by commit
>
>   0f0d83b99ef7 ("pstore: Convert internal records to timespec64")
>

Thanks for the report, I had actually provided a fix for this earlier
(it was a clash
between a patch in Deepa's tree with one of mine that Thomas had picked up
into tip) but forgot to apply it before I pushed out the merged tree.

I've updated my tree now.

      Arnd
