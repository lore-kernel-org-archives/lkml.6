Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A713C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E802520C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E802520C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389652AbeGKQWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:22:49 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:43623 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733263AbeGKQWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:22:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 3A6C541845;
        Wed, 11 Jul 2018 16:17:45 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bKHQOHrj915V; Wed, 11 Jul 2018 16:17:45 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id D315D41831;
        Wed, 11 Jul 2018 16:17:38 +0000 (UTC)
Subject: Re: [PATCH v2] selftests/android: initialize heap_type to avoid
 compiling warning
To:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pintu Agarwal <pintu.ping@gmail.com>, Shuah Khan <shuah@kernel.org>
References: <1531274880-9375-1-git-send-email-lizhijian@cn.fujitsu.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <53f02d65-9a91-2661-3052-d46032389e3a@kernel.org>
Date:   Wed, 11 Jul 2018 10:17:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531274880-9375-1-git-send-email-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2018 08:08 PM, Li Zhijian wrote:
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
>  tools/testing/selftests/android/ion/ionapp_export.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/android/ion/ionapp_export.c b/tools/testing/selftests/android/ion/ionapp_export.c
> index a944e72..b5fa0a2 100644
> --- a/tools/testing/selftests/android/ion/ionapp_export.c
> +++ b/tools/testing/selftests/android/ion/ionapp_export.c
> @@ -51,6 +51,7 @@ int main(int argc, char *argv[])
>  
>  	heap_size = 0;
>  	flags = 0;
> +	heap_type = ION_HEAP_TYPE_SYSTEM;
>  
>  	while ((opt = getopt(argc, argv, "hi:s:")) != -1) {
>  		switch (opt) {
> 

Thanks. Applied to linux-kselftest next after updating the commit message

"Initialize heap_type to ION_HEAP_TYPE_SYSTEM to avoid "used uninitialized"
compiler warning. heap_type gets used after initialization, this change is
to just keep the compiler happy."

thanks,
-- Shuah

