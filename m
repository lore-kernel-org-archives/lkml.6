Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1285CC4646D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF67D217CC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="FqW41dqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF67D217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbeHECO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 22:14:27 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:37681 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbeHECO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 22:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Hu9KPv3W5tD7+gCVZok4D9ZZNHx7jk3+i/fUW739RZY=; b=FqW41dqy+jVm0480dTKQTksFLk
        /im4TBG99nVuTfegmzx4D+fJP3GlFyOFRxeT8Zz+y/1P6J66cOTRJXBwJiKL10ip64cPOOJZs3H55
        G+6ykTKUJ+N5ilIR6ttcApuPCEygtzjn8WbubwkobzvLJ2u3Oz7LR+49yCzGjjcb7z+QIv+UiTGY/
        4mQ3sOSIJd4XhxWjRQR2/2I63yRdzXjvWI5h71cdcOjO4fC+IKaFfrDOmniFe9V1ZTRPHjjF81X6M
        1S22SuEmScUKzKAxyTFp9QPSH2zVsAsfXLq2f6a2N0FnUX1ruxg/WP+dLOtFM86X5gcQy8lWK1+5h
        YFRHyehQ==;
Received: from dsl-hkibng22-54faa2-250.dhcp.inet.fi ([84.250.162.250])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1fm6eM-0008Rk-3P; Sun, 05 Aug 2018 03:11:58 +0300
Subject: Re: [RFC PATCH v1] memory: tegra: Block DMA for clients HW on a
 faulty memory access
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180508165841.13758-1-digetx@gmail.com>
 <2607799.I2xByD6lqT@dimapc>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <89f0794e-affa-dba0-9684-582ce5570cad@kapsi.fi>
Date:   Sun, 5 Aug 2018 03:11:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2607799.I2xByD6lqT@dimapc>
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

One potential issue is with host1x clients where userspace processes can 
submit jobs with invalid memory accesses (addresses not mapped to 
IOMMU). If when such a failure happens, we disable the DMA for the whole 
host1x client, unrelated userspace processes may see failures even 
though there is no problem with their jobs.

Mikko

On 08/04/2018 02:53 PM, Dmitry Osipenko wrote:
> On Tuesday, 8 May 2018 19:58:41 MSK Dmitry Osipenko wrote:
>> Currently Memory Controller informs about erroneous memory accesses done
>> by memory clients and that's it. Let's make it to block whole HW unit
>> that corresponds to the misbehaving memory client in order to try to avoid
>> memory corruptions and to stop deliberate attempts of manipulation by a
>> misbehaving client.
> 
> Guys, any comments? That is a kinda useful feature, in worst case only some of
> memory could get corrupted instead of trashing the whole memory. In my
> experience with T20/30, the interrupt handling latency is low and blocking
> happens immediately after the first page fault.
> 
> 
> 
