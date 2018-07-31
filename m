Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A6EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECF72083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECF72083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbeGaWyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:54:02 -0400
Received: from www62.your-server.de ([213.133.104.62]:60469 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbeGaWyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:54:02 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fkbvj-00007B-3f; Tue, 31 Jul 2018 23:11:43 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fkbvi-0002su-V7; Tue, 31 Jul 2018 23:11:42 +0200
Subject: Re: [PATCH] lib/bpf/libbpf: Simplify the code by using
 PTR_ERR_OR_ZERO
To:     zhong jiang <zhongjiang@huawei.com>, ast@kernel.org,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533054656-36134-1-git-send-email-zhongjiang@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4291dac0-8384-c357-1409-4a765bb70fb7@iogearbox.net>
Date:   Tue, 31 Jul 2018 23:11:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1533054656-36134-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24800/Tue Jul 31 18:43:36 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2018 06:30 PM, zhong jiang wrote:
> Use PTR_ERR_OR_ZERO is better than the open code.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  tools/lib/bpf/libbpf.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 40211b5..9b61468 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2271,9 +2271,7 @@ struct bpf_map *
>  
>  long libbpf_get_error(const void *ptr)
>  {
> -	if (IS_ERR(ptr))
> -		return PTR_ERR(ptr);
> -	return 0;
> +	return PTR_ERR_OR_ZERO(ptr);
>  }
>  
>  int bpf_prog_load(const char *file, enum bpf_prog_type type,
> 

Looks like you didn't even bother to try to compile your change ...

# make
Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'
  CC       libbpf.o
  CC       nlattr.o
  CC       btf.o
  CC       bpf.o
  CC       libbpf_errno.o
libbpf.c: In function ‘libbpf_get_error’:
libbpf.c:2269:9: error: implicit declaration of function ‘PTR_ERR_OR_ZERO’ [-Werror=implicit-function-declaration]
  return PTR_ERR_OR_ZERO(ptr);
         ^~~~~~~~~~~~~~~
libbpf.c:2269:2: error: nested extern declaration of ‘PTR_ERR_OR_ZERO’ [-Werror=nested-externs]
  return PTR_ERR_OR_ZERO(ptr);
  ^~~~~~
cc1: all warnings being treated as errors

