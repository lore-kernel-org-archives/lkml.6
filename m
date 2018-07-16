Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60A1ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F67620BED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCBcehDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F67620BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbeGPM2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:28:52 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43372 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbeGPM2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:28:52 -0400
Received: by mail-lf0-f66.google.com with SMTP id m12-v6so32009313lfc.10;
        Mon, 16 Jul 2018 05:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ugeVYcuv3uKU4dkNZvrENO71mE3YJcSdZ7517fE3+6k=;
        b=kCBcehDqxCcIuN3ZyozctU3U1u9aktzKb96ORSeXGs56K/0nev4UlQDrc2reAxUDtJ
         btnbbQSV28+utzTu6+M26+m91eUauT4h025Qorugxo02rOTizQjONZjIYKD8TaQVQVQ7
         DT0FJw8HeIdJEp+BTNMAVZWsTVGIKaYgYQHUagCwaC8aIztghMRs3ogUYqAvT2Jm9eLB
         DEVrg598VlF8SEKk4TUfrKGVoWBrx/E3JZmXUqIfZviC5e+4iz16tXgFCzfjP4nwTn5W
         x+ccqqitW9KQJIAlbZJ1XfWtAJAImIx97+kixEpYnanJL8/3ID5cysfan24V6Di34k2h
         J8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ugeVYcuv3uKU4dkNZvrENO71mE3YJcSdZ7517fE3+6k=;
        b=fOO62O9sO4F36a6xXpZ5Hn3PRuQbO1yu47D98IUgneedWG0JdpeqnuLPs5ITj5tWhM
         +7owop6larAQ7afL/TCuhXAQHapmpt+RHWXWzA/m0N2WiKaEzoCTGOs67tfK7Kz2ijfF
         IMlt/axQ6KEgzTS6Qtvy+WZSeYg6ulOyD1sv3qAwGq5DTFVogmGYDqxRTRcwrKD1PiuA
         lSke0TUi2zZle4xE69ZJl4xLSu7+c0wvOqMyIirlymVKL1S04w19J+Wbya4Ydl6A7ap0
         NerULGO8hIHYAyzw+PwydBxWQ8Xl0dVtsfQ7v/WyVskrLDaIyy9KZby8GthVnNhDml21
         my0Q==
X-Gm-Message-State: AOUpUlEySRuTzQNAnUrPFpRwWZ426BDqwgysUKLHDUyK1j0pQnhFGqiM
        PAx3QOsdsz0OnfvB8ZeDPy4=
X-Google-Smtp-Source: AAOMgpf5HUN07s4CpvTHTUoxbbB1LXymaiTBYYh5tYECYELDmvLAmoEemWpeOZu1ZOnh4R9cKNImEQ==
X-Received: by 2002:a19:4344:: with SMTP id m4-v6mr12238968lfj.111.1531742503456;
        Mon, 16 Jul 2018 05:01:43 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id 36-v6sm717820lja.65.2018.07.16.05.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 05:01:42 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ff2C6-0007e0-LI; Mon, 16 Jul 2018 14:01:34 +0200
Date:   Mon, 16 Jul 2018 14:01:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] regulator: qcom_spmi: Fix warning Bad of_node_put()
Message-ID: <20180716120134.GL10204@localhost>
References: <20180716113525.9335-1-niklas.cassel@linaro.org>
 <20180716113525.9335-2-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716113525.9335-2-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

On Mon, Jul 16, 2018 at 01:35:22PM +0200, Niklas Cassel wrote:
> For of_find_node_by_name(), you typically pass what the previous call
> returned. Therefore, of_find_node_by_name() increases the refcount of
> the returned node, and decreases the refcount of the node passed as the
> first argument.
> 
> However, in this case we don't pass what the previous call returned,
> so we have to increase the refcount of the first argument to compensate.

I don't think this is the right fix. of_find_node_by_name() should
generally not be used by drivers in the first place as it searches the
entire tree and can end up matching an entirely unrelated node.

I haven't looked at the device-tree binding in question, but you
probably want to use something like of_get_child_by_name() instead.

Johan
