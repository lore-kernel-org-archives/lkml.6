Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49/F179InF9zz3ZyZTCymrqAGBZ7MGRxDNxPedaDAhLhGJG875MurSWnz2atZO9nVA/1ySo
ARC-Seal: i=1; a=rsa-sha256; t=1524405949; cv=none;
        d=google.com; s=arc-20160816;
        b=rA6q2Li5zwqbfVCTOk2Zvvfjr5K0Ky1zRMyT2PFnAa3ewteool8YYRyp9okzjIETxC
         v+IFW5+6fVLrdAJWUDT/iKhPSt5VraZYmDdq0o/Rgam9LLMIARhP0NclXrWfQLl3UFDZ
         UFdkqCAZop3/5yglW5e7FB7K6qkv9NfsHk1xww8ByuzPipLQ1Ot3L0wT7SuUU9orzIfe
         6LfQ3jhguLaahn9/jiVsKmm4sQOK4GNbcxapmrUQ4jbOUmXS9N7AmNNnyKgxkRBXXSSv
         yHc2zW62MmOc8h3RbzrS+9k528unrgRYfl5kZ3F7WD2ia9/CCTgHROb6bW5mVagDztSi
         Tt+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WrNMpaabPKD8W3DLv6cmhZHuVC5giMKTxqNCyfuJ5NA=;
        b=Jeb4ZKyxg5yXqTvosItC/U8jWdG3OUivdjVvPTnrkyVrief9yRgEstlEyWRAguI0uz
         YdsKUYxT9Rtx6NH+N/oUoZhD2jsvsYfvbcCPXPQJD3PtJ1W4QNOXghUJ1cNXqty8fAYu
         1XgSnEOQQbakY466maEZE7nyFzHra7CdtZtpdIdyqBjusb1OUYpok/6DfAMp8tAg/5ZI
         w2xYHZEA54Itejqfz9V4T+ygFTg9SyfrAGkDdRT4QTOKwTx59sjZYdQtN2iTBaNKTjmW
         PrZjUmOFKGX6P4mAj5has9T3BWxYc/WLgpHGKxrMdvMtwTrMasEfcUsIOLClRQ0UbF/V
         j3ig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 057/164] powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops
Date: Sun, 22 Apr 2018 15:52:04 +0200
Message-Id: <20180422135137.776144260@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454959303912084?=
X-GMAIL-MSGID: =?utf-8?q?1598455493165389538?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit 3b8070335f751aac9f1526ae2e012e6f5b8b0f21 upstream.

The OPAL NVRAM driver does not sleep in case it gets OPAL_BUSY or
OPAL_BUSY_EVENT from firmware, which causes large scheduling
latencies, and various lockup errors to trigger (again, BMC reboot
can cause it).

Fix this by converting it to the standard form OPAL_BUSY loop that
sleeps.

Fixes: 628daa8d5abf ("powerpc/powernv: Add RTC and NVRAM support plus RTAS fallbacks")
Depends-on: 34dd25de9fe3 ("powerpc/powernv: define a standard delay for OPAL_BUSY type retry loops")
Cc: stable@vger.kernel.org # v3.2+
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/opal-nvram.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/powerpc/platforms/powernv/opal-nvram.c
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -11,6 +11,7 @@
 
 #define DEBUG
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of.h>
@@ -56,8 +57,12 @@ static ssize_t opal_nvram_write(char *bu
 
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_write_nvram(__pa(buf), count, off);
-		if (rc == OPAL_BUSY_EVENT)
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		}
 	}
 
 	if (rc)
