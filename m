Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/UcA7VklYwAa3viSoDLmM3NemZAHYzJ6LllGWr4CiknIa1b4illo4hgqGzU/pKCx2T1Y8e
ARC-Seal: i=1; a=rsa-sha256; t=1523472088; cv=none;
        d=google.com; s=arc-20160816;
        b=Fhe+AyFJsfHU9dGVoiK9UdvUnalhFlPwA1Jsf39UyMNk0lrUxNPthGgV/FVSZGqh2d
         uZNfFLTAodqcipc7qiJsiJqa15Pgk+rUyRsSRaTCs1IRwvBIJlNmcx+0nvGuh/4nbzyg
         NQOoo9tK5Gd5Cvxc3IpVKhf5dRbi2RE11JRp3vXCO08INWmkd9bu5VB9ySAPGZPLBsmw
         aLcHRUt6NnIUzqiqE7laeyQa0vtUYl2dA3/4dOgl+mghkZJL2Bz25bHZmUwQHznyBbo8
         4xuxYmyabXmaQKoNS64fefQ0me3iy7uZy2j7vOZgw/zoyvw9XfN7Er2rF5b9rgPMRDfS
         ac5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TdRJP6nXxiHVeqWJuFL2ICObw7dDWWJWsu6P0YMSuFE=;
        b=zK89S0KmsE0N5Awdusxk3yG0BJVsQLymSbG5DBS6ZVLpmqx8DYXpskCSQwFwMKnIgm
         Pv75M1gdoKirz1XapkY7VflIhMaPNDmNdytIUjbgge+fBgqHCUkcwBeqpEBvzP+umlBo
         S6CQLv7eXCK2tPUDM52WY6dijuv/qbRp79oXXfYKRTSxOKLhwcCPHGtsn6omSZQSWQ6b
         fyfgzp/++z/GTDr6VOA4HIutea2co0Hw/PNQYEXHXNoTR3NFXpwC5iAv9aSJ1K/lElBZ
         bZlQ9Oycza5Q2qMzvyn7fwaARF63e6VX6QUpP4p94i98Z0DgKTlwVjxPFk+hVCwjJn24
         lnAA==
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
Subject: [PATCH 3.18 081/121] xen: avoid type warning in xchg_xen_ulong
Date: Wed, 11 Apr 2018 20:36:24 +0200
Message-Id: <20180411183501.133395425@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476268776982779?=
X-GMAIL-MSGID: =?utf-8?q?1597476268776982779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
 
