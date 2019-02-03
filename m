Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D12EC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 22:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C4A217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 22:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfBCWDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 17:03:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:33794 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726673AbfBCWDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 17:03:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AEC8FAE7A;
        Sun,  3 Feb 2019 22:03:00 +0000 (UTC)
Date:   Sun, 3 Feb 2019 23:02:58 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        David Howells <dhowells@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 3/3] selftests/ima: kexec_file_load syscall test
Message-ID: <20190203220258.GC4022@x230>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
 <1548960936-7800-4-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548960936-7800-4-git-send-email-zohar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

> The kernel can be configured to verify PE signed kernel images, IMA
> kernel image signatures, both types of signatures, or none.  This test
> verifies only properly signed kernel images are loaded into memory,
> based on the kernel configuration and runtime policies.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +++ b/tools/testing/selftests/ima/test_kexec_file_load.sh
> @@ -0,0 +1,250 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0+
# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Loading a kernel image via the kexec_file_load syscall can verify either
> +# the IMA signature stored in the security.ima xattr or the PE signature,
> +# both signatures depending on the IMA policy, or none.
> +#
> +# To determine whether the kernel image is signed, this test depends
> +# on pesign and getfattr.  This test also requires the kernel to be
> +# built with CONFIG_IKCONFIG enabled and either CONFIG_IKCONFIG_PROC
> +# enabled or access to the extract-ikconfig script.
> +
> +VERBOSE=1
Maybe allow to disable verbose without source change?
VERBOSE="${VERBOSE:-1}"

> +EXTRACT_IKCONFIG=$(ls /lib/modules/`uname -r`/source/scripts/extract-ikconfig)
> +IKCONFIG=/tmp/config-`uname -r`
> +PROC_CONFIG="/proc/config.gz"
> +KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
> +PESIGN=/usr/bin/pesign
> +GETFATTR=/usr/bin/getfattr
> +
> +TEST="$0"
> +. ./common_lib.sh
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +kconfig_enabled()
> +{
> +	RC=0
> +	egrep -q $1 $IKCONFIG
> +	if [ $? -eq 0 ]; then
> +		RC=1
> +	fi
> +	return $RC
> +}
This would be enough (grep with -e returns only 0 or 1):
kconfig_enabled()
{
	grep -E -q $1 $IKCONFIG
}
> +
> +# policy rule format: action func=<keyword> [appraise_type=<type>]
> +check_ima_policy()
> +{
> +	IMA_POLICY=/sys/kernel/security/ima/policy
> +
> +	RC=0
> +	if [ $# -eq 3 ]; then
> +		grep -e $2 $IMA_POLICY | grep -e "^$1.*$3" 2>&1 >/dev/null
> +	else
> +		grep -e $2 $IMA_POLICY | grep -e "^$1" 2>&1 >/dev/null
> +	fi
> +	if [ $? -eq 0 ]; then
> +		RC=1
> +	fi
> +	return $RC
> +}
This would be enough and more descriptive:
check_ima_policy()
{
	local action="$1"
	local keyword="$2"
	local type="$3"

	[ -n "$type" ] && type="appraise_type=$type"
	grep -q "^$action.*func=$keyword.*$type" /sys/kernel/security/ima/policy
}

> +
> +check_kconfig_options()
> +{
> +	# Attempt to get the kernel config first via proc, and then by
> +	# extracting it from the kernel image using scripts/extract-ikconfig.
> +	if [ ! -f $PROC_CONFIG ]; then
> +		modprobe configs 2>/dev/null
> +	fi
> +	if [ -f $PROC_CONFIG ]; then
> +		cat $PROC_CONFIG > $IKCONFIG
> +	fi
> +
> +	if [ ! -f $IKCONFIG ]; then
> +		if [ ! -f $EXTRACT_IKCONFIG ]; then
> +			echo "$TEST: requires access to extract-ikconfig" >&2
> +			exit $ksft_skip
> +		fi
> +
> +		$EXTRACT_IKCONFIG $KERNEL_IMAGE > $IKCONFIG
> +		kconfig_enabled "CONFIG_IKCONFIG=y"
> +		if [ $? -eq 0 ]; then
> +			echo "$TEST: requires the kernel to be built with CONFIG_IKCONFIG" >&2
> +			exit $ksft_skip
> +		fi
> +	fi
> +
> +	kconfig_enabled "CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y"
> +	pe_sig_required=$?
> +	if [ $VERBOSE -ne 0 ] && [ $pe_sig_required -eq 1 ]; then
> +		echo "$TEST: [INFO] PE signed kernel image required"
> +	fi
Checks for $VERBOSE here and in other kconfig_enabled usages bellow are a bit
redundant. And you check for assigned variable now and then later on,
you use these variables as global (and reset $ima_sig_required in
check_runtime().

How about using functions instead:
log_info()
{
	echo "$TEST: [INFO] $1"
}
(Reducing some duplicity, IMHO helper functions in shell library used in all
selftest tests would be useful)

kconfig_enabled()
{
	local config="$1"
	local msg="$2"
	local ret

	grep -E -q $config $IKCONFIG
	ret=$?
	[ $VERBOSE -ne 0 ] && [ $ret -eq 1 ] && log_info "$msg"
	return $ret
}

ima_sig_enabled()
{
	kconfig_enabled "CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y" \
		"PE signed kernel image required"
}

ima_sig_enabled()
{
	kconfig_enabled "CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS=y" \
		"IMA kernel image signature required"
}
Warning is printed each time, but that's deliberate.
If it's not wanted, it can be moved into setup.

...
> +check_kconfig_options
> +check_for_apps
> +check_runtime
> +check_for_sigs
> +kexec_file_load_test

> +rc=$?
> +exit $rc
These two are redundant.

Kind regards,
Petr
