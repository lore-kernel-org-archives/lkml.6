Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrlTRMc60rvAnClDRivn5qmQ7836TCbBbVuyLEP+1Qc/EmzYmZpZ8s3Fild70i2m9AL9SUn
ARC-Seal: i=1; a=rsa-sha256; t=1526937371; cv=none;
        d=google.com; s=arc-20160816;
        b=LF05M1jfuxzMz1vniorFqDdW0yWgBKOYlgQ57G6NVDxLDXdurUxSkSV9aYu8PaxY2K
         MW+3sLXYWEcd0vIjIMPdynnNOoiTv1g43k7/OF8/15cwA1dMb9plBSEBETcZr8qwl4CK
         GjOyDOPQ7FiGPmbTlBfmcbjKI22dDRGZXVVWtgGTNzSbKme+5j7rjZV28vTNtNFMnLBB
         KEHH90MFP2wzERyp3f58d8UF4HxJsuMXiVK/zYz0uFjKXcHdpIMy3OL9a9hoIiRUc+Oq
         Se6T/zgsQZopYXiH+g9dA3ZyQt8vGHeIxhtIlkhDS6LYl/1LTJUX1b6R4QwqM1x/TReZ
         5i0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=BnZeF+wId0rLmsa95T+2Ss6Ntje22tQMnCJEX1btij8=;
        b=ttAgItvaRSg3ymYIjR0ZKDRle4Ls/Vtcytz72jzOpB2IOMPPJOJonjSFtq3rB9Bb+3
         eom7eZm7YU6k9Tigx6fZks5sb4gBC3jx1vAoRbxUbRPmtbM4cTXo9dfHNBbfL0H1sse8
         bWPe2l38yn0xRyTFj6KIwArSIQaWr7J1cNmTCkI3GAdz88SiTDeNI3vdnneUi8N2YoJ2
         i091MJhFZ6Yx6nKV6BwY+/i4/zzpy6pFmYpNFOHoe2O2NXiVcGGCLR2QPcFKWCkNnUDY
         euAdoBM5LBPcqgQJCMR9dni8RYoEfWfDAm+K5ry92V9anj+acx2zAbh3ITtIQO5NbWVZ
         pqAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=i3aXe0GA;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=i3aXe0GA;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.9 23/87] s390: remove indirect branch from do_softirq_own_stack
Date: Mon, 21 May 2018 23:10:59 +0200
Message-Id: <20180521210422.451223506@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109880764209307?=
X-GMAIL-MSGID: =?utf-8?q?1601109880764209307?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -173,10 +173,9 @@ void do_softirq_own_stack(void)
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
