Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D036DC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887BC22540
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PO8dDQpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887BC22540
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934156AbeGFSJ3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:09:29 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37796 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934048AbeGFSJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:09:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id h20-v6so9044138pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 11:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8APCaDQmvgHfVUNMYRrWGZcrrA9ekA9Anra8k1sTqg4=;
        b=PO8dDQpYzK5HMJhyW4ttrIU3qZQ+OxpnN+LFFJkPQbWQC2kCMSZYTTKYRgB7jSOak0
         uGnNZZo2qQIRb+8b9zn53hx898ylZk9onrVgKlu+wH5WlkVLMP+JKpMqxPYEDRAcazzz
         yuA1ojcCQqp818XGslzGQI+Pt5kxFNM/1jb1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8APCaDQmvgHfVUNMYRrWGZcrrA9ekA9Anra8k1sTqg4=;
        b=ZsJ5Td1nku/g6EZX9fVlZu/9xYN6BmoDLop3itwUPLnKw4TJtzSFq006DVTx5+sQg1
         alIh0R5H8QEG4yeCaWoH3lI9XccQeKPJuiZcewa469RSiAFlbdaJ7THjHnY57JypocYO
         EdPbIoL5zFM7Bm1vYGjvvz+v/EYh6rIuVlqlEcFeQ9IaVXjLhd8FfoemcSA79pjeXAyc
         j3Ft9foxm9YervkHPLBxJqKd8810mQ4dI8TDZ3XR+o4f9EmyAR7tNa79WqsSTObseKeI
         j29NXEs76oCJ81BFy9UwgLuGt/J3wartNxATLWQ1RaV0vQt27pw/KydM7Y91yhtxOnHQ
         0d2g==
X-Gm-Message-State: APt69E3xKzpwzJUJBF02DUHgaHWQUTibTL4U1g+WchgjFbpnHMcRIvIC
        txpr4KH6hc1evxmMp7Gw0HL2KA==
X-Google-Smtp-Source: AAOMgpegfZz/+xr/q26/Xvp7bStLM7hMec75qj/lff1XUBIzplVPtNFvtYMMtbBzAEls7ClKSMjfFw==
X-Received: by 2002:a62:2785:: with SMTP id n127-v6mr11639517pfn.129.1530900564956;
        Fri, 06 Jul 2018 11:09:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id k71-v6sm22545422pga.62.2018.07.06.11.09.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 11:09:24 -0700 (PDT)
Date:   Fri, 6 Jul 2018 11:09:23 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 07/12] PM / devfreq: export devfreq_class
Message-ID: <20180706180923.GH129942@google.com>
References: <20180703234705.227473-1-mka@chromium.org>
 <CGME20180703234837epcas5p1da751e0394c16816b95ac1956bf6de20@epcas5p1.samsung.com>
 <20180703234705.227473-8-mka@chromium.org>
 <5B3C5B78.6020401@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B3C5B78.6020401@samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 04, 2018 at 02:30:32PM +0900, Chanwoo Choi wrote:

> I didn't see any framework which exporting the class instance.
> It is very dangerous. Unknown device drivers is able to reset
> the 'devfreq_class' instance. I can't agree this approach.

While I agree that it is potential dangerous it is actually a common
practice to export the class:

grep "extern struct class " include/linux/ -R
include/linux/rio.h:extern struct class rio_mport_class;
include/linux/tty.h:extern struct class *tty_class;
include/linux/fb.h:extern struct class *fb_class;
include/linux/ide.h:extern struct class *ide_port_class;
include/linux/device.h:extern struct class * __must_check __class_create(struct module *owner,
include/linux/devfreq.h:extern struct class *devfreq_class;
include/linux/switchtec.h:extern struct class *switchtec_class;
include/linux/input.h:extern struct class input_class;
include/linux/genhd.h:extern struct class block_class;
include/linux/power_supply.h:extern struct class *power_supply_class;
include/linux/rtc.h:extern struct class *rtc_class;

struct class_interface and class_interface_register() would be
pointless without exported classes.

My understanding is that the kernel is often lax on encapsulation and
exposes private/delicate data pragmatically within the kernel when
needed because "the kernel trusts itself".

Thanks

Matthias
