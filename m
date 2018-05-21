Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoZVTP4K1EInLlueSu3R+gCdd+CzHjD9ngw6JE1pyv9l6vhr7KGbWAeAufrAMtwxdtsbO+C
ARC-Seal: i=1; a=rsa-sha256; t=1526937670; cv=none;
        d=google.com; s=arc-20160816;
        b=S0xkcIVg42zCzeFayKa6RA7ZLYNDs2Wlax8lHJflUtYFMP6+e1BQyvJykxVVrcWPy6
         03AODChS/i/TYVjGDY5iruIln5tm/l4tq+OwVMRXRbZSUUUyBB26c9cy1zTn9DdUipLQ
         sk2YdhOue8ylnzpnvGJa9UJzPWZRiLrd0FH6GYrcDrxLQOLAARqzkEV0tdTu3l7Q30Cv
         xeE29b3jyqqzBFGfwlrcHguwv1UpvDfZZcmq4Db696AVju7fG6nWC8QZN5dRUEaIk+sG
         VctrnExX1o/8OlLvfJ4H3kOG7F6xoo4WkOOHFqtPFKJgtaIDa16XsResYXlZy8U2yFTW
         Jj7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=WpXxxrIHuePwciSZzKdE+ra5I3rca17n7uhv4mEoynA=;
        b=jENCYs/q5uGxyeIvrVrTtaEBXMaNHS0oOBRiZUk/xjApUyPwlx0gFcXjhKAWkLvRWi
         7d/HUBIEIwxEIAiaw2rMNgDyYdlE5OOXnm6RF9ddINUY45kGKvDTALbr7LUSROLDGt9y
         dh6ZYNcQOSQ63wSzJQe2pTMirogp/l161IH+7GVlZOpDUlg80WmAZLAv5P2puQ+N8hdr
         sDV8y4yNgFFH8nzt5J/rqspus0TMMulN3R8OoRe1lxmdsVdOXJSwxMQLytXfHYNj+HEs
         Rs/LXXWIvdVHe3gYQZ/Qo4nrzmKBY0RF/7eeOI7fxSVQOqUwGiku98C9l4lJQuljdHxs
         fkqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NfT18hnl;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NfT18hnl;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 79/95] x86/cpu: Make alternative_msr_write work for 32-bit code
Date: Mon, 21 May 2018 23:12:09 +0200
Message-Id: <20180521210502.045569588@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109915496238144?=
X-GMAIL-MSGID: =?utf-8?q?1601110195118895894?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Mattson <jmattson@google.com>

commit 5f2b745f5e1304f438f9b2cd03ebc8120b6e0d3b upstream

Cast val and (val >> 32) to (u32), so that they fit in a
general-purpose register in both 32-bit and 64-bit code.

[ tglx: Made it u32 instead of uintptr_t ]

Fixes: c65732e4f721 ("x86/cpu: Restore CPUID_8000_0008_EBX reload")
Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/nospec-branch.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -265,8 +265,8 @@ void alternative_msr_write(unsigned int
 {
 	asm volatile(ALTERNATIVE("", "wrmsr", %c[feature])
 		: : "c" (msr),
-		    "a" (val),
-		    "d" (val >> 32),
+		    "a" ((u32)val),
+		    "d" ((u32)(val >> 32)),
 		    [feature] "i" (feature)
 		: "memory");
 }
