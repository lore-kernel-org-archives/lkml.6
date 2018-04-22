Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/jTv0WOb1u+qg6tSsvhQtF4mHH1RZjZJN3P+Q913fcRKIl270EKeAUcvLFsHd9u9cudqVJ
ARC-Seal: i=1; a=rsa-sha256; t=1524406473; cv=none;
        d=google.com; s=arc-20160816;
        b=BpUqAhiIzH8DVwYr8qHGfgCKnE0+oOFqIC8WztzXcCIh96MwkFNX5uxbqnGUuLNQs3
         AcfjJDk1LRrz2opjHrkrNCMko+f/T3109scx1///8zC81X6UBtqZHsRYll4yZfgVOaa3
         W3rZLSc8vUwlIifR2bjb19jwRBuwaGYH+UHV+WzcI9okyPHR8QtsMcnYx3Yg2CMUm8kB
         s3m3fB1E4yz3DonABE1vADVW9Q1grIbNzA6t20+rt0jtKFlNNvDcHZMY1LnD1OrMTMFN
         CfzE9GVHsdISe9YxTimhxRBx+OsT25fIChz3GfVx5wy7I8bmm+cN7TWLKmdalX/OHoEo
         I93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fdqLhY9Tp4vcGSAQdbnAkC0+pcCIb9I5nPJapxITq1I=;
        b=gZs2ExKPuqYODSKK1+g0T7NqtxXsE/20hbzo8oTwHflieWRr+toHG8/ahRx3lQk9tu
         f7Iow5hOX4R6P8PfuTMSm7zFJAk0XUPv5SjiIP14XzD+FuQ/Yegk6fV2UkLTr6b4/46D
         dVHYu2lhDMlxLkRNqqGQnf9Vwk13pk9CpJdgCt0Mleivlnr23iUFRS9a8XYkMQ2/J1O4
         B/+bPHw3xm8gxaE9bnkv/msCXljwY2ff+eR29xCKyPmgOJBo7FYWU8d0GN6ktzuuu863
         bq58DmWXqAwZjng9MqnQswUmZ8BAac1+EupWk8OTimn/yv9m5hR5E8G+tTIPsXcUBVfL
         cXfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 84/95] powerpc/lib: Fix off-by-one in alternate feature patching
Date: Sun, 22 Apr 2018 15:53:53 +0200
Message-Id: <20180422135213.862996430@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455279697433577?=
X-GMAIL-MSGID: =?utf-8?q?1598456042124387236?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit b8858581febb050688e276b956796bc4a78299ed upstream.

When we patch an alternate feature section, we have to adjust any
relative branches that branch out of the alternate section.

But currently we have a bug if we have a branch that points to past
the last instruction of the alternate section, eg:

  FTR_SECTION_ELSE
  1:     b       2f
         or      6,6,6
  2:
  ALT_FTR_SECTION_END(...)
         nop

This will result in a relative branch at 1 with a target that equals
the end of the alternate section.

That branch does not need adjusting when it's moved to the non-else
location. Currently we do adjust it, resulting in a branch that goes
off into the link-time location of the else section, which is junk.

The fix is to not patch branches that have a target == end of the
alternate section.

Fixes: d20fe50a7b3c ("KVM: PPC: Book3S HV: Branch inside feature section")
Fixes: 9b1a735de64c ("powerpc: Add logic to patch alternative feature sections")
Cc: stable@vger.kernel.org # v2.6.27+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/lib/feature-fixups.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -55,7 +55,7 @@ static int patch_alt_instruction(unsigne
 		unsigned int *target = (unsigned int *)branch_target(src);
 
 		/* Branch within the section doesn't need translating */
-		if (target < alt_start || target >= alt_end) {
+		if (target < alt_start || target > alt_end) {
 			instr = translate_branch(dest, src);
 			if (!instr)
 				return 1;
