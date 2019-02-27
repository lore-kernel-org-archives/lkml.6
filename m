Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E009C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F310A218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551232793;
	bh=F7zlZZAMeF7Z62l+tPnZdxmk+qxlE0UQOW4vo/F3WCM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=nRVuCbkCIQv2Azi681Ak3A7qRWyAWViM2PKrNkCRnJQDixPLDOWgqCo555ZWEn1Jf
	 cX59Yv3JZ2WD3T42Fw3Zv5ftXs7v2sCQ6ybYrXxxSIaukX60IQU1NfREzCb9VZHjzk
	 hZEEW9yhpfYSgcSfwSkLSyzkwh7qDOVOF+98x4qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbfB0B7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:59:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729464AbfB0B7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:59:51 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CC51218CD;
        Wed, 27 Feb 2019 01:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551232789;
        bh=F7zlZZAMeF7Z62l+tPnZdxmk+qxlE0UQOW4vo/F3WCM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MIYjHX1MNk5yYfw1J80BuJAzqe3U/k4uuUxndb+yZHgPoc4T7ZM8CNxBtAMKSL5tt
         9WUpp+/dBBtbem02b/414P2/RIF8ONBs2CQjpaDmSKa0n9ovfyQpZV41XWxktubxTf
         m4tY+GwjC7QXrRr44LnLrh88+1yEUFbuZD58BDfA=
Subject: Re: [PATCH v2 5/5] selftests/ima: loading kernel modules
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-kselftest@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
 <1551223620-11586-6-git-send-email-zohar@linux.ibm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <19d494c6-ecb1-b884-2d23-5f556b3ec05b@kernel.org>
Date:   Tue, 26 Feb 2019 18:59:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1551223620-11586-6-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/19 4:27 PM, Mimi Zohar wrote:
> While the appended kernel module signature can be verified, when loading
> a kernel module via either the init_module or the finit_module syscall,
> verifying the IMA signature requires access to the file descriptor,
> which is only available via the finit_module syscall.  As "modprobe"
> does not provide a flag allowing the syscall - init_module or
> finit_module - to be specified, this patch does not load a kernel
> module.
> 
> This test simply verifies that on secure boot enabled systems with
> "CONFIG_IMA_ARCH_POLICY" configured, that at least an appended kernel
> module signature or an IMA signature is required based on the Kconfig
> and the runtime IMA policy.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   tools/testing/selftests/ima/Makefile              |  2 +-
>   tools/testing/selftests/ima/test_kernel_module.sh | 96 +++++++++++++++++++++++
>   2 files changed, 97 insertions(+), 1 deletion(-)
>   create mode 100755 tools/testing/selftests/ima/test_kernel_module.sh
> 
> diff --git a/tools/testing/selftests/ima/Makefile b/tools/testing/selftests/ima/Makefile
> index 049c83c9426c..ef5201ff0bea 100644
> --- a/tools/testing/selftests/ima/Makefile
> +++ b/tools/testing/selftests/ima/Makefile
> @@ -4,7 +4,7 @@ uname_M := $(shell uname -m 2>/dev/null || echo not)
>   ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>   
>   ifeq ($(ARCH),x86)
> -TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh
> +TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh test_kernel_module.sh
>   TEST_FILES := common_lib.sh
>   
>   include ../lib.mk
> diff --git a/tools/testing/selftests/ima/test_kernel_module.sh b/tools/testing/selftests/ima/test_kernel_module.sh
> new file mode 100755
> index 000000000000..4009e1b60b03
> --- /dev/null
> +++ b/tools/testing/selftests/ima/test_kernel_module.sh
> @@ -0,0 +1,96 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later

Same here

# SPDX-License-Identifier: GPL-2.0

> +#
> +# On secure boot enabled systems with "CONFIG_IMA_ARCH_POLICY" configured,
> +# this test verifies that at least an appended kernel module signature or
> +# an IMA signature is required.  It does not attempt to load a kernel module.
> +
> +TEST="KERNEL_MODULE"
> +. ./common_lib.sh
> +
> +trap "{ rm -f $IKCONFIG ; }" EXIT
> +
> +# Some of the IMA builtin policies may require the kernel modules to
> +# be signed, but these policy rules may be replaced with a custom
> +# policy.  Only CONFIG_IMA_APPRAISE_REQUIRE_MODULE_SIGS persists after
> +# loading a custom policy.  Check if it is enabled, before reading the
> +# IMA runtime sysfs policy file.
> +# Return 1 for IMA signature required and 0 for not required.
> +is_ima_sig_required()
> +{
> +	local ret=0
> +
> +	kconfig_enabled "CONFIG_IMA_APPRAISE_REQUIRE_MODULE_SIGS=y" \
> +		"IMA kernel module signature required"
> +	if [ $? -eq 1 ]; then
> +		log_info "IMA kernel module signature required"
> +		return 1
> +	fi
> +
> +	# The architecture specific or a custom policy may require the
> +	# kernel module to be signed.  Policy rules are walked sequentially.
> +	# As a result, a policy rule may be defined, but might not necessarily
> +	# be used.  This test assumes if a policy rule is specified, that is
> +	# the intent.
> +	if [ $ima_read_policy -eq 1 ]; then
> +		check_ima_policy "appraise" "func=MODULE_CHECK" \
> +			"appraise_type=imasig"
> +		ret=$?
> +		[ $ret -eq 1 ] && log_info "IMA signature required";
> +	fi
> +	return $ret
> +}
> +
> +# loading kernel modules requires root privileges
> +if [ $(id -ru) -ne 0 ]; then
> +	log_skip "requires root privileges"
> +fi
> +
> +# Are appended signatures required?
> +if [ -e /sys/module/module/parameters/sig_enforce ]; then
> +	sig_enforce=$(cat /sys/module/module/parameters/sig_enforce)
> +	if [ $sig_enforce = "Y" ]; then
> +		log_pass "appended kernel module signature required"
> +	fi
> +fi
> +
> +get_secureboot_mode
> +if [ $? -eq 0 ]; then
> +	log_skip "secure boot not enabled"
> +fi
> +
> +# get the kernel config
> +get_kconfig
> +

get_kconfig() will be good candidate as a kselftest common
function. Is that possible?

> +# Determine which kernel config options are enabled
> +kconfig_enabled "CONFIG_IMA_ARCH_POLICY=y" \
> +	"architecture specific policy enabled"
> +arch_policy=$?
> +
> +kconfig_enabled "CONFIG_MODULE_SIG=y" \
> +	"appended kernel modules signature enabled"
> +appended_sig_enabled=$?
> +
> +kconfig_enabled "CONFIG_IMA_READ_POLICY=y" "reading IMA policy permitted"
> +ima_read_policy=$?
> +
> +is_ima_sig_required
> +ima_sig_required=$?
> +
> +if [ $arch_policy -eq 0 ]; then
> +	log_skip "architecture specific policy not enabled"
> +fi
> +
> +if [ $appended_sig_enabled -eq 1 ]; then
> +	log_fail "appended kernel module signature enabled, but not required"
> +fi
> +
> +if [ $ima_sig_required -eq 1 ]; then
> +	log_pass "IMA kernel module signature required"
> +fi
> +
> +if [ $ima_read_policy -eq 1 ]; then
> +	log_fail "IMA kernel module signature not required"
> +else
> +	log_skip "reading IMA policy not permitted"
> +fi
> 

thanks,
-- Shuah
