Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx488Ys7FpDzfeihEh9cobUFAGdYhEx+On+8UDUQ7VOGQQccha3TBVp6kXjB/aDb0zgCZwb4E
ARC-Seal: i=1; a=rsa-sha256; t=1523981335; cv=none;
        d=google.com; s=arc-20160816;
        b=vHrEVtILOIi4D1dV2av0xwDaJvteqbRl/BcOSUE5K7Tq+0aJeRuk5vC+X16wFAX3Y3
         +8MO1T1IHX90QTnlXwNy2SPftEoq6o3IZ7JaOyaejPOC5edzCSzigag3tIhEOYKDpYk5
         SYRZ9E7YBonKN0rm5ZmTygpRPHAzldNNl9W8YQab5DQ4jqnyuFLWobkTasTn3FiKQ9ic
         3lvNJ+vQZep/76vm+CcAMhf391NiuMrmsWNf8o2e3n5v943SvepnShD3wUTrtMhP8+Bf
         gfpR5Zt14mFNZ/fAMKl7igCvJbzq17/nNoRoNb8P8YPoyWV2x6Lp4qCHfbliWSI0JL/7
         6nOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fybB2mzwgi+QTGvFEONRwOHNmdKKbSxbwJXWRFY9cG4=;
        b=hCrn6EAUwCdl3DXepONaSyO8Kj+o5sGiTuHPYg63tegsyaJNZJfSEH6HZZh+sud/2i
         iZGuVBHALq+nWxbBuYvPeV437dmICW6GgssNF/aD/21bkszhNJe1CPM3iuIjWtdFJWAT
         3DlTvY3mgDUOKUBhdMnunHc73wZJX+gOcbACraHU1BPdH/KXQHgz8azMfl7AADZwv45L
         OLMhOfTMBGIOVui8WAVl4sMcLllFpd78iI7PjeWYgQMaDMkgBkkstF/ZtLNnb6YAvemJ
         YlId3QVsjyEX5NFkPHkAvmTplO08hIJMd/OfF+/Y+0lYT7iDyYtIjieSyxzF5UtaXd9x
         smvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Will Deacon <will.deacon@arm.com>,
	Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 4.9 27/66] mm: Introduce lm_alias
Date: Tue, 17 Apr 2018 17:59:00 +0200
Message-Id: <20180417155647.043849847@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010253435398002?=
X-GMAIL-MSGID: =?utf-8?q?1598010253435398002?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Laura Abbott <labbott@redhat.com>

commit 568c5fe5a54f2654f5a4c599c45b8a62ed9a2013 upstream.

Certain architectures may have the kernel image mapped separately to
alias the linear map. Introduce a macro lm_alias to translate a kernel
image symbol into its linear alias. This is used in part with work to
add CONFIG_DEBUG_VIRTUAL support for arm64.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mm.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -76,6 +76,10 @@ extern int mmap_rnd_compat_bits __read_m
 #define page_to_virt(x)	__va(PFN_PHYS(page_to_pfn(x)))
 #endif
 
+#ifndef lm_alias
+#define lm_alias(x)	__va(__pa_symbol(x))
+#endif
+
 /*
  * To prevent common memory management code establishing
  * a zero page mapping on a read fault.
