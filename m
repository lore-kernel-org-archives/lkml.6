Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19D4C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E68205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YydaRDj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E68205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJ1WHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 18:07:22 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:53224 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeJ1WHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 18:07:21 -0400
Received: by mail-wm1-f53.google.com with SMTP id 189-v6so5601155wmw.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VGMBkqQepJaIK5hp9KrXbnrCZGgU0IlaIV5TBSqeg4c=;
        b=YydaRDj0WS7gri+D5Wmx+GgGSo9iSseoxLI9yYwGrAWMbV3/4zpS4qQoe0+ZYaJ1+R
         54HDJdhViJ4e7BUmGja/F5MA4OKr/qwLcra7+w1yQutzAs/g1OBJgPKfMg35fGtRg3rs
         A6462birjKOug9gTypnKzcmM0dp+BuaUOvGTnKyOQSkg6X4XrYew+ozqAOQi34ErBc8M
         eFWQfaxxq++x4vwfRXr5NTEMjjZaqcg033IrIB+3yA1ZkePbsKepOveCrLLxjXUNJNfa
         4o1HsG/d/pY9s17TGqD5htCa233luEBuCELLnmxJ34hxBaV8erO0idsBGZtnyiw4k9X7
         Z+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VGMBkqQepJaIK5hp9KrXbnrCZGgU0IlaIV5TBSqeg4c=;
        b=lTN40iMjsaKLP5LpE/gLOQmIDKWrzTEO/uoDLPHcEUraSUDl7nWWzfQgx1oKWIC2S2
         GAVmjYNuogTZmItfzf60gNDkOVEiT9TFATNBs87dXrnSgXW3YUK6Afvh729SYp+Xb40S
         kg8WSwSHzdGYFLOdANQldBL8b4mZaShDi+mZXNYaJYigSkGaOCSmAH1UBxgGfAQ/La9r
         8h9yrM4kE/ki8g2NFq2Y2EMx9VwmzyhV/yy7AT+6y9nCQkh8hID58S6vTBtXOKY8oyzg
         L1v027qVmNbp0sT4D9Yt9DWKSe2BW6YyhDB8IavLxXQ4ZWA93bnU3q1CTDuW2qR4X336
         /LpQ==
X-Gm-Message-State: AGRZ1gL4hQqKcX+Snbf3HBk2nBLy89AAdWhKi0Pwl63e43cAteJzSRJ4
        bCqqCIexn1QVEJkuhYQjIXm2n7sI
X-Google-Smtp-Source: AJdET5eG17d2C6RXnkAj9R6onUTZjD1YGy3aL4q+yfKQTArdMwuOVUhZQqInbyvlMB0eLpZOZgIw3g==
X-Received: by 2002:a1c:85d0:: with SMTP id h199-v6mr10748865wmd.127.1540732961945;
        Sun, 28 Oct 2018 06:22:41 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:bc68:3d44:305d:951f? ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id x12-v6sm30777376wmd.32.2018.10.28.06.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 06:22:41 -0700 (PDT)
Subject: Re: Which SPDX Identifier for files without explicit GPL version
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <406c69c1-43fd-f821-b74b-a1399ed636e9@gmail.com>
 <20181028112728.GD8826@kroah.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <f1aa3ce0-7e68-ce7e-e2a3-a978bcc36e03@gmail.com>
Date:   Sun, 28 Oct 2018 14:22:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181028112728.GD8826@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/18 12:27 PM, Greg Kroah-Hartman wrote:
> On Sun, Oct 28, 2018 at 11:04:06AM +0100, Michael Straube wrote:
>> Hi,
>>
>> which GPL version should be used in SPDX Identifiers for files that
>> are GPL licensed but do not mention any version? It is not clear to
>> me after reading license-rules.rst.
>>
>> For example:
>>
>> /******************************************************************************
>>   * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
>>   *
>>   * This program is distributed in the hope that it will be useful, but WITHOUT
>>   * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>>   * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>>   * more details.
>>   *
>>   * The full GNU General Public License is included in this distribution in the
>>   * file called LICENSE.
> 
> Perhaps look up what version of the GPL that was originally contained in
> the tarball that this driver was bundled with?  I think that should be
> on their website somewhere...
> 
> If not, it's v1, not a good thing, but all we have to go on.  Also, try
> emailing:
> 
>>   * Contact Information:
>>   * wlanfae <wlanfae@realtek.com>
> 
> That address :)
> 
> thanks,
> 
> greg k-h
> 

Ah, there is a file 'license' in the root directory of this driver (rtl8192e)
that I overlooked. It contains GPLv2. So v2 applies to all files with the above
shortened boiler plate?

Thanks,
Michael


  
