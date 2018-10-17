Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006C7ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3A02087A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5aHUN1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3A02087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeJREI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:08:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38762 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeJREI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:08:58 -0400
Received: by mail-lf1-f68.google.com with SMTP id x24-v6so5065505lfe.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o9j9NhQ9M5pm5+MLhmitP4FiK2z4+Y4Sgl8y9b7kcf8=;
        b=E5aHUN1u3DE2VZQV6cezJDVIWxyPk1woC+1C0YMEMWxfAtpSRIazzjP6LbWywRCvv2
         klviNs2eOHRC0ORbvY0mOxr1Ql+VitUWUnic82UwiElnHgYn0ROwj6zTR2XRtvkZiwBD
         dIkLL/RjR8AOGvPpvm5m4RogSduYXXN4v35IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=o9j9NhQ9M5pm5+MLhmitP4FiK2z4+Y4Sgl8y9b7kcf8=;
        b=kPinVAxMaGsJWLcu5I55Jhtl/T8qWP5AZ8cjSYT3U98hK0jZ1QtYnxmj9Fk0TeGwX/
         vjyzCAncBMuwLaKi4Aopkfm1L41EjUwlmgdgpoZHsNn6+eQJ2KnyePweuImCDfSgqr1H
         2w0NlDKy4YoQd6lUAfsl4/RlKbQ/uzNbLDLCcIk84A4SH9cAHzNpBfz5URtO9X2DZ4B1
         NcbDhzP4iVuVmh1CiSP6XpdzEeKmgHq9L/vQvoNDmHzUhhdJ4dAHy38ZCmHkTxMxVRmu
         UkjweDO7cy+yhVZsLdnQ0Ae+8LRsXM7GTafpRFQwAfEpEVQV+Sm6dM8dqcmqMMi6IlBY
         mYgw==
X-Gm-Message-State: ABuFfoilWlMwKhq6ZrBRFRJp2pRyGRMzxEhURlIzJjo8WSoEe5n5cWm7
        6yroVLBJIctcZ7LGTMkoy0fiAA==
X-Google-Smtp-Source: ACcGV61aBMw2Ic47Le3dLhB2933u8edSWmh5+p7e33J//vuGgl4+x47OX1KJUt/5D/2h0+1ZgYGqUg==
X-Received: by 2002:a19:505a:: with SMTP id z26-v6mr7899789lfj.120.1539807098230;
        Wed, 17 Oct 2018 13:11:38 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id a23-v6sm4075491ljj.1.2018.10.17.13.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 13:11:37 -0700 (PDT)
Date:   Wed, 17 Oct 2018 23:11:35 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexander.h.duyck@intel.com
Subject: Re: [RFC PATCH net-next 0/4] net: ethernet: ti: cpsw: fix vlan mcast
Message-ID: <20181017201133.GA13816@khorivan>
Mail-Followup-To: Grygorii Strashko <grygorii.strashko@ti.com>,
        davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexander.h.duyck@intel.com
References: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
 <92ab4728-109f-01cc-09db-3da4d8c8e92e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <92ab4728-109f-01cc-09db-3da4d8c8e92e@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 02:38:33PM -0500, Grygorii Strashko wrote:
>
>
>On 10/16/2018 01:20 PM, Ivan Khoronzhuk wrote:
>>The cpsw holds separate mcast entires for vlan entries. At this moment
>>driver adds only not vlan mcast addresses, omitting vlan/mcast entries.
>>As result mcast for vlans doesn't work. It can be fixed by adding same
>>mcast entries for every created vlan, but this patchseries uses more
>>sophisticated way and allows to create mcast entries only for vlans
>>that really require it. Generic functions from this series can be
>>reused for fixing vlan and macvlan unicast.
>
>I assume this is first of all for dual_mac mode.
Mainly yes, but affects on switch mode also (and single port) adding
appropriate mcast entries.

-- Regards,
Ivan Khoronzhuk
