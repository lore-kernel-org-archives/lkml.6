Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225Qp6Yfs8ZIOUZQK6s+VhV5+oMycw1e63AuUI5E8Q76I//oR8HL0YLoVLYvzboleCyJNYI7
ARC-Seal: i=1; a=rsa-sha256; t=1518709232; cv=none;
        d=google.com; s=arc-20160816;
        b=0YlU+HylRFcrxj+LBgpLTEKsFYh+v/cVxw1iF7Hu4C+yLPbOFQa0gyYQOXxGmwNbU1
         3gCg3p7wbtrE23GdO3dG52P0vz3saGQwbcDM6KwPqhSQSQe4Hf3CrqPT8KYq5mfy7YzR
         fNzLMdy+eLsk0czA5IwQ6Wpmf5WK9wZxPgaXUBmQttOj7Ig3j97I3RNgGQg/FCQ95jvk
         d4phgB2wbvtuddwApIKVnZ1yHG+uJCJHbtxrq+eGkOvaVktIXi1nF8bll0m/bV6ZvC1K
         NIGdot1b7cU27bxXQkh5/0W8BxQJwgnZB11BoarRJBbITx+GtA7xC3ZeKod6z7MT+Jdn
         lxKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zGG0GJXcj7JiiRsf+pyd0s1Z65Xgi/bRFsLrhV9mkmQ=;
        b=M9oLY2i7YIBi0HVSh6K4JRmEaGdTqoHss8eOngrYEcYCmnw2vENYTzX77DnU6swQEq
         gRVatbPN/okYG7ETLnWF1GfDu3Lhmck7G6+D8b5Gon7fNvLSZwPkio1I3XmFSFD/gumP
         DjiRYZmdIBZ6OlCq6jPxMfhT1WGMaQB3G9cJ6Bs4JZvTc6/ihKAt0jdB0YcECr3abs/O
         l7JRoFveRVNIJEMsJ70sp8LU1c6s1DaZt7+n2SaYqsVEdlgDYc3l9aXtGOJbXVmdIbad
         WyeG0ABwH8qUYLKWX5G00bqso1Vo/agsovpDPFL1IMTgcxStQsTQHLsJf0Mh5+/Kh0dz
         MvSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 043/202] [Variant 3/Meltdown] arm64: mm: Permit transitioning from Global to Non-Global without BBM
Date: Thu, 15 Feb 2018 16:15:43 +0100
Message-Id: <20180215151715.431836869@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481606997145686?=
X-GMAIL-MSGID: =?utf-8?q?1592482052422038558?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 4e6020565596 upstream.

Break-before-make is not needed when transitioning from Global to
Non-Global mappings, provided that the contiguous hint is not being used.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/mm/mmu.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -117,6 +117,10 @@ static bool pgattr_change_is_safe(u64 ol
 	if ((old | new) & PTE_CONT)
 		return false;
 
+	/* Transitioning from Global to Non-Global is safe */
+	if (((old ^ new) == PTE_NG) && (new & PTE_NG))
+		return true;
+
 	return ((old ^ new) & ~mask) == 0;
 }
 
