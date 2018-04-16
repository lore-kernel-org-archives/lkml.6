Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523917493; cv=none;
        d=google.com; s=arc-20160816;
        b=GF2K6fdF+we9LbnrXMxxalVsTw2LNwLWTKfNLBS1dFxtAApoQaAQ/dOVVdlFu2jQYL
         7PuUR8paTz+MJTljGPYpM3ZLxw7aY3awy3ocFz5zZyNtsMdloCbhnZy8gKIxqhEpsDeM
         6lISOVt8p5cjT7uVyVPc4rnxdYHx9TNJfaFkOIXZ46GJu5konI6mve0dY+Nm3AmU8yvw
         szIz9HwQz/ZDsRMroJwofs9A1xhjijAq5yRjIlQjtQSIRfR/Be5OrqBqSdWdpij8HLuM
         y49NSqkI+CytDJ6/GfDYj88aLIxCKxNKRLs/sVVXxkj6+OUmb6kVPWvljRjfq2Ge1nlY
         bY9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=6LXwLpslexdyegTWRfAMLY9DFfVDpfpatQYZah89NLQ=;
        b=Jh2CzsBf2xhYnmOwS73D7EFXKKrRQmclE7MYFmG/TKMdyTnFUNk7NLbRMk7M7m3BVW
         aPxhffLMDsMBBdtXQM7XKtY8lsagdmuyfuRICp4VZ36H8Ov95pSpNgJU4plSujZDeheG
         cRkGzGmmQQhC/bGCOVpADH9UQzFeK+Rfz2fV4Vd1uJo1whJ+FTyl30sc9KMGnqrwCEk8
         5t9CXxjFvcDERZXI1IhttbYAayFvKWt8EaGBs7nSuLcSKj3+omzGuJNgG8dFDSRtymuJ
         DO2huL4iLL5Hd10YSlgxwJIA9xc8gIO4XxFc8gJOm0zZ6fVN2m9c70+kziYdP3xC0a16
         lKXg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HdAwZec+;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HdAwZec+;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/4LH5OZ5PW7vKVE/zjTooalZKrq1KcaFNn87e90eiZlw7zynzR9TXPJQGjFc3/jlcC7vsUiw==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com
Subject: [PATCH 8/8] brcmfmac: use request_firmware_nowait2 to load firmware without warnings
Date: Mon, 16 Apr 2018 18:24:27 -0400
Message-Id: <20180416222427.29683-9-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180416222427.29683-1-andresx7@gmail.com>
References: <20180416222427.29683-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597943309688458168?=
X-GMAIL-MSGID: =?utf-8?q?1597943309688458168?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This reduces the unnecessary spew when trying to load optional firmware:
"Direct firmware load for ... failed with error -2"

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index 091b52979e03..26db3ebd52dc 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -503,8 +503,9 @@ static void brcmf_fw_request_code_done(const struct firmware *fw, void *ctx)
 		goto done;
 
 	fwctx->code = fw;
-	ret = request_firmware_nowait(THIS_MODULE, true, fwctx->nvram_name,
-				      fwctx->dev, GFP_KERNEL, fwctx,
+	ret = request_firmware_nowait(THIS_MODULE, true, false,
+				      fwctx->nvram_name, fwctx->dev,
+				      GFP_KERNEL, fwctx,
 				      brcmf_fw_request_nvram_done);
 
 	/* pass NULL to nvram callback for bcm47xx fallback */
@@ -547,7 +548,7 @@ int brcmf_fw_get_firmwares_pcie(struct device *dev, u16 flags,
 	fwctx->domain_nr = domain_nr;
 	fwctx->bus_nr = bus_nr;
 
-	return request_firmware_nowait(THIS_MODULE, true, code, dev,
+	return request_firmware_nowait2(THIS_MODULE, true, false, code, dev,
 				       GFP_KERNEL, fwctx,
 				       brcmf_fw_request_code_done);
 }
-- 
2.14.1
