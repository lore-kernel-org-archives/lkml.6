Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/+bj35+Le6RmTJLgt7Ex/y04katKA8ImdbEfgBe0mvv5EFnRhn0KiH7zNcYwjmIVhXDCMT
ARC-Seal: i=1; a=rsa-sha256; t=1523472962; cv=none;
        d=google.com; s=arc-20160816;
        b=tpPO7Aba5DKLPLtJchH7sLMtCbDOhrdE/fegFE+b/SJVmm0y0carbTTyt+AGwKSm4p
         xkYTt4lW+KcIuTG/D+NtUy5AuwnBoqnMmTFCTVIFBMc83olhCtE5fOXPY0K43rUrmffw
         UI8hYsJly8teYjiArr9W+K8twOpZcmdqtFBouYPWPs5AGxZI4nOd2Xj7XO8BI6kRc++t
         iQfirB5ju390zsPJemjXJWcGv5s/zYZOBbyBMwCYFpnx7Yg/bCslM6D/Xc0wnto3NgOS
         gT9/jV9nXm94Ug0MziHAoWbXOe4aap33obyVDdRTcqY/M+e2gZKAIIGQ08k/K5rutKiW
         k0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bKcY2SC02CDQmNRolIAJZPizvWpgMeUaLDe1IzXzsKc=;
        b=uO7HZiljNsz17CfQVyJVs4jJQLPZMC2ylpProK0pbpn7ytBlAWQu+s0VHf5z1BNt9u
         8Z976GxANrKVfG0eUZWtVzhDvK231hieqYiXvB2h4HdgyQFSbX4VYuhL1NFOJVPuQdF+
         Lk7P7XHzA3kKTLc1eTDJkZIB30TZN1auKTHsULykFA7NU/rEmjudh4OWywN9UyXu1xIV
         8mypd1vvjFwBhanCthYaViomvoaVS15J1MsjsveaYRUt3ssuO3N5sUas6l2SFJPfQx/r
         WewCiGvVsmuESWpUWgsSLK5HzZXJ9L5oNJQeFXP6IzM3Wyz/uOzDz/q9kHMftrlz9ZLk
         d3gg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michael Neuling <mikey@neuling.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 080/310] selftests/powerpc: Fix TM resched DSCR test with some compilers
Date: Wed, 11 Apr 2018 20:33:39 +0200
Message-Id: <20180411183625.738182385@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476122672942002?=
X-GMAIL-MSGID: =?utf-8?q?1597477185592737504?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>


[ Upstream commit fe06fe860250a4f01d0eaf70a2563b1997174a74 ]

The tm-resched-dscr test has started failing sometimes, depending on
what compiler it's built with, eg:

  test: tm_resched_dscr
  Check DSCR TM context switch: tm-resched-dscr: tm-resched-dscr.c:76: test_body: Assertion `rv' failed.
  !! child died by signal 6

When it fails we see that the compiler doesn't initialise rv to 1 before
entering the inline asm block. Although that's counter intuitive, it
is allowed because we tell the compiler that the inline asm will write
to rv (using "=r"), meaning the original value is irrelevant.

Marking it as a read/write parameter would presumably work, but it seems
simpler to fix it by setting the initial value of rv in the inline asm.

Fixes: 96d016108640 ("powerpc: Correct DSCR during TM context switch")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/powerpc/tm/tm-resched-dscr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
+++ b/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
@@ -42,12 +42,12 @@ int test_body(void)
 	printf("Check DSCR TM context switch: ");
 	fflush(stdout);
 	for (;;) {
-		rv = 1;
 		asm __volatile__ (
 			/* set a known value into the DSCR */
 			"ld      3, %[dscr1];"
 			"mtspr   %[sprn_dscr], 3;"
 
+			"li      %[rv], 1;"
 			/* start and suspend a transaction */
 			"tbegin.;"
 			"beq     1f;"
