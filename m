Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224UXIAT0oJE+SxuGcPeIhi7RcHO+EgnovvrRfwLGG504X9XpCIpbI3owQDrVL6huiAckJCH
ARC-Seal: i=1; a=rsa-sha256; t=1518708937; cv=none;
        d=google.com; s=arc-20160816;
        b=PV9s5ZLuuTfPsKgp8Hf2m+vqRPOLtwyIQqs2Iv8iMee7Lc/T1rY+S+C7FZgeDB/rMD
         OLYlqlmXt0mMazANFpSzErrizjZUvZxbe8tR5nZXnA0Oa2JtXeDl2ltMIHjfaWdD+eD0
         8dEDt/O+CdL7tQ3r7kfGS7pG+gLxiiUrL2HjkMm9V9KEgxbAf9hUD694wMcA3oO8bRwH
         Fw0St+w8mqI3DG3SmJnYC5eiSM6vxYYNaxSmOhXcxmIInu8QJv+NPw1NzJjNdjQXB9zZ
         MAjOtRRGaAExHOSEajyoTVM8JOH61Cn9gYgQckO3CZovjB4viCpUHPY1HoMJl8vbZBHr
         Cu6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jQVC7oTq/WPYTkzVpdjSQjbTWs4GqhwPuWR+7W4gjcQ=;
        b=g7RhTWozhCcv9DGhxzz5vgyNGeUQ3JCAU7ljgodhNw5qoSpRcTyICD1VOhhDHXGKDJ
         kfYPVRR+ATS96ud+TCoaBFmSqjNsUvx6vIq24LDu6wvmayysHuGHfIRFqFPA2wB5wSBn
         N2T+ZADUpXRF/Ec/ciOy54xfKFaI+arszjNEHNIZxQaKQBcw20kPHwJrz8ioc9FNAPzJ
         1nge5VN2kuPuHmJuawruc94U4ktlrNDAxD0rNBW/NPMC080M7C7u/oX4qFe3jrCjKLhX
         cIYoFMy2dara0UEPitBZspcl5zeE04wZm4PJ4lbTPwW/BzxudaxxDIesnW01/qflOU8H
         rIyw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>,
	Eric Biggers <ebiggers@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 134/195] crypto: sha512-mb - initialize pending lengths correctly
Date: Thu, 15 Feb 2018 16:17:05 +0100
Message-Id: <20180215151712.491281059@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481245689572997?=
X-GMAIL-MSGID: =?utf-8?q?1592481742575546935?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit eff84b379089cd8b4e83599639c1f5f6e34ef7bf upstream.

The SHA-512 multibuffer code keeps track of the number of blocks pending
in each lane.  The minimum of these values is used to identify the next
lane that will be completed.  Unused lanes are set to a large number
(0xFFFFFFFF) so that they don't affect this calculation.

However, it was forgotten to set the lengths to this value in the
initial state, where all lanes are unused.  As a result it was possible
for sha512_mb_mgr_get_comp_job_avx2() to select an unused lane, causing
a NULL pointer dereference.  Specifically this could happen in the case
where ->update() was passed fewer than SHA512_BLOCK_SIZE bytes of data,
so it then called sha_complete_job() without having actually submitted
any blocks to the multi-buffer code.  This hit a NULL pointer
dereference if another task happened to have submitted blocks
concurrently to the same CPU and the flush timer had not yet expired.

Fix this by initializing sha512_mb_mgr->lens correctly.

As usual, this bug was found by syzkaller.

Fixes: 45691e2d9b18 ("crypto: sha512-mb - submit/flush routines for AVX2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/sha512-mb/sha512_mb_mgr_init_avx2.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/arch/x86/crypto/sha512-mb/sha512_mb_mgr_init_avx2.c
+++ b/arch/x86/crypto/sha512-mb/sha512_mb_mgr_init_avx2.c
@@ -57,10 +57,12 @@ void sha512_mb_mgr_init_avx2(struct sha5
 {
 	unsigned int j;
 
-	state->lens[0] = 0;
-	state->lens[1] = 1;
-	state->lens[2] = 2;
-	state->lens[3] = 3;
+	/* initially all lanes are unused */
+	state->lens[0] = 0xFFFFFFFF00000000;
+	state->lens[1] = 0xFFFFFFFF00000001;
+	state->lens[2] = 0xFFFFFFFF00000002;
+	state->lens[3] = 0xFFFFFFFF00000003;
+
 	state->unused_lanes = 0xFF03020100;
 	for (j = 0; j < 4; j++)
 		state->ldata[j].job_in_lane = NULL;
