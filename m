Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpEU3633sCEEhLT/PqsUh3YMENXiHWtgpduPkbD3EqMMT8sfJXZ27BqGuqBDiQF6nZqAFba
ARC-Seal: i=1; a=rsa-sha256; t=1525767369; cv=none;
        d=google.com; s=arc-20160816;
        b=axEeSqHoA+wmmHASeq5NgwQE81oLP5X27tawfP6SzPdh2WkqmaV3ttuVgX+AbuPSyK
         +FxaAw/h2S0XH6XeWp9JQCTpGl8/9yQKbmzh2YuvEVEAn8q75eTBbmJyPJPo+AtfKJMc
         qo9e4WQ5iOidSCOlhCCprbGEo9pvkRLAemDDrJWPszGniDUgDtcOzDsUZxLIU5y9/L1U
         IsgbLaCS5CphlFg7bNShPaz8zMBlXbW415JDpXBV2c6pyHG6hY6jv+yuQ3VwlDqEIDBA
         O5uWFxjU5O/ZDM9ht24cyVTKNXxnrOlHCotfTi5HH77OWnuwDLg/ZgAo8kOskqpHziy+
         DH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=bQxp6qfE9LaEbbVqbgExdFsRha6Km2RLGyrpVXW1xtY=;
        b=ypa2ohZFqpr1v9JIj8sHwsq7IyvM55GmPiIzrO7Qn5R7XsePRNtJfxXKWHcuzAdJf9
         DTapnoApqlLrRUKmYdy0EzPfJENQ4vMYgF26N2EXIhrdV7qNomw2U8PoeaVZQ5pikUzI
         LDK6uQzt/pPURREy6P8Pm4S9FedC6NXS82oBKzdxkSclitWYkrTwQPhbVEGhM85Wud0W
         8FJ2PoKkwzZDFpIEdS16jnUUGa14fxOhmS1LKbB3EO/HErX27/GFDyzAmeCWmIPoUboY
         +n2hssmibYddZ13GT24pIc9D1Bs0+74JyKbhbZV06S06u3qQY4DqRYT/m5QhJozdh9t+
         PWKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=VP/sSsOM;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=VP/sSsOM;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Hellstrom <thellstrom@vmware.com>,
	Deepak Rawat <drawat@vmware.com>,
	Sinclair Yeh <syeh@vmware.com>
Subject: [PATCH 4.14 30/43] drm/vmwgfx: Fix a buffer object leak
Date: Tue,  8 May 2018 10:10:49 +0200
Message-Id: <20180508074008.683243248@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882831936000482?=
X-GMAIL-MSGID: =?utf-8?q?1599883045768133448?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellstrom <thellstrom@vmware.com>

commit 13f149d47392782baafd96d54d4e65f3b5ca342f upstream.

A buffer object leak was introduced when fixing a premature buffer
object release. Fix this.

Cc: <stable@vger.kernel.org>
Fixes: 73a88250b709 ("Fix a destoy-while-held mutex problem.")
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Deepak Rawat <drawat@vmware.com>
Reviewed-by: Sinclair Yeh <syeh@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -2612,6 +2612,7 @@ void vmw_kms_helper_resource_finish(stru
 		vmw_kms_helper_buffer_finish(res->dev_priv, NULL, ctx->buf,
 					     out_fence, NULL);
 
+	vmw_dmabuf_unreference(&ctx->buf);
 	vmw_resource_unreserve(res, false, NULL, 0);
 	mutex_unlock(&res->dev_priv->cmdbuf_mutex);
 }
