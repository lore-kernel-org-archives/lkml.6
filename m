Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpYxREHi+HJoIVWzT8Cn80G8VVP7S5hEErmBgef31Njw6H9CNvmo9DQEAXQSZpj08wa49nc
ARC-Seal: i=1; a=rsa-sha256; t=1527156086; cv=none;
        d=google.com; s=arc-20160816;
        b=tF1N8tbdbVAN6/7s9SZeEFvzLqlylTOKrH50u+FSgI3BHCRpS0quvzueRALHSSetxJ
         02wnZgG6KgFxhC1lNUHPXaty7HL2EHv8zSqTkc4ZjWyPdYZ1AlAExyKkBStqXJSzjWxH
         geHo3xC5c0KV8cTOSKXdhHRu89LQzblayR5ZC5wDHQ3N+SBSCTn8dmzTNKAT6GMTwoP5
         nKzzVhBHmlntWnPmTzwd4PpCTM10fRNeXZIP3QZ1JKfidmVOL3l/pGar1OGMI2d6rR1K
         kgDE71AB0wuxaUYRcyT1o/Kk18oqli7bhlKXAjIFWUoz5eYtR7TzHB7LK3YAqCCfwr2Q
         3aUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=lRPzuruBtHIG74HH5PbqRrU3h6xSioYday6O6A7XQ3o=;
        b=WlW/QGhd5LB25P+EZgQ0LcOAW/09e/5QL1AcCr5x8+cYU3UeDb94NMuHhoP1UTwa1R
         swY6Jt85svVGC0tENKP8ZPa+b/MBX1ZpayDJT49P6dSdHS/RT16xyaZ7jQ1xh3N3sZTP
         fpubLMblMBhSVXx+iraHyanMfiyLuqWm8Q1sw8X0qUSF8XUttYnTL38R90dkVMEYCbp4
         BEniiw0vkvW+D1zDlZ79nvrswjdfb/9Kw0unyHFXYS6pz6e/X96/dzaNYTMTYNFfn+Sz
         rEYYFY2QOt6psaGOBDieOyd+6Jx/r93tKIwhaoyPuo0FN/oBOf7dNlNAGBTlfV/zjqVx
         C2Fg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=YnyVLPLP;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=YnyVLPLP;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 4.16 057/161] s390/crc32-vx: use expoline for indirect branches
Date: Thu, 24 May 2018 11:38:02 +0200
Message-Id: <20180524093025.325713440@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338325235326048?=
X-GMAIL-MSGID: =?utf-8?q?1601339220201584633?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[ Upstream commit 467a3bf219cee12259182c5cb4821f88fd518a51 ]

The return from the crc32_le_vgfm_16/crc32c_le_vgfm_16 and the
crc32_be_vgfm_16 functions are done with "br %r14". These are indirect
branches as well and need to use execute trampolines for CONFIG_EXPOLINE=y.

Cc: stable@vger.kernel.org # 4.16
Fixes: f19fbd5ed6 ("s390: introduce execute-trampolines for branches")
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/crypto/crc32be-vx.S |    5 ++++-
 arch/s390/crypto/crc32le-vx.S |    4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

--- a/arch/s390/crypto/crc32be-vx.S
+++ b/arch/s390/crypto/crc32be-vx.S
@@ -13,6 +13,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/nospec-insn.h>
 #include <asm/vx-insn.h>
 
 /* Vector register range containing CRC-32 constants */
@@ -67,6 +68,8 @@
 
 .previous
 
+	GEN_BR_THUNK %r14
+
 .text
 /*
  * The CRC-32 function(s) use these calling conventions:
@@ -203,6 +206,6 @@ ENTRY(crc32_be_vgfm_16)
 
 .Ldone:
 	VLGVF	%r2,%v2,3
-	br	%r14
+	BR_EX	%r14
 
 .previous
--- a/arch/s390/crypto/crc32le-vx.S
+++ b/arch/s390/crypto/crc32le-vx.S
@@ -14,6 +14,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/nospec-insn.h>
 #include <asm/vx-insn.h>
 
 /* Vector register range containing CRC-32 constants */
@@ -76,6 +77,7 @@
 
 .previous
 
+	GEN_BR_THUNK %r14
 
 .text
 
@@ -264,6 +266,6 @@ crc32_le_vgfm_generic:
 
 .Ldone:
 	VLGVF	%r2,%v2,2
-	br	%r14
+	BR_EX	%r14
 
 .previous
