Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt9slMUjedQX/S6RwaG+Kw9wa/qeld/RhmZMsO41DU+eqxYLfML+clxcW7Unm6C8Hb5o/CV
ARC-Seal: i=1; a=rsa-sha256; t=1520954997; cv=none;
        d=google.com; s=arc-20160816;
        b=tOKe8drcjQTTTgg51SJHwxzQzD9foBlnEbYNMQjdE1l6Y8lH1EL0jR7kmF1rf2NVH4
         NCpB2Ynr47JVEd428KrIsO46TsKK/TNXEJ845OY2uA2jO0MeyEFmHIcwbczwks9391PJ
         DSn23U4zio8+Lj8qo/vJb7CLdaxxUM1+FL0m2n+xqQBfzAjrOLtPZbAb2z6I6YRV8Ws/
         Z9Gr0XmIGsM9QErzDolMY9dXO4KpDGCE6guJJZC35C+poz+Drw1gQosxEV2QkhK6Zt/u
         hqjufNCg+m3n2W35rwMMdqFUwxhM11RxtWnMg6vsSe2KpwTjcj5iZxcv+z2CO4SOo4od
         Lw6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=smqNmhYz5BI9gMp0kLRF5VPOyObBmTv3iH8/4F4AYNs=;
        b=MA5ryqYvho53wW3W6dpIOIYEO5Kp8976JgOraM28xLOEf4cAtd5jhKUFk/pS7Cwrvx
         9qCOXAtiGwCMTmESwsVxsi+T7Uq/P7njT/H8usmNcU87FZcrC7pwHMyOoFACQJOySupH
         vtOvrpCX00ULB0hEH8DkfQdhL98fdHl7OFIQ3aGoKwXHPJS86NwYXy97A7ENqGCZCObo
         3NiFGBH6UbDygUNih8HUl79wt+zsyIxBCEYfMUTruPqnutUiPi2zO59DJY7/B/Trd66j
         hReSmXqxA49XjF/wyyGKapjwpYJh0x97Uv0QxzuKdomppCGlCeAyPX/2hdjD/vmWJ2Ck
         nlVg==
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
Subject: [PATCH 4.15 054/146] arm64: mm: fix thinko in non-global page table attribute check
Date: Tue, 13 Mar 2018 16:23:41 +0100
Message-Id: <20180313152324.816712250@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836906972726336?=
X-GMAIL-MSGID: =?utf-8?q?1594836906972726336?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
