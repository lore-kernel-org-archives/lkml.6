Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtyLDtmtVKdgc9hJwKVy8sxhHhGIoEBlKbUFUXlxh+ZdPzBDyfIvhPlMet3fNj5ZXJ2AAD6
ARC-Seal: i=1; a=rsa-sha256; t=1521214959; cv=none;
        d=google.com; s=arc-20160816;
        b=a6Irb2LraKTMHTX+DiHP1n+2Y9tUSqJsl8rNG2Na/4+rLbQLxl3M7D9uYZIVp52Tyz
         moBaELcOiPtlzCyEXH1YbrHka9ILp8QZMw7zYbFeUwn705lqG7Hb5FZVRkJK+7/XNFLJ
         0mgiYvp59TfIF92eayOAia7CLkytn46CBhi6dEbs9umnt+leTBTRHgAsD+RShP+DjRgt
         Vve/1zcNySu1EO97kR+4zmFkzoO4AK8BYCVYr1ea1QlUKV2W8NwSqro4uQiyaMc7ESdK
         cWiqOhMfrHTbWUH7QdV0ruFen0tTeCOgs7PS3wY5epKBOltZFzjWk07FuLlRa3lVZBhz
         XnLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=76Igaicf6nnLdUEVUkpAcTdM0lzrL3nPWjkmgdB/GS4=;
        b=cSeLIV8funyGb8Za63xiG2aoEF0TLkSOVtzNHyDZf9zR6roPBFlklH/sNZPlVIT5eR
         GSLA0A4FtvGnHtRQZ+XiTyNUAMhuVGAA14Rn7k+bEeHKjYadOHe93+Jz74oAQSgbnQMl
         7GPn9lLZd4Ei53Xng5XiTQ8HtRGgfkgTkPpaZVI2z/bfnN+WrXL//EkfOBHF/ngEbJjG
         dCpuqBFumQKSOmMB4NwAEAL2zEyXR/PslaKiKvJ9U/9vyJVOgcW+8PNGVylDhTPGfrAU
         88SspLAqNi3r6hsHqfMfUaonfvA+KKAL2vKtDyXJrVqhzS6hpji8Vd8kWSoJqKyq5ePu
         xltw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 042/128] staging: rtl8822be: fix missing null check on dev_alloc_skb return
Date: Fri, 16 Mar 2018 16:23:03 +0100
Message-Id: <20180316152338.865136709@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109039358682188?=
X-GMAIL-MSGID: =?utf-8?q?1595109497989178152?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>


[ Upstream commit 3eb23426e1749a0483bc4c9b18e51f657569e3ed ]

dev_alloc_skb can potentially return NULL, so add a null check to
avoid a null pointer dereference on skb

Detected by CoverityScan, CID#1454558 ("Dereference on null return")

Fixes: 7e5b796cde7e ("staging: r8822be: Add the driver code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtlwifi/rtl8822be/fw.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/staging/rtlwifi/rtl8822be/fw.c
+++ b/drivers/staging/rtlwifi/rtl8822be/fw.c
@@ -464,6 +464,8 @@ bool rtl8822b_halmac_cb_write_data_rsvd_
 	int count;
 
 	skb = dev_alloc_skb(size);
+	if (!skb)
+		return false;
 	memcpy((u8 *)skb_put(skb, size), buf, size);
 
 	if (!_rtl8822be_send_bcn_or_cmd_packet(rtlpriv->hw, skb, BEACON_QUEUE))
