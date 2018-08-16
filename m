Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0043C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F243208AD
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSGuiHyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F243208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbeHPWiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:38:03 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53639 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbeHPWiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:38:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so5498956wmh.3;
        Thu, 16 Aug 2018 12:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EOomyM8+CFscMDL/FtVrbfedSmCw2XhfclDbxVuU84k=;
        b=QSGuiHyRrbqDBtLPWME1dtWTHCYv928M8yDYKc4rZx0M4hYCkkCJSvG/4BPrRNLQGy
         V0QGya1NF97HrAf+1XW/H1lfmdln0+par1RugYT3djyIo3aYLq6kIoWfpssePUJedDYW
         MR8847GjigzkdTTE7sBX0RiCPD94Q7N96dYJIiJHBX5OcT56abirMLDUjbEhOrwqpFbY
         usZFGkCbdey92IeT6FfcZuEPAQW2vcSKStkOgAcRKJBCv0YzNlkcksXdlOfPwN3dIdEP
         IAzJHy1wUEqsCZ6A+bzMfmk6w0t7XKP30kV0Uq1xogzcec03830KmOIrdgIH+h1hGrR/
         epOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EOomyM8+CFscMDL/FtVrbfedSmCw2XhfclDbxVuU84k=;
        b=HQgGPAMOB/sUUWKssBzQRrBkgmNaJZDxg7JNyRRRiigmvOb31Gn4rpCZ2F2msX2c++
         RTmxNSS0iUBxeXiHU7uX6GCA1d8fMohQNnxiQrtDPFFEp84aSwGsTUz8fPCPWfZyqcv/
         sZj6/P80C6vYVW6DpzP9K7lvrAJpY8iORRbhu3J4yoGEvjav+VNG0DtRaNj+fV9vCfyj
         y1jne32WVYIvQWATtdW2DHi38cjGsMlKbSqhSOAKxMBloKFn6TVBefzdBHwTkmOTF7wS
         TUxLy93mzq8eidawkyL8/7BeAwjXzKgMMF0HuYVuwCCTRmGgeXii5UNdas7dnhIpoYwN
         59Xg==
X-Gm-Message-State: AOUpUlFyCz5qLI/WnXgAieonpy41MolX7E1wW0eHLsCNDAMcsPHG4GBh
        W7/b6bWVUDk/TOtT48nELZVydq32
X-Google-Smtp-Source: AA+uWPyB7BloZ1IjC76RLI5F7p8qOz+P1nV5W29J4b43pp9U1BJMSMYnS1liAckC7ItLEftq6A880g==
X-Received: by 2002:a1c:b213:: with SMTP id b19-v6mr16146489wmf.141.1534448259305;
        Thu, 16 Aug 2018 12:37:39 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:fce9:ceca:5c9:a793? (p200300EA8BD4D600FCE9CECA05C9A793.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:fce9:ceca:5c9:a793])
        by smtp.googlemail.com with ESMTPSA id r140-v6sm4213270wmd.7.2018.08.16.12.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 12:37:38 -0700 (PDT)
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
To:     David Miller <davem@davemloft.net>, jian-hong@endlessm.com
Cc:     nic_swsd@realtek.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com
References: <20180815062110.16155-1-jian-hong@endlessm.com>
 <20180816.122131.604270853620318143.davem@davemloft.net>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <458efbf9-5971-653a-e7cd-8c56ba055648@gmail.com>
Date:   Thu, 16 Aug 2018 21:37:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180816.122131.604270853620318143.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.2018 21:21, David Miller wrote:
> From: <jian-hong@endlessm.com>
> Date: Wed, 15 Aug 2018 14:21:10 +0800
> 
>> Found the ethernet network on ASUS X441UAR doesn't come back on resume
>> from suspend when using MSI-X.  The chip is RTL8106e - version 39.
> 
> Heiner, please take a look at this.
> 
> You recently disabled MSI-X on RTL8168g for similar reasons.
> 
> Now that we've seen two chips like this, maybe there is some other
> problem afoot.
> 
Thanks for the hint. I saw it already and just contacted Realtek
whether they are aware of any MSI-X issues with particular chip
versions. With the chip versions I have access to MSI-X works fine.

There's also the theoretical option that the issues are caused by
broken BIOS's. But so far only chip versions have been reported
which are very similar, at least with regard to version number
(2x VER_40, 1x VER_39). So they may share some buggy component.

Let's see whether Realtek can provide some hint.
If more chip versions are reported having problems with MSI-X,
then we could switch to a whitelist or disable MSI-X in general.

Heiner

> Thanks.
> 

