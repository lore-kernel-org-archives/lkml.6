Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524514342; cv=none;
        d=google.com; s=arc-20160816;
        b=zDKKPw2cAZpoaj+Mo4ELKmr1vWfuQTztRG4g0pZxZXnph5Yf+/8pApJCjZyJsRJKoP
         ydowRq+ClZzQmj5v27NE1ZLNuADIUSWbchE8DXw25BuqwBIvqd8IcBWjEhp1jwll96hd
         t+dmHI/0RK0RvXYDfpRU78OEnfi4gzRjs/5XfkQUtQpRMRbNwgCPfOn6KAweJqljCnKT
         y4ijW/j8NZeb4NsH/dmuSwuBgyWCrgKQSFkyHCPXzSJ/+D8yVlupJjndPwn6xXBKkkcu
         W6pHoqPwZJSgnkN4xBmi4V4d7wJm0MGJp90Ujyofz1VxneFfmcMfTmwRsl40sEOzEcqw
         fLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=5tnmS4A0EkeinAzDvDrUlGtQwgojMNe4S8UGgYfzhE4=;
        b=hyybPvxyotk85WrFYzTtkxys0dde4DBv0JeshkUtUxq1Sb4vUL2ohs+3mhNCSgCYP8
         qI/g+K/2nAI4ELsLJkLrvTZGkSzSvH5judU38p4ZEPIy8JGuVaIki+0TCVTppYA6Nqk4
         9g1NWmHQwBd3hwYHIJc/7VGSKXwWoxxib4fCrqioyh7AsTMCptYSUbt97H/Fv22UloRx
         Mh02cW3d3jY2SSNL9qKorWHjWbpJ5+Rk1a5NZgi/QaCZGLuaARtBGl+vNvn0PKOEMfku
         nz7+6hVvZWutVc9af19TvY7cpPxhHevaWlz3UzjYWr1aIYCormU8q0/VXYn/6yaO5OhB
         W9/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=s5Pef7Lu;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=s5Pef7Lu;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpWm6FIadcf1BDCzj2Mtm3K7oYgqNpQQbF2T65WlbHUa3KxF9+uY6CVj8U2CQ7qGAgoC7gZkw==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	christian.koenig@amd.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	hdegoede@redhat.com
Subject: [PATCH 6/9] firmware: print firmware name on fallback path
Date: Mon, 23 Apr 2018 16:12:02 -0400
Message-Id: <20180423201205.20533-7-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180423201205.20533-1-andresx7@gmail.com>
References: <20180423201205.20533-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598569151610038779?=
X-GMAIL-MSGID: =?utf-8?q?1598569151610038779?=
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
index e75928458489..1a47ddc70c31 100644
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
