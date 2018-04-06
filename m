Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48B1hKlaUi8F/j39fRJ0PELdOvFWDtwwBqJYdy6CiKj94vyotoy0U5GLq9I7QUPKpyfxS8k
ARC-Seal: i=1; a=rsa-sha256; t=1523021483; cv=none;
        d=google.com; s=arc-20160816;
        b=o+s1qH9hAPkQFaET10hbsYsYn37R6FXP2zaW19KgfzZIwW8kTdgVRsWvC1ifzLtgiw
         LIorp8W9AJWm8ayA6G/NkMTJNt2O/RXp8hT8xJu/Tr5cqZtLIddbTOggVuXibe76wYTI
         aqJGhfh9QpX8+0kvyuDORqUiStYEoUJCQAXEkI5jxEvT3o00gu+HLVNt4h4HYdjxIbMp
         Y1KoG8LMCXbVPY2nGrXDMtBNauN0HVAXpEhxxga6hy9sMIkJ9OFQaUXxIXYjsNY9S+Fa
         xVWp1AHxqoWknB1RaxAPBKtSZz4cPYtnUJ9SNUgZgzEYA8WJgi1H7pacQQRZPW4TGDQ1
         Jz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QAhfuiF5D13iEOvO7W26BjEcJKB6uKg7ZbFzzLgTz4g=;
        b=Vse8PlOYp04C3aK7P+L7siD4JDzc6NO4LAk5SUWlAM9pUPesGBpT2Yg2w/2Ejqu6s1
         nsLqXh3Fx3j/Jha1iFPPLDmL8cNJOiwnAHPMkhbMbSRPDkTKRrQ3qxUMOgnLAn2ayJZh
         dqw7K+EBL7VqHinCpxz1oqubTbXx+3RvQzVwjzejNXzEqMIjq27vOLg6QmWdwSYKK/59
         5lmbojKLbLVWcas3EgRIIPaUOEw0jJX+3bdWDgflhxqrOQIpmRz/sMuJntzgRi5fSz/I
         HPtYzj2JJbC7n5+1g7Q0lnnh8JRKtTuAA1k0SJA6A8zzsqYG9dsS2P8jaKIjPsMTfund
         dVaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 20/72] selinux: Remove unnecessary check of array base in selinux_set_mapping()
Date: Fri,  6 Apr 2018 15:23:21 +0200
Message-Id: <20180406084306.801783028@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003774688884357?=
X-GMAIL-MSGID: =?utf-8?q?1597003774688884357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit 342e91578eb6909529bc7095964cd44b9c057c4e upstream.

'perms' will never be NULL since it isn't a plain pointer but an array
of u32 values.

This fixes the following warning when building with clang:

security/selinux/ss/services.c:158:16: error: address of array
'p_in->perms' will always evaluate to 'true'
[-Werror,-Wpointer-bool-conversion]
                while (p_in->perms && p_in->perms[k]) {

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/ss/services.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -155,7 +155,7 @@ static int selinux_set_mapping(struct po
 		}
 
 		k = 0;
-		while (p_in->perms && p_in->perms[k]) {
+		while (p_in->perms[k]) {
 			/* An empty permission string skips ahead */
 			if (!*p_in->perms[k]) {
 				k++;
