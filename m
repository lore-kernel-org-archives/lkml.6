Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+HhmMK3R8zcJeBlOPQt05t7Aw0HckV/tqCBXfngzrke950ruCkVE0rKLXgsISSX/7N+DFB
ARC-Seal: i=1; a=rsa-sha256; t=1524406462; cv=none;
        d=google.com; s=arc-20160816;
        b=IRmKME65JKhMU5PGI5gzOLbXAwWcU+zsorMrCB5peE10O389ntSpUphupbaAOVO/1O
         5+fw5+ghpvCX67l1G/JC+itDm3UosJaAgvZsT2bQC+nhybf9i1vFbVCahiCAIMWm6aef
         sIc39N/cBKNtUTqgUskpuQxa/W4A3QjvsgsVO4Ms2IKmp3Ah8u3kiF30dIPVbp0VmMjQ
         EberZycKTdrR8BvbjB8U4AfwC1f61KilFx2gDIejVAv6zKxay2Ko14+LNhEzOsJ5cx8S
         +WkMLHnVuz9AivutmcOGixMR7d8ao6wQshJoz7Mi/7yEXWQTlrgRC6+B5S2Zw9NhBZeV
         FdTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7tOtsojPhkawV4G4Rr1wmzlP2pUBFOT9wxd8AKtsk4c=;
        b=kO81aqMiLhOPqPFsxGZlCLS6KZclbuAFfYyQ2ngvePwY5drWKzYzbk6uEGCVJczDYJ
         yyMj9Fn2193WMupdv7DjP2U4RQn3NOeoKOQ4TXDRiOKGY850xESSD4put65ltwrdB3cd
         R7w4G8STX7MkoEJr6/0IpVjmRSYFhJFFy4iDP9eie57Tijw/99B85Ezu+grWRA+zlF8z
         y4gdXE638UvIZqOPyi9166usLkiHRiJQLooC6v0kc6snobDqHobbZcCsdU6whp7kd4zq
         aBtbeSJhbOXDlhhx1zTlCjXNeO9feEmkaxH1Ns8iJ3gCLT3fjUXk1pt14khD2JqSTIag
         XlHw==
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
Subject: [PATCH 4.9 80/95] MIPS: memset.S: EVA & fault support for small_memset
Date: Sun, 22 Apr 2018 15:53:49 +0200
Message-Id: <20180422135213.698474662@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455262967185714?=
X-GMAIL-MSGID: =?utf-8?q?1598456030810865723?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -218,7 +218,7 @@
 1:	PTR_ADDIU	a0, 1			/* fill bytewise */
 	R10KCBARRIER(0(ra))
 	bne		t1, a0, 1b
-	sb		a1, -1(a0)
+	 EX(sb, a1, -1(a0), .Lsmall_fixup\@)
 
 2:	jr		ra			/* done */
 	move		a2, zero
@@ -259,6 +259,11 @@
 	jr		ra
 	andi		v1, a2, STORMASK
 
+.Lsmall_fixup\@:
+	PTR_SUBU	a2, t1, a0
+	jr		ra
+	 PTR_ADDIU	a2, 1
+
 	.endm
 
 /*
