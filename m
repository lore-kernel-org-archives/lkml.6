Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELseUyAFvcdm139/lLnXr/DhTsg5BuBBOy3srtj7/wfQe4Yl5tiG0+GT5K/6ypTlFSmiHGl9
ARC-Seal: i=1; a=rsa-sha256; t=1520824072; cv=none;
        d=google.com; s=arc-20160816;
        b=Bl5zfh82jSeAEPeLcW6aAvnYV52a2AhUy02L+DgJzwSZ8ic+ygHADqIdRfaZjwS24g
         iHa4pW+ySonnEf3X9djCQiS7z+6UmetYFPvGD9tIH9wZzkX9+QJEqraRGGk/QbafYQsp
         Hm+/Bg1s9CXRRSoxg2OrLrjNC5a0UGFPHiyfl3F6CcUBnLqxY0zr5fbYPx4scApO/1tb
         zC9aOYTcmu+FCon4zmBPrDwAKliVC/dmieSHVc+OTD//NO9qUO3uZOm+/lu+/XjKO2Mv
         h1DYctK8RUcAqyFqAl74phIEZYpilU0skVCu2cLZY29WLU9SBLpOr+4rJs19NmoH5C+q
         zSXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=af5m8B+qB73UFpOPeLI8fXkSvi4riIXjhwmc//WiOJc=;
        b=SxYwxDNWj8URpFc9oh82qcMKgDax/YChk5gJn6rt2HozV3fD8gfpgKjirTjU+lRWC1
         JeGKwHT3MkK9geN7Vbdf0pf59LTXXJ7KJdVSgevhiwTdaHgSR1kWJeM/ehYCmaPB50OC
         7JXF1Nd+EuRgpvBcpR8Z2+gDf3g1ZPVQjwJRU4/R/s0iGXOgGFlLPgisth2WU7Qkggnm
         hRYOEsi/wH9UP49DXv4L6L7VnT2jc33AkjO0/vyN5TgfpTUgQqP/vxdhhQ4MOyrGaQ09
         XolyDlGfEdZdiByM/xzD1bBMa/1d3hU4evYGWkcjWzGE9svZWj2Yb+Sw/EiLkjK6ihWT
         5Feg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Ingo Molnar" <mingo@kernel.org>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Andy Lutomirski" <luto@kernel.org>,
 linux-arch@vger.kernel.org,
 "Will Deacon" <will.deacon@arm.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Borislav Petkov" <bp@alien8.de>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.733970867@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 099/104] nospec: Kill array_index_nospec_mask_check()
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699623234297784?=
X-GMAIL-MSGID: =?utf-8?q?1594699623234297784?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 1d91c1d2c80cb70e2e553845e278b87a960c04da upstream.

There are multiple problems with the dynamic sanity checking in
array_index_nospec_mask_check():

* It causes unnecessary overhead in the 32-bit case since integer sized
  @index values will no longer cause the check to be compiled away like
  in the 64-bit case.

* In the 32-bit case it may trigger with user controllable input when
  the expectation is that should only trigger during development of new
  kernel enabling.

* The macro reuses the input parameter in multiple locations which is
  broken if someone passes an expression like 'index++' to
  array_index_nospec().

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org
Link: http://lkml.kernel.org/r/151881604278.17395.6605847763178076520.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/nospec.h | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -30,26 +30,6 @@ static inline unsigned long array_index_
 #endif
 
 /*
- * Warn developers about inappropriate array_index_nospec() usage.
- *
- * Even if the CPU speculates past the WARN_ONCE branch, the
- * sign bit of @index is taken into account when generating the
- * mask.
- *
- * This warning is compiled out when the compiler can infer that
- * @index and @size are less than LONG_MAX.
- */
-#define array_index_mask_nospec_check(index, size)				\
-({										\
-	if (WARN_ONCE(index > LONG_MAX || size > LONG_MAX,			\
-	    "array_index_nospec() limited to range of [0, LONG_MAX]\n"))	\
-		_mask = 0;							\
-	else									\
-		_mask = array_index_mask_nospec(index, size);			\
-	_mask;									\
-})
-
-/*
  * array_index_nospec - sanitize an array index after a bounds check
  *
  * For a code sequence like:
@@ -67,7 +47,7 @@ static inline unsigned long array_index_
 ({									\
 	typeof(index) _i = (index);					\
 	typeof(size) _s = (size);					\
-	unsigned long _mask = array_index_mask_nospec_check(_i, _s);	\
+	unsigned long _mask = array_index_mask_nospec(_i, _s);		\
 									\
 	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
 	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
