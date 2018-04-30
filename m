Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpGJqh7wQreFNWCpSmDO/Xo/JS5YYDp7Iw8NnM3gXsx4zIm5h88uZJXWaO3JcUVD6yOpgry
ARC-Seal: i=1; a=rsa-sha256; t=1525116519; cv=none;
        d=google.com; s=arc-20160816;
        b=ifgN6wwQYF8iEP7qXcUR3ApdQ42RseE/jNUy4KtcV8qmrtXiyTCv4zh6OmthS7khaE
         sI89bfFFUIQ2w6B6P1PmvckfWkMLS72er7Ikxad1uVbn8eu1s6Cp5QvRn4LA1FAPYO0P
         /6mPe8GtdBENN056zG6nA8eOH7jrZGLfSw7BEapryYh8gfbSuQzfAoSS9bUjHqagaTbA
         ZUWaaZE4J77q18N5Dcpz2MMmgSIXtFne7SzoLjkO/szNctY7S+gFZsrW+REVWFfZZDOa
         goIWT4ayu9/v8E4/j3l7uUed5jJ4NJnD3gTWNdWjNssJuKOZaRbscxWfd4KW82VLUYqR
         lkwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=0puzRD1RHswk7MXQcoPF1wdwu5RWU61qZ6DhW/Ok+M0=;
        b=lXH5/SnQVV3Cr5SJ5C8Qk0j+7/nUSr/sgR1Ti8qiuA+mWx4f4K/umYhdK79eRYTag7
         9gqVLIBIphnb6fkWm7/s3OwQxCgej4Ark0z7d5hl1jTemLqfgfdkMFJGYJuDCB9ehVLD
         h8HoiB/2JtAflLwclC5s4Fa0hIR0JjbcxjHoqKGLft+mLvxxfQ08XVDE8RhYKTJScfQD
         dmGrh3lOvPUJJ1LUZ98Mq+JC+YufdOQIlR3CtPZ6E98X4Yo+NYVHZWahaZjlrCEhu2Om
         SbjD3cbwZWhMPe7/HkWc+JrY9V0TI1JjGytOX2irEjAEOkM2+Pnc2gijIkMgWe4QphAL
         o1TA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A874022DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tero Kristo <t-kristo@ti.com>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.16 084/113] ASoC: dmic: Fix clock parenting
Date: Mon, 30 Apr 2018 12:24:55 -0700
Message-Id: <20180430184018.745129600@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200579022767839?=
X-GMAIL-MSGID: =?utf-8?q?1599200579022767839?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tero Kristo <t-kristo@ti.com>

commit 573eda59c772d11fc2b56d525dfb698b0f87ddb3 upstream.

In 4.16 the clock hierarchy got changed by
a5c82a09d876 ARM: dts: omap4: add clkctrl nodes

The fck of dmic is no longer a mux clock, it's parent is.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org # 4.16+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/omap/omap-dmic.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -281,7 +281,7 @@ static int omap_dmic_dai_trigger(struct
 static int omap_dmic_select_fclk(struct omap_dmic *dmic, int clk_id,
 				 unsigned int freq)
 {
-	struct clk *parent_clk;
+	struct clk *parent_clk, *mux;
 	char *parent_clk_name;
 	int ret = 0;
 
@@ -329,14 +329,21 @@ static int omap_dmic_select_fclk(struct
 		return -ENODEV;
 	}
 
+	mux = clk_get_parent(dmic->fclk);
+	if (IS_ERR(mux)) {
+		dev_err(dmic->dev, "can't get fck mux parent\n");
+		clk_put(parent_clk);
+		return -ENODEV;
+	}
+
 	mutex_lock(&dmic->mutex);
 	if (dmic->active) {
 		/* disable clock while reparenting */
 		pm_runtime_put_sync(dmic->dev);
-		ret = clk_set_parent(dmic->fclk, parent_clk);
+		ret = clk_set_parent(mux, parent_clk);
 		pm_runtime_get_sync(dmic->dev);
 	} else {
-		ret = clk_set_parent(dmic->fclk, parent_clk);
+		ret = clk_set_parent(mux, parent_clk);
 	}
 	mutex_unlock(&dmic->mutex);
 
@@ -349,6 +356,7 @@ static int omap_dmic_select_fclk(struct
 	dmic->fclk_freq = freq;
 
 err_busy:
+	clk_put(mux);
 	clk_put(parent_clk);
 
 	return ret;
