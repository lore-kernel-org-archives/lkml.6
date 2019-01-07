Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62311C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD4320881
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i9ieEyBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfAGHG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:06:57 -0500
Received: from pb-sasl1.pobox.com ([64.147.108.66]:63156 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfAGHG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:06:56 -0500
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Jan 2019 02:06:54 EST
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-sasl1.pobox.com (Postfix) with ESMTP id 350AF1163D3;
        Mon,  7 Jan 2019 02:01:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=XxYZqe2yWsYy
        0gbE7TWuTePldKg=; b=i9ieEyBsfn+zZvSuyMKgtUrw9WgTrnQqNAQJ2xwUHMG+
        HyEDVQ6k7/QbwbyFhAd3e9qhlJqKIjshF4grOAdkkppWmblDoksPV66rcdzNxg9B
        52IEdSDhXV1FiftPgQCOKopE811qFsDnSMRkMmtyDqVuw141RUvBDR5n82vnNyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hFjnYb
        wnkSp5OmCKH9ZRU0XFXKsu6PfKtxpYNee63BjhYUVAih9xxSrzERYNQTTRBQBhzm
        KJa60wO60RqjoiKWmDXSf9wVZXkhSIggo8/SC2Gvos3ItAZjVFq7M5vTu4pS+4I1
        VEXP6hQ4qDDpv1Xlh+15QnICQJZfztbD7SqZ4=
Received: from pb-sasl1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-sasl1.pobox.com (Postfix) with ESMTP id 1105E1163D1;
        Mon,  7 Jan 2019 02:01:22 -0500 (EST)
Received: from [10.0.0.9] (unknown [24.53.240.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-sasl1.pobox.com (Postfix) with ESMTPSA id 0B80B1163CE;
        Mon,  7 Jan 2019 02:01:21 -0500 (EST)
Subject: Re: r8152: data corruption in various scenarios
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     Ansis Atteka <aatteka@nicira.com>,
        Hayes Wang <hayeswang@realtek.com>,
        David Miller <davem@davemloft.net>,
        "greg@kroah.com" <greg@kroah.com>,
        "romieu@fr.zoreil.com" <romieu@fr.zoreil.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        nic_swsd <nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
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
 <3F1015D1-B2B5-4A2B-87EC-8AB2A516A2F1@canonical.com>
 <2ed9c380-c299-586e-a036-49cdf0387766@pobox.com>
 <E9946B82-6F51-404E-8A72-C24CB5E7A7BA@canonical.com>
From:   Mark Lord <mlord@pobox.com>
Message-ID: <fe7cbb44-a7a5-8de8-6a98-1508da92d130@pobox.com>
Date:   Mon, 7 Jan 2019 02:01:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <E9946B82-6F51-404E-8A72-C24CB5E7A7BA@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: 09ED469E-124A-11E9-A8ED-6E125F1924B7-82205200!pb-sasl1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-07 1:46 a.m., Kai Heng Feng wrote:
>
> Do you happen to use a Dell system? We can do some test here.

Yes.  It is a Dell XPS 13 9360 i7-8550U notebook,
with the Dell WD15 USB-C dock.

-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
