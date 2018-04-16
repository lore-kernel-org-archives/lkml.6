Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523917489; cv=none;
        d=google.com; s=arc-20160816;
        b=glfAjLkHuBeHER20u3oFqECDEDhKsWVf/7WWIPiirxfkjPW6G2xXjtxI3GFU4GaC9b
         nWZpQquWIPZot8ekUiarNvKndtYcivmGT9xPWcHSitzgE4epRxJHtjajbN27ZjfaFhgj
         V2FwX2BjYELJ6U6o2oCZYQx1ayYExNZ96kDWH/1tVw6sQ2xQy7Po2kIBcBnvGAuX5FNm
         qn4VIMYgCDsoyQasI5qwqm5uIy+54Rm+UtdJ/px4tFGn5TS5IFj59WtD0vscFdy/3Tf1
         hwoz79antANhQiUcjbMzfODfAYeoQUdSoH318nqbA9cewo4u/MJmHE8U+9cgfIQZaRrO
         whjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=XLM3XNRLqTt91Am8vIGvCLq9nMkzugNTurkeYqa+iYA=;
        b=infMV9bdrgxV6rYPAmOhmelILeqtCv14L1Ffe8iJqzKAjIeXG6sP1Evb1vb6usJWlV
         Hlx2ufsGNOEtsoaUpm4sr71g74qyL6qXxOuxhcL2vT1dY4tJNFQV5AfyTHQbg0rdusng
         h5vvAtlWRXbU8YqI/HHmyJhm0MVdHI77Yngn1pE6ljfd0DyJ8+IPp0prvHUgUwDhN4iB
         wZ7Hzn7NTIbHfzZQOou+HUxIY8D+qQuxJLY/slBjhRTp+4vu7xLiEkXHF11YziU0xN8P
         7ArXwb8izoEFXKgWzbz2CV+XTpNljfxKtQDPGrTymM1rfKiya6o4K3N8ZbBMLFL/gAMW
         XW1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KY439Ld5;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KY439Ld5;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49SBiV4MBv6ZW20SJiu3mp46XtOodsrn+HDOev3+Yz38jmhJ/AhiPW21lxpNrHAuzXEsW3vpw==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com
Subject: [PATCH 5/8] firmware: print firmware name on fallback path
Date: Mon, 16 Apr 2018 18:24:24 -0400
Message-Id: <20180416222427.29683-6-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180416222427.29683-1-andresx7@gmail.com>
References: <20180416222427.29683-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597943306126423414?=
X-GMAIL-MSGID: =?utf-8?q?1597943306126423414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Previously, one could assume the firmware name from the preceding
message: "Direct firmware load for {name} failed with error %d".

However, with the new firmware_request_nowarn() entrypoint, the message
outlined above will not always be printed.

Therefore, we add the firmware name to the fallback path spew in order
to associate it with the appropriate request.

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
---
 drivers/base/firmware_loader/fallback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index ecc49a619298..e5b0a96ae781 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -669,6 +669,6 @@ int fw_sysfs_fallback(struct firmware *fw, const char *name,
 	if (!fw_run_sysfs_fallback(opt_flags))
 		return ret;
 
-	dev_warn(device, "Falling back to user helper\n");
+	dev_warn(device, "Falling back to user helper for %s\n", name);
 	return fw_load_from_user_helper(fw, name, device, opt_flags);
 }
-- 
2.14.1
