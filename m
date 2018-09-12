Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA55C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEDF2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HAOheMTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEDF2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeIMDoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 23:44:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37558 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbeIMDoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 23:44:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id 2-v6so1766294pgo.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UuEbWsLz0v062afWfq+nsqqhLCTaadSe9wrZgCzU820=;
        b=HAOheMTtdnqid6dCsdH9hRonwx5gNXqYAV1HJGr9L4oW5UIYabtbknv5hAw/OI8jW5
         u3GMhefMoDmwnuJxyD0yy96YqhQwEZKBsB058DmZUtACZ18b3hH20lUOvXLEj6yA6byU
         D/couD6rSihwJ5+l6JYNeIqkx+PdfFmylrLn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UuEbWsLz0v062afWfq+nsqqhLCTaadSe9wrZgCzU820=;
        b=azDmhXGcw7NBs5PnSGaZ6pys8kITG6hg45JWAFKjUxaXTPoqybnAP456ITROFVl0/D
         NpGk7S60lv8cRli810PXzXvoEiGQSa5WcrvfN/GFOKa+kpnIOmknsJX+q3MHSPfx7CTE
         q+poz1zQ/9hHqDEkUuOU9phi0E7dalExjN3PeLgJHHVT0YEy0iKu2jtB/wUf1ToGBqG5
         xkVwAHNrYfkMvltt8hjMcRsuk6Ou+4EKJLsugPLxda3kA15/UrWfPntnCyJt8CvoNuqg
         0JQeTHTWlKCJ17Y5VYobh/6Yf0LJuBuEOXzVgqFrlrrzBGrAkbumj2k3y1I74SXa/mJr
         illA==
X-Gm-Message-State: APzg51Bn7HyeR6KaxGxhSxSlSsDq9eg1vlAMT1SwwoRWynorVgF95ORT
        Ve+npNIgyCMOCyMkV0SVe6b+EQ==
X-Google-Smtp-Source: ANB0VdadZRyx6gXpYcr64j/8qxO0XCAcRcEyjgikw5uE8R+OcPm9FsbaOgg/E4QI3LVOQQy5cpTyXQ==
X-Received: by 2002:a62:9541:: with SMTP id p62-v6mr4592503pfd.194.1536791877562;
        Wed, 12 Sep 2018 15:37:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id h69-v6sm5605577pfh.13.2018.09.12.15.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 15:37:56 -0700 (PDT)
Date:   Wed, 12 Sep 2018 15:37:56 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Raju P L S S S N <rplsssn@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org
Subject: Re: [PATCH v2 5/6] drivers: qcom: rpmh-rsc: write PDC data
Message-ID: <20180912223756.GL22824@google.com>
References: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
 <1532685889-31345-6-git-send-email-rplsssn@codeaurora.org>
 <20180912222809.GK22824@google.com>
 <20180912223356.GA11079@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180912223356.GA11079@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 04:33:56PM -0600, Lina Iyer wrote:
> On Wed, Sep 12 2018 at 16:28 -0600, Matthias Kaehlcke wrote:
> > On Fri, Jul 27, 2018 at 03:34:48PM +0530, Raju P L S S S N wrote:
> > > From: Lina Iyer <ilina@codeaurora.org>
> > > 
> > > The Power Domain Controller can be programmed to wakeup the RSC and
> > > setup the resources back in the active state, before the processor is
> > > woken up by a timer interrupt. The wakeup value from the timer hardware
> > > can be copied to the PDC which has its own timer and is in an always-on
> > > power domain. Programming the wakeup value is done through a separate
> > > register on the RSC.
> > > 
> > > Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> > > Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> > > ---
> > > Changes in v2:
> > >    - Remove unnecessary EXPORT_SYMBOL
> > > ---
> > 
> > > +int rpmh_rsc_write_pdc_data(struct rsc_drv *drv, const struct tcs_request *msg)
> > > +{
> > > +	int i;
> > > +	void __iomem *addr = drv->base + RSC_PDC_DRV_DATA;
> > > +
> > > +	if (!msg || !msg->cmds || msg->num_cmds != RSC_PDC_DATA_SIZE)
> > > +		return -EINVAL;
> > 
> > Is it really always exactly 2 (RSC_PDC_DATA_SIZE) commands?
> > 
> Yes, always.

Thanks for the confirmation!

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
