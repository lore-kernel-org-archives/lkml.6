Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48I+YlYyGRw2uleEgYInV8j3zHUXRiYDIwvVCvjZAdxwZviP8I8QPXHqqyC1sEX1Scw11nV
ARC-Seal: i=1; a=rsa-sha256; t=1524405729; cv=none;
        d=google.com; s=arc-20160816;
        b=zEUkxONYIn4PkL4KNjbJj/tZVX3U3XsszeYDjhY+0tPrPLg0OzuZqO0Vu9sIlQyyus
         q7muQN+LHjsfreK7NxNMOwJBK2LYmnRBR1O1ZHA0aS/gRJVWFPoOki3MEm/nbYnSfFQq
         QgOm/rAfrEt+e/p5wPvHPndn5loThwINWwUUp7dubr6h9abf0YbKX2uSgwCB0BPUkEEy
         Pi7YbHywE3ItGssxvwmnpF1CESHmdggbazjOzbpVTBz4Wrpgki02hxr4i9P5pNP4SYge
         xK3AFlk+gjMuP6wP24BNzjSkJ6panSamz/wEtW6MxZbdK76jpzCUxJiK/kKTpteSn9bD
         nVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Pwt9sG9cLd7kjwejlOsHvhV8W7uGe1pQMHHSfcZDrv4=;
        b=Y7JnioGHmQ6vcJQR+9Za4KnWQexSab/aesNr5mVbRuAkzKDMhRdYCotEqT9GKFemZY
         +n7HnUGzMmOEAueHhO65bB0/9hMPf2vTkkAGvrPIfi5MM5rDIj/Afsrrig1eSVBC9+pm
         DtGjI4ZF9jmFPueXHdnnKznf1XHJoCDCmAS0pJnM/IaTUauPyGKHPpb0uCvrNyCpCxwh
         AxwCSdX+Mg3bnWld+6dIxwJZTNdpfe9wfZ9wkCLs3BzhmKBzH84YGl9ID4HyG9yvcgTO
         M8m5+zOrxshKkSHsgVnH8lJALwdM1n47gNd0BBpegHEJVxzfiHG/Xi1rJXMvt96PuxPB
         b4AA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chuanhua Lei <chuanhua.lei@intel.com>,
	Matt Redfearn <matt.redfearn@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org,
	James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.16 174/196] MIPS: memset.S: EVA & fault support for small_memset
Date: Sun, 22 Apr 2018 15:53:14 +0200
Message-Id: <20180422135113.252054528@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455262967185714?=
X-GMAIL-MSGID: =?utf-8?q?1598455262967185714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@mips.com>

commit 8a8158c85e1e774a44fbe81106fa41138580dfd1 upstream.

The MIPS kernel memset / bzero implementation includes a small_memset
branch which is used when the region to be set is smaller than a long (4
bytes on 32bit, 8 bytes on 64bit). The current small_memset
implementation uses a simple store byte loop to write the destination.
There are 2 issues with this implementation:

1. When EVA mode is active, user and kernel address spaces may overlap.
Currently the use of the sb instruction means kernel mode addressing is
always used and an intended write to userspace may actually overwrite
some critical kernel data.

2. If the write triggers a page fault, for example by calling
__clear_user(NULL, 2), instead of gracefully handling the fault, an OOPS
is triggered.

Fix these issues by replacing the sb instruction with the EX() macro,
which will emit EVA compatible instuctions as required. Additionally
implement a fault fixup for small_memset which sets a2 to the number of
bytes that could not be cleared (as defined by __clear_user).

Reported-by: Chuanhua Lei <chuanhua.lei@intel.com>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/18975/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lib/memset.S |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -219,7 +219,7 @@
 1:	PTR_ADDIU	a0, 1			/* fill bytewise */
 	R10KCBARRIER(0(ra))
 	bne		t1, a0, 1b
-	sb		a1, -1(a0)
+	 EX(sb, a1, -1(a0), .Lsmall_fixup\@)
 
 2:	jr		ra			/* done */
 	move		a2, zero
@@ -260,6 +260,11 @@
 	jr		ra
 	andi		v1, a2, STORMASK
 
+.Lsmall_fixup\@:
+	PTR_SUBU	a2, t1, a0
+	jr		ra
+	 PTR_ADDIU	a2, 1
+
 	.endm
 
 /*
