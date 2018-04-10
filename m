Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48VLxZ3VotJqCPpBIotfEpBAFUAAt6JFFJg03IqNOqYm5PXtN0dgsT0hq6JTV5OhmNEXxe4
ARC-Seal: i=1; a=rsa-sha256; t=1523399707; cv=none;
        d=google.com; s=arc-20160816;
        b=chgglad3MDlfyo1pxmpIoGOzKKasu5BQ8PmH4ezGRcoALQolSjdJ0NcJk0+zeYdA6A
         1ehjjpZs9mPitzNKSGHCKt8ReCmRKf84tVMAw2agz2j445l58HnaZ24A+GfJGuUy4pB7
         iqVLHLOqLKIDGL76L/N0oWy1GWseSbIcuGsTBZqQIvIBlhjv6t/z20Veqletal7T/xJ8
         rQlVE8f4649oFMyZYPm860TzZHEta7HhhIpchyH2b6Qgm5L8lmVd59eb4hcqLeLRXgKQ
         S15u3jTN/SdQQ46OzEkjqXfEYY1h3tInq8I8d3HtI9jfzx7aivnuRJFRVNJPUEjjmnXv
         xh5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QWw6eyN3TQBXT4XdurzOEfL4sKq1fcLKvVMGjdhm904=;
        b=rxZrs2tR7+LGAQo7lzPJlvgpRM9ns5oK+vzALgNRkL6RynzjCcWLYs6LvyjKF5gO6d
         zmz6aNW+XkP9EBXzN6L2my/gQz8bTUNKnMUB2qbtWtJ5eUeTGswm6zQR+GUVZXWtEcRh
         RU28aIUKNqwB7xmGM9L9jQw82CYax34iB/IIi6hG1kKTj3sJFfhX+/qflzQ/83ompTBd
         0dYEY/9XbJ2XUXPufBIOC065j5TRVa1ZKg5FgqvLLrgwGsARdrRYAGmbl9BbECfyNQJ3
         ti1ZV/meBn4VkHWzrneC1OAACrnOwLUcuMu89gmTRzE2Lg7wF4DTGU8/7PdLRySOzTPD
         dYyw==
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
Subject: [PATCH 4.14 027/138] ASoC: Intel: Skylake: Disable clock gating during firmware and library download
Date: Wed, 11 Apr 2018 00:23:37 +0200
Message-Id: <20180410212905.288150316@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399936619580458?=
X-GMAIL-MSGID: =?utf-8?q?1597400371589876254?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1332,7 +1332,11 @@ static int skl_platform_soc_probe(struct
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
