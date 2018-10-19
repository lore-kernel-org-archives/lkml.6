Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688CBECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC072087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XTho15XH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC072087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeJTEg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 00:36:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39608 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbeJTEg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 00:36:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id n14-v6so14328146lfe.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 13:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SbpGLHd52hfUE0LpFvB9t2mnaMK27KshyGUy3wuhBTk=;
        b=XTho15XH+xFgqddhDhxWefSZfej1vzIqL3GJ5uzg+XvTSBpYRfvAKmQinPxD7Mc4xn
         4yaPBiP3rCa4mIgwdxKLx0eO4S8dafxJVTKxuW0T30gwoNYp7Fte6iCBQcsZWi8TXMfr
         zzAVhYqtSIZPCQeFWZ+myeNIEl72pKQzmB8i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SbpGLHd52hfUE0LpFvB9t2mnaMK27KshyGUy3wuhBTk=;
        b=t8JBYAGWBxex4mGbPjpvE/mcGM7pr4YgJUWmU4ARap4sSqgaZedhRqWJ2MDDfKedhB
         NtHB/zksnhyafSDFIUC5/Ev5QZmkQTkuRCaWF+Ly19oqgfZsKHDi00IZGdsmYpAmhkJM
         mV+/D4Rt4Lf9/tosjZ8qZbJ6FWdKiAJ7tk1XUGhqVpGO5Dm0HlJJTqR9BlgdGbbxdVBW
         hibMMEJ9I4F25Sc6plwDWjeUR5QQ6cP2FLNuTcyS6cJzanJSIp3V8nPijWPR7oqUEPCh
         uaRUYzr/anlkGQcV5P8RaHGYisdQTFkk0XGEPTBZhROOoJSU2JUNhQvJhLGjwAS26ELl
         xNpw==
X-Gm-Message-State: ABuFfoiOYJjCYax3i+X8zOerfNFXV4wI8pBP4Ab9AtlHY/m9hmrNYfbh
        UelrHR/fE0pn8YSjWOsq44ZqWw==
X-Google-Smtp-Source: ACcGV61O4ctHteI6ChbcUs04CeFusEmZTDHhdyyTt6wN0XMxX+ZHlVrGXNRHa6PMf8oB9WBRE3DAPw==
X-Received: by 2002:a19:d0c2:: with SMTP id h185-v6mr3822169lfg.81.1539980927197;
        Fri, 19 Oct 2018 13:28:47 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id z25-v6sm1917939lfe.54.2018.10.19.13.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 13:28:46 -0700 (PDT)
Date:   Fri, 19 Oct 2018 23:28:44 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>, davem@davemloft.net,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: don't flush mcast
 entries while switch promisc mode
Message-ID: <20181019202843.GD3909@khorivan>
Mail-Followup-To: Grygorii Strashko <grygorii.strashko@ti.com>,
        davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181018180006.7065-1-ivan.khoronzhuk@linaro.org>
 <6c34a3ce-dbee-538e-bda7-8dd485315267@ti.com>
 <20181019120408.GA3909@khorivan>
 <36da9bb2-38b7-cc70-9569-8895e20c6d1f@ti.com>
 <20181019192453.GC3909@khorivan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181019192453.GC3909@khorivan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Grygorii,

On Fri, Oct 19, 2018 at 10:24:55PM +0300, Ivan Khoronzhuk wrote:
>On Fri, Oct 19, 2018 at 12:23:28PM -0500, Grygorii Strashko wrote:
>>
>>
>>On 10/19/18 7:04 AM, Ivan Khoronzhuk wrote:
>>>On Thu, Oct 18, 2018 at 07:03:06PM -0500, Grygorii Strashko wrote:
>>>>
>>>>
>>>>On 10/18/18 1:00 PM, Ivan Khoronzhuk wrote:
>>>>>No need now to flush mcast entries in switch mode while toggling to
>>>>>promiscuous mode. It's not needed as vlan reg_mcast = ALL_PORTS
>>>>>and mcast/vlan ports = ALL_PORTS, the same happening for vlan
>>>>>unreg_mcast, it's set to ALL_PORT_MASK just after calling promisc
>>>>>mode routine by calling set allmulti. I suppose main reason to flush
>>>>>them is to use unreg_mcast to receive all to host port. Thus, now, all
>>>>>mcast packets are received anyway and no reason to flush mcast entries
>>>>>unsafely, as they were synced with __dev_mc_sync() previously and are
>>>>>not restored. Another way is to _dev_mc_unsync() them, but no need.

I've sent new patch achiving the same but with second viariant described
in this cover letter. Please, look at it. No rush.

-- 
Regards,
Ivan Khoronzhuk
