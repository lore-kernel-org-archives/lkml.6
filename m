Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48PNPkCnVyHn7mHcZnll+anX5QdS2xQtwAMzJf47RyhIghctIxrHtuX2FAu6ccIXk9+wfvU
ARC-Seal: i=1; a=rsa-sha256; t=1523399292; cv=none;
        d=google.com; s=arc-20160816;
        b=ObFLQHkLM/FmRvWGg2eXEa4aixJxJT1Q+ZLt1AKKrZV/HjH+siBET+tSSpUEXeh7o2
         TVTpBg68GwflUn/c+r0sIsJ3C5VSJTcWGO/sHiINhkFtr6hpcL2lutS1JB293cbVyUAp
         B3pXAZYuYL7+4lIVtZYm+rfQ9jzt/2a3126Gl3j3R8HC5a/7UIshPs4pSp8lgDVPjuxw
         Wv1G7I/tXS4rZEpSL1H2Y5LRYy6j7M9HJVZqwW+E1h2vN1sfabVyVNGTqB92ME+33nBF
         6mstD4S82lPwCje8L3EYte5lAQ+EMF+fuQRozKL6xK6/pmvq2To9C3LU30mN92NePI0L
         dnrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wNSvMDusv8VVTXWdnu1GBO8Wjb9pjUGpRPffoFcNK74=;
        b=ivEsLYJoupxcWKCpissQOyvFmrrClkP/XyiiLotCm1U4gtfVpLJODx7yriAxusi70P
         BYht3iJmDf8anK7Lg/7/1ie1nKFC3U7v0YBNKvXe8eKGg1I9KVNgA4X/kDIAZjizLbII
         ZpyLx3lw38bEXCRvDT+T5eIqMGCHbyXqy7jxNYFfOVb5Kk7X6meSDGMK3aDcgPzap4dP
         u4SzDRjth9UuGHWKAmfCSy12bxvERfAILaDwj2JbW8vrg7zN6f/kkzyP8ptEYAZYke1G
         6/EQQpgCwN79HVp/J2IwTITlwmwc3Ua8c9XiNtBuHjjZl9ythQ4zp+6DqP1nFvduIexL
         AumQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Guneshwor Singh <guneshwor.o.singh@intel.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 034/168] ASoC: Intel: Skylake: Disable clock gating during firmware and library download
Date: Wed, 11 Apr 2018 00:22:56 +0200
Message-Id: <20180410212801.648223132@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399936619580458?=
X-GMAIL-MSGID: =?utf-8?q?1597399936619580458?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>


[ Upstream commit d5cc0a1fcbb5ddbef9fdd4c4a978da3254ddbf37 ]

During firmware and library download, sometimes it is observed that
firmware and library download is timed-out resulting into probe failure.

This patch disables dynamic clock gating while firmware and library
download.

Signed-off-by: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/skylake/skl-messages.c |    4 ++++
 sound/soc/intel/skylake/skl-pcm.c      |    4 ++++
 2 files changed, 8 insertions(+)

--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -404,7 +404,11 @@ int skl_resume_dsp(struct skl *skl)
 	if (skl->skl_sst->is_first_boot == true)
 		return 0;
 
+	/* disable dynamic clock gating during fw and lib download */
+	ctx->enable_miscbdcge(ctx->dev, false);
+
 	ret = skl_dsp_wake(ctx->dsp);
+	ctx->enable_miscbdcge(ctx->dev, true);
 	if (ret < 0)
 		return ret;
 
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1343,7 +1343,11 @@ static int skl_platform_soc_probe(struct
 			return -EIO;
 		}
 
+		/* disable dynamic clock gating during fw and lib download */
+		skl->skl_sst->enable_miscbdcge(platform->dev, false);
+
 		ret = ops->init_fw(platform->dev, skl->skl_sst);
+		skl->skl_sst->enable_miscbdcge(platform->dev, true);
 		if (ret < 0) {
 			dev_err(platform->dev, "Failed to boot first fw: %d\n", ret);
 			return ret;
