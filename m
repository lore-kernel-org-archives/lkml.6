Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x22436TKmvRFTHTi7VKlGrJg9ecAdrxGX5ELxZ5LxXWpzPyUOiGCH0C714oKwU8HC7qRcZyJ0
ARC-Seal: i=1; a=rsa-sha256; t=1518708633; cv=none;
        d=google.com; s=arc-20160816;
        b=YOVzwz3l1nTAqYDLzOlB+nPm3Jqoj13FKfwpzwPZ6Bx7InaCUI+X3Recx0u5x4J82w
         ioMf0d8gID7sXZ5CovuQwLI6rsVIicjJiItGkv8q8qlQTCSyIkdeCqwLBMlT/qeQxwn0
         0OOZuAf62niIswWWjoMoNluNZHqTxrPiAh7AZDUobWCN5C8pAYuGhF87K5MErAltjQdE
         3phZyJsqI7gpvxNrjweWfsw3/2QwYEVxAIdfJbuL/h/tKY8WbAJ/MvuVoJ1nuIZ6gEYN
         TpKUS8yn0bEXxT4jPB2ARermo5jVT8rEUjw1H4b67mL8bYZLVaMmnEPU7NeRnqVpnbEq
         VvxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=78miSuzeeu+t43lGeODbmVacnuqzUDMiHr3TFj6EfNM=;
        b=mZl/4sP2hZ/PybqC9/D6GtcfUhdFpnWdxXSv3LV5cGq9Zh/NQOA5vJyn7QI7Kh8t21
         +k/e2Cz6m1c0EWRULdEfWVvviZHZnau0wEreSDaWkGDqqSiY7iERHDtktTtdQwZbh4Bn
         tcKWnJNR8l/yI6kucIMfla+tuaHD1Oc94hkXVVQiVqxmu1psAPhDNAYmWVX03VznHpqn
         xgvE2+z4VFp5z+WOGdkqlxlm4sukUp/cQHoXdFK0s0ohdMgdFuOoE5lWSfWLvFuNNe6D
         DS1mswsdIFzP/1f8z9t9pAuInDqk4MyKQnRJeKtSADsi/xxUKnRNhNIzyeryH0wzqskK
         gbnw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 024/195] [Variant 3/Meltdown] arm64: mm: Temporarily disable ARM64_SW_TTBR0_PAN
Date: Thu, 15 Feb 2018 16:15:15 +0100
Message-Id: <20180215151706.962798698@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481423799436656?=
X-GMAIL-MSGID: =?utf-8?q?1592481423799436656?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 376133b7edc2 upstream.

We're about to rework the way ASIDs are allocated, switch_mm is
implemented and low-level kernel entry/exit is handled, so keep the
ARM64_SW_TTBR0_PAN code out of the way whilst we do the heavy lifting.

It will be re-enabled in a subsequent patch.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -882,6 +882,7 @@ endif
 
 config ARM64_SW_TTBR0_PAN
 	bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
+	depends on BROKEN       # Temporary while switch_mm is reworked
 	help
 	  Enabling this option prevents the kernel from accessing
 	  user-space memory directly by pointing TTBR0_EL1 to a reserved
