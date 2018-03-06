Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELtMKf+V24yGRhhXbrfOpRNkEqeNTw1JWeHbCv1ktihWfZrMBvDvAwGd2PBUWEzvtJHndRfV
ARC-Seal: i=1; a=rsa-sha256; t=1520295989; cv=none;
        d=google.com; s=arc-20160816;
        b=YlP58K2CBaujWhKjSGcNMBMCpi1BqfQKcDSPWuwFgiaJZLGxhXBzM02briwh2ki5m2
         XYnuueVPNBPrydoKR9Roj1taDvbVor9rD/0g35ctSySG9AEWl5BerZ+NHDslzESb1Ezu
         Qi42TkCKaqwkEgVt4fqjQKjswnmn5dYDS+SPl7FXtfhBiUEOwHqoHpwzTjiBa3KJs6jp
         2VrwLb28GgNPjeHTIUrOW/iubPPJ5Q2qwHdJxLeUoMUAWyGNM/LcADsmZWf3wlNu2/LX
         DHwpiRL68qqeyZuleCariUa66O8597FklFVB9RJrpdEHbUNxyit5p0KpeB8QbrPSCwoW
         kcTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=4dMhrQFZiqYY0bOZ0Jn6bsC/rEVN47hHED+m/27ywZE=;
        b=Kb6ORzBwDbTHIuuZYcatAcxuCdETgoVpFVIoR9ZoNKnET5C+zaNi9SFlFk6wG4/euL
         XJev98dYu0VzbEkD1/RW3V08VDePckSn5+RRvqB/i71K/8p780RxMv+Wi2m2wOZtgkyR
         YYBvz0d5a64QPyGygLWptRefmMzXRONV1eLlQXXLEqHgvTeS12ltqnL+biQ/no8DaQA4
         Q1OkvsrwFvwcEVG1DGDQaIAqTDQWk2Nf2kK5p5eIwUeYqpQsSOSnOShWKp66EegeDUYV
         vgUtrK2pBLtqXyndc6V4DMHz536V2kF1AwPXo/L3cvMIeldGexlgfBw6QTg2afW1N+vm
         ea+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=sEd9PZmW;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=sEd9PZmW;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 31/65] kaiser: KAISER depends on SMP
Date: Mon,  5 Mar 2018 19:25:04 -0500
Message-Id: <20180306002538.1761-32-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=660
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145887267826772?=
X-GMAIL-MSGID: =?utf-8?q?1594145887267826772?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

It is absurd that KAISER should depend on SMP, but apparently nobody
has tried a UP build before: which breaks on implicit declaration of
function 'per_cpu_offset' in arch/x86/mm/kaiser.c.

Now, you would expect that to be trivially fixed up; but looking at
the System.map when that block is #ifdef'ed out of kaiser_init(),
I see that in a UP build __per_cpu_user_mapped_end is precisely at
__per_cpu_user_mapped_start, and the items carefully gathered into
that section for user-mapping on SMP, dispersed elsewhere on UP.

So, some other kind of section assignment will be needed on UP,
but implementing that is not a priority: just make KAISER depend
on SMP for now.

Also inserted a blank line before the option, tidied up the
brief Kconfig help message, and added an "If unsure, Y".

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit d94df20135ccfdfb77b1479c501564e9b4ab5bc9)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 security/Kconfig | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index cdad6dd3693a..5f4b656bfa4c 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -30,14 +30,16 @@ config SECURITY
 	  model will be used.
 
 	  If you are unsure how to answer this question, answer N.
+
 config KAISER
 	bool "Remove the kernel mapping in user mode"
 	default y
-	depends on X86_64
-	depends on !PARAVIRT
+	depends on X86_64 && SMP && !PARAVIRT
 	help
-	  This enforces a strict kernel and user space isolation in order to close
-	  hardware side channels on kernel address information.
+	  This enforces a strict kernel and user space isolation, in order
+	  to close hardware side channels on kernel address information.
+
+	  If you are unsure how to answer this question, answer Y.
 
 config KAISER_REAL_SWITCH
 	bool "KAISER: actually switch page tables"
-- 
2.16.2
