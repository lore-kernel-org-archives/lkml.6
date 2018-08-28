Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6C4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B2A2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B2A2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeH1U25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:28:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:24978 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbeH1U25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:28:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 09:36:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,300,1531810800"; 
   d="scan'208";a="252611609"
Received: from anshuma1-pnp-server.iind.intel.com ([10.223.107.119])
  by orsmga005.jf.intel.com with ESMTP; 28 Aug 2018 09:36:26 -0700
From:   Anshuman Gupta <anshuman.gupta@intel.com>
To:     puneethx.prabhu@intel.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, rafael@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, anshuman.gupta@intel.com
Subject: Re: [PATCH v2 1/1] hdac-codec runtime suspended at PM:Suspend.
Date:   Tue, 28 Aug 2018 22:04:15 +0530
Message-Id: <1535474055-11763-1-git-send-email-anshuman.gupta@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534615923-8541-2-git-send-email-anshuman.gupta@intel.com>
References: <1534615923-8541-2-git-send-email-anshuman.gupta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is this patch not in consideration, there are no review comment for it. 
this patch fixes an issue with hdac hdmi codec driver.

On one of our platform HD audio controller takes arounf 300ms.
Below are the snippet of dmesg log.

[ 3778.461888] calling  0000:00:0e.0+ @ 3667, parent: pci0000:00, cb: pci_pm_resume
[ 3778.775273] call 0000:00:0e.0+ returned 0 after 306016 usecs

When HD audio controller is in runtime suspend state, 
with direct complete, we can improve overall system wide resume latency.
 
On Sat, Aug 18, 2018 at 11:42:03PM +0530, Anshuman Gupta wrote:
> Keep hdac hdmi codec to be in runtime suspended while entering to
> system wide suspend. Currently hdac hdmi codec driver using its
> suspend and resume operation in prepare and complete PM callbacks,
> and it resumes the hd audio controller (parent of self) from runtime
> suspend and blocks the direct complete for hd audio controller.
>
> If hdac-codec is already in runtime suspend state skip its power down
> sequence in prepare, power up sequence in complete phase. It enables
> direct complete path for hdac-codec and hd audio controller
> PCI device.
>
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> ---
> Changes in v2
> - Changed the commit message.
> - Using pm_runtime_suspended instead of pm_runtime_status_suspended
>   in order to handle any race condition.
>
> sound/soc/codecs/hdac_hdmi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
> index 84f7a7a..e965338 100644
> --- a/sound/soc/codecs/hdac_hdmi.c
> +++ b/sound/soc/codecs/hdac_hdmi.c
> @@ -1859,6 +1859,9 @@ static int hdmi_codec_prepare(struct device *dev)
>       struct hdac_ext_device *edev = to_hda_ext_device(dev);
>       struct hdac_device *hdev = &edev->hdev;
>
> +     if (pm_runtime_suspended(dev))
> +             return 1;
> +
>       pm_runtime_get_sync(&edev->hdev.dev);
>
>       /*
> @@ -1880,6 +1883,9 @@ static void hdmi_codec_complete(struct device *dev)
>       struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
>       struct hdac_device *hdev = &edev->hdev;
>
> +     if (pm_runtime_suspended(dev))
> +             return;
> +
>       /* Power up afg */
>       snd_hdac_codec_read(hdev, hdev->afg, 0, AC_VERB_SET_POWER_STATE,
>                                                       AC_PWRST_D0);
> --
> 2.7.4
>

--
Thanks,
Anshuman.
 
