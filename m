Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELs/aXJBNxB2GXML1DUs2W77wqPMoQwM5wOF5zbrNalu4L3dwNZBOydd5pHqb7PPPfw03jJE
ARC-Seal: i=1; a=rsa-sha256; t=1520295982; cv=none;
        d=google.com; s=arc-20160816;
        b=oxkt4qXVB03G8pdMSS4HuL5olpip8mkeD0djWMCeUeOOD6EkxHSwQj0jK4YPNkrKpt
         CgzoyPJxRWQzDU/SyhAxkKqsojeneVdxEXS62l8lrnD2qV7zCAWL5fuox6qqXsR0Garv
         c1F3O5Aj9QVV1rpB4Wj7w2RVUH/JPSfXADwOlWzD7Y9wETM2i48HpiUsOD/q9ImY9QEn
         xen/blGgz+SiC7lA5jR8ifpN3MFO+mIC3bdBqvFvqkqgQavI+iMmueQLEgTCJuI0MXZa
         DoFwR7O8GO0e9CklDcGn34B4xA1F5x/n7eHjbPi6ftSO4isBagy4mkm8Uw0ApvGz0GeK
         3yEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:dkim-signature
         :arc-authentication-results;
        bh=Fw4nILt4cSRGk/meQI30J/hOm/f5mu2d3cu0sgHbshU=;
        b=XDPZFyY53RwhmCp1dN9zFwG/iwJ/OO1ugqJVobBFJp0LNnvytMIuXiaHMBXerWcTNy
         qicdBvsPp6vUwnrQevB7b+dMIIQTKRvfAciSjJd8MXxVBHXWInfydza/oMZkTg6DAn0R
         csRyiTesQ2h4koX3Y959cYLMBBVy7YNxD+iwD0pLVAURT3CMh3Nz4ZV/5X+d7bo+yZm7
         6+ty4u5jcHs8BJjM4Blm3jj7rfAWpO4lcKslmTnBor+bFKzUVuzbFWazW9+LGKZbdrJQ
         cTuv+Ok5PCLKJzN6HIZL1dGbyfjYuWJb3BtggVpSHtA/bxSLjr/65tKz/O5TnhtOMKo/
         dXvw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=NdiceYv2;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=NdiceYv2;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 22/65] x86/boot: Add early cmdline parsing for options with arguments
Date: Mon,  5 Mar 2018 19:24:55 -0500
Message-Id: <20180306002538.1761-23-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145879389132170?=
X-GMAIL-MSGID: =?utf-8?q?1594145879389132170?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tom Lendacky <thomas.lendacky@amd.com>

commit e505371dd83963caae1a37ead9524e8d997341be upstream.

Add a cmdline_find_option() function to look for cmdline options that
take arguments. The argument is returned in a supplied buffer and the
argument length (regardless of whether it fits in the supplied buffer)
is returned, with -1 indicating not found.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Larry Woodman <lwoodman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Toshimitsu Kani <toshi.kani@hpe.com>
Cc: kasan-dev@googlegroups.com
Cc: kvm@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-efi@vger.kernel.org
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/36b5f97492a9745dce27682305f990fc20e5cf8a.1500319216.git.thomas.lendacky@amd.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

(cherry picked from commit 0fa147b407478e73fe7a478677ff2b12bb824014)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/cmdline.h |   2 +
 arch/x86/lib/cmdline.c         | 105 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/arch/x86/include/asm/cmdline.h b/arch/x86/include/asm/cmdline.h
index e01f7f7ccb0c..84ae170bc3d0 100644
--- a/arch/x86/include/asm/cmdline.h
+++ b/arch/x86/include/asm/cmdline.h
@@ -2,5 +2,7 @@
 #define _ASM_X86_CMDLINE_H
 
 int cmdline_find_option_bool(const char *cmdline_ptr, const char *option);
+int cmdline_find_option(const char *cmdline_ptr, const char *option,
+			char *buffer, int bufsize);
 
 #endif /* _ASM_X86_CMDLINE_H */
diff --git a/arch/x86/lib/cmdline.c b/arch/x86/lib/cmdline.c
index 422db000d727..a744506856b1 100644
--- a/arch/x86/lib/cmdline.c
+++ b/arch/x86/lib/cmdline.c
@@ -82,3 +82,108 @@ int cmdline_find_option_bool(const char *cmdline, const char *option)
 
 	return 0;	/* Buffer overrun */
 }
+
+/*
+ * Find a non-boolean option (i.e. option=argument). In accordance with
+ * standard Linux practice, if this option is repeated, this returns the
+ * last instance on the command line.
+ *
+ * @cmdline: the cmdline string
+ * @max_cmdline_size: the maximum size of cmdline
+ * @option: option string to look for
+ * @buffer: memory buffer to return the option argument
+ * @bufsize: size of the supplied memory buffer
+ *
+ * Returns the length of the argument (regardless of if it was
+ * truncated to fit in the buffer), or -1 on not found.
+ */
+static int
+__cmdline_find_option(const char *cmdline, int max_cmdline_size,
+		      const char *option, char *buffer, int bufsize)
+{
+	char c;
+	int pos = 0, len = -1;
+	const char *opptr = NULL;
+	char *bufptr = buffer;
+	enum {
+		st_wordstart = 0,	/* Start of word/after whitespace */
+		st_wordcmp,	/* Comparing this word */
+		st_wordskip,	/* Miscompare, skip */
+		st_bufcpy,	/* Copying this to buffer */
+	} state = st_wordstart;
+
+	if (!cmdline)
+		return -1;      /* No command line */
+
+	/*
+	 * This 'pos' check ensures we do not overrun
+	 * a non-NULL-terminated 'cmdline'
+	 */
+	while (pos++ < max_cmdline_size) {
+		c = *(char *)cmdline++;
+		if (!c)
+			break;
+
+		switch (state) {
+		case st_wordstart:
+			if (myisspace(c))
+				break;
+
+			state = st_wordcmp;
+			opptr = option;
+			/* fall through */
+
+		case st_wordcmp:
+			if ((c == '=') && !*opptr) {
+				/*
+				 * We matched all the way to the end of the
+				 * option we were looking for, prepare to
+				 * copy the argument.
+				 */
+				len = 0;
+				bufptr = buffer;
+				state = st_bufcpy;
+				break;
+			} else if (c == *opptr++) {
+				/*
+				 * We are currently matching, so continue
+				 * to the next character on the cmdline.
+				 */
+				break;
+			}
+			state = st_wordskip;
+			/* fall through */
+
+		case st_wordskip:
+			if (myisspace(c))
+				state = st_wordstart;
+			break;
+
+		case st_bufcpy:
+			if (myisspace(c)) {
+				state = st_wordstart;
+			} else {
+				/*
+				 * Increment len, but don't overrun the
+				 * supplied buffer and leave room for the
+				 * NULL terminator.
+				 */
+				if (++len < bufsize)
+					*bufptr++ = c;
+			}
+			break;
+		}
+	}
+
+	if (bufsize)
+		*bufptr = '\0';
+
+	return len;
+}
+
+int cmdline_find_option(const char *cmdline, const char *option, char *buffer,
+			int bufsize)
+{
+	return __cmdline_find_option(cmdline, COMMAND_LINE_SIZE, option,
+				     buffer, bufsize);
+}
-- 
2.16.2
