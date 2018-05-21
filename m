Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZosmXxIAE4+7BXpRaLJa202AHcyddghSsDyPp7lCxYcNYBUyJB7BDqgx35/TYIoNL0SLJ1k
ARC-Seal: i=1; a=rsa-sha256; t=1526937834; cv=none;
        d=google.com; s=arc-20160816;
        b=r7D/j4W1X6zzhGdl2I9MCVPf7OdBbX29hYw1xqtvGU26e8oqVGlExGHJvVpduYs8A/
         FWwzb0nqdrr334C8lPVJ/A6w3Fq51RuA0jV10/+ddSoINGVT4p0dwnIvBEGRsp+UbjgD
         JpyNyOjljgR9EjMtC798Wqh8kdV5E1nPkdnCbQ8B3RRV+B/fwajem1McNbKJABdcXmcS
         hJS5Y1ny+d1SBQyutB2TL2GB55rQSKooq+CHbyT5VVvBYtxId0gUvOqOyiwsTltb+IEi
         X9hssEAFrwrQuEsDVjJTUaZA7ur8Brp2n5VwwQX4vixq1hHKrJF22DddRDpk4vnaY1GQ
         K1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=6vbqNpEKQ0yPVXtrVySXiBDtLSqMrbLzCr/l31vE3HU=;
        b=YlnnKJiS0/LcCRHIm1BsuwfhkVwblY5eNzfxYk+15sVie46LdFEYPgX5uRpkxjQfZk
         aVHNSBOTfxOHgAUtNZIwjPrTKrWAzjddH2PGSeiSIGgIWWvDSWtIHqwFPoUGHMCsfMOp
         V+MPwDa4zHBwTLsWssVOs1e4Wxezfm46iz/IX4vxj/MnnB1uzqH3lXzTpQbmn+TZHNEi
         dqVw73KSTMTvD5YriBBrCJFiaU8ISTbq7TPENyDOCVAmLVxRsKMXeMmiTH4+7bFOGMem
         Q2qIiJ6cRb4WLjbZPV/zm44oUAFhnC0VRPZ3lvM/OPrhYyKUTUVYRgdkd7Jb/plBAOHz
         vAAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QsMmMUBO;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QsMmMUBO;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.16 043/110] s390: remove indirect branch from do_softirq_own_stack
Date: Mon, 21 May 2018 23:11:40 +0200
Message-Id: <20180521210507.918921974@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109880764209307?=
X-GMAIL-MSGID: =?utf-8?q?1601110366336223503?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

commit 9f18fff63cfd6f559daa1eaae60640372c65f84b upstream.

The inline assembly to call __do_softirq on the irq stack uses
an indirect branch. This can be replaced with a normal relative
branch.

Cc: stable@vger.kernel.org # 4.16
Fixes: f19fbd5ed6 ("s390: introduce execute-trampolines for branches")
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/irq.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -176,10 +176,9 @@ void do_softirq_own_stack(void)
 		new -= STACK_FRAME_OVERHEAD;
 		((struct stack_frame *) new)->back_chain = old;
 		asm volatile("   la    15,0(%0)\n"
-			     "   basr  14,%2\n"
+			     "   brasl 14,__do_softirq\n"
 			     "   la    15,0(%1)\n"
-			     : : "a" (new), "a" (old),
-			         "a" (__do_softirq)
+			     : : "a" (new), "a" (old)
 			     : "0", "1", "2", "3", "4", "5", "14",
 			       "cc", "memory" );
 	} else {
