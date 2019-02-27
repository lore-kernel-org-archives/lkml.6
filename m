Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2CCC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A320B218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551231600;
	bh=pyn7sKv/4MDDxpHvsYd0zxnS5CrV2/9VPUf3yt+quxY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=RFexK8JmM8idp6tCOwSpYQfOUUgemYqCi6adCqPKZFrTlpcbMa0hyklxy7/WDOdg8
	 uSpyk0B3hqjgWdp4Bk6oxU8NH84Zs0HZg6cdFVTkrN0aaPAfp+oagmdjMtvEdEJK0p
	 FH1KmsTvOv3WiHIO/3vfXGBhRQl1x2tEpN1oHu2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfB0Bj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:39:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:41672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729187AbfB0Bj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:39:59 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E01E218D8;
        Wed, 27 Feb 2019 01:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551231598;
        bh=pyn7sKv/4MDDxpHvsYd0zxnS5CrV2/9VPUf3yt+quxY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=xM8lNt5TRQ/fxGQhC0NsDsa6fcWnk1lg8CNsor0+VJ0rB3H4u5XlNrXN+INoLmbzP
         JRHRtDa0UQif6kpIxkh9Go+kZgsQrjvz2j8dpHhG6zxANb0LXdBlWP9HzV8ytwYEc7
         3C1U3KQf8xXg4Mur4dVmYq6UuXi5/utAV5SYOVVA=
Subject: Re: [PATCH v2 3/5] selftests/ima: define common logging functions
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-kselftest@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
 <1551223620-11586-4-git-send-email-zohar@linux.ibm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <69140d9c-7e76-9ef7-31af-65208a126f4b@kernel.org>
Date:   Tue, 26 Feb 2019 18:39:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1551223620-11586-4-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/19 4:26 PM, Mimi Zohar wrote:
> Define log_info, log_pass, log_fail, and log_skip functions.
> 
> Suggested-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   tools/testing/selftests/ima/common_lib.sh      | 43 +++++++++++++++++++++++---
>   tools/testing/selftests/ima/test_kexec_load.sh | 19 +++---------
>   2 files changed, 43 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/testing/selftests/ima/common_lib.sh b/tools/testing/selftests/ima/common_lib.sh
> index 5583ea74c14e..c6d04006281d 100755
> --- a/tools/testing/selftests/ima/common_lib.sh
> +++ b/tools/testing/selftests/ima/common_lib.sh
> @@ -1,5 +1,36 @@
>   #!/bin/sh
>   # SPDX-License-Identifier: GPL-2.0-or-later

Same here:

# SPDX-License-Identifier: GPL-2.0

thanks,
-- Shuah
