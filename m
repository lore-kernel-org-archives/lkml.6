Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49F7+tyVt4Uofyzng2379iNQaTEUWEObFdgM8SL8FX2ea/TpDH6Y+KdBPpI6ASFLPVHlHrh
ARC-Seal: i=1; a=rsa-sha256; t=1524405852; cv=none;
        d=google.com; s=arc-20160816;
        b=KLvuIuea6V6dyvlghj+dPV4y39nRUvFNZyk+CsdZf1clj5ogU3WdRmwGbxpI0p83tF
         LAFSv9nUqVpNZvYdZEpQVyHQWlt6/ps9eRbXtG3WmZCIET5d1qWP7sx5ACI+COBYicQb
         CsXqGmyhtT/fh7ZBqpa06Fe799onJ+rwuq53wRRLmeO6632VQaDaUMstROaIh3HDF6bE
         z26N2AjjwF3D+DNOo5gSH2/f9jBMaRQXcoyxt8EagWht8TcwAX3VWJVletLck0s4h5CD
         naB696NIzSJjCBCuNq3PcnzWxjy9/jlayG8Cq7alXYHUL/TgUjfffmHaCh6EJRSGtTaX
         Ey6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hZeyO1ZOd48494Q38ysZdjJf9ql5G5XnIuf6OdoAkc8=;
        b=J7vrpxg5I51L9J/YRsGIyE5FsIEq/TpBoQSiFHUAwlsPrfxoHX9mb4KuK9I/I/mVwi
         G78ER+0Th7ivcuSXhZMWjiPUBN6jFPsUP5DW7ysHgS7Z/apJ4R3WAFsWPIMg2CQ6w5sn
         pd++0wEYONyGbVfeZkfWhKHa769Zg9wz+lGpfMwVvx8gD6ZU2PqR0fLA6NPARxF2wwRY
         D+dDMDsaOdJHi9BCq8MZB33eQFH8ABGQpxwxnbdTTZsIQCjcvrWKCkI6D0mxEffo7w03
         O7aUw5w/p3WQQxBG0dcOp8bSwVXX0Ra5xKd67EeBmp/EckGF0KCUHbSsmnEA6lQ9iiPo
         n24g==
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
Subject: [PATCH 4.14 021/164] ARM: EXYNOS: Fix coupled CPU idle freeze on Exynos4210
Date: Sun, 22 Apr 2018 15:51:28 +0200
Message-Id: <20180422135136.260339136@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454828094726894?=
X-GMAIL-MSGID: =?utf-8?q?1598455391014520745?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -276,11 +276,7 @@ abort:
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
