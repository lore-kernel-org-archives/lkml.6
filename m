Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF743C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1FE20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1FE20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbeGaBKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 21:10:11 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:58831 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729575AbeGaBKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 21:10:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id DC6F94171A;
        Mon, 30 Jul 2018 23:32:48 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AadnshP2r_YA; Mon, 30 Jul 2018 23:32:48 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 24415418AC;
        Mon, 30 Jul 2018 23:32:36 +0000 (UTC)
Subject: Re: [PATCH] selftests: membarrier: fix test by checking supported
 commands
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, gregkh@linuxfoundation.org,
        mathieu.desnoyers@efficios.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de,
        Shuah Khan <shuah@kernel.org>
References: <20180730160543.19056-1-rafael.tinoco@linaro.org>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <9edf8459-aea1-c59e-5d73-112e986777e1@kernel.org>
Date:   Mon, 30 Jul 2018 17:32:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730160543.19056-1-rafael.tinoco@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 07/30/2018 10:05 AM, Rafael David Tinoco wrote:
> Makes membarrier_test compatible with older kernels (LTS) by checking if
> the membarrier features exist before running the tests.
> 
> Link: https://bugs.linaro.org/show_bug.cgi?id=3771
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> Cc: <stable@vger.kernel.org> #v4.17
> ---
>  .../selftests/membarrier/membarrier_test.c    | 69 +++++++++++--------
>  1 file changed, 41 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/testing/selftests/membarrier/membarrier_test.c b/tools/testing/selftests/membarrier/membarrier_test.c
> index 6793f8ecc8e7..b96caa096e2f 100644
> --- a/tools/testing/selftests/membarrier/membarrier_test.c
> +++ b/tools/testing/selftests/membarrier/membarrier_test.c
> @@ -225,7 +225,14 @@ static int test_membarrier_global_expedited_success(void)
>  
>  static int test_membarrier(void)
>  {
> -	int status;
> +	int supported, status;
> +
> +	supported = sys_membarrier(MEMBARRIER_CMD_QUERY, 0);
> +	if (supported < 0) {
> +		ksft_test_result_fail(
> +			"sys_membarrier() failed to query supported cmds\n");
> +		return supported;
> +	}
>  

ksft_exit_skip() is the right interface to use here. If feature isn't supported,
it should exit skip as opposed fail.

>  	status = test_membarrier_cmd_fail();
>  	if (status)
> @@ -236,21 +243,22 @@ static int test_membarrier(void)
>  	status = test_membarrier_global_success();
>  	if (status)
>  		return status;
> -	status = test_membarrier_private_expedited_fail();
> -	if (status)
> -		return status;
> -	status = test_membarrier_register_private_expedited_success();
> -	if (status)
> -		return status;
> -	status = test_membarrier_private_expedited_success();
> -	if (status)
> -		return status;
> -	status = sys_membarrier(MEMBARRIER_CMD_QUERY, 0);
> -	if (status < 0) {
> -		ksft_test_result_fail("sys_membarrier() failed\n");
> -		return status;
> +
> +	/* commit 22e4ebb975822833b083533035233d128b30e98f added this feature */
> +	if (supported & MEMBARRIER_CMD_PRIVATE_EXPEDITED) {
> +		status = test_membarrier_private_expedited_fail();
> +		if (status)
> +			return status;
> +		status = test_membarrier_register_private_expedited_success();
> +		if (status)
> +			return status;
> +		status = test_membarrier_private_expedited_success();
> +		if (status)
> +			return status;
>  	}
> -	if (status & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
> +
> +	/* commit 70216e18e519a54a2f13569e8caff99a092a92d6 added this feature */
> +	if (supported & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
>  		status = test_membarrier_private_expedited_sync_core_fail();
>  		if (status)
>  			return status;
> @@ -261,19 +269,24 @@ static int test_membarrier(void)
>  		if (status)
>  			return status;
>  	}
> -	/*
> -	 * It is valid to send a global membarrier from a non-registered
> -	 * process.
> -	 */
> -	status = test_membarrier_global_expedited_success();
> -	if (status)
> -		return status;
> -	status = test_membarrier_register_global_expedited_success();
> -	if (status)
> -		return status;
> -	status = test_membarrier_global_expedited_success();
> -	if (status)
> -		return status;
> +
> +	/* commit c5f58bd58f432be5d92df33c5458e0bcbee3aadf added this feature */
> +	if (supported & MEMBARRIER_CMD_GLOBAL_EXPEDITED) {
> +		/*
> +		 * It is valid to send a global membarrier from a non-registered
> +		 * process.
> +		 */
> +		status = test_membarrier_global_expedited_success();
> +		if (status)
> +			return status;
> +		status = test_membarrier_register_global_expedited_success();
> +		if (status)
> +			return status;
> +		status = test_membarrier_global_expedited_success();
> +		if (status)
> +			return status;
> +	}
> +
>  	return 0;
>  }
>  
> 

thanks,
-- Shuah
