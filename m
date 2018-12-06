Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E57C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9666520868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cx1MqXyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9666520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbeLFXum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:50:42 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33730 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeLFXum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:50:42 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so863736pgu.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 15:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=54Wo/joBzUQUfmFU3PrU1d49R3TsSQp+xuxFIuUaM1U=;
        b=Cx1MqXyyODo4wGJHo0sk02bm5nrcactfILNHxLmDryNNiqmoYnFwRPOY3YM2Uis7Cr
         qfGtKuSJqlgYULBCpV46DAqAlxDKjbfgoj/HqRVdcGswT+XXNcB+fqGxTcjCWI+Ev/Ks
         q/4fAusI4IleV4MCRTcTO3C+88T7X5JO6m2+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=54Wo/joBzUQUfmFU3PrU1d49R3TsSQp+xuxFIuUaM1U=;
        b=NcToYEQTHF4fmyO1/e9MEXa9Rys2y+kzRdmrb4M1E7nVJDuADLGcwsN69NtSAefjIG
         9kwrchuMTVnUEIJ/yOxxKOkKL0NPJcpIwCSclXt70CX9l+DDN3I1/FxThRFK4R3XPFuN
         oy6nyrHtsBSfP12DqrsVAdvIcqZRnKaWMGpGVwLSiLTh8HG+M0j68pwetoGyukj7RTTT
         Ueyrlp/12HBCNGHPaDGw6JW/Cr+lKg+ApLfwJoLHiBA39VZfwe5YNILhLTrUNOvnSD3T
         7rmuKb3TufNK7m7qhmKO8sBGzTUJfG9/Cbm0wxWArv3kA4eGWik4tJ/E/50Abho11DN2
         nYug==
X-Gm-Message-State: AA+aEWYUP1EyTHyzjsj3vo8VtEEhCCPrRf+zKZaYyPZamvKaPbwyOsNJ
        e1uhUf5N9PK2hUFLDU54JVmZlg==
X-Google-Smtp-Source: AFSGD/ULZCvdfEx3FRYVbDUIabGbXrqkGz1oduwFsSUxo1vfz1ImyWoPUChPDSUnULab+A664EELbg==
X-Received: by 2002:a63:9c1a:: with SMTP id f26mr7376328pge.381.1544140241108;
        Thu, 06 Dec 2018 15:50:41 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r130sm2503337pfr.48.2018.12.06.15.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 15:50:39 -0800 (PST)
Date:   Thu, 6 Dec 2018 15:50:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/seccomp: Remove SIGSTOP si_pid check
Message-ID: <20181206235038.GA18273@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f149b3155744 ("signal: Never allocate siginfo for SIGKILL or SIGSTOP")
means that the seccomp selftest cannot check si_pid under SIGSTOP anymore.
Since it's believed[1] there are no other userspace things depending on the
old behavior, this removes the behavioral check in the selftest, since it's
more a "extra" sanity check (which turns out, maybe, not to have been
useful to test).

[1] https://lkml.kernel.org/r/CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com

Reported-by: Tycho Andersen <tycho@tycho.ws>
Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Shuah, can you make sure that Linus gets this before v4.20 is released? Thanks!
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index e1473234968d..c9a2abf8be1b 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -2731,9 +2731,14 @@ TEST(syscall_restart)
 	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
 	ASSERT_EQ(true, WIFSTOPPED(status));
 	ASSERT_EQ(SIGSTOP, WSTOPSIG(status));
-	/* Verify signal delivery came from parent now. */
 	ASSERT_EQ(0, ptrace(PTRACE_GETSIGINFO, child_pid, NULL, &info));
-	EXPECT_EQ(getpid(), info.si_pid);
+	/*
+	 * There is no siginfo on SIGSTOP any more, so we can't verify
+	 * signal delivery came from parent now (getpid() == info.si_pid).
+	 * https://lkml.kernel.org/r/CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com
+	 * At least verify the SIGSTOP via PTRACE_GETSIGINFO.
+	 */
+	EXPECT_EQ(SIGSTOP, info.si_signo);
 
 	/* Restart nanosleep with SIGCONT, which triggers restart_syscall. */
 	ASSERT_EQ(0, kill(child_pid, SIGCONT));
-- 
2.17.1


-- 
Kees Cook
