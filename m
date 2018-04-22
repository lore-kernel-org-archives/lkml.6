Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48nZQYlp/GIxlD2XZauIz6M68cV4c08YHLaBNVIQA5aowOrFgpMmH6G2CeuEVzKNAWrr64I
ARC-Seal: i=1; a=rsa-sha256; t=1524405315; cv=none;
        d=google.com; s=arc-20160816;
        b=uXUBjFVN3kkVePDc4AKjphIYopDkGpMLOWNjIbIzmVkHCPs6XeFtA3DzZacFW4Wz5J
         +C44Sxu7MI6mVffiLJMS0Rny4JX8dQWKvR1wyeqrxrRWBNAUKcXSP24pUsHoUAWPCJHN
         7L/HXwCBxb/c4Ot2u4MtqekTAHBc29y0seA2KrQl4nACHCCDsInfMEYcqOLtnGkBbbaC
         yjIaMjpDU65a57CeDitB2k7yjvW/DEcrERUivB0Ok2sw/K4UZl7ho8iE9AlFGIeiodGi
         /pKbYmpwovyJB018FOEZLJL9jTH+L8XrlECTs7oAaXSv/gybT/ttUL9/9lJR1MsSz42z
         i5yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HsWy2WJ6vKjD38yR9BM4nWTOl6npYNbU762sAnRBCvo=;
        b=UIUY3bd5opD6hQpcVSDA0BvNsCBo75RWiMIua8dQZ4QMKS3FaQshCSMvHXWrmzyS9k
         POBmeiDMJomhmlcWzPDpQdChn2MjlwkqcGu95xhJHINXAzk4QbmE6C8IOlHvoL/orAS4
         p7vv4qTvmjhehsHvxRkn2DetsQLrJ+El0B+0kuh8Cc1h1zHbcEpeVVG25cSXe2qAAivx
         jjB8wCSpSYe1/kqulJDJ+aLgukCD0oYAlcBPT/MTfbO5jz9LRjEwtrqReVO4t2R2ybN1
         uugcKFOzMY6wJLrr2mDwkc+lHQ3w58HfRbVUsyOhvzCfTxw0dHDJ2f7ouxysH3rt62QA
         Qm5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.16 022/196] ARM: EXYNOS: Fix coupled CPU idle freeze on Exynos4210
Date: Sun, 22 Apr 2018 15:50:42 +0200
Message-Id: <20180422135105.268175706@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454828094726894?=
X-GMAIL-MSGID: =?utf-8?q?1598454828094726894?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit a7480dbcf983c31d8111f864c848e8a75116a87d upstream.

Since commit 04c8b0f82c7d ("irqchip/gic: Make locking a BL_SWITCHER only
feature") coupled CPU idle freezes from time to time on Exynos4210. Later
commit 313c8c16ee62 ("PM / CPU: replace raw_notifier with atomic_notifier")
changed the context in which the CPU idle code is executed, what results
in fully reproducible freeze all the time. However, almost the same coupled
CPU idle code works fine on Exynos3250 regardless of the changes made in
the mentioned commits.

It turned out that the IPI call used on Exynos4210 is conflicting with the
change done in the first mentioned commit in GIC. Fix this by using the
same code path as for Exynos3250, instead of the IPI call for
synchronization with second CPU core, call dsb_sev() directly.

Tested on Exynos4210-based Trats and Origen boards.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
CC: <stable@vger.kernel.org> # v4.13+
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-exynos/pm.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -271,11 +271,7 @@ abort:
 				goto fail;
 
 			call_firmware_op(cpu_boot, 1);
-
-			if (soc_is_exynos3250())
-				dsb_sev();
-			else
-				arch_send_wakeup_ipi_mask(cpumask_of(1));
+			dsb_sev();
 		}
 	}
 fail:
