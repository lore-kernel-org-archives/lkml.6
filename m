Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48NimVP0BtUeNaOnjRfG3O7+k11xtwl0LRm7KEFsF+cAgzIzYK++r5b7GZaSCX+yzMRqmvq
ARC-Seal: i=1; a=rsa-sha256; t=1523472681; cv=none;
        d=google.com; s=arc-20160816;
        b=LqMo8okOZ9T+fw33jgftdGqPNHeljtHZ2aL4SgXYAqieQRcQ//JKeiw7jE3cPOCF8j
         KN8Htx0/fK+VJfFrO/umwOYSr39hlrwyUysCxoBoqDeKlq9eGg1dIcjppaIP0dy70qwA
         QIA+8mvfMXEHK/czhp9Wyh759v17OL8W3i1QDyCySnhYw9cWKmQSlYlg/3vIUpleS7wQ
         u6Kxl/KVSJb3Sj9icVT9zNy0+qbwz0ciycCifwjpLSaY6Kutla4SYT3NGgq7ytlJlL2M
         ddiP+T4KeO13g7DL73qU+wZRf9GCvAntRFS5mHnYcgsA66EKf+n4pXlAtk6EW01ntK0G
         sBLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=t0mwoZhSPs2+XsI6vxbqZnjsi5JkqFQNWhgmNH7i7Kg=;
        b=Rkvmj+39M2649fResgu8HSTlzHUiDMoCYHS/YADjg+ba8yqAaBchUUd1R7Oojtqk8T
         NweDhYkIOsXSWCeksKfwNuDqNfkzrEy8dOrn1Rfk9jjVwagXC7CMVT852vpNQ4FMHJ+M
         UwmaqLbeCuJU/CxfiyNQt07i8IzICdwr2W0zatFTn7HufgE6x2WUkPTnWWvPnsnvnWq/
         xvSfbu+7rlS7UDSx7Cnoy3j/CuOLmg2wioErIn9IxwanTEFxKvDO5UOomTJVmB3xcE0j
         2YRSJuXWOcp4YWnvBeLeHnbyrwV/QCrpEfIOEEtWSct/0iyogD9S/bgVHz0VjppQ0qJx
         RzOA==
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
Subject: [PATCH 4.4 138/190] xen: avoid type warning in xchg_xen_ulong
Date: Wed, 11 Apr 2018 20:36:24 +0200
Message-Id: <20180411183600.674705114@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476268776982779?=
X-GMAIL-MSGID: =?utf-8?q?1597476890387167664?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 
