Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE79C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282BE20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JmO+KDze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282BE20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbeIFTHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:07:50 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38852 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729910AbeIFTHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:07:50 -0400
Received: by mail-it0-f67.google.com with SMTP id p129-v6so14396137ite.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 07:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qjNTOM+gt5HE2HN1An+A0pNgsPjUWTfzv7KpbLlaTYI=;
        b=JmO+KDzeF65xcUfcBHCce5jhybPE91zcujuqeC23eV3QAY/ifpI+GojYQFxobbHQPA
         zwHLc20QrURs+JNgxLnQqxDpmVyG7UGWj2Z6sqntpxrWgTDb/EUufTpsQBHvs+VZgNBD
         2UfWc1gcEgQCBIj3r7czvOI+uIQeaSP9wRSKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjNTOM+gt5HE2HN1An+A0pNgsPjUWTfzv7KpbLlaTYI=;
        b=OPJ/uLRC8otqKDanz64n/I50m5e22UGjM449w1DwNcXEBQFx1JcKCofmZg2LMmc/ij
         6ShPYlRTiyxzJRQFxrVQkcaWBJh5+f6Mnmv/nJiIDjiW7hvZ0K93DbvGSb08e7uad9Oo
         ILWCP9WbGn1iVhmqpgeOvYSnUXChuYbP0muvj+5lLdPBAZnwpgieOaNfyCtXmtv8arjp
         Txl6TeLOzboNw1z2ZYobysg5nvNjTyWkad0qMw7T/9Qnv6jwgLvFFLrkBIeoVPysz1PP
         9GdDyJojqWtU9/D7Tb5rBgICBC3tfavH7zD+GlcwIDPrz8WgZjKRrjylnKPNZn9tCkDx
         2q1Q==
X-Gm-Message-State: APzg51CVVkZj/xuOSEfkusAlEtjlJszHA/2WLbR/Yz/hb0MVhxESII1i
        tJOP/sC3D2mNpMGW2ogwyVqEuLxObZZcoycXiT+OZg==
X-Google-Smtp-Source: ANB0VdbEq56fnnq05Px4axpUfgCn06xmxtVgFvXq921zKCv1toHKXHu8SZdZoRqrTGd/qWoV9ZkYfWNsGGI/Deqb2J8=
X-Received: by 2002:a24:6b0d:: with SMTP id v13-v6mr3011819itc.16.1536244321305;
 Thu, 06 Sep 2018 07:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdaHabhD_pW3XtDh+XzQ3d--r=qNRZVnhx44RV82p0boMA@mail.gmail.com>
 <20180906133348.brzvqt53nzukn7n2@kili.mountain>
In-Reply-To: <20180906133348.brzvqt53nzukn7n2@kili.mountain>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 Sep 2018 16:31:49 +0200
Message-ID: <CACRpkdakEX+3aknFj8f7q97bqQvZXDqaRNG8wqFG4bWBb=tPmg@mail.gmail.com>
Subject: Re: [PATCH] gpio: ep93xx: fix test for end of loop
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Colin King <colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 3:34 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The problem is that if port == ARRAY_SIZE() and "gc == &epg->gc[port]"
> then that should be treated as invalid.
>
> Fixes: fd935fc421e7 ("gpio: ep93xx: Do not pingpong irq numbers")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch applied!

Yours,
Linus Walleij
