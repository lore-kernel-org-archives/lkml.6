Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E407C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CC0213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6Lb7Sgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CC0213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbeLFBx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:53:26 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:52447 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727712AbeLFBxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:53:25 -0500
Received: by mail-it1-f181.google.com with SMTP id g76so4778196itg.2;
        Wed, 05 Dec 2018 17:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F2JrG5JSg9cUoRofFVNO5VtJ+WPxWIYqzJic4FWzVpI=;
        b=E6Lb7Sggjb6bkkd9GtBJWBH0OT1W0gnYS80+oj62r9Qr8xo3p03uudSYC5kqH7dF31
         lwJc7ZHVvDdnjw81jJVhRKvskbRI+eP/ujwVII2jxTAKPUyt00VjXDgohogK8vfDnXC9
         QJJA7f5gVDX692N74ynsEW5yjHxS/64SwlJyb12sNSToEgyUS40TM4FovFcl6+HMImsL
         3h4UuKGg3dSbipEritLqkxDS4+55iX4NkOa1ZcaZLWt4aB4McJNxVzWs5S69jh5vSEVU
         PU75i55tHrFAB6AWv5jy5othBJTK5+asKY/6qkvrF3EfKQJQS5RVCzeMpcB4OlNj55A5
         nmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2JrG5JSg9cUoRofFVNO5VtJ+WPxWIYqzJic4FWzVpI=;
        b=V6tvj3GeM+kTtf3JF49luoA35I5K2+TBwGc+sU1PoGzytB3q4t31L43yWfuS8R36w6
         EYvoj+QxDUOnJgHMAKT22pXM8nCSSIO1l2lIe1Vef29WLBxqtD5zRjubb0PBU2Z+z4sb
         BKeeRPnRKBumWqqpgEevDmUcCimh3amFBpcYwKnNybBkxT0VI+byxtKd78wRNPOqJK87
         byWwxjx4uR8rDi/BJN7x6CPn6VL6I6geWE/TTUls4FZeGbKpOFFV9yvpdC0p/N35kchI
         mZoa3/IEIYWoMssAwLkq+4boieSudtgpbnYbv7JQGh8JAlT6J09yqx8wudb0mROlD2Js
         u/fQ==
X-Gm-Message-State: AA+aEWadYSsd4f6sWvoBwqiy1NcBrFAbefHyv/5+1uR8rqD4STeSfD2f
        LZRf7sHeL1omUmhocgWeX/1qHWGb8FXso1A6U0c=
X-Google-Smtp-Source: AFSGD/VrHpbISDKiX/hZ6dpqSdCqT5bNthf9W540WIPjQh1RPFHhRXMNtjg4jwQiWdfpuGgDIsA35nqfOwj3WO1ENiU=
X-Received: by 2002:a24:d081:: with SMTP id m123mr17787140itg.119.1544061204148;
 Wed, 05 Dec 2018 17:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20181205195050.4759-33-robh@kernel.org>
In-Reply-To: <20181205195050.4759-33-robh@kernel.org>
From:   Nicolin Chen <nicoleotsuka@gmail.com>
Date:   Thu, 6 Dec 2018 09:53:12 +0800
Message-ID: <CAGoOwPReuEgzgYng0YeffgejVKPcoQinnNeFu_f2QBgs5daGdg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Use of_node_name_eq for node name comparisons
To:     Rob Herring <robh@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Dec 6, 2018 at 3:51 AM Rob Herring <robh@kernel.org> wrote:
>
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>
> For the FSL ASoC card, the full node names appear to be "ssi", "esai",
> and "sai", so there's not any reason to use strstr and of_node_name_eq

I am not quite sure about the replacement of strstr.
IIRC, a node name in fsl dts might appear to be "ssi@xxxx".

I am currently out of town so cannot verify the patch.

Fabio, would it be possible for you to run a boot test?

Thanks
Nicolin
