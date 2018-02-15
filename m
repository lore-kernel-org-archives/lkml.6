Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225aHuAvNsXrqGoEGbIzfOC7cgRNqaHdwtowHV86m+w54KF+4yQ55CdLCwMtdjZwByVYDiMX
ARC-Seal: i=1; a=rsa-sha256; t=1518708463; cv=none;
        d=google.com; s=arc-20160816;
        b=zvkN2NzxELGd1l55MSanocjTyGtftiH0cgWgEaF5xtfQ3Ah875rrzSss8hrFtrHEE1
         k8NEurp99dp/JHaLjKxnMt7OqSd+X69X7jUZEWQIXIbhYOPg+VaM/IIRJO5SLto7HI9+
         otvSIiJFRS36uNN29vFIEigbEz4uqEkTPzHWXCs3P0cUADFaZHWyWNj+Rb7Ts4E8sAsh
         ohrE4WN5unfSsjwZW9e00jGDJuZDgvJ9eIip08myx/MJsBaEOUdpiCzanGUy1gJEiCo/
         YFCLVcrLV7d1gfeadSz4Z8HKo+QI8xRygkwqRiNZ/RsnUVfeDi33P/LxcOrw7X3xQ3Pp
         +4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6u59yxRV1Qb9Tb4Hhnm+aWEB5scJ7LFF49ZK9vzTy2Y=;
        b=PZi9tHjubi1EsEljJiU6520akWBOq+uJhS2yL4vZj/2noUc25fPkdfiw0nnXeJhZ2T
         X+pU0ghBdEM+/5Bsrtf9kJVcwdsIP8tyPSQe5YaJy/XTSTDBVKwomP6WUQL+JhIIHsw+
         en1lCjUYuZfYnfrhNWUcpe1c4V/9VUQgKZJ2ldb2rCVcwbL/DIKaLM+27J7Xum/UXm0g
         79+T8AkgTUY+us/RWX3lLMFxgyh72sPvHbIYfRSQ0aYQUAgzwJI2XOWj/h+ZmtX/nOw0
         jsEsLbDTt2YaIax3xJ4ixZe/ylNuZnYvrNtHRCggoLPqvTyUITooIinpQPYkVvgV25qm
         PdYg==
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
Subject: [PATCH 4.9 50/88] crypto: sha512-mb - initialize pending lengths correctly
Date: Thu, 15 Feb 2018 16:17:17 +0100
Message-Id: <20180215151229.655280118@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481245689572997?=
X-GMAIL-MSGID: =?utf-8?q?1592481245689572997?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
