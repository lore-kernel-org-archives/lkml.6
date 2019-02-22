Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B841AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9207420700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfBVQbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:31:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37477 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfBVQbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 11:31:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id c8so3041222wrs.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 08:31:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nTAIsF0yXHVS2Fg6dE1M9fRUBDDYagLdBmolwf+Nja0=;
        b=OUJSBW3vyYR865pBkPyQrf6yE5wRFeFUkWxj6IB5NUj1t00AHroBy2oXnxoJmEK4SU
         10DA3zsrsRq45zmK9JUWn1ARUMepk/67sH3Cm/mVwHxVluIDUGERue5XNgW1fz7y+tMA
         Yd4R9vGGxhlgkZT1NIvh3K+JS3P++2RZO0WkxLZocertQ5tCdyDbuTO7EpE1Mcs+9LSj
         OYkZjgaC5jewIDltLuiGEqekiHwQKKpIaTIH/ZbIuXv464hoZghjOd/3QTTZJE4ryAtm
         otI8+5lk+DrrPypyTfSDkOPeXQ8nHa3JVNY6HlYN7hvtjKfiDIqXbZNwO8ORmM4eMvPd
         IrHA==
X-Gm-Message-State: AHQUAuZPIENnafUkwPbQJ/JDFjAiLiRYOlgctWA0vKF/pH71kM5QJQrr
        LnKbPU4XFIe6V2Of2FL0my4eCnSabFw=
X-Google-Smtp-Source: AHgI3IbH7x08RQiUQMrGpdz9EAWvt0nQZsmj73IKP2xi5E7nb5TrVv5Qn2DaxB1tUq5AmUK+j/XdTg==
X-Received: by 2002:adf:fd46:: with SMTP id h6mr3541469wrs.170.1550853095209;
        Fri, 22 Feb 2019 08:31:35 -0800 (PST)
Received: from dhcp-44-202.space.revspace.nl ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id i10sm2415873wrx.54.2019.02.22.08.31.33
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 08:31:34 -0800 (PST)
Subject: Re: [PATCH 0/2] platform/x86: intel_cht_int33fe: Start using software
 nodes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190219115959.55553-1-heikki.krogerus@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d0e10d6f-efb5-0139-d6c9-edb66c97c0b6@redhat.com>
Date:   Fri, 22 Feb 2019 17:31:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190219115959.55553-1-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/19/19 12:59 PM, Heikki Krogerus wrote:
> Hi guys,
> 
> The software nodes support node hierarchy. By using them with fusb302
> we can add a separate fwnode also for the USB connector as a child of
> fusb302. We can then use the "standard" USB connector device
> properties with the connector node, and stop using the deprecated
> fusb302 specific properties.
> 
> Since the goal is to ultimately move to the software node API from the
> old device property API, converting also max17047 in this series.
> 
> If you test this now (before v5.1-rc1 is out), then the series depends
> Greg's latest usb-next:
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/log/?h=usb-next
> 
> and on a patch in Rafael's latest linux-next branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=344798206f171c5abea7ab1f9762fa526d7f539d

Interesting series, I like the direction this is heading in.

Question, I currently have this hack to test DP over Type-C on the
GPD-pocket / GPD-win:

https://github.com/jwrdegoede/linux-sunxi/commit/f481b7032030dcdda1ccc39875eb59f996d3e775

Do this properly we need to add alt-modes support for usb-c-connector nodes to:
Documentation/devicetree/bindings/connector/usb-connector.txt

Do you have any ideas for what the binding this should look like, we need to
specify a svid, mode and vdo tripple in this case. Maybe use an u32 array
with 3, 6, 9, ... entries depending on how much alt-modes the fwnode needs to
specify ?

Regards,

Hans


