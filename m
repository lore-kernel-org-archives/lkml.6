Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49iMEYfTwqRW2KF8supvT2Q3XvPGyOKiRhL4V3d6wuLNue2iYRI8ZVEAoyqzCjHe3hpat9U
ARC-Seal: i=1; a=rsa-sha256; t=1524405968; cv=none;
        d=google.com; s=arc-20160816;
        b=ZaHp4iTriH6JIml1UH44TTVqk/IEj0FC6PIRxt6PLzpu01DqGbbLD1cggww91Rww0O
         ptAZQ6vJXJDaxXoc2hB+aSGCFNMdRtJjezS0zrkdVZUqqE5O1rEQcUNIb6ygj8KqrVN0
         IGPUdyHhLXWAYErMkT22sL4UK0JMJmtZq3CrsK9DfMblkWr57MSXFVkgRPfg8fM5XZrN
         wvlRcSpTOFYh13LZyrarwWBDWtdU/o0a4fIFBBNeea24+2B3ku0qziKvWjGFAWxvp8Ra
         V8oSddGu7XFHpotr4lva2Esfi5gIAGGo/n1Uh0i/PF3uoufQEhiG/5T+sfe1e9sWH/TP
         xx3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8a0UOmoFbn2Plstbv1Ti//FYZRMrpGTeoWCNJ9HMgxw=;
        b=kGGYYz+lTLhu55ZEKyKps4eR6EE1+ai/lnYb5JDjBmjC6c/pl/wJIiIkbURcAKXmpX
         pqNszclFq94GiEiA91vkwtVfzpM+umnNKVzEPJWxFIHevJhvSBlJHUzhXV5/k5+XerXY
         M8Zej/ZpuLRf/8ZXrSO/MmiBHqjvbVbGRheCtRYpKSBowBfL+k16E2zx0lZZh14hcLhu
         5s2wQahX4SfRkah735eHi/bJcav3IpeZst2ewydxP7w40/KEGBx8s86B+UZ2ST8TSVqV
         AkSVD4Ptt7uArxvtSnjve5jVHtlB6g848iJu8UXBgVHP9Km71VMzoxVrBP1M21yQzPWt
         hyFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 4.14 063/164] thunderbolt: Wait a bit longer for ICM to authenticate the active NVM
Date: Sun, 22 Apr 2018 15:52:10 +0200
Message-Id: <20180422135138.028777007@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454984602080437?=
X-GMAIL-MSGID: =?utf-8?q?1598455512783746548?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit e4be8c9b6a512e274cb6bbac4ac869d73880a8b3 upstream.

Sometimes during cold boot ICM has not yet authenticated the active NVM
image leading to timeout and failing the driver probe. Allow ICM to take
some more time and increase the timeout to 3 seconds before we give up.

While there fix icm_firmware_init() to return the real error code
without overwriting it with -ENODEV.

Fixes: f67cf491175a ("thunderbolt: Add support for Internal Connection Manager (ICM)")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thunderbolt/icm.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -539,14 +539,14 @@ static bool icm_ar_is_supported(struct t
 static int icm_ar_get_mode(struct tb *tb)
 {
 	struct tb_nhi *nhi = tb->nhi;
-	int retries = 5;
+	int retries = 60;
 	u32 val;
 
 	do {
 		val = ioread32(nhi->iobase + REG_FW_STS);
 		if (val & REG_FW_STS_NVM_AUTH_DONE)
 			break;
-		msleep(30);
+		msleep(50);
 	} while (--retries);
 
 	if (!retries) {
@@ -859,6 +859,9 @@ static int icm_firmware_init(struct tb *
 			break;
 
 		default:
+			if (ret < 0)
+				return ret;
+
 			tb_err(tb, "ICM firmware is in wrong mode: %u\n", ret);
 			return -ENODEV;
 		}
