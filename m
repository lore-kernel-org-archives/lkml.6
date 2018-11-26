Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E35C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E7E205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HtbO1A7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E7E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeK0HDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:03:20 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41184 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbeK0HDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:03:19 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so14583485lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 12:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KJMzzKN1BS/GizbeiG3GSikvDDOTZTohRjoUf482bow=;
        b=HtbO1A7Mgn4NIJghuzgeEtM0UTIDW2R9hd6XGQvooLTcjmy5OTmt8tFX81KZ1ru8OU
         oTh9HXVYktqFZG1J66O5BcwM/wDuT2HbuAAi3Eh/TbZkcF+sEYra3S3HXOmLNdAB42Hf
         bj0t6xtJmsGs8U5v/aHQQaX2BwfyTUjGeWmdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KJMzzKN1BS/GizbeiG3GSikvDDOTZTohRjoUf482bow=;
        b=Wp0687iYa/xOtHDLD9JE+v50Jc9xXtIgfWclJ42sIAmlhWnBUynP42joQcfGhYFIgL
         hcJ6EtaUHoeVagzSQGiAuSc6uALlUr6UlundjFFzSMByowyXkPuJ7L63H2ynwmwBaxy7
         bs88KtU8ZlUtHhIBzouoAtg5P5CXMPb8TIHjd1u8oLsOKmcDY1o8SslcS5KKyKL1DdB9
         8tJ9TklXeq/FuKMXgenWk+0bsPlxqt1+nouxF7lTIZ4YneUiF9D/piF5q5tAqtE68DHK
         o1dSeGmJjqEBO7pH7QbKQewFXvqK1QrVrcuIKExYSnXS9oA39QxSjXJXNz6LSySlUMRJ
         gjSw==
X-Gm-Message-State: AGRZ1gK1F4WQ5SdsHue5k8t7jSh7jg+GwOn4wHyqqATf5zwVyg6LSp3Q
        RtN+Qu9TBFcdFR6MVxgc6Z6/IA==
X-Google-Smtp-Source: AJdET5dW6N7OL1Uf5HhQXSGvoPr6VJ0Q2PWodPdRudpIuTR7iYwp8q1VF/Njy82+kdHeg7Wm5GU82g==
X-Received: by 2002:a19:4f0c:: with SMTP id d12mr16113802lfb.121.1543262883580;
        Mon, 26 Nov 2018 12:08:03 -0800 (PST)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id p138sm208869lfp.22.2018.11.26.12.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 12:08:01 -0800 (PST)
Date:   Mon, 26 Nov 2018 22:07:59 +0200
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: drop vid0
 configuration in dual_mac modey
Message-ID: <20181126200757.GB23230@khorivan>
Mail-Followup-To: Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
References: <20181125234626.28474-1-grygorii.strashko@ti.com>
 <20181126162644.GA23230@khorivan>
 <7f2c5e66-3b42-f921-c52d-236f5adc44bf@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f2c5e66-3b42-f921-c52d-236f5adc44bf@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 12:57:20PM -0600, Grygorii Strashko wrote:
>
>
>On 11/26/18 10:26 AM, Ivan Khoronzhuk wrote:
>> On Sun, Nov 25, 2018 at 05:46:26PM -0600, Grygorii Strashko wrote:
>>> In dual_mac mode CPSW driver uses vid1 and vid2 by default to implement
>>> dual mac mode wich are used to configure pvids for each external ports.
>>> But, historicaly, it also adds vid0 to ALE table and sets "untag" bits for both
>>> ext. ports. As result, it's imposible to use priority tagged packets in
>>> dual mac mode.
>>>
>>> Hence, drop vid0 configuration in dual mac mode as it's not required for dual
>>> mac mode functionality and, this way, make it possible to use priority
>>> tagged packet in dual mac mode.
>> So, now it's enabled to be added via regular ndo.
>> I have similar change in mind, but was going to send it after
>> mcast/ucast, and - enabling same vlans patch...
>>
>> 2 things stopped me to add this:
>>
>> 1) Moving it to be enabled via regular call is Ok, but in dual mac mode
>> it causes overlaps, at least while vid deletion. So decided to wait till
>> same vlans series is applied.
>
>TI driver documentation mentions this restriction
>"While adding VLAN id to the eth interfaces,
>same VLAN id should not be added in both interfaces which will lead to VLAN
>forwarding and act as switch"
It's not accurate now.
This sw bug "acting like a switch" was fixed indirectly in LKML ).
And at least for upstream version, not TISDK, desc should be updated,
but better do this when it fixed completely and merged with TISDK.

I know about this "written" restriction
(for tiSDK, and it's not TRM after all ...),
it can be avoided and it's partly avoided now ...

Also, for notice, while you add any of the vlans to any of
the ports, vlan0 is added to both of them.....restricted it or not.
Thanks to last changes in the driver it's not "acting like a switch"
The patch in question enables this in ndo, not me.

#ip link add link eth0 name eth0.400 type vlan id 400
[  326.538989] 8021q: 802.1Q VLAN Support v1.8
[  326.543217] 8021q: adding VLAN 0 to HW filter on device eth0
[  326.554645] 8021q: adding VLAN 0 to HW filter on device eth1
[  326.572236] net eth0: Adding vlanid 400 to vlan filter

I just propose to extend it later, when it's correct to do.
But if no harm (basically no harm, only if someone decides
to add vlan0 to both ports and then delete on one of them)
, at least you should take this into account.

>
>>
>> 2) Wanted implement somehow similar handling for single port boards
>> in one patch, not only for dual mac mode. This part was not clear and
>> not verified completely...
>>
>> So, if it's needed now, maybe better at this moment only remove
>> untag field? and remove vlan0 later, once other vlan changes applied.
>>
>> Say:
>>
>> cpsw_ale_add_vlan(cpsw->ale, cpsw->data.default_vlan,
>>            ALE_ALL_PORTS, 0, ALE_ALL_PORTS, 0);
>>
>> instead of:
>> cpsw_ale_add_vlan(cpsw->ale, cpsw->data.default_vlan,
>>            ALE_ALL_PORTS, ALE_ALL_PORTS, 0, 0);
>>
>
>This patch affects only dual_mac mode and in this mode adding vid0 by default is
>definitely make no sense in any case.
The above proposition is only to your change, only for dual-mac.

>
>>>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>> ---
>>> drivers/net/ethernet/ti/cpsw.c | 7 ++-----
>>> 1 file changed, 2 insertions(+), 5 deletions(-)
>-- 
>regards,
>-grygorii

-- 
Regards,
Ivan Khoronzhuk
