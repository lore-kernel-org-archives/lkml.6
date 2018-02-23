Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2247YSEcEQ+82tluIdxEel0YmDRJZ7EdFoEusssgjypZNmOGJDvtXNlOL111ZFGYb3CGTilx
ARC-Seal: i=1; a=rsa-sha256; t=1519410774; cv=none;
        d=google.com; s=arc-20160816;
        b=bs8UfXtlUEoQXXgd7QspBM26rtNuad5353MbWJo0r58Ttm5I6AHQsXgZh3GQ3V/2I4
         UW43Jsg79yMV9jUJHSR7h+9VyyGZADuB9YnZsZIhI2gvejnQhywEcPetBqmpD3DIrwBL
         5WOJLqTQFJS2Cr5ZTl2ifL6OkBC9/GuQyHWPz/4izCOwsJRb2CFfpFiZlUAuWzBVNNWj
         ZhQ+jrdGOlGXhOWysLBMNA344eXIp/OGlmTzN8Kz5XXzSrBIImBj5jYzxbd5cRJcTmlj
         WPPETcep/1wocR3x+OIRZShPFcxu5pTnhzieHZr5Mu3uUIcgsEWbDgcSc9iTjoEepm1F
         mf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3wngXkXg/XjLaNviu+PdzFYbCKwXEHjfZFLV4pNdxF4=;
        b=M0qrWBks3dz880k/ku219SxlgR2ZUAKATqSFX2WPMdRfwwQ58Lf02ZJNssI0fSJ7rk
         MAh9XJVoq98kQ8rC9kUWp0Cny7u3opF7revBNRkSUhlItsWRbWPbevsGoCVHKn37DIE0
         3FnGDM9hv/1x/nGdczyUJvKYvY29JWA1zmL7nhYsvVvcTHrG3IuaFFAVowHH7pAewUYJ
         PBvF/eIxIIgOt2qi7Y6o0HRoxU30Mq/cSnngjafoHsZWiA33vFmmvs6LUOFub1sWOeYY
         FiONobyEGlRD5kzN5hCgE5RYFWYzpfA+mM6lzzaFU0cSYdWWwCYm6LZ97Fo0g5Dfl0T4
         UepQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>,
	Paul Moore <paul@paul-moore.com>,
	William Roberts <william.c.roberts@intel.com>
Subject: [PATCH 4.4 010/193] selinux: ensure the context is NUL terminated in security_context_to_sid_core()
Date: Fri, 23 Feb 2018 19:24:03 +0100
Message-Id: <20180223170327.748878896@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217554793974221?=
X-GMAIL-MSGID: =?utf-8?q?1593217672281107022?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Moore <paul@paul-moore.com>

commit ef28df55ac27e1e5cd122e19fa311d886d47a756 upstream.

The syzbot/syzkaller automated tests found a problem in
security_context_to_sid_core() during early boot (before we load the
SELinux policy) where we could potentially feed context strings without
NUL terminators into the strcmp() function.

We already guard against this during normal operation (after the SELinux
policy has been loaded) by making a copy of the context strings and
explicitly adding a NUL terminator to the end.  The patch extends this
protection to the early boot case (no loaded policy) by moving the context
copy earlier in security_context_to_sid_core().

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Reviewed-By: William Roberts <william.c.roberts@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/ss/services.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1406,27 +1406,25 @@ static int security_context_to_sid_core(
 	if (!scontext_len)
 		return -EINVAL;
 
+	/* Copy the string to allow changes and ensure a NUL terminator */
+	scontext2 = kmemdup_nul(scontext, scontext_len, gfp_flags);
+	if (!scontext2)
+		return -ENOMEM;
+
 	if (!ss_initialized) {
 		int i;
 
 		for (i = 1; i < SECINITSID_NUM; i++) {
-			if (!strcmp(initial_sid_to_string[i], scontext)) {
+			if (!strcmp(initial_sid_to_string[i], scontext2)) {
 				*sid = i;
-				return 0;
+				goto out;
 			}
 		}
 		*sid = SECINITSID_KERNEL;
-		return 0;
+		goto out;
 	}
 	*sid = SECSID_NULL;
 
-	/* Copy the string so that we can modify the copy as we parse it. */
-	scontext2 = kmalloc(scontext_len + 1, gfp_flags);
-	if (!scontext2)
-		return -ENOMEM;
-	memcpy(scontext2, scontext, scontext_len);
-	scontext2[scontext_len] = 0;
-
 	if (force) {
 		/* Save another copy for storing in uninterpreted form */
 		rc = -ENOMEM;
