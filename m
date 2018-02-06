Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x226xZ6MmhZPShFanqOEv7jgzSeu7kYMKUB42uNdlw+qvMVwE61mHjeZux2fm5QJdKTOTg5Fz
ARC-Seal: i=1; a=rsa-sha256; t=1517918475; cv=none;
        d=google.com; s=arc-20160816;
        b=bAvX0Jsvpf+a9CVEaKHEKrG/4UzVyzOVUs/z/Ob9E3/Hk8YNqWQKdfi4skR8Wx2AkK
         Bn2CYF+/dsZSDt7pEv3csMY7mJ7ExywRYZNn9EXLJZw5fwHpRLbHQS/FR1hOisFlF7Af
         75NDfh807SERhm6Oa9wNBJvmjGvl/OLHfC2fUQykd/xCv7GpWATWK9WHjyaUlI+pyVta
         PggGBZtbI1LWn85lKKvSaNSuMTJyi/xktTV54kovgH3jWmd2Hb2PJlpK2FMVEx0KNUWL
         eqfyNbnVLBAwQ+gTF+mIKiIpd24O6ExD1fJ7mdUudd5mrMlB309cVa2FCEzWQsu8Y4XZ
         NO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=8Rhsld6hsRfBBWWBTZ/coJqo+vV4quc5AITmlk0pM5Y=;
        b=LHfOGcoCd9m62J1M/pvToO29Wya4xBDJPoN+LOr2lU68ZmP5XcP+9q1BMbxayH2CAP
         FcEf6DY/JVuk3DI6ZMElnNHYmU4Bkp7plVRyUYF3+eLmGPb2FS0U4lyWrjIq4/VKCW/W
         13bbs1Sk1vETVH0XF4Ll1n7+0jL5LeUkh4MzfkPz/+6jc2KvpkP/58G1syL2XGPsckae
         d4GfDdVEdsiTFYTjo+ec2Y58UpxlBoR1IPI+JAp0aME43kjoVffBnyGih2wDF9/UxNM1
         clVtcxhacXRaajB8h+PInchuc8XsdTyJRMvegLsCMxgn8P9MbJb8ZgPOCvtu5vfJBMzN
         PVYw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 65.50.211.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 65.50.211.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Tue, 6 Feb 2018 03:57:47 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-ca66e797120fb09b8138623fb4b563e952586ef5@git.kernel.org>
Cc: mingo@kernel.org, peterz@infradead.org, babu.moger@oracle.com,
        gregkh@linuxfoundation.org, nico@linaro.org, akpm@linux-foundation.org,
        tglx@linutronix.de, will.deacon@arm.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, arnd@arndb.de, hpa@zytor.com
Reply-To: akpm@linux-foundation.org, tglx@linutronix.de,
        gregkh@linuxfoundation.org, nico@linaro.org, mingo@kernel.org,
        babu.moger@oracle.com, peterz@infradead.org, will.deacon@arm.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        torvalds@linux-foundation.org
In-Reply-To: <20180202154104.1522809-1-arnd@arndb.de>
References: <20180202154104.1522809-1-arnd@arndb.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/qrwlock: include asm/byteorder.h as
 needed
Git-Commit-ID: ca66e797120fb09b8138623fb4b563e952586ef5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304711998635461?=
X-GMAIL-MSGID: =?utf-8?q?1591652883648397079?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  ca66e797120fb09b8138623fb4b563e952586ef5
Gitweb:     https://git.kernel.org/tip/ca66e797120fb09b8138623fb4b563e952586ef5
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Fri, 2 Feb 2018 16:40:44 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 6 Feb 2018 10:28:58 +0100

locking/qrwlock: include asm/byteorder.h as needed

Moving the qrwlock struct definition into a header file introduced
a subtle bug on all little-endian machines, where some files in some
configurations would see the fields in an incorrect order.  This was
found by building with an LTO enabled compiler that warns every time we
try to link together files with incompatible data structures.

A second patch changes linux/kconfig.h to always define the symbols,
but this seems to be the root cause of most of the issues, so I'd suggest
we do both.

On a current linux-next kernel, I verified that this header is
responsible for all type mismatches as a result from the endianess
confusion.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Babu Moger <babu.moger@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Fixes: e0d02285f16e ("locking/qrwlock: Use 'struct qrwlock' instead of 'struct __qrwlock'")
Link: http://lkml.kernel.org/r/20180202154104.1522809-1-arnd@arndb.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/asm-generic/qrwlock_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/qrwlock_types.h b/include/asm-generic/qrwlock_types.h
index 137ecdd..c36f1d5 100644
--- a/include/asm-generic/qrwlock_types.h
+++ b/include/asm-generic/qrwlock_types.h
@@ -3,6 +3,7 @@
 #define __ASM_GENERIC_QRWLOCK_TYPES_H
 
 #include <linux/types.h>
+#include <asm/byteorder.h>
 #include <asm/spinlock_types.h>
 
 /*
