Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF274C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DCA206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DCA206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeIVEow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:44:52 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:50116 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725750AbeIVEow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:44:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id B4293C13DF;
        Fri, 21 Sep 2018 22:53:50 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9kd2_r0P_uQ4; Fri, 21 Sep 2018 22:53:50 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 768A9C0D4A;
        Fri, 21 Sep 2018 22:53:44 +0000 (UTC)
Subject: Re: [PATCH v4] selftests: membarrier: reorganized test for LTS
 supportability
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <1a86c3c5-66f5-24d8-4fcc-367302ecec35@kernel.org>
 <20180903190457.27088-1-rafael.tinoco@linaro.org>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <dcc20b51-3069-6854-3190-b8958e2f9b96@kernel.org>
Date:   Fri, 21 Sep 2018 16:53:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903190457.27088-1-rafael.tinoco@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2018 01:04 PM, Rafael David Tinoco wrote:
> This commit re-organizes membarrier test, solving issues when testing
> LTS kernels. Now, the code:
> 
>  - always run the same amount of tests (even on older kernels).
>  - allows each test to succeed, fail or be skipped independently.
>  - allows testing features even when explicitly unsupported (force=1).
>  - able to consider different return codes for diff kernel versions.
>  - checks false positive/negative by checking ret code and errno.
>  - can be extended easily: to expand an array with commands.
> 
> Link: https://bugs.linaro.org/show_bug.cgi?id=3771
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> ---
>  .../selftests/membarrier/membarrier_test.c    | 482 +++++++++---------
>  1 file changed, 241 insertions(+), 241 deletions(-)
> 
> diff --git a/tools/testing/selftests/membarrier/membarrier_test.c b/tools/testing/selftests/membarrier/membarrier_test.c
> index 6793f8ecc8e7..151bc8a944a3 100644
> --- a/tools/testing/selftests/membarrier/membarrier_test.c
> +++ b/tools/testing/selftests/membarrier/membarrier_test.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #define _GNU_SOURCE
>  #include <linux/membarrier.h>
> +#include <sys/utsname.h>
>  #include <syscall.h>
>  #include <stdio.h>
>  #include <errno.h>
> @@ -8,305 +9,304 @@
>  
>  #include "../kselftest.h"
>  
> -static int sys_membarrier(int cmd, int flags)
> +#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> +#define KERNEL_VERSION(a, b, c) (((a) << 16) + ((b) << 8) + (c))
> +
> +struct memb_tests {
> +	char testname[80];
> +	int command;
> +	int flags;
> +	int exp_ret;
> +	int exp_errno;
> +	int enabled;
> +	int force;
> +	int force_exp_errno;
> +	int above;
> +	int bellow;
> +};
> +
> +struct memb_tests mbt[] = {
> +	{
> +	 .testname = "cmd_fail\0",
> +	 .command = -1,
> +	 .exp_ret = -1,
> +	 .exp_errno = EINVAL,
> +	 .enabled = 1,
> +	 },
> +	{
> +	 .testname = "cmd_flags_fail\0",
> +	 .command = MEMBARRIER_CMD_QUERY,
> +	 .flags = 1,
> +	 .exp_ret = -1,
> +	 .exp_errno = EINVAL,
> +	 .enabled = 1,
> +	 },
> +	{
> +	 .testname = "cmd_global_success\0",
> +	 .command = MEMBARRIER_CMD_GLOBAL,
> +	 .flags = 0,
> +	 .exp_ret = 0,
> +	 },
> +	/*
> +	 * PRIVATE EXPEDITED (forced)
> +	 */
> +	{
> +	 .testname = "cmd_private_expedited_fail\0",
> +	 .command = MEMBARRIER_CMD_PRIVATE_EXPEDITED,
> +	 .flags = 0,
> +	 .exp_ret = -1,
> +	 .exp_errno = EPERM,
> +	 .force = 1,
> +	 .force_exp_errno = EINVAL,
> +	 .bellow = KERNEL_VERSION(4, 10, 0),
> +	 },
> +	{
> +	 .testname = "cmd_private_expedited_fail\0",
> +	 .command = MEMBARRIER_CMD_PRIVATE_EXPEDITED,
> +	 .flags = 0,
> +	 .exp_ret = -1,
> +	 .exp_errno = EPERM,
> +	 .force = 1,
> +	 .force_exp_errno = EPERM,
> +	 .above = KERNEL_VERSION(4, 10, 0),
> +	 },
> +	{
> +	 .testname = "cmd_register_private_expedited_success\0",
> +	 .command = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED,
> +	 .flags = 0,
> +	 .exp_ret = 0,
> +	 .force = 1,
> +	 .force_exp_errno = EINVAL,
> +	 },
> +	{
> +	 .testname = "cmd_private_expedited_success\0",
> +	 .command = MEMBARRIER_CMD_PRIVATE_EXPEDITED,
> +	 .flags = 0,
> +	 .exp_ret = 0,
> +	 .force = 1,
> +	 .force_exp_errno = EINVAL,
> +	 },
> +	 /*
> +	  * PRIVATE EXPEDITED SYNC CORE
> +	  */
> +	{
> +	 .testname = "cmd_private_expedited_sync_core_fail\0",
> +	 .command = MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE,
> +	 .flags = 0,
> +	 .exp_ret = -1,
> +	 .exp_errno = EPERM,
> +	 },
> +	{
> +	 .testname = "cmd_register_private_expedited_sync_core_success\0",
> +	 .command = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE,
> +	 .flags = 0,
> +	 .exp_ret = 0,
> +	 },
> +	{
> +	 .testname = "cmd_private_expedited_sync_core_success\0",
> +	 .command = MEMBARRIER_CMD_PRIVATE_EXPEDITED,
> +	 .flags = 0,
> +	 .exp_ret = 0,
> +	 },
> +	/*
> +	 * GLOBAL EXPEDITED
> +	 * global membarrier from a non-registered process is valid
> +	 */
> +	{
> +	 .testname = "cmd_global_expedited_success\0",
> +	 .command = MEMBARRIER_CMD_GLOBAL_EXPEDITED,
> +	 .flags = 0,
> +	 .exp_ret = 0,
> +	 },
> +	{
> +	 .testname = "cmd_register_global_expedited_success\0",
> +	 .command = MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED,
> +	 .flags = 0,
> +	 .exp_ret = 0,
> +	 },
> +	{
> +	 .testname = "cmd_global_expedited_success\0",
> +	 .command = MEMBARRIER_CMD_GLOBAL_EXPEDITED,
> +	 .flags = 0,
> +	 .exp_ret = 0,
> +	 },
> +};
> +
> +static void
> +info_passed_ok(struct memb_tests test)
>  {
> -	return syscall(__NR_membarrier, cmd, flags);
> +	ksft_test_result_pass("sys_membarrier(): %s succeeded.\n",
> +			test.testname);
>  }
>  

Why do we need to add new routines for these conditions. Why can't handle
these strings in array. For example you can define an array of strings for

passed unexpectedly etc. and the pass the string to appropriate ksft_* interface
instead of adding of these routines. Also it is hard to review the code this way.

I do like the direction though. Also please run get_maintainer.pl and cc everybody
it suggests.

thanks,
-- Shuah

