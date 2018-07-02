Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CFFC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451C525A2A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451C525A2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=petrovitsch.priv.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753920AbeGBHhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:37:43 -0400
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:1120 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753495AbeGBHhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:37:40 -0400
Received: from thorin.petrovitsch.priv.at (80-110-108-200.cgn.dynamic.surfer.at [80.110.108.200])
        (authenticated bits=0)
        by esgaroth.tuxoid.at (8.15.2/8.15.2) with ESMTPSA id w627a38S025988
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 2 Jul 2018 09:36:04 +0200
Message-ID: <00590669b886b4cc54548e6101912c3d4d1752f2.camel@petrovitsch.priv.at>
Subject: Re: [PATCH] fbcon: introduce for_each_registered_fb() helper
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
To:     Yisheng Xie <ysxie@foxmail.com>, b.zolnierkie@samsung.com,
        keescook@chromium.org, j.w.r.degoede@gmail.com,
        david@lechnology.com
Cc:     andriy.shevchenko@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 02 Jul 2018 09:36:02 +0200
In-Reply-To: <1530202809-24105-1-git-send-email-ysxie@foxmail.com>
References: <1530202809-24105-1-git-send-email-ysxie@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-DCC-URT-Metrics: esgaroth.tuxoid.at 1060; Body=9 Fuz1=9 Fuz2=9
X-Virus-Scanned: clamav-milter 0.97 at esgaroth.tuxoid.at
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

On Fri, 2018-06-29 at 00:20 +0800, Yisheng Xie wrote:
[...]
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index aa74a22..3e13b95 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -650,6 +650,10 @@ extern int fb_get_color_depth(struct
> fb_var_screeninfo *var,
>  extern int num_registered_fb;
>  extern struct class *fb_class;
>  
> +#define for_each_registered_fb(i)		\
> +	for (i = 0; i < FB_MAX; i++)		\
> +		if (registered_fb[i])
> +

That leaves the possibility of a dangling-else.
----  snip  ----
#define for_each_registered_fb(i)		\
	for (i = 0; i < FB_MAX; i++)		\
		if (!registered_fb[i])		\
			continue;		\
		else
----  snip  ----
avoids that.

Kind regards,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at
