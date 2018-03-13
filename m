Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELukHF4NLXOZVRZC13IfvC9ptvx+KwQKZuozlwlzFEU4SOawrN0YZVPoDh57A7F4eo2tfiFa
ARC-Seal: i=1; a=rsa-sha256; t=1520955555; cv=none;
        d=google.com; s=arc-20160816;
        b=T4MXXTH9dBXeu137UslJH+D2gwrP+YMkLq8h592HV2yAX4DP+PLK5dSpt69FZrItcs
         5TykJKIXGOlDzRXqqCxwcISWqaPRBO6yVoshVGvmfAJlsM6+WQNBKEhUXK55p9ilVWUk
         89GARkaC5qT8lO041RnRXrTBf5sHMJjWSpJEZCos3mCWa1bXe+3OEpGUSYQUiNJhxWo9
         Jc51vRZhHhJzkfNpTlbI7mlcI/i7Uo2dLGVVM4l35uk5iAhnA7G4pJAoKO3j1aWAl+C1
         POy64fROO40B7RBJp2IFgXFygpqD+j+q2801xAI7Z0T9QCmvHu07VgjlCt6ISBoIGESY
         hV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pfNHV4DohaURF2uPOj/FYB2YF5DT5NClVHLICPcd5oQ=;
        b=zIFm0DkrRQ9Nfpj7su3Vk7kb8qa2+NXEnjOSfGZ1xiKV/T1beDLzL51vJSKo8T6NKC
         VnyUdd0Q0eoHoWEcMTBS1GxthI9ShH2n29D6UddBMnhlbQf2U1m3gsX94BTQAsbOdzCo
         dsQwd1d/n+OvAUUgCum2Q/ti+XONPlOoHkmGWfDOObJVl3UcQzFC/ECd22VaCpVnnCr7
         6VfXcmF/hVkK1G9JdG8TkoVRcKt79roIbjGGrI7aefvIxIEwhlGhGy8aMBHWHc3IKiX4
         M6glwBz1EtaTRJpOmoMYoG5U5JaaY6SLWTc4v7K/CIGFRrXWsnhecLodZiQhtUcSqN7t
         efEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.14 090/140] arm64: mm: fix thinko in non-global page table attribute check
Date: Tue, 13 Mar 2018 16:24:53 +0100
Message-Id: <20180313152504.179086368@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836906972726336?=
X-GMAIL-MSGID: =?utf-8?q?1594837492693923487?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit 753e8abc36b2c966caea075db0c845563c8a19bf upstream.

The routine pgattr_change_is_safe() was extended in commit 4e6020565596
("arm64: mm: Permit transitioning from Global to Non-Global without BBM")
to permit changing the nG attribute from not set to set, but did so in a
way that inadvertently disallows such changes if other permitted attribute
changes take place at the same time. So update the code to take this into
account.

Fixes: 4e6020565596 ("arm64: mm: Permit transitioning from Global to ...")
Cc: <stable@vger.kernel.org> # 4.14.x-
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/mm/mmu.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -107,7 +107,7 @@ static bool pgattr_change_is_safe(u64 ol
 	 * The following mapping attributes may be updated in live
 	 * kernel mappings without the need for break-before-make.
 	 */
-	static const pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE;
+	static const pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE | PTE_NG;
 
 	/* creating or taking down mappings is always safe */
 	if (old == 0 || new == 0)
@@ -117,9 +117,9 @@ static bool pgattr_change_is_safe(u64 ol
 	if ((old | new) & PTE_CONT)
 		return false;
 
-	/* Transitioning from Global to Non-Global is safe */
-	if (((old ^ new) == PTE_NG) && (new & PTE_NG))
-		return true;
+	/* Transitioning from Non-Global to Global is unsafe */
+	if (old & ~new & PTE_NG)
+		return false;
 
 	return ((old ^ new) & ~mask) == 0;
 }
