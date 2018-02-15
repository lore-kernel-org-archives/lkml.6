Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227H1Y4UgSAdkNmpR5jqUs2e4cDpsJ++pplvuL15Tgyvrkl1uasW/4ctRwRxlmqU8I8rHwmE
ARC-Seal: i=1; a=rsa-sha256; t=1518708733; cv=none;
        d=google.com; s=arc-20160816;
        b=JPdIlGo0druonVzlYoGHTljrBXI1NIdLz2UyJANiwuH+B9B6bTRZ4lPpG9hfTBuI32
         6lchyuJoeQQpWbZyXQ5AITkPsPC3XHNhv3yfqmxM6GymFyIy6/i+vKWINEuxNCEtsWgQ
         WzuVTIYSxEgwfBd7DKn5EFyEJuITNIGumDNaswLfFYxVBNST0M6pGlyD53VaIAX5y0Qd
         R4LgaRU0aIeNunPorFeb0VZmAtF2NgXyT4W/lf5pkClU7ACIECAneqFGfgIHdLPlj8Pv
         Oejr9DYFzXCNl5OvNjBzpRxpGpER3+RE5hbN60tKdEdwOnxI6dxOn1dKBX3GZb6y0z9b
         /kJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/JkuDiqwJctpYIHlkaeE6r1apPGr6jXcXb15xLTx6eg=;
        b=Cs3Cwb1OOXRDHMRBA0W1vNGUSyPvU/nNl5YhLtvXqfmiKNSXB5yZuFJGARzxVoAram
         tkakrp5jMBMHrd/M2lgrHvvHWlDjj7R0xtvVwIuifNBvN8M9B1mYy+VrZnlZRp+qKqj8
         lp10XwMvjoQvo+5e8390jzdM0gD5UU3hqF5/6UlqCM63pITUSvNbmvblhttMD25m7FCw
         OZyYGU5DffzMaMjj/Axg8JJeyVXxie9NuBp4GozC9XsOgWC7nJl+nHuPE7fp1l9zKfqq
         95GrKzrKnkk69VsT96KZVnXzHPDJVnR9jH/L1k+iMHbzdnSEl7OtlZoZpAEFlq2LbPUQ
         iltQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 061/195] [Variant 1/Spectre-v1] arm64: uaccess: Prevent speculative use of the current addr_limit
Date: Thu, 15 Feb 2018 16:15:52 +0100
Message-Id: <20180215151708.779414870@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481529299669431?=
X-GMAIL-MSGID: =?utf-8?q?1592481529299669431?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit c2f0ad4fc089 upstream.

A mispredicted conditional call to set_fs could result in the wrong
addr_limit being forwarded under speculation to a subsequent access_ok
check, potentially forming part of a spectre-v1 attack using uaccess
routines.

This patch prevents this forwarding from taking place, but putting heavy
barriers in set_fs after writing the addr_limit.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/uaccess.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -42,6 +42,13 @@ static inline void set_fs(mm_segment_t f
 {
 	current_thread_info()->addr_limit = fs;
 
+	/*
+	 * Prevent a mispredicted conditional call to set_fs from forwarding
+	 * the wrong address limit to access_ok under speculation.
+	 */
+	dsb(nsh);
+	isb();
+
 	/* On user-mode return, check fs is correct */
 	set_thread_flag(TIF_FSCHECK);
 
