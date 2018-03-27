Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48dxbnu5NhhPc05JQ/ucyvSvVonzW++urU+khDP69cZxktrPPIC55/xOiPxF3kkrvWt4D9V
ARC-Seal: i=1; a=rsa-sha256; t=1522168488; cv=none;
        d=google.com; s=arc-20160816;
        b=LfKYsAuhJBLzGxAkutPdOvh6EkRzevS2L5qtQOaehDGSLM/kFmWWDioGE38+ZNERcQ
         yjCqEQIElsx/z+YVLAHBnJqAtsBxyNMIY2sCChNaLgglqbp43zppg3RknrwqRMIum7sD
         pta33HDzEwr3j/azx5E1u7J4nDZMeA2W0xFC+BAwIA4arvt+Eutw5GVh9kRRHl1UZZq6
         2PzYZQWEO4jj7FBYGZ9ygaqccXDp5A6dk1+dRauQAh0jcnq+dvNU5K3TmC67sTY6zXu2
         KGjWWBhy0ak32oTtWf1bdkirrp2n1e4AL7/7nGBM4Qv7TyfVAD6D6UVt95wEDw8h7OLC
         +bVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ii1DYBs9MhNkgSB5sAhhBg8jrm9RqWFM6Hrd1pzJPQc=;
        b=U3+vOwDpwZECNlHyOFnMYB0hqBEu+BOVAlqykemZDFXONz5+AR8vfhKVO1Hsj+nWUM
         BWo9r5h3IS/A3UqTxpXLVeuALieCBqTQjNEnX2Kya6VYiC3JopwJvB/K1eIGrFY7XpJu
         m6kqaQPHw2mi0aVWnnI7WHXweDHygHXmE8tFel5xmkThx11fiRBKve3DX06kFXsRzxEW
         ryQL4cJr0bS8tBy/7l4EvRdloMuBQiyxH0e7NgefGuilKBrydEQipwN0/Ft4GWrYYfI5
         xIQtjcv3A2V4OUqSLe+hQqW1r1V+13LPlAoF7qXi9ABbKurNvX9D3eUIYxQrcEaUIU7x
         4JMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Evgeniy Didin <Evgeniy.Didin@synopsys.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Alexey Brodkin <abrodkin@synopsys.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH 4.14 021/101] mmc: dw_mmc: fix falling from idmac to PIO mode when dw_mci_reset occurs
Date: Tue, 27 Mar 2018 18:26:53 +0200
Message-Id: <20180327162751.275889617@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108975022484551?=
X-GMAIL-MSGID: =?utf-8?q?1596109344692659984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Evgeniy Didin <Evgeniy.Didin@synopsys.com>

commit 47b7de2f6c18f75d1f2716efe752cba43f32a626 upstream.

It was found that in IDMAC mode after soft-reset driver switches
to PIO mode.

That's what happens in case of DTO timeout overflow calculation failure:
1. soft-reset is called
2. driver restarts dma
3. descriptors states are checked, one of descriptor is owned by the IDMAC.
4. driver can't use DMA and then switches to PIO mode.

Failure was already fixed in:
https://www.spinics.net/lists/linux-mmc/msg48125.html.

Behaviour while soft-reset is not something we except or
even want to happen. So we switch from dw_mci_idmac_reset
to dw_mci_idmac_init, so descriptors are cleaned before starting dma.

And while at it explicitly zero des0 which otherwise might
contain garbage as being allocated by dmam_alloc_coherent().

Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: <stable@vger.kernel.org> # 4.4+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/dw_mmc.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -564,6 +564,7 @@ static int dw_mci_idmac_init(struct dw_m
 					(sizeof(struct idmac_desc_64addr) *
 							(i + 1))) >> 32;
 			/* Initialize reserved and buffer size fields to "0" */
+			p->des0 = 0;
 			p->des1 = 0;
 			p->des2 = 0;
 			p->des3 = 0;
@@ -586,6 +587,7 @@ static int dw_mci_idmac_init(struct dw_m
 		     i++, p++) {
 			p->des3 = cpu_to_le32(host->sg_dma +
 					(sizeof(struct idmac_desc) * (i + 1)));
+			p->des0 = 0;
 			p->des1 = 0;
 		}
 
@@ -1801,8 +1803,8 @@ static bool dw_mci_reset(struct dw_mci *
 	}
 
 	if (host->use_dma == TRANS_MODE_IDMAC)
-		/* It is also recommended that we reset and reprogram idmac */
-		dw_mci_idmac_reset(host);
+		/* It is also required that we reinit idmac */
+		dw_mci_idmac_init(host);
 
 	ret = true;
 
