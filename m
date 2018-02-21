Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224AUEv0UnTYrHa1FoR4LYWk5mtJFEYH58oziF0LtwS3SjDWTjUo+TXpskTqIus13j9cdTOW
ARC-Seal: i=1; a=rsa-sha256; t=1519217802; cv=none;
        d=google.com; s=arc-20160816;
        b=KdYkdCgcVmSYKHWaOVlQgac6ZyjkBbOEKnfhNKyP601DjjOq/8+5tFaiX5gi7IBStS
         nDQ72upUzzRqRPExCQiwDmvDx6DVrYPhY96nhRzhZWxgR2tXrxZ/x4tpI1++b5iAeQg0
         67WoPxV7xRFyWa7yaR/TDnPG7gOcJdQxbrQWM+WpK5Bft2BMhzSa4n5RyhZaeHhWygUV
         646rXjluzqC5J4g8OcYzZRJ4KMEtjfyEYeoIhLhy+TQ7E21goRIwS+WcGEd1rb64WGsJ
         6QkHqxJ10BaKQQaI1ABS6S8MA7vvpfh0SAKIvN/ytmEZdO8IqbroebQ3KvNRDQSCQA7Z
         +/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yMfs3wFJdW88thQPX3k2Db5eVPwFf2kRekYeqacSDww=;
        b=SW2KWc3jlzSm9mNfE88coNerVLodxiuhfeE5ACH5XVXa/DUGDZpTsJkeNhaQyaEPRa
         kVolwzVv/+X/IdYIiohvuP1K0yenFXl24EaZ6iYOMr5XrcjJD7xpGnaT4h7Z9fWBmqpM
         UX/qC8pLVFUfrkegN9LdFEAsTN8Xr5q+xcFyU0thFHHFxXPGUXuIaFttQEshbAjaic1e
         Gxv6T0BVX8PazrxpgZcwTqcrnop/kaAM7/BkUz5IGeIuR4BFQ2uIYlIcNxHlEIJc4Db3
         sP7m+sWAaUDWaIOZEFtmsl4mHdty1WSj+LJ7d8VBtTe+k0/P55FB6arvXhlstZPT/0vg
         RlQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 60/77] x86/speculation: Fix up array_index_nospec_mask() asm constraint
Date: Wed, 21 Feb 2018 13:49:09 +0100
Message-Id: <20180221124434.735031078@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015326563332665?=
X-GMAIL-MSGID: =?utf-8?q?1593015326563332665?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit be3233fbfcb8f5acb6e3bcd0895c3ef9e100d470 upstream.

Allow the compiler to handle @size as an immediate value or memory
directly rather than allocating a register.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/151797010204.1289.1510000292250184993.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/barrier.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -39,7 +39,7 @@ static inline unsigned long array_index_
 
 	asm ("cmp %1,%2; sbb %0,%0;"
 			:"=r" (mask)
-			:"r"(size),"r" (index)
+			:"g"(size),"r" (index)
 			:"cc");
 	return mask;
 }
