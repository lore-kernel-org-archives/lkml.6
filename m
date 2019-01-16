Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEE0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC56E20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dE6LaPYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfAPRoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:44:55 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41770 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfAPRoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:44:54 -0500
Received: by mail-oi1-f193.google.com with SMTP id j21so3856653oii.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ntliFnHMh1UFNI4i4XDupue9MMU30iXjJz2OA1O7CA=;
        b=dE6LaPYLsHeS+ovTqbvwCuSHNPNEk3K5LNXIm2pin52MRe9AEshtvGhtUaT/VcQfsf
         gqmwwhDTOCtkpd/n+1VJpacJfROA6aQYHN47Ej0jJM0MRC0aRNxFpoKTvlhMc0Hw+Tfg
         I6g2EU3HqPqW0kO5J2e1pLJvs7+tWMc+RWpd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ntliFnHMh1UFNI4i4XDupue9MMU30iXjJz2OA1O7CA=;
        b=Zz2gqrOkwIwspb+68dofTllE2Bld8W/Xuz2Noz6bhDzYB0pUbUk+cyFDwQ7T+vB3/K
         HbHymyF+JMfP1ZmltCVCqtQPzlrpPv6SI1FTexIWD7g6R97xt1/YlzMIblzSC6NJJogR
         JQRQawcNTVhvPfI8T51K2EhRlwICJzeZVK2cvfONxpAhyIcf2zEjIrmRuU0drgYfmdVY
         Np5muT7J14NN2nVM1Uv+yAEBSaqyUZ+c9Nn2d30AKM/jdttfwfMHqrhWRhAZpHgijPe/
         3TsUpX6UPcvUDGhvpF8fp4D5e5evJdFucKtaAlhcvLZ0UbNhKlUit7dHDaiVLroGyKGX
         ZP4A==
X-Gm-Message-State: AJcUukfgEkGXxupYG/hxHFL+Gvo9NRkCi6D7LJnqIRANZ9g8kznk+3AI
        ZiGLdpoFohCkvZuHu1Bj5OyPLw==
X-Google-Smtp-Source: ALg8bN7cpCI03/LDta+Zt56exwYfkyZ06NbTx5DgNNwHmvViSlk8WwsVOE0d4mMo1TYGXUP9s07jkA==
X-Received: by 2002:a54:488b:: with SMTP id r11mr595706oic.80.1547660693160;
        Wed, 16 Jan 2019 09:44:53 -0800 (PST)
Received: from alago.cortijodelrio.net (CableLink-189-218-30-19.Hosts.InterCable.net. [189.218.30.19])
        by smtp.googlemail.com with ESMTPSA id m129sm3152973oif.50.2019.01.16.09.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 09:44:52 -0800 (PST)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     shuah@kernel.org
Cc:     Fathi Boudra <fathi.boudra@linaro.org>,
        Denys Dmytriyenko <denys@ti.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org (open list:TIMEKEEPING, CLOCKSOURCE CORE,
        NTP, ALARMTIMER),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH 4/4] selftests: timers: use LDLIBS instead of LDFLAGS
Date:   Wed, 16 Jan 2019 11:43:20 -0600
Message-Id: <20190116174320.14938-4-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190116174320.14938-1-daniel.diaz@linaro.org>
References: <20190116174320.14938-1-daniel.diaz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fathi Boudra <fathi.boudra@linaro.org>

posix_timers fails to build due to undefined reference errors:

 aarch64-linaro-linux-gcc --sysroot=/build/tmp-rpb-glibc/sysroots/hikey
 -O2 -pipe -g -feliminate-unused-debug-types -O3 -Wl,-no-as-needed -Wall
 -DKTEST  -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed -lrt -lpthread
 posix_timers.c
 -o /build/tmp-rpb-glibc/work/hikey-linaro-linux/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/timers/posix_timers
 /tmp/cc1FTZzT.o: In function `check_timer_create':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/timers/posix_timers.c:157:
 undefined reference to `timer_create'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/timers/posix_timers.c:170:
 undefined reference to `timer_settime'
 collect2: error: ld returned 1 exit status

It's GNU Make and linker specific.

The default Makefile rule looks like:

$(CC) $(CFLAGS) $(LDFLAGS) $@ $^ $(LDLIBS)

When linking is done by gcc itself, no issue, but when it needs to be passed
to proper ld, only LDLIBS follows and then ld cannot know what libs to link
with.

More detail:
https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html

LDFLAGS
Extra flags to give to compilers when they are supposed to invoke the linker,
‘ld’, such as -L. Libraries (-lfoo) should be added to the LDLIBS variable
instead.

LDLIBS
Library flags or names given to compilers when they are supposed to invoke the
linker, ‘ld’. LOADLIBES is a deprecated (but still supported) alternative to
LDLIBS. Non-library linker flags, such as -L, should go in the LDFLAGS
variable.

https://lkml.org/lkml/2010/2/10/362

tools/perf: libraries must come after objects

Link order matters, use LDLIBS instead of LDFLAGS to properly link against
libpthread.

Signed-off-by: Denys Dmytriyenko <denys@ti.com>
Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
---
 tools/testing/selftests/timers/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
index c02683cfb6c9..7656c7ce79d9 100644
--- a/tools/testing/selftests/timers/Makefile
+++ b/tools/testing/selftests/timers/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -O3 -Wl,-no-as-needed -Wall
-LDFLAGS += -lrt -lpthread -lm
+LDLIBS += -lrt -lpthread -lm
 
 # these are all "safe" tests that don't modify
 # system time or require escalated privileges
-- 
2.17.1

