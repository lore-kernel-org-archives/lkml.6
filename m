Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E948C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8262173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mhNP8+g0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfAGSGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:06:30 -0500
Received: from pb-sasl21.pobox.com ([173.228.157.49]:62531 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfAGSGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:06:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-sasl21.pobox.com (Postfix) with ESMTP id CF59028E8C;
        Mon,  7 Jan 2019 13:06:27 -0500 (EST)
        (envelope-from mlord@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=5QiOn+WftsD6
        VShHjldCuBpNdQ8=; b=mhNP8+g0HHeTYyzfF6El/vCmfX0X42i6AEiHIMU/fDM3
        ojjROZyfuBsiMn+k7Ry+OX9GHRYS4F4cGFznLBlgvXlQAYOqBYTsVDr3I3xFuwCk
        mRTBDlVbvM2ESgmdp0kHFOAaPcZ1s9SVFS0MNspGZ29kJIJsg5SuKgP7hkJf5Ls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GiWtg8
        o0jwLNFa19dvi+oMC7WCHzepBNseM9lQux1QRSrD+o5c1f+vSgzZEnWQ66dTur7s
        K5KDHZKImkXh9z85CPlw/32RGkB2teORqirHhXz0etOAniSx83g20SKg6wpBRZcz
        26LDmv+qmDMZNkz1jveaO8tMDy8oL+EvgCOgI=
Received: from pb-sasl21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-sasl21.pobox.com (Postfix) with ESMTP id BAD3228E8B;
        Mon,  7 Jan 2019 13:06:27 -0500 (EST)
        (envelope-from mlord@pobox.com)
Received: from [10.0.0.9] (unknown [24.53.240.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-sasl21.pobox.com (Postfix) with ESMTPSA id 3628A28E88;
        Mon,  7 Jan 2019 13:06:24 -0500 (EST)
        (envelope-from mlord@pobox.com)
Subject: Re: r8152: data corruption in various scenarios
To:     Mario.Limonciello@dell.com, hayeswang@realtek.com,
        kai.heng.feng@canonical.com
Cc:     aatteka@nicira.com, davem@davemloft.net, greg@kroah.com,
        romieu@fr.zoreil.com, netdev@vger.kernel.org, nic_swsd@realtek.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        ryankao@realtek.com
References: <ed0c9790-57be-8bca-cdd6-3a54ca24f0bd@pobox.com>
 <20161125095350.GA20653@kroah.com>
 <1816ec7e-2733-f4ba-5d30-29dbabd20aad@pobox.com>
 <20161125.115827.2014848246966159357.davem@davemloft.net>
 <0835B3720019904CB8F7AA43166CEEB201057793@RTITMBSV03.realtek.com.tw>
 <CAA=3Oqn5_5w+vrg9_7UtZ-5BEbZ9Pm=qdX3WoVZKaAkxcMXYXA@mail.gmail.com>
 <469a41ea-e97c-23d2-d129-68aad5585fec@pobox.com>
 <3D7273C4-D378-42D5-92FA-4ED72041D820@canonical.com>
 <1726a1ef-cfa7-0f97-4388-bf2ba72cb9a9@pobox.com>
 <31f145b8-4518-122c-eab8-50ed1075ba55@pobox.com>
 <0835B3720019904CB8F7AA43166CEEB2D38781F2@RTITMBSVM03.realtek.com.tw>
 <92e9ddd8a05a493bbb1f5ac4828c2f2a@ausx13mpc120.AMER.DELL.COM>
From:   Mark Lord <mlord@pobox.com>
Message-ID: <0e7fce67-a88e-4245-ae4e-c218bfbea12f@pobox.com>
Date:   Mon, 7 Jan 2019 13:06:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <92e9ddd8a05a493bbb1f5ac4828c2f2a@ausx13mpc120.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: F266BCB4-12A6-11E9-85A0-B0A4589248B8-82205200!pb-sasl21.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-07 11:01 a.m., Mario.Limonciello@dell.com wrote:
>
> TB16 contains ASMedia host controller.  It's a Thunderbolt dock and all USB devices
> are connected to ASMedia host controller in the dock.
> 
> WD15 does not contain an ASMedia host controller, it connected to system's
> USB host controller.


Thank-you, Mario.

So.. why are we enabling the r8153 (USB-ethernet) workaround on this WD15 dock?
The discussion back in 2017 was that only the TB15/TB16 were affected by
the XHCI overruns it produces?

-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
