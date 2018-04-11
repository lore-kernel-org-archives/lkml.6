Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ogoBJa4wHDyq8ddf3dyaWRkN6QdeqZtqF+7lM+FO0UgZ28f7BcRvrrB0qK33LnYmbqGqe
ARC-Seal: i=1; a=rsa-sha256; t=1523473378; cv=none;
        d=google.com; s=arc-20160816;
        b=v2NHezMRLGoN8NwpXlc/QP0rxXS3OHfBVTyw0wBc+61/rjkGSZeIKMWoeDMIEYm7X3
         t8JbGGgKARD920lhy2ta6498TgFjh7Vbrb4BefT27ZRudTSAVMjy7d1Xchrfsed0ksSt
         BY3E4kJ+H+4RR2RrQ2n5NdO7QWVZHgRjgLUlXwUrT0VymXqgKx9oc7iTzzHHggBKfZRV
         3gTi/qHfH8K2Ez1ZW+C0cPvdvrGo0ZqckhY7vjn/O04gvIizf+79H2Pbu3sII1i190Ug
         hdoZ7PPlh1ubDDC1IAIWL4Ol8a0qI9g8wQm8gWoDdTucSXvP7PHXCtb2LwWVfcNMO8jU
         2umQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9D/1MMxL+TwsH3zZbmlweLkzg3R88r98dY30cPvmVLM=;
        b=V8dtc1BDmh/gfiX5JpuTnzfXDQAZcJ4WHOetDkhgGZ/0ua2Wqhl9JtLsMmMHZrfpiV
         n0kwtcPZ9KDx42bvPl0tDE5BaA0G69CYeEChyNYubqN5RaAChH0sMbG3b6O56/plaimW
         F4JIz6XDrALF6KDd5Xa50cpUSPj+s7ZNgVpRlduQXmBmEKn5Cdm6aVfyxucDh4o2ia+/
         ScDWIpyeBGRo2hCAETg7Tn8OwUUTBsY8zICgGxkQe4S/F3C/B772oS4f6rsguK3Xjips
         RZDjRDBYxCcRzTzc0F4NnqNbmvRrVPGmLt/6D7x+znbRAfUYbm1SsiILs48saK9aDGTP
         A62w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ian Abbott <abbotti@mev.co.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 227/310] xen: avoid type warning in xchg_xen_ulong
Date: Wed, 11 Apr 2018 20:36:06 +0200
Message-Id: <20180411183632.282910891@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476268776982779?=
X-GMAIL-MSGID: =?utf-8?q?1597477621569279890?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>


[ Upstream commit 9cc91f212111cdcbefa02dcdb7dd443f224bf52c ]

The improved type-checking version of container_of() triggers a warning for
xchg_xen_ulong, pointing out that 'xen_ulong_t' is unsigned, but atomic64_t
contains a signed value:

drivers/xen/events/events_2l.c: In function 'evtchn_2l_handle_events':
drivers/xen/events/events_2l.c:187:1020: error: call to '__compiletime_assert_187' declared with attribute error: pointer type mismatch in container_of()

This adds a cast to work around the warning.

Cc: Ian Abbott <abbotti@mev.co.uk>
Fixes: 85323a991d40 ("xen: arm: mandate EABI and use generic atomic operations.")
Fixes: daa2ac80834d ("kernel.h: handle pointers to arrays better in container_of()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Acked-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/xen/events.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/include/asm/xen/events.h
+++ b/arch/arm/include/asm/xen/events.h
@@ -16,7 +16,7 @@ static inline int xen_irqs_disabled(stru
 	return raw_irqs_disabled_flags(regs->ARM_cpsr);
 }
 
-#define xchg_xen_ulong(ptr, val) atomic64_xchg(container_of((ptr),	\
+#define xchg_xen_ulong(ptr, val) atomic64_xchg(container_of((long long*)(ptr),\
 							    atomic64_t,	\
 							    counter), (val))
 
