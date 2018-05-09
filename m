Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934049AbeEIKTL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 06:19:11 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37368 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932215AbeEIKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 06:19:09 -0400
X-Google-Smtp-Source: AB8JxZrzzIpcfVZnt7umrh1Qlv/UebJB+/87RsTsXmwoBvcKAMMPQqnwjEfANJozqcJ72FAi9cmHPQ==
Date: Wed, 9 May 2018 11:49:00 +0200
From: Anders Roxell <anders.roxell@linaro.org>
To: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: mount: delete RUN_TESTS and EMIT_TESTS
 overrides
Message-ID: <20180509094900.GC10043@localhost.localdomain>
References: <20180502211848.22404-1-shuah@kernel.org>
 <20180502211848.22404-4-shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180502211848.22404-4-shuah@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-02 15:18, Shuah Khan (Samsung OSG) wrote:
> Delete RUN_TESTS and EMIT_TESTS overrides and use common defines in
> lib.mk. Add new run_tests.sh to do the dependency checks the custom
> RUN_TESTS did. Common defines work with the run_tests.sh set as the
> TEST_PROGS and defining unprivileged-remount-test in TEST_GEN_FILES.
> 
> Kselftest framework builds and installs TEST_GEN_FILES and doesn't run
> them via RUN_TESTS and include it in EMIT_TESTS. With this change the
> new run_tests.sh runs the test after checking dependencies.
> 
> This change also adds Skip handling to return kselftest skip code when
> test is skipped to clearly identify when the test is skipped instead of
> reporting it as failed.
> 
> Output with this change:
> 
> TAP version 13
> selftests: mount: run_tests.sh
> ========================================
> WARN: No /proc/self/uid_map exist, test skipped.
> not ok 1..1 selftests: mount: run_tests.sh [SKIP]
> 
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

Reviewed-by: Anders Roxell <anders.roxell@linaro.org>

> ---
>  tools/testing/selftests/mount/Makefile     | 12 ++----------
>  tools/testing/selftests/mount/run_tests.sh | 12 ++++++++++++
>  2 files changed, 14 insertions(+), 10 deletions(-)
>  create mode 100755 tools/testing/selftests/mount/run_tests.sh
> 
> diff --git a/tools/testing/selftests/mount/Makefile b/tools/testing/selftests/mount/Makefile
> index e094f71c6dbc..026890744215 100644
> --- a/tools/testing/selftests/mount/Makefile
> +++ b/tools/testing/selftests/mount/Makefile
> @@ -3,15 +3,7 @@
>  CFLAGS = -Wall \
>           -O2
>  
> -TEST_GEN_PROGS := unprivileged-remount-test
> +TEST_PROGS := run_tests.sh
> +TEST_GEN_FILES := unprivileged-remount-test
>  
>  include ../lib.mk
> -
> -override RUN_TESTS := if [ -f /proc/self/uid_map ] ; \
> -		      then	\
> -				./unprivileged-remount-test ; \
> -		      else	\
> -				echo "WARN: No /proc/self/uid_map exist, test skipped." ; \
> -		      fi
> -override EMIT_TESTS := echo "$(RUN_TESTS)"
> -
> diff --git a/tools/testing/selftests/mount/run_tests.sh b/tools/testing/selftests/mount/run_tests.sh
> new file mode 100755
> index 000000000000..4ab8f507dcba
> --- /dev/null
> +++ b/tools/testing/selftests/mount/run_tests.sh
> @@ -0,0 +1,12 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +# Run mount selftests
> +if [ -f /proc/self/uid_map ] ; then
> +	./unprivileged-remount-test ;
> +else
> +	echo "WARN: No /proc/self/uid_map exist, test skipped." ;
> +	exit $ksft_skip
> +fi
> -- 
> 2.14.1
> 
