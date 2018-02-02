Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226ghM2ESpctQu68cFcGZmK4LMpxPyt7tzrZyoy8KgAfwJxlldK4yCBMDfc9kbp9DFKanV8G
ARC-Seal: i=1; a=rsa-sha256; t=1517591288; cv=none;
        d=google.com; s=arc-20160816;
        b=aZ6SiwGCzntXrl5FA0ICYBHv2POmx/l7bvEB0zo0p7M2z4RmwYSX43mn+cNw6yab6o
         Gf9Y6lfN2xaDNzf3DE9Xbc2We/NmrFpTbsOgCrPySsGSGF7PyDOLPN9aXY6/m+ixSR7K
         24l8Pkz/noH7y3mHrDIPelM36Gu7MEZd/VhLoclDfm7RhH+k8G0vq8u6mPZXLCVrpqE4
         afugWC4mEqDX3wf+3oYjS6q3c6jbBP6H25X/7ULgTiCtiHI9q5boph5SKCLaj6q5nZ0z
         17WhoL3yePjX1Jc5SHFcy9D6GnEVxwOzK+pcYtpF509NP/nW9tOj5fdFQrGdUNnQMIL1
         56QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CDYkaNx5kBywvE8C5vO6LLiRus2JwWbhXbrsDrnCQSg=;
        b=REcBkXB32p0f7v1Uic4XTmsd2Mli/fXzj7knKm8npFgcF4JgY5MwMlbUFjWhHJ3X2e
         N9CjDpLO1nxY2WRMP10RXr1mACwGAVzfwj07EZYb2dRjNcYPAv1NTB4sozkhdypx/+kF
         zVXtXfwT4IfMawO2rhFnLEe5X5TGuN8Y219ENBgGlSCNPFuvAlsyM4nqJmo8LDikI+3e
         CjPiqwelL8k9AJWHIYeZiFETabvJ7/ere3o0I+fpMb+S1ul6ivRkrRCzAT6vGl71Gt19
         Lhz8Q1uDAzqS8SCA5UQxNLXUtqS4TcKa2LujIcB9FxHetOl2g53BW1t7rLXObzboYQNt
         65Gw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 4.14 027/156] ima/policy: fix parsing of fsuuid
Date: Fri,  2 Feb 2018 17:56:48 +0100
Message-Id: <20180202140841.538764031@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309802880681266?=
X-GMAIL-MSGID: =?utf-8?q?1591309802880681266?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Rapoport <rppt@linux.vnet.ibm.com>

commit 36447456e1cca853188505f2a964dbbeacfc7a7a upstream.

The switch to uuid_t invereted the logic of verfication that &entry->fsuuid
is zero during parsing of "fsuuid=" rule. Instead of making sure the
&entry->fsuuid field is not attempted to be overwritten, we bail out for
perfectly correct rule.

Fixes: 787d8c530af7 ("ima/policy: switch to use uuid_t")
Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/integrity/ima/ima_policy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -743,7 +743,7 @@ static int ima_parse_rule(char *rule, st
 		case Opt_fsuuid:
 			ima_log_string(ab, "fsuuid", args[0].from);
 
-			if (uuid_is_null(&entry->fsuuid)) {
+			if (!uuid_is_null(&entry->fsuuid)) {
 				result = -EINVAL;
 				break;
 			}
