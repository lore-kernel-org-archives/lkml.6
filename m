Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv8dTM/pAssE8ABgzbY4+pk10oo7HLAe7dInb8arEnQtwjOwG11+kdzYqVpZXSEQXvTfDq3
ARC-Seal: i=1; a=rsa-sha256; t=1519676224; cv=none;
        d=google.com; s=arc-20160816;
        b=EA2htXLdn1abyH9e4VFbDRQddL7T9a41URiDbk3PYgG0RigJSV3MMzbBa4MqjxtrNp
         BjhlWqZIl6vSSSxZJS03OCaFP+NEglEFHVvy2qS2lWzefGHPn8Ep4KM8pBuH3/YPgIzc
         DMWyUorDmpzbMTzG33iqNuVKrwczW0a5iJ9BRU4lswarhR+Hq9z5ldZ993FiH3NvReIB
         ocFmStPzP/ZmBm+V2aizGq/J0RBbK896UbkVw9n/FQ0lalXRtTKQ8wz0D1tgZXtJajSw
         1CJdfsrPCNlcTKw3VlPyMveLAbfran+8xLHQKf5vtOypJYXVYA3rSCrBWsZKQd6I+Scd
         kaqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uWXkQ5l8+x6Xa8Ab/LT4flnJiOOyuS/JD6mO/GlDdQk=;
        b=Y3/QYgMpiSx2zUSDkzGnFKHJ9RwuXz9jYTm74EIPAgWs2WSYsB0vfQEwjggDrGg2cV
         2QDXI5wDBykteABScKJ7lDjK8ivV6WkYSmLz2Zf60DpbEGq4v6ZbGFmo02TXdyUs+RAO
         t4/AxRkPm/Gmd5M0A9CN7dPk05NgHamiiCR07PEGwXUcv9w88EIh89EXqvcjPDpGjtlq
         MpdUShLlIqOJsEcA8MLkXuzw/y0xocceSiXr5bMImc61w49ay5nuPch6NAFlWpbEZexU
         5zwY+jly2jsB0KQFH6X9qB/bnGJ91JGXTLyAwiz8Kv5SkhpyDdsHxxkXH+4hJWNUQS1M
         IB8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bernhard Kaindl <bernhard.kaindl@thalesgroup.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 02/22] powerpc/64s: Fix RFI flush dependency on HARDLOCKUP_DETECTOR
Date: Mon, 26 Feb 2018 21:16:02 +0100
Message-Id: <20180226201558.809893153@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
References: <20180226201558.681421374@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496017277626852?=
X-GMAIL-MSGID: =?utf-8?q?1593496017277626852?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

The backport of commit aa8a5e0062ac ("powerpc/64s: Add support for RFI
flush of L1-D cache"), incorrectly placed the new RFI flush code
inside an existing #ifdef CONFIG_HARDLOCKUP_DETECTOR block.

This has the obvious effect of requiring HARDLOCKUP_DETECTOR to be
enabled in order for RFI flush to be enabled, which is a bug.

Fix it by moving the #endif up to where it belongs.

Fixes: c3892946315e ("powerpc/64s: Add support for RFI flush of L1-D cache")
Reported-by: Bernhard Kaindl <bernhard.kaindl@thalesgroup.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/setup_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -835,6 +835,7 @@ static int __init disable_hardlockup_det
 	return 0;
 }
 early_initcall(disable_hardlockup_detector);
+#endif
 
 #ifdef CONFIG_PPC_BOOK3S_64
 static enum l1d_flush_type enabled_flush_types;
@@ -973,4 +974,3 @@ ssize_t cpu_show_meltdown(struct device
 	return sprintf(buf, "Vulnerable\n");
 }
 #endif /* CONFIG_PPC_BOOK3S_64 */
-#endif
