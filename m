Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id L1LYFb01HlvlHAAAmS7hNA
	; Mon, 11 Jun 2018 08:50:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F1800607BB; Mon, 11 Jun 2018 08:50:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5ACB1602FC;
	Mon, 11 Jun 2018 08:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5ACB1602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754189AbeFKIuA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:50:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:46184 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754024AbeFKIt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:49:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 01:49:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,501,1520924400";
   d="scan'208";a="236386113"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jun 2018 01:49:56 -0700
Message-ID: <520e80a8b8de0f532e8dd3ee15af9efbc748dd9a.camel@linux.intel.com>
Subject: Re: [PATCH] ALSA: fm801: add error handling for snd_ctl_add
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: jiazhouyang09@gmail.com,
        =?ISO-8859-1?Q?=C9meric?= MASCHINO <emeric.maschino@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date: Mon, 11 Jun 2018 11:49:56 +0300
In-Reply-To: <1528704248-33818-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528704248-33818-1-git-send-email-jiazhouyang09@gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-11 at 16:04 +0800, jiazhouyang09@gmail.com wrote:
> When snd_ctl_add fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling snd_ctl_add.
> 

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Though I can't test this (I have FM-only card). Last person who would
able to test was Émeric (Cc'ed).

> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  sound/pci/fm801.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
> index 73a67bc..e3fb9c6 100644
> --- a/sound/pci/fm801.c
> +++ b/sound/pci/fm801.c
> @@ -1068,11 +1068,19 @@ static int snd_fm801_mixer(struct fm801 *chip)
>  		if ((err = snd_ac97_mixer(chip->ac97_bus, &ac97,
> &chip->ac97_sec)) < 0)
>  			return err;
>  	}
> -	for (i = 0; i < FM801_CONTROLS; i++)
> -		snd_ctl_add(chip->card,
> snd_ctl_new1(&snd_fm801_controls[i], chip));
> +	for (i = 0; i < FM801_CONTROLS; i++) {
> +		err = snd_ctl_add(chip->card,
> +			snd_ctl_new1(&snd_fm801_controls[i], chip));
> +		if (err < 0)
> +			return err;
> +	}
>  	if (chip->multichannel) {
> -		for (i = 0; i < FM801_CONTROLS_MULTI; i++)
> -			snd_ctl_add(chip->card,
> snd_ctl_new1(&snd_fm801_controls_multi[i], chip));
> +		for (i = 0; i < FM801_CONTROLS_MULTI; i++) {
> +			err = snd_ctl_add(chip->card,
> +				snd_ctl_new1(&snd_fm801_controls_mult
> i[i], chip));
> +			if (err < 0)
> +				return err;
> +		}
>  	}
>  	return 0;
>  }

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
