Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7164CC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 10:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186A6217CE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 10:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="lwV87Vjo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186A6217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeHDMqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 08:46:23 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:35191 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbeHDMqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 08:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CQtI1CvcneBmbgMnFmRBQ8DBLmVsBp11DbWWQ+ped8s=; b=lwV87VjoZpf0I7NW/8GA6qz/Ph
        dt/yO1YfVtE57Q0sLe9+MRIRx/zUyy05EmgD13CfHSYvr5LcPk6kHa3vN5hP3hbq9zNCX0HQcYYld
        2kPMR7D47ty4UCAF7HXWdAR2BJZX/3QMSpyxTX6m/oBasysV9t2aFYEheP0z1qFGqxQBL+02+kbWn
        2EjoWXCU5RyrKvRFtLWCrROlKvh5Rt22Fk68GECYpAn66cfsKdQF+t/fU//uJrMXU+9he0ziCXl4J
        02MQMgSBbfrFID6mIaRXrSDNK04C8juVHOIxYF85cTxcl4uJEGdB1A061c+t+y+cRYk0QOK1qrp+E
        Gbj/+1/w==;
Received: from dsl-hkibng22-54faa2-250.dhcp.inet.fi ([84.250.162.250])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1flu4D-0002Xd-Ib; Sat, 04 Aug 2018 13:45:49 +0300
Subject: Re: [PATCH v3 3/8] mailbox: Add transmit done by blocking option
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        ", linux-arm-kernel"@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        srv_heupstream <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-4-mperttunen@nvidia.com>
 <CABb+yY0_dKC_cYFwwb-aeRgrx=sjv=8VLP=C6DJEecFf=v+mkQ@mail.gmail.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <907bac36-0c54-8f38-0f5e-f59196d414c6@kapsi.fi>
Date:   Sat, 4 Aug 2018 13:45:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CABb+yY0_dKC_cYFwwb-aeRgrx=sjv=8VLP=C6DJEecFf=v+mkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 84.250.162.250
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 03:54 PM, Jassi Brar wrote:
> On Mon, Jul 2, 2018 at 5:10 PM, Mikko Perttunen <mperttunen@nvidia.com> wrote:
>> Add a new TXDONE option, TXDONE_BY_BLOCK. With this option, the
>> send_data function of the mailbox driver is expected to block until
>> the message has been sent. The new option is used with the Tegra
>> Combined UART driver to minimize unnecessary overhead when transmitting
>> data.
>>
> 1) TXDONE_BY_BLOCK flag :-
>          Have you tried setting the flag mbox_chan->mbox_client->tx_block ?

No - I suppose I should have done that. I'm a bit concerned about 
overhead as send_data may be called thousands of times per second, so I 
tried to make it as close as possible to the downstream driver that just 
pokes the mailbox register directly.

> 
> 2) Implementing TEGRA_HSP_MBOX_TYPE_SM :-
>         In mailbox framework, a controller is a collection of identical
> channels. That is, instances of the same class.
>         So ideally, in probe you should populate a controller for each
> type of channel, i.e, DB, SM, SS and AS.

Hmm, yes, I guess this would be possible if I change the mailbox core to 
allow registering multiple controllers per device.

Thanks!
Mikko

> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
