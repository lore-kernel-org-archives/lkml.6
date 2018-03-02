Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsPTdcQOqtYPBlTe1GWtkwWGkIvHlbZ8K36XHYWvcapFxUYlMYMjp+5u1ro5EzRFu+oT42m
ARC-Seal: i=1; a=rsa-sha256; t=1519981451; cv=none;
        d=google.com; s=arc-20160816;
        b=X9p847lqM3KFLJbrkxCqRvka72GLfqcuX1QuLG1FRsMbCBD7HirVkjrzgZSPOrpLJg
         8mTn/PbthW2rvx5cySjVrkpBPyfeSwRnkQvkBsUdgbtbu/U8zBKrl7M6NAkRCQ2wuGnr
         o4hzJm1KMRUWXosnb5w9XBVN105VoVfWd5rLJSr7YJRmBF4kNiVcY+3AOatwdgzLTdZf
         PJDagx9HPn5ieSLl3MuABF8/nr3V/i9dpxs3A/w/bsqE5Nzgi6aOcYS1X/y8ATPJLJpB
         0OzsgBCwbYEv9VRf8wJGRh77R1W6aYUQLg4kxzGwdacCmQK74hNUxiA+1j2KYew+rOn3
         GkBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JNsu2D+z+yiMi6G4Za7BNMl+CVM9pYRZagI9FVmcytM=;
        b=M1SwXm5+ery4fDX1/prdOaifnRmXXmr71vk0xyl1VDIaSH7F2wWX6VJStJVtXsr75q
         +qxLnP8NbbtRBMNWl5CeW5vtJAaRxNza3ldlF/4UHC3QqP5/I3gyRPaNnzVWyKh9NVFo
         KKN/XfwjyiJhbaC8rAjKbj1pvrcZD9Ep5SHHDGDkHVJzkW/hrKU6pCjZ2XjJ7acmjPMY
         p3/FLayrwgmv8DMvtNwD4bByc0Dp0EGUMSt3872qdn377G+cyXPTN9jwxiFYX+BM2YDU
         o0kzZPVnuFjoGYLU4OxrvirCGg8vxz5UgDEP7yqHnT1Tnf7tXVJpda1BJvMp4vXJNltD
         SeYw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bhumika Goyal <bhumirks@gmail.com>,
	Darren Hart <dvhart@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	julia.lawall@lip6.fr,
	platform-driver-x86@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 094/115] x86/platform/intel-mid: Revert "Make bt_sfi_data const"
Date: Fri,  2 Mar 2018 09:51:37 +0100
Message-Id: <20180302084507.647317868@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816070431181180?=
X-GMAIL-MSGID: =?utf-8?q?1593816070431181180?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


[ Upstream commit 9d0513d82f1a8fe17b41f113ac5922fa57dbaf5c ]

So one of the constification patches unearthed a type casting fragility
of the underlying code:

  276c87054751 ("x86/platform/intel-mid: Make 'bt_sfi_data' const")

converted the struct to be const while it is also used as a temporary
container for important data that is used to fill 'parent' and 'name'
fields in struct platform_device_info.

The compiler doesn't notice this due to an explicit type cast that loses
the const - which fragility will be fixed separately.

This type cast turned a seemingly trivial const propagation patch into a
hard to debug data corruptor and crasher bug.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bhumika Goyal <bhumirks@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: julia.lawall@lip6.fr
Cc: platform-driver-x86@vger.kernel.org
Link: http://lkml.kernel.org/r/20171228122523.21802-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/platform/intel-mid/device_libs/platform_bt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/platform/intel-mid/device_libs/platform_bt.c
+++ b/arch/x86/platform/intel-mid/device_libs/platform_bt.c
@@ -60,7 +60,7 @@ static int __init tng_bt_sfi_setup(struc
 	return 0;
 }
 
-static const struct bt_sfi_data tng_bt_sfi_data __initdata = {
+static struct bt_sfi_data tng_bt_sfi_data __initdata = {
 	.setup	= tng_bt_sfi_setup,
 };
 
