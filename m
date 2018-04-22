Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Q/6I9LfCf+RRczyH1csxZveNpVwXEidHZfQ7EY2JIj6sKbr+zrrZT7q6r1Xxahon/YGJr
ARC-Seal: i=1; a=rsa-sha256; t=1524406900; cv=none;
        d=google.com; s=arc-20160816;
        b=JHquXO7lHuBCNVNixuBUyPtiM2iWFJaJ+knrd4hRLfsTurc74XB4EivbWQQyV0YWMp
         7Rm+po2yxNLkrXTYKTMnfm6bKRVW/pb2w1rrBcUh/TvuIGh2xVv5gJ25UxRIJJvHDP7b
         bxu9ICwRtaGydUcZZDsXLipEG4+dMfUJvwj+drpUUzT4pP/nPqd6hQjasH2Q+bkIOdoZ
         ORSZycq3JVVsiTuH3L7usGnqglvEtlMurAt/BwRduB87nzgvq6MpBePW08tz4Wdpft9J
         mCZFv5+0aqtjOcB23TE0x+Pc7knenM+iJvL6lTJbDKPm2AjYZOoollUHoHEquEB/ogpM
         FBaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SGjyjEJ49kmRu2vhi/+BZK5MQBKLsO3TI3RSqNu/Ek0=;
        b=cY3bFsCLmx+NVK3JwOmslUXMwvQL6eueQRgQYo9ozbq31ky3KvfQy+h+f0u64HTZsV
         cl0VWo+TLKvD1uHwAjUvBJT7e7rZx39XIbjZ03R9hix946Z/6TAAgHk4vDF1z7mJStcF
         0aeV8W3f9fgyS5buyD01uNhq+hK/jyaHmovqatLf6S/ihr8PMYigUdgARPgT+7d1STpA
         GoBBeLmJ/el/jA12C1xqqL1MW58oYZFEFWcndRmpI24s26594kLZNSrXQhPgI4E63jFP
         tnMM4HnZK+WV861XD79s3rJ3ofGZK7+rvw0CAMhCKw53z1loJtRhPg4lc5YavSHif/C4
         TODQ==
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
Subject: [PATCH 3.18 45/52] MIPS: memset.S: Fix clobber of v1 in last_fixup
Date: Sun, 22 Apr 2018 15:54:18 +0200
Message-Id: <20180422135317.436671003@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455270804661651?=
X-GMAIL-MSGID: =?utf-8?q?1598456489581687640?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@mips.com>

commit c96eebf07692e53bf4dd5987510d8b550e793598 upstream.

The label .Llast_fixup\@ is jumped to on page fault within the final
byte set loop of memset (on < MIPSR6 architectures). For some reason, in
this fault handler, the v1 register is randomly set to a2 & STORMASK.
This clobbers v1 for the calling function. This can be observed with the
following test code:

static int __init __attribute__((optimize("O0"))) test_clear_user(void)
{
  register int t asm("v1");
  char *test;
  int j, k;

  pr_info("\n\n\nTesting clear_user\n");
  test = vmalloc(PAGE_SIZE);

  for (j = 256; j < 512; j++) {
    t = 0xa5a5a5a5;
    if ((k = clear_user(test + PAGE_SIZE - 256, j)) != j - 256) {
        pr_err("clear_user (%px %d) returned %d\n", test + PAGE_SIZE - 256, j, k);
    }
    if (t != 0xa5a5a5a5) {
       pr_err("v1 was clobbered to 0x%x!\n", t);
    }
  }

  return 0;
}
late_initcall(test_clear_user);

Which demonstrates that v1 is indeed clobbered (MIPS64):

Testing clear_user
v1 was clobbered to 0x1!
v1 was clobbered to 0x2!
v1 was clobbered to 0x3!
v1 was clobbered to 0x4!
v1 was clobbered to 0x5!
v1 was clobbered to 0x6!
v1 was clobbered to 0x7!

Since the number of bytes that could not be set is already contained in
a2, the andi placing a value in v1 is not necessary and actively
harmful in clobbering v1.

Reported-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/19109/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lib/memset.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -210,7 +210,7 @@
 
 .Llast_fixup\@:
 	jr		ra
-	andi		v1, a2, STORMASK
+	 nop
 
 .Lsmall_fixup\@:
 	PTR_SUBU	a2, t1, a0
