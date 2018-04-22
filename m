Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48omXKV+lBcShnMibuFqRgNtcemoO7VG1VRAZOgnp2ONRocXOUuDQ2lZXRWOTG9Jc2lWNr0
ARC-Seal: i=1; a=rsa-sha256; t=1524406465; cv=none;
        d=google.com; s=arc-20160816;
        b=1LoWRDhx4c1mIfK3hhnRqblAaaHmi3t7I05kXJsrRfiNg39tWRE55S03162Bfdbna0
         kyGGSmpALTjO8vofZFVGBmzZowmD/bwIu6rRogLQDolOuDW9g4hqGyF0lAFSRpf/+boA
         HrFln4yKaeaF6NjCnsed3foBbTvjRKoxVLXhj1kyshMGVZhkuPgx7IZA9P2zt3Dt+n0P
         j3WpdHaWQ0wOvPA9Fdv9bqF7gGyVgif4GfvzyIlgxMpahJRSMTt/qcioasVWAO350Qgo
         yHKnfbZvFAHW79+gyZMm1oM0I2py67YLZEczpqKADP963KiujWhnL2kjzxnQG1RRcJcS
         vZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=on2oWJfh21TiS7RFPkvqLGctsQvjwfPp0qYd/sGsGAI=;
        b=E35XFAvzDSyD4S+Xwm/m9ny6veDAOuHwov3oWoeXXZVFSb40cwXCnGsSjwo9YWfkXG
         /yfi9kB4Ea/L9zF6PMPqT0jhvtVZMwuok4DHFRHJTHmcNsgjzZatZPXpLfbA1eTK97bV
         ihNhFSngcHZYoZioXU3UJ9PkbTFjEpAzCWY9zZwFCHgWoY7hQuaWnHq+jd8hkb5bDXxj
         DPCN9MnnM37PoIflit6yUhiTLZRbQqEXbfoXfJyL83Q+/iX0Xd5LeOk4RxAFGVKhlWPE
         mkATBSUhNWVR+ZefxRdp0wgJOKziei0ECYOLZIoHBfJbmijx/3AVt9kKvpmrq1DW9/tE
         sQyg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Hogan <jhogan@kernel.org>,
	Matt Redfearn <matt.redfearn@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: [PATCH 4.9 81/95] MIPS: memset.S: Fix return of __clear_user from Lpartial_fixup
Date: Sun, 22 Apr 2018 15:53:50 +0200
Message-Id: <20180422135213.740637068@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455264978774304?=
X-GMAIL-MSGID: =?utf-8?q?1598456033921140798?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@mips.com>

commit daf70d89f80c6e1772233da9e020114b1254e7e0 upstream.

The __clear_user function is defined to return the number of bytes that
could not be cleared. From the underlying memset / bzero implementation
this means setting register a2 to that number on return. Currently if a
page fault is triggered within the memset_partial block, the value
loaded into a2 on return is meaningless.

The label .Lpartial_fixup\@ is jumped to on page fault. In order to work
out how many bytes failed to copy, the exception handler should find how
many bytes left in the partial block (andi a2, STORMASK), add that to
the partial block end address (a2), and subtract the faulting address to
get the remainder. Currently it incorrectly subtracts the partial block
start address (t1), which has additionally been clobbered to generate a
jump target in memset_partial. Fix this by adding the block end address
instead.

This issue was found with the following test code:
      int j, k;
      for (j = 0; j < 512; j++) {
        if ((k = clear_user(NULL, j)) != j) {
           pr_err("clear_user (NULL %d) returned %d\n", j, k);
        }
      }
Which now passes on Creator Ci40 (MIPS32) and Cavium Octeon II (MIPS64).

Suggested-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/19108/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lib/memset.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -251,7 +251,7 @@
 	PTR_L		t0, TI_TASK($28)
 	andi		a2, STORMASK
 	LONG_L		t0, THREAD_BUADDR(t0)
-	LONG_ADDU	a2, t1
+	LONG_ADDU	a2, a0
 	jr		ra
 	LONG_SUBU	a2, t0
 
