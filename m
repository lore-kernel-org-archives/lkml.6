Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2268eItZ457pa2iXH5ouxVqqcu4yYFjmWYtT0MXGboIyJ52NJPdfvSkm8iuDVPCCwexZ8ITk
ARC-Seal: i=1; a=rsa-sha256; t=1518708807; cv=none;
        d=google.com; s=arc-20160816;
        b=G1PwKEys9fxqPFq0dudmZaNAqbgnCW/tIGxuwJj48cGfsZ0ym2hNerkj9igRQkonYa
         BMJCYZ31xnRzUw/ugdT7ekghmMv7T3XeTnF40UVCZYLK7ggFJUZT1sy3WkRXsY09/5aa
         tIN9FubPfk/i3hHny6s0q1OW5wIV4fXsTy1MT3NILMoYE3okQ1SgFY9DgwVhw9EiJEj6
         xJEX8ZKup73MoXbmgTiVDpxjmb/GUI30C5TIpUr8zBWwrxdQuNSbLM85OvogOjn/kMns
         ZMjWOU/+kphbVXFhrMrhiCfvAOtggwrYSfghUcFMdZqTKBqq/N9s/BadN33OJgQM/clc
         p14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=t4RJJX0xGW6cTE+CAwsKnEKmhEwtuEKcwpoRdTRKQ9M=;
        b=WpHVy/aj4yd3AePKKGk4NIl3kq4QAI3ZqOspCN54lbQRYlg+pZjBl93crDZo+ntc06
         9uZ8WZ1Hh4OXTrXLPtW9IfxzX1ENxU44vIVOErYNmGd0Ok9X7LtN2KmXOSrbivSlDOp3
         +5d4mFab9v5Q2jazD2S/lz/vyVd5PRzLzBSceYlBgkBMnIAe0tKtwBYTbIwMoFb7PH1/
         8ViewBiU3ZY4w4F/MpP6/H9riF95r1f3L+6H5sS0cetCEgBs6/Mom0SWuj7nmYHbuR8Y
         qGr31n9n26y7ZURboI+XwYX+SgXrspW6EM/I9FNdJuczUXYRGKWa/R5Y1brvMxS0hQOV
         bowg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 051/195] [Variant 3/Meltdown] arm64: mm: Permit transitioning from Global to Non-Global without BBM
Date: Thu, 15 Feb 2018 16:15:42 +0100
Message-Id: <20180215151708.289611212@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481606997145686?=
X-GMAIL-MSGID: =?utf-8?q?1592481606997145686?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 4e6020565596 upstream.

Break-before-make is not needed when transitioning from Global to
Non-Global mappings, provided that the contiguous hint is not being used.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
 
