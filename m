Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227t3Ag8m/7pCE5E5ntGYIH9uIyMOb/8yrbARpzQcPT4ChrYCka+TlILTMAz72DQcX+sv9bq
ARC-Seal: i=1; a=rsa-sha256; t=1519411153; cv=none;
        d=google.com; s=arc-20160816;
        b=UkDbnJ7dNmdYC0AO3Q4QAZ1fgfx4MRxR9jerBkroCnvz5utaTPeuVA6T9Oxr+rRBsh
         xU2g2bWF5DgmlsoIznbA4qxl4i5eqLfYP/A6UU0eAdQ26S3XeLL3CPSkSqvxP9i3R2qC
         RPyEsQUty0mq9TJeYJeQNsAkLNeAy81a/vVQi9hZ8NKu9Q+0rdn3HkXCt0Z/3PZCRNXO
         x2KCGg3ugHCNvicKHwPjaQuBA0eGn0Kwh6OZ/NHh75aUv/X56aLJYanPBmOmhCo/2CHl
         PiErG7LCDlvkr2NazVnEaZytfOVSz81DzP1uh1uUcbLwmz0tOpUF4EgvqzviShk1pPwd
         LLMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TiyjnLCGV1eqN0kWxLqCaTwJOwXR5p6mC9kMlgEz2VM=;
        b=Gwg4KaI8BEmvENG2PuSJUCu0PsCeLuAeHyr17UZuU4ZrMySwyXe40UouAVU2Z4xxKm
         LDXbS75u/ZcmWOnrOi7qaJpquA8+QT/0UN5woVKOdkBfH0PdNqhXx0nnu6EOS54g/CW5
         j/BU3JlyAXqMNFStOTZ3+5IkgZRIp4pIt7Y68Nr9ZlHRHRot4ikan47Ws7u4UorZNldf
         4s2wMaPixIEXA0LRVswjS9L2bOc+vzHj1pKuTJ0eOR/8rstT1QTaI2YxBja5YqCCWwpO
         o3NI7aVB38NmF/jtRw4BRyIFZhnewAzBP2pTvbX614145/fTTcJ0iW3VU/bHm09BkRU8
         iZAg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.4 139/193] drm/gma500: Sanity-check pipe index
Date: Fri, 23 Feb 2018 19:26:12 +0100
Message-Id: <20180223170347.581545091@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218069647684070?=
X-GMAIL-MSGID: =?utf-8?q?1593218069647684070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thierry Reding <treding@nvidia.com>

commit 4f250706211cdb949f7580d4fe4dd1fd646de693 upstream.

If the DSI output isn't connected, then mdfld_dsi_encoder_get_pipe()
will return -1. The mdfld_dsi_dp_mode_set() function doesn't properly
check for this condition and causes the following compiler warnings:

	  CC      drivers/gpu/drm/gma500/mdfld_dsi_dpi.o
	drivers/gpu/drm/gma500/mdfld_dsi_dpi.c: In function ‘mdfld_dsi_dpi_mode_set’:
	drivers/gpu/drm/gma500/mdfld_dsi_dpi.c:828:35: warning: array subscript is below array bounds [-Warray-bounds]
	  u32 pipeconf = dev_priv->pipeconf[pipe];
	                                   ^
	drivers/gpu/drm/gma500/mdfld_dsi_dpi.c:829:33: warning: array subscript is below array bounds [-Warray-bounds]
	  u32 dspcntr = dev_priv->dspcntr[pipe];
	                                 ^

Fix this by checking for a valid pipe before indexing the pipeconf and
dspcntr arrays.

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Reviewed-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Link: http://patchwork.freedesktop.org/patch/msgid/1450178476-26284-2-git-send-email-boris.brezillon@free-electrons.com
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/gma500/mdfld_dsi_dpi.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/gma500/mdfld_dsi_dpi.c
+++ b/drivers/gpu/drm/gma500/mdfld_dsi_dpi.c
@@ -821,14 +821,18 @@ void mdfld_dsi_dpi_mode_set(struct drm_e
 	struct drm_device *dev = dsi_config->dev;
 	struct drm_psb_private *dev_priv = dev->dev_private;
 	int pipe = mdfld_dsi_encoder_get_pipe(dsi_encoder);
-
 	u32 pipeconf_reg = PIPEACONF;
 	u32 dspcntr_reg = DSPACNTR;
+	u32 pipeconf, dspcntr;
 
-	u32 pipeconf = dev_priv->pipeconf[pipe];
-	u32 dspcntr = dev_priv->dspcntr[pipe];
 	u32 mipi = MIPI_PORT_EN | PASS_FROM_SPHY_TO_AFE | SEL_FLOPPED_HSTX;
 
+	if (WARN_ON(pipe < 0))
+		return;
+
+	pipeconf = dev_priv->pipeconf[pipe];
+	dspcntr = dev_priv->dspcntr[pipe];
+
 	if (pipe) {
 		pipeconf_reg = PIPECCONF;
 		dspcntr_reg = DSPCCNTR;
