Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E301C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E801F2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E801F2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933773AbeGJOur (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:50:47 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:60697 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933248AbeGJOun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:50:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 0C3B6218C6;
        Tue, 10 Jul 2018 14:50:43 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0yrjOJ49F2sY; Tue, 10 Jul 2018 14:50:43 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 0FDBC218BC;
        Tue, 10 Jul 2018 14:50:36 +0000 (UTC)
Subject: Re: [PATCH 2/3] selftests/android: initialize heap_type to avoid
 compiling warning
To:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pintu Agarwal <pintu.ping@gmail.com>, Shuah Khan <shuah@kernel.org>
References: <1530503634-32241-1-git-send-email-lizhijian@cn.fujitsu.com>
 <1530503634-32241-2-git-send-email-lizhijian@cn.fujitsu.com>
 <1530503634-32241-3-git-send-email-lizhijian@cn.fujitsu.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <1f24bf06-88cb-8d09-febf-02ff55ec263a@kernel.org>
Date:   Tue, 10 Jul 2018 08:50:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530503634-32241-3-git-send-email-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li Zhijian,

On 07/01/2018 09:53 PM, Li Zhijian wrote:
> root@vm-lkp-nex04-8G-7 ~/linux-v4.18-rc2/tools/testing/selftests/android# make
> make[1]: warning: jobserver unavailable: using -j1.  Add '+' to parent make rule.
> make[1]: Entering directory '/root/linux-v4.18-rc2/tools/testing/selftests/android/ion'
> gcc  -I. -I../../../../../drivers/staging/android/uapi/ -I../../../../../usr/include/ -Wall -O2 -g    ionapp_export.c ipcsocket.c ionutils.c   -o ionapp_export
> ionapp_export.c: In function 'main':
> ionapp_export.c:91:2: warning: 'heap_type' may be used uninitialized in
> this function [-Wmaybe-uninitialized]
>   printf("heap_type: %ld, heap_size: %ld\n", heap_type, heap_size);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> CC: Shuah Khan <shuah@kernel.org>
> CC: Pintu Agarwal <pintu.ping@gmail.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  tools/testing/selftests/android/ion/ionapp_export.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/android/ion/ionapp_export.c b/tools/testing/selftests/android/ion/ionapp_export.c
> index a944e72..e3435c2 100644
> --- a/tools/testing/selftests/android/ion/ionapp_export.c
> +++ b/tools/testing/selftests/android/ion/ionapp_export.c
> @@ -49,6 +49,7 @@ int main(int argc, char *argv[])
>  		return -1;
>  	}
>  
> +	heap_type = -1UL;

Initialize it to one of the valid types. ION_HEAP_TYPE_SYSTEM
is one choice.


>  	heap_size = 0;
>  	flags = 0;
>  
> @@ -82,6 +83,12 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  
> +	if (heap_type == -1UL) {
> +		printf("heap_type is invalid\n");
> +		print_usage(argc, argv);
> +		exit(1);
> +	}

This check isn't necessary. The test requires two arguments,
-i <heap id> and -s <size in bytes> and won't run without either
one of them. heap_type is going to be ION_HEAP_TYPE_SYSTEM or
ION_HEAP_TYPE_SYSTEM_CONTIG at this point.

Interesting. Looks like this test doesn't cover all ion_heap_types.

thanks,
-- Shuah
