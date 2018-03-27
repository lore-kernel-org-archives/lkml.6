Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+8cb0qYzPt1D5QlM1k6r/DTo9r9wWclEvHtUflPKlf4n6kr/kIzcQoj2GD17Wv5995MO7U
ARC-Seal: i=1; a=rsa-sha256; t=1522168262; cv=none;
        d=google.com; s=arc-20160816;
        b=Zy/woZfRWoj/bBQohK9AHl6saSmnxfqabQgxTWhFovGaiTJcwsmvhkj+HG3QNDtkip
         xDi0Oo+9KB6G4CG6RWUBMWE9gSjCeYPXY8h6R5qMgT5CP70OpKCCtcLfm4YjULlFp0eH
         IIb/g1apBXbnpzB///GHNl9ib1S4Gcewe2qcdJvywkGifIs5I+7Y8VRYMQNJCkz5uw9t
         ag9IajLoDJEZdW5qg4PuuPf+svlLQt1YT4Il7NuyIpMVfVtrqC9zu+eZ7StlzbX7Os/5
         2ynO6u/15Tlf915y47/CxV5ED3tq5cBy2Ac3knUpG6mdS1fq0GJYY80etXgKmGb3dcoG
         dVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=M7zklXPaVcAR2m2aCok14URe/0A8YwDFkat3NbW2W0k=;
        b=jsGORTUPnZ0fZ3FYeuSjqjLnco1gy4P053oLL8aZ0DXVM9Gb8A1BDpVwgp3030fIyW
         jTlATobYRvC20JtrzH5pK3RKKTuahSZMZgnL7mVvUAoAxnVmHUANXy10Y44l+dpwsVFi
         7RKCiK2ztENybUCxPadMWFmu6F3Jtn3MCI/4bjtY5wtho40f5hPz0CZ3WfQucNCv4/xT
         AWu8Dln2xBUh64j3PUBPESFnCCKw5HhLFmiFbunDor5etXNNbhDC5ypYgCS+yK36OGI0
         ciTlN7hkiKTrZIY0ikycMyIJReAVFvUPZJq8ZpXMPbM9BdpJcok0bfs1inR9gk18iWy4
         rviA==
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
Subject: [PATCH 4.9 07/67] mmc: dw_mmc: fix falling from idmac to PIO mode when dw_mci_reset occurs
Date: Tue, 27 Mar 2018 18:26:59 +0200
Message-Id: <20180327162727.087079723@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108975022484551?=
X-GMAIL-MSGID: =?utf-8?q?1596109108514282142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -490,6 +490,7 @@ static int dw_mci_idmac_init(struct dw_m
 					(sizeof(struct idmac_desc_64addr) *
 							(i + 1))) >> 32;
 			/* Initialize reserved and buffer size fields to "0" */
+			p->des0 = 0;
 			p->des1 = 0;
 			p->des2 = 0;
 			p->des3 = 0;
@@ -512,6 +513,7 @@ static int dw_mci_idmac_init(struct dw_m
 		     i++, p++) {
 			p->des3 = cpu_to_le32(host->sg_dma +
 					(sizeof(struct idmac_desc) * (i + 1)));
+			p->des0 = 0;
 			p->des1 = 0;
 		}
 
@@ -2878,8 +2880,8 @@ static bool dw_mci_reset(struct dw_mci *
 	}
 
 	if (host->use_dma == TRANS_MODE_IDMAC)
-		/* It is also recommended that we reset and reprogram idmac */
-		dw_mci_idmac_reset(host);
+		/* It is also required that we reinit idmac */
+		dw_mci_idmac_init(host);
 
 	ret = true;
 
