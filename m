Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtjiiylLxVXcLTBL+Dz9XXHfSmhoAGKMDdFizu0YPxg7485daX1+O6tVjoRDJQJ5tGOlBmU
ARC-Seal: i=1; a=rsa-sha256; t=1521483813; cv=none;
        d=google.com; s=arc-20160816;
        b=VH3EPuU3HSB4a1mFCiPvdaHgY3eA9wnHZ9w4CnyhA+ppOwXzpgUiA06uXI3F4dqXER
         Rx3jKzw3oU5/Im+F2LZ0KjnWcKk3fTTjMCPoZesPBABM0jxlweiJaLh8uWnVTouX/7i8
         4tDgbUA/rB6v/P5WHhop1qMHjWF5+ibkVXEf4nXPaTWnH/4cAIeUhztd8RzbqNUwJBcl
         2A9dm8zNVodAD1+8+tgBBtwNSnon6oBcVtCnHW1KeyDTYSBPW0wl9pds9Z7Tzp2tncEA
         AvuQw8niWTF2zmRQXODkhqbYROZSGzJ/nq8zB0O/pz61FNKgro5b8edBJBTZ9cq81lUA
         aUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wF+9772r45PQfWP3M3F+HGdntpVPlvJ4+TSywRn/lgk=;
        b=yONhdY3S0oKWhbY6VPC0zhS4X54rJz3sgLv11dkLih3E6MdsjaJjV+LD9nxmP9eeXG
         qr2zTarua2DUnopWWQI+bl49CXEpI2O0fRtgBrqgO49nkmV7OhkCpMvt+XrcHGVjuQEb
         4b51kM3QKgT5qF/kb42SnsXXTS/aoAwgV3E21FePLtNTP5zP8Er6WgYiGhlcxZZB56ob
         j8KTJQDDadi6qqjEsnebxKwwZuoeH4ts5iPEnL3uvNqJ9/Qin1MQDEw5B9MhMR6II8PD
         nCCTNO9jYk9yr+6KQK8l7HwNOjIfRH5wuVRJJtFPdRbPtcZnrtrFH3OPyKBWCVgsWon9
         TTNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Dmitry Vyukov <dvyukov@google.com>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 126/241] lkdtm: turn off kcov for lkdtm_rodata_do_nothing:
Date: Mon, 19 Mar 2018 19:06:31 +0100
Message-Id: <20180319180756.416129214@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391411037569790?=
X-GMAIL-MSGID: =?utf-8?q?1595391411037569790?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>


[ Upstream commit 7064dc7fc13b2994d33ae540ffb7a3a05ac463bf ]

I ran into a link error on ARM64 for lkdtm_rodata_do_nothing:

drivers/misc/built-in.o: In function `lkdtm_rodata_do_nothing':
:(.rodata+0x68c8): relocation truncated to fit: R_AARCH64_CALL26 against symbol `__sanitizer_cov_trace_pc' defined in .text section in kernel/built-in.o

I did not analyze this further, but my theory is that we would need a trampoline
to call __sanitizer_cov_trace_pc(), but the linker (correctly) only adds trampolines
for callers in executable sections.

Disabling KCOV for this one file avoids the build failure with no
other practical downsides I can think of.

The problem can only happen on kernels that contain both kcov and
lkdtm, so if we want to backport this, it should be in the earliest
version that has both (v4.8).

Fixes: 5c9a8750a640 ("kernel: add kcov code coverage")
Fixes: 9a49a528dcf3 ("lkdtm: add function for testing .rodata section")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/Makefile |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -61,6 +61,8 @@ lkdtm-$(CONFIG_LKDTM)		+= lkdtm_perms.o
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_rodata_objcopy.o
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_usercopy.o
 
+KCOV_INSTRUMENT_lkdtm_rodata.o	:= n
+
 OBJCOPYFLAGS :=
 OBJCOPYFLAGS_lkdtm_rodata_objcopy.o := \
 			--set-section-flags .text=alloc,readonly \
