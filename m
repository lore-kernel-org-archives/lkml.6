Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181CCC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70612086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70612086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeIDNnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:43:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36687 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeIDNnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:43:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id f4-v6so2678511edq.3;
        Tue, 04 Sep 2018 02:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UtBXIq3/zVs4PB9Gi6YmgNjsPbtGgVCK6BPT3hI6w6c=;
        b=QquslnEp1NCoOXWtHKYWkq6wii3UzSkS4KGODNr9sVc/llvcN6NZFi6Hmwv6IoJRJp
         t7ZZuwSljUC/OnVjygELav/7cjKYmgmzKjO2pYuvgbFM3LSZeeU8ZmoQZoputioXRcHH
         i2SPZl05f8VZ8XhG1C9YGTVfRIXq00Tokb/5r4POuGqZTza4++iILKOkSBcfsSrRm3tm
         ZVYt6cj+LWuztSavo3RyAlyD6SoAdHY2xDb77c9WJ/0DGPyFQ6zGMAfNSFc39VadVgr5
         Mv0E3PdGnKsTgsiI9+fq6GvVIrnWfkGFt87A7s0C6+0hRVIMZIGN9I6Dc2B8Uisnaj8N
         tcrg==
X-Gm-Message-State: APzg51DrK04tvwjjchwMCzlZ8tY1mS93FAH/OqK2YnYQGgLYOJC37mE6
        Aj7A01a5HQaL2mkkbZ7FYSrr458fScg=
X-Google-Smtp-Source: ANB0VdaqSBYAmu8OfSyZmobXJ9kM/xhju/OK0WQkLKST5cwlUwjtJzUCgX39F4t7qMuFc46mEo3MKQ==
X-Received: by 2002:a50:e40d:: with SMTP id d13-v6mr36186675edm.263.1536052741757;
        Tue, 04 Sep 2018 02:19:01 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id 25-v6sm11291463edz.45.2018.09.04.02.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 02:19:01 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id a108-v6so3099549wrc.13;
        Tue, 04 Sep 2018 02:19:01 -0700 (PDT)
X-Received: by 2002:adf:f906:: with SMTP id b6-v6mr7266973wrr.28.1536052740892;
 Tue, 04 Sep 2018 02:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net> <20180902072643.4917-6-jernej.skrabec@siol.net>
In-Reply-To: <20180902072643.4917-6-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 4 Sep 2018 17:18:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v64Y0ui6ZvAJqc2dXMKtSSQJ-T4ubrV9188JTV7aFSrFCA@mail.gmail.com>
Message-ID: <CAGb2v64Y0ui6ZvAJqc2dXMKtSSQJ-T4ubrV9188JTV7aFSrFCA@mail.gmail.com>
Subject: Re: [PATCH 05/27] clk: sunxi-ng: Use u64 for calculation of NM rate
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> Allwinner H6 SoC has multiplier N range between 1 and 254. Since parent
> rate is 24MHz, intermediate result when calculating final rate easily
> overflows 32 bit variable.
>
> Because of that, introduce function for calculating clock rate which
> uses 64 bit variable for intermediate result.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

The code looks good. The A80's Video PLLs are also affected by this.
The range for N on the A80 is 12 ~ 255.

Can you add fixes and stable tags?

ChenYu
