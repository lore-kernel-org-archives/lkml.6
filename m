Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvb2pbBbOQ+SVE78eX1o3loz556AkdVaKC1IawUwLZUM4rorLoMW1aUiTeMQFWMCDs9T7pF
ARC-Seal: i=1; a=rsa-sha256; t=1521214871; cv=none;
        d=google.com; s=arc-20160816;
        b=SAGdogef8LuPzS769av87dQ72Ph47vVq0r1Ag6TKPzA0CateMag3yOIsZ+GQKPNsHR
         ozVdoRgH9v6dTON4r5wfHtcLOA3DU3BlnXDH69h9jEQePb0wMtUbCc/QqioIiHtA7nHy
         J+DfH9LWZW17K/XFTiCtYFD/Rp8aRfViLrkQ/BunQuUPy/YCIFaYFnMkWnCV91duixJm
         yip0qI1xG+WkuZeFYBcXwbprMmA6PQuhz1gkxaTAIDPeupKSlOH7uTyghUC6reirZyby
         ZdEpS/SUzoeS5vSGaIyU5qBBL6j8A/GJgMtu0IUMvpUpr5N2A4/nAE7jEBmlMif+jNSO
         3ezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=c7RWe3UDtojRrkU9Y3eAMRrGtKBH1Pej5evB3XxCEaU=;
        b=C+NqjqYgDgkECSBCNU6EvMy5NLE6C20IHUGyhai1OCI2pHNoYnQAJiQmGf+iNuMbfe
         O1jsYYhgxCUIxgsQNszQNLN85xTVCmw5s59cBfFom3NXwN9Td1rWLHlkfFGCjtJUWXFK
         kATcC2uTgBbyy0CbUbJl5qn38xmzr7VcjZiQ5ngWpGyIX2L5IrMuQFnpktBewNYCMvx4
         nf4pUbbJhLRzIcX43wdIXRLyUFygwe2/2dwZRjjb/hgHe7j5BaBS+T5vVZc6Y2zKorF7
         i1ViTsoOiqykBJ4aUmRdIqSaJKhEGqNIUGUeSyT65S4vwVvUNThB8sCiL4+3dPdypRTC
         Y0DA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 048/128] crypto: chelsio - Fix an error code in chcr_hash_dma_map()
Date: Fri, 16 Mar 2018 16:23:09 +0100
Message-Id: <20180316152339.222836322@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109404736628376?=
X-GMAIL-MSGID: =?utf-8?q?1595109404736628376?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 7814f552ff826fefa5e1b24083c7a06a9378e9ef ]

The dma_map_sg() function returns zero on error and positive values on
success.  We want to return -ENOMEM on failure here and zero on success.

Fixes: 2f47d5804311 ("crypto: chelsio - Move DMA un/mapping to chcr from lld cxgb4 driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/chelsio/chcr_algo.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -2414,7 +2414,7 @@ static inline int chcr_hash_dma_map(stru
 	error = dma_map_sg(dev, req->src, sg_nents(req->src),
 			   DMA_TO_DEVICE);
 	if (!error)
-		return error;
+		return -ENOMEM;
 	req_ctx->is_sg_map = 1;
 	return 0;
 }
