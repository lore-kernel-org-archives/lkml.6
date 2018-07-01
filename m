Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7D1C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 22:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B1E250F0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 22:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B1E250F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeGAWKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 18:10:32 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:48006 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbeGAWK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 18:10:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id A79B76A56;
        Mon,  2 Jul 2018 00:10:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 15vvNgbouel4; Mon,  2 Jul 2018 00:10:25 +0200 (CEST)
Received: from var.youpi.perso.aquilenet.fr (static-176-158-111-12.ftth.abo.bbox.fr [176.158.111.12])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id B290E176;
        Mon,  2 Jul 2018 00:10:25 +0200 (CEST)
Received: from samy by var.youpi.perso.aquilenet.fr with local (Exim 4.91)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1fZkY3-0001jx-Ts; Mon, 02 Jul 2018 00:10:23 +0200
Date:   Mon, 2 Jul 2018 00:10:23 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Chris Brannon <chris@the-brannons.com>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kirk Reiser <kirk@reisers.ca>, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org, William Hubbs <w.d.hubbs@gmail.com>
Subject: Re: [PATCH] staging: speakup: Replace strncpy with memcpy
Message-ID: <20180701221023.2fkpyv4jetf2zgjo@var.youpi.perso.aquilenet.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Brannon <chris@the-brannons.com>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kirk Reiser <kirk@reisers.ca>, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org, William Hubbs <w.d.hubbs@gmail.com>
References: <1530478644-16857-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1530478644-16857-1-git-send-email-linux@roeck-us.net>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck, le dim. 01 juil. 2018 13:57:24 -0700, a ecrit:
> gcc 8.1.0 generates the following warnings.
> 
> drivers/staging/speakup/kobjects.c: In function 'punc_store':
> drivers/staging/speakup/kobjects.c:522:2: warning:
> 	'strncpy' output truncated before terminating nul
> 	copying as many bytes from a string as its length
> drivers/staging/speakup/kobjects.c:504:6: note: length computed here
> 
> drivers/staging/speakup/kobjects.c: In function 'synth_store':
> drivers/staging/speakup/kobjects.c:391:2: warning:
> 	'strncpy' output truncated before terminating nul
> 	copying as many bytes from a string as its length
> drivers/staging/speakup/kobjects.c:388:8: note: length computed here
> 
> Using strncpy() is indeed less than perfect since the length of data to
> be copied has already been determined with strlen(). Replace strncpy()
> with memcpy() to address the warning and optimize the code a little.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  drivers/staging/speakup/kobjects.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/speakup/kobjects.c b/drivers/staging/speakup/kobjects.c
> index f1f90222186b..08f11cc17371 100644
> --- a/drivers/staging/speakup/kobjects.c
> +++ b/drivers/staging/speakup/kobjects.c
> @@ -388,7 +388,7 @@ static ssize_t synth_store(struct kobject *kobj, struct kobj_attribute *attr,
>  	len = strlen(buf);
>  	if (len < 2 || len > 9)
>  		return -EINVAL;
> -	strncpy(new_synth_name, buf, len);
> +	memcpy(new_synth_name, buf, len);
>  	if (new_synth_name[len - 1] == '\n')
>  		len--;
>  	new_synth_name[len] = '\0';
> @@ -519,7 +519,7 @@ static ssize_t punc_store(struct kobject *kobj, struct kobj_attribute *attr,
>  		return -EINVAL;
>  	}
>  
> -	strncpy(punc_buf, buf, x);
> +	memcpy(punc_buf, buf, x);
>  
>  	while (x && punc_buf[x - 1] == '\n')
>  		x--;
> -- 
> 2.7.4
> 

-- 
Samuel
Tu as lu les docs. Tu es devenu un informaticien. Que tu le veuilles
ou non. Lire la doc, c'est le Premier et Unique Commandement de
l'informaticien.
-+- TP in: Guide du Linuxien pervers - "L'évangile selon St Thomas"
