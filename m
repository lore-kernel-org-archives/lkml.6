Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8ACC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8627121479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544103275;
	bh=/brkj+bZc9NrR3D3W5uJBwFGEeeZyiyeMAwTVS7zWB4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QVntl0h2H7UBxgJVceO5YhSgzo/oqXlx7NnSoyyx3DGuPS14mN9UNTzOP0mvh1nZZ
	 hOM5QeNl7G8VZ/eguU3ewZl4Y/meDjLb+7rs+52fuZi3GfhIo81VQjx5xSZ0tG1HZf
	 ROMBzKl7fydpFoTdfKnZLMXGacsy4epVfpeg28Kk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8627121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbeLFNee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:34:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:53450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbeLFNee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:34:34 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5876B214DB;
        Thu,  6 Dec 2018 13:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544103273;
        bh=/brkj+bZc9NrR3D3W5uJBwFGEeeZyiyeMAwTVS7zWB4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0uEHwq8N6kkKyL21e2wU1H4xbS32augUKuzU1A51NQWB0oHsMgQP8AgBctPjF1peA
         EUiaAWiUNc/HhFRLolTHlI+lx+fFALJDIe3yTYvAixYuxubqNVhCcQQFdJ8gXnkv0q
         rxG4nG/ZQzYB6npp0lFwlTjq4GvKGxeBkWMtQVzc=
Received: by mail-qt1-f172.google.com with SMTP id y20so451512qtm.13;
        Thu, 06 Dec 2018 05:34:33 -0800 (PST)
X-Gm-Message-State: AA+aEWa/stq8Mlmj088X541ICNM+xeZceTSTF6fiSfoPLnZ/Xrebia8P
        LQEnYOlbam2aHnuK47wqZFNAGAA+/7+CZP52Pg==
X-Google-Smtp-Source: AFSGD/WMz6HaJ2c71Al6DS/WkKTMkdi1Wm/kJ9g79viEeAYh9z4otUggX3MLhuBcAD7eSuW4e6BiXEkYUkNgaGDianU=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr27099210qve.246.1544103272519;
 Thu, 06 Dec 2018 05:34:32 -0800 (PST)
MIME-Version: 1.0
References: <20181205195050.4759-33-robh@kernel.org> <CAGoOwPReuEgzgYng0YeffgejVKPcoQinnNeFu_f2QBgs5daGdg@mail.gmail.com>
In-Reply-To: <CAGoOwPReuEgzgYng0YeffgejVKPcoQinnNeFu_f2QBgs5daGdg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 6 Dec 2018 07:34:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJiQnQ0PgQz-G=Cj0-cEffMDx0H8vR7wjB25qwRWo-xRw@mail.gmail.com>
Message-ID: <CAL_JsqJiQnQ0PgQz-G=Cj0-cEffMDx0H8vR7wjB25qwRWo-xRw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Use of_node_name_eq for node name comparisons
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 7:53 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> Hi Rob,
>
> On Thu, Dec 6, 2018 at 3:51 AM Rob Herring <robh@kernel.org> wrote:
> >
> > Convert string compares of DT node names to use of_node_name_eq helper
> > instead. This removes direct access to the node name pointer.
> >
> > For the FSL ASoC card, the full node names appear to be "ssi", "esai",
> > and "sai", so there's not any reason to use strstr and of_node_name_eq
>
> I am not quite sure about the replacement of strstr.
> IIRC, a node name in fsl dts might appear to be "ssi@xxxx".

That will work fine. Unit-addresses are not part of the node name for
the comparison.

> I am currently out of town so cannot verify the patch.
>
> Fabio, would it be possible for you to run a boot test?
>
> Thanks
> Nicolin
