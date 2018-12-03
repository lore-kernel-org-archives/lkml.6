Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36A3C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD7720864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZNj2O9PF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD7720864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeLCWit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:38:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37786 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbeLCWis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:38:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so7208725plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=gcEANpm6IyLrQJyUoSOHUgWNmtpCovZ8ca5EgDqLNvY=;
        b=ZNj2O9PFGLl4zit9lRL/2x5uBOvqEiof8YOy1rvWYP7CcAJLcu4N6LZdEzQJ6lQNcO
         UmrnW0jYOOXa5zsPCezCUUPdDXPmHgQh8TnUVwBTylN/Ht4cezLPMvQVgufbyVUFFFVP
         hh9/4OGyPZZwBlECDh8JT9IEGkxJ/SyEtJzNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=gcEANpm6IyLrQJyUoSOHUgWNmtpCovZ8ca5EgDqLNvY=;
        b=B82I/KdcTDUixZb5OHVeglFHM7V3L0hZasYrMdCgbcBFHPOgKnowtK2ZB4bbFYwXTp
         K7xspkl47l3UV2oXR9jbm4+gU85sle1klOcnQ0a2A7pMUbP2bmz7H7lXRjyu8joDyURK
         9b5OuSfCrhyRioDQPX32Q4epJGBRJ2dla8up2UyXQPG9rNCAPL9S4EQKfIjFj/YYDylm
         Fbf6uq5VjhiRZzvt7rDebgZ6oC9ZWH1rv0WFC0FQ2PcfcLevWfQsCfpI716lgsl85Wci
         hPK3ooqD1nIK5OmrPFajL4bImJJ8Dj2rFMKgLr85AltiAHJnXlQdGK5I5rjgdZ5Hh5+z
         b14Q==
X-Gm-Message-State: AA+aEWbnb9d55cA87GCbtDTjE/8JFXiw8437CG01OpU+qyv5c5yppQPH
        Op3twr30mUdIybkbJgTMOJat+Q==
X-Google-Smtp-Source: AFSGD/XP09ibj2By5ofgCjDVz5aTWX6av+n9QSBtMt2HTRBwRJXxpoQh6JsEd+FGIt2C55LfoXXSkQ==
X-Received: by 2002:a17:902:8e8a:: with SMTP id bg10mr17815585plb.192.1543876728450;
        Mon, 03 Dec 2018 14:38:48 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id l85sm38211657pfg.161.2018.12.03.14.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 14:38:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181129221357.67417-5-evgreen@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh@kernel.org>, Can Guo <cang@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>
References: <20181129221357.67417-1-evgreen@chromium.org>
 <20181129221357.67417-5-evgreen@chromium.org>
Message-ID: <154387672722.88331.10663388522762144439@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 4/4] phy: qcom-qmp: Expose provided clocks to DT
Date:   Mon, 03 Dec 2018 14:38:47 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2018-11-29 14:13:57)
> Register a simple clock provider for the PHY pipe clock sources so that
> device tree users can point at these clocks via phandles to the lane
> nodes.
> =

> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

