Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD01C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8FE21759
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="BL9qDU68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8FE21759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbeHCOdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:33:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37147 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbeHCOdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:33:54 -0400
Received: by mail-lf1-f68.google.com with SMTP id j8-v6so3946303lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 05:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gh6p0KJdfRQjsfA6TAi38fge0rfft8FJKDYZzw10xAw=;
        b=BL9qDU68P1YF9126tMzmPMRcwDVjvvWMbQb8FlxH8j/H0iu1+xfNmdkWoiDtjuhBXi
         D4j5lC+35A4XFetrjfM0B3xHz0ZgSoU8mg8gEHKHcNPM1MeAqOIaF1jsRF5kqQBCQMIz
         kLFMyETA8+N/am6FeEdPCnR3g/xpClyFiqAkOg9eMgYp+B79peQ6p14mT+CvwtCAtdY6
         si7U3IqmgXoDdJkp0Eh1OMl9lEXlK1yPiaot0squijmypLATTWpAOMxMFYsvJZuL9Mmt
         0CB8E5NDllbB4upUq0ifyRuNrteNVfv6mRcafbF430zGAnJ1wKNiWj4UDK+BdCWte7jx
         98Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gh6p0KJdfRQjsfA6TAi38fge0rfft8FJKDYZzw10xAw=;
        b=TNv19ny8k78hdRaZqOEcO9y0slJZvXYBcKYxTXg2fNsYgVzj7h5PU+BUYPzsNh09me
         xjqbxVhNQ7I5VwhPugtw1vDvJY1Srv4lwfMmCjuoudvZtyt2cpie+XEueCd9gDyH8+1Y
         Vd6WDcFW+xO8hDUWuQqU6tPu9QSa2NxyIEn0n4repFr9f0ZQoPtz/jpuBw0EEPBFyZfh
         11+dM5QElFTH5M0O0FLbvroIfM+OOn+Hgti3VaHEqk2rTgdCnWje7SNkQARMNLOhj12g
         tFoIR+Ead2AjUzC9NuTH9hR+D7QIy3TWG09nWISChwq181N3p1HPNqgn9XzkxpdS7zIZ
         RGvQ==
X-Gm-Message-State: AOUpUlFtLBPbKw0BPYwYTn4JYGxlHLJRbKKY1h3IUkkiky7I8172wsgH
        fWp7BUMN5lWCfCdfm/JmpgrxDJ5gSMaC+w==
X-Google-Smtp-Source: AAOMgpeglgHfA4DAESWMt9tnU8upOFjIekYu3HexGhv3gb2oBX7s9Vnf1rTV0hoRPqcczpRH5q3iTg==
X-Received: by 2002:a19:c64c:: with SMTP id w73-v6mr4821247lff.2.1533299863408;
        Fri, 03 Aug 2018 05:37:43 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id j17-v6sm706771lfb.27.2018.08.03.05.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 05:37:42 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: move device L2P detection to core
To:     javier@cnexlabs.com
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180803085449.3436-1-mb@lightnvm.io>
 <31319710-8A72-49DC-9CFA-521CA06843F3@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <9349be00-4d14-9b25-ed11-fb9244428d7f@lightnvm.io>
Date:   Fri, 3 Aug 2018 14:37:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <31319710-8A72-49DC-9CFA-521CA06843F3@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 02:16 PM, Javier Gonzalez wrote:
>> On 3 Aug 2018, at 10.54, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> A 1.2 device is able to manage the logical to physical mapping
>> table internally or leave it to the host.
>>
>> A target only supports one of those approaches, and therefore must
>> check on initialization. Move this check to core to avoid each target
>> implement the check.
>>
>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>> ---
> 
> 
> I see where you want to go with these changes, but the way targets are
> layered on top of the LightNVM subsystem does not align with it.
> LightNVM can support different OCSSD versions and capabilities, but that
> does not mean that a target (e.g., pblk) does. The way I see it, core
> should only check for (i) the drive to expose itself in a known revision
> and (ii) the reported structures to be consistent. However, specific
> functionality is not for core to check upo.

Why try to initialize a target, if we already know that it is incompatible?


