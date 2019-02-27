Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20279C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87D0218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551232491;
	bh=poVlimfAN7xelLtj2d+zX7shrn65yP+oCJOhuuy1vqo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=LaemCkLTmvNNp72Y1boWJzku0X5Y4VjFJQ904NnPXWWfDyb+vl60tYXdrwT+vbrFi
	 pIv7NCtywHdS7uyiH/zVdIKTusfYZt/YcnMdn3sFg8nfzu1ZXHLJfrgXQxFhNq1LHr
	 4kv7d9+pxHpyiEpmMsXAYmd4Sm0tR9GVPBW4pmh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfB0Byt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:54:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729647AbfB0Byt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:54:49 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5470C218D3;
        Wed, 27 Feb 2019 01:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551232487;
        bh=poVlimfAN7xelLtj2d+zX7shrn65yP+oCJOhuuy1vqo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=w41v6euEHe+8ktWqp/uWAGl1VwWPXzyJXaKKJpd4+ChtAvI3nsVJEbnZve+/sSX+w
         4J/qhOb5xKMPQId2nvrFqhGhTZcwPir/wZ0E28G0BuYruMAYVKwjb/ZbAb7rLSgJSg
         LqOnGFmp5vBvQUER2ROmQCUDjmdk03a3JxTGRoOs=
Subject: Re: [PATCH v2 4/5] selftests/ima: kexec_file_load syscall test
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-kselftest@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
 <1551223620-11586-5-git-send-email-zohar@linux.ibm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <e61083af-1d8b-3f6d-ccc3-35e99b3ea94e@kernel.org>
Date:   Tue, 26 Feb 2019 18:54:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1551223620-11586-5-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/19 4:26 PM, Mimi Zohar wrote:
> The kernel can be configured to verify PE signed kernel images, IMA
> kernel image signatures, both types of signatures, or none.  This test
> verifies only properly signed kernel images are loaded into memory,
> based on the kernel configuration and runtime policies.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   tools/testing/selftests/ima/Makefile               |   2 +-
>   tools/testing/selftests/ima/common_lib.sh          |  97 ++++++++++
>   .../testing/selftests/ima/test_kexec_file_load.sh  | 195 +++++++++++++++++++++
>   tools/testing/selftests/ima/test_kexec_load.sh     |   1 -
>   4 files changed, 293 insertions(+), 2 deletions(-)
>   create mode 100755 tools/testing/selftests/ima/test_kexec_file_load.sh
> 
> diff --git a/tools/testing/selftests/ima/Makefile b/tools/testing/selftests/ima/Makefile
> index 46b9e04d2737..049c83c9426c 100644
> --- a/tools/testing/selftests/ima/Makefile
> +++ b/tools/testing/selftests/ima/Makefile
> @@ -4,7 +4,7 @@ uname_M := $(shell uname -m 2>/dev/null || echo not)
>   ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>   
>   ifeq ($(ARCH),x86)
> -TEST_PROGS := test_kexec_load.sh
> +TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh
>   TEST_FILES := common_lib.sh
>   
>   include ../lib.mk
> diff --git a/tools/testing/selftests/ima/common_lib.sh b/tools/testing/selftests/ima/common_lib.sh
> index c6d04006281d..24091f29bd09 100755
> --- a/tools/testing/selftests/ima/common_lib.sh
> +++ b/tools/testing/selftests/ima/common_lib.sh
> @@ -4,6 +4,9 @@
>   # Kselftest framework defines: ksft_pass=0, ksft_fail=1, ksft_skip=4
>   
>   VERBOSE="${VERBOSE:-1}"
> +IKCONFIG="/tmp/config-`uname -r`"
> +KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
> +SECURITYFS=$(grep "securityfs" /proc/mounts | awk '{print $2}')
>   
>   log_info()
>   {
> @@ -55,3 +58,97 @@ get_secureboot_mode()
>   
>   	return $ret
>   }
> +
> +# Look for config option in Kconfig file.
> +# Return 1 for found and 0 for not found.
> +kconfig_enabled()
> +{
> +	local config="$1"
> +	local msg="$2"
> +
> +        grep -E -q $config $IKCONFIG
> +        if [ $? -eq 0 ]; then
> +                log_info "$msg"
> +                return 1
> +        fi
> +        return 0
> +}
> +
> +# Attempt to get the kernel config first via proc, and then by
> +# extracting it from the kernel image or the configs.ko using
> +# scripts/extract-ikconfig.
> +# Return 1 for found and 0 for not found.
> +get_kconfig()
> +{
> +	local proc_config="/proc/config.gz"
> +	local module_dir="/lib/modules/`uname -r`"
> +	local configs_module="$module_dir/kernel/kernel/configs.ko"
> +
> +	if [ ! -f $proc_config ]; then
> +		modprobe configs > /dev/null 2>&1
> +	fi
> +	if [ -f $proc_config ]; then
> +		cat $proc_config | gunzip > $IKCONFIG 2>/dev/null
> +		if [ $? -eq 0 ]; then
> +			return 1
> +		fi
> +	fi
> +
> +	local extract_ikconfig="$module_dir/source/scripts/extract-ikconfig"
> +	if [ ! -f $extract_ikconfig ]; then
> +		log_skip "extract-ikconfig not found"
> +	fi
> +
> +	$extract_ikconfig $KERNEL_IMAGE > $IKCONFIG 2>/dev/null
> +	if [ $? -eq 1 ]; then
> +		if [ ! -f $configs_module ]; then
> +			log_skip "CONFIG_IKCONFIG not enabled"
> +		fi
> +		$extract_ikconfig $configs_module > $IKCONFIG
> +		if [ $? -eq 1 ]; then
> +			log_skip "CONFIG_IKCONFIG not enabled"
> +		fi
> +	fi
> +	return 1
> +}
> +
> +# Make sure that securityfs is mounted
> +mount_securityfs()
> +{
> +	if [ -z $SECURITYFS ]; then
> +		SECURITYFS=/sys/kernel/security
> +		mount -t securityfs security $SECURITYFS
> +	fi
> +
> +	if [ ! -d "$SECURITYFS" ]; then
> +		log_fail "$SECURITYFS :securityfs is not mounted"
> +	fi
> +}
> +
> +# The policy rule format is an "action" followed by key-value pairs.  This
> +# function supports up to two key-value pairs, in any order.
> +# For example: action func=<keyword> [appraise_type=<type>]
> +# Return 1 for found and 0 for not found.
> +check_ima_policy()
> +{
> +	local action=$1
> +	local keypair1="$2"
> +	local keypair2="$3"
> +
> +	mount_securityfs
> +
> +	local ima_policy=$SECURITYFS/ima/policy
> +	if [ ! -e $ima_policy ]; then
> +		log_fail "$ima_policy not found"
> +	fi
> +
> +	if [ -n $keypair2 ]; then
> +		grep -e "^$action.*$keypair1" "$ima_policy" | \
> +			grep -q -e "$keypair2"
> +	else
> +		grep -q -e "^$action.*$keypair1" "$ima_policy"
> +	fi
> +
> +	[ $? -eq 0 ] && ret=1 || ret=0
> +        return $ret
> +}
> diff --git a/tools/testing/selftests/ima/test_kexec_file_load.sh b/tools/testing/selftests/ima/test_kexec_file_load.sh
> new file mode 100755
> index 000000000000..e08c7e6cf28c
> --- /dev/null
> +++ b/tools/testing/selftests/ima/test_kexec_file_load.sh
> @@ -0,0 +1,195 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#

Same here

# SPDX-License-Identifier: GPL-2.0

thanks,
-- Shuah
