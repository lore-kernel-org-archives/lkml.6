Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523979206; cv=none;
        d=google.com; s=arc-20160816;
        b=mgrQji7hfgfCLtCfHGAeqYhY2qxzjy5iwwqFbUrThTXx7FvQl2tdapoBHonItbXz4U
         EaXsfksqfeDmM0iOsOqtTjSKlzCu53RFcpwMwZKQsWo39rs4/Szo/334AvAzMH8ylqVN
         KvcJBmJgTG9gGqZ7kuBKZ5LRXyYCxaw/6DPKlo5FT1Oj6X0VRKxyWdoeZIDvN4mYG0Uj
         bE910VScCqKAyjbLTbgaFE9EE9hVoSWZSuFBPPa5Vk0Js6R0XopADuSSX/hYcpEHquHY
         JZKtryQk9iW/OqaWsCxXsMws+70KQL29PDCwUlTJWdWwPQXbQ0hQUAxNHgcnpNwQUeN2
         4cmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=6LXwLpslexdyegTWRfAMLY9DFfVDpfpatQYZah89NLQ=;
        b=PlaY8pkXwwL6seI/zNjEnf5Lqumrp0GZ29ycm2Yb/PeomIQYfIAhW+qRAI0wYF12VO
         rnKUOyM/iWluqU7OvUjVrlDhdvAZIiZ9b0YVt8JcV9Py+lTAHavkHe8Eyx0Ya3tpYGJc
         wg1QUuwdbLDvPd/wmgo7QWczzeIHpm/wR47EIt61ttSgcHHYcfwDKzcIhsuiOXURcTEJ
         KrXIJoYi8HOv3uv1VzUTYAHCrqaBeKyoVFK7RxoeKeSUTtAOij3iEnEY/Jt25FqxCZCy
         DSZhNm/0jUTHTKr9oGjMfwwihDGixjDMC6FQ1r8JEeCw6/RRgGcTZV8+wk1zS32mVifB
         XRMw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pbnc4ItB;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pbnc4ItB;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/HGGBi/NjsrrQmpKMzL+lcGUwVcS4uEpMU438dcyBa702wpjX+gBA2x9XFRAOtjZdUCTM99Q==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com
Subject: [PATCH 9/9] brcmfmac: use request_firmware_nowait2 to load firmware without warnings
Date: Tue, 17 Apr 2018 11:33:07 -0400
Message-Id: <20180417153307.3693-10-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180417153307.3693-1-andresx7@gmail.com>
References: <20180417153307.3693-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008020626065507?=
X-GMAIL-MSGID: =?utf-8?q?1598008020626065507?=
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
