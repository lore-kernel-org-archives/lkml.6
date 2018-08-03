Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4890C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9EB21707
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/btPmzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9EB21707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbeHCDP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 23:15:29 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:34210 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729765AbeHCDP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 23:15:29 -0400
Received: by mail-pg1-f182.google.com with SMTP id y5-v6so2046034pgv.1;
        Thu, 02 Aug 2018 18:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nWpiy2E6FI/4nUo2GghCa9UgehehRyfKV+OhP10TV3s=;
        b=m/btPmzJ2sXHi4h46QKJk2gFahZMN99k7hZ/HEdi07zkEHYSZ4IDQ5ALrSWrRLyGkp
         XNXJw8Z89R6DehLUPP/flgIs+VNeNa3U+B0uv7Ni+NofLI/a4oLzJkSPoW4FDcsCUW0y
         xvaoWwGzIPJUCY1TlNDJZ+Fwk3eY94BJfBO9l80TuKN6KEzZkaSknzNje7cW2LGwlyoK
         KxzhWbAYKQ7eCqokh+myY42Psw61n/CwHltlUvln5plJLGrEZ766jx2LuFMiAlRcGS4t
         49EfcuOdc+qMaKWk6x6s3BfXMng66Od5xUP78Ip2AktwNyLwK1ebR7ryT5nlsmZLUC2j
         guIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpiy2E6FI/4nUo2GghCa9UgehehRyfKV+OhP10TV3s=;
        b=Y7TQrm/PJPMhnTnhXxQ1hNHDxhcSODX7AHRx0pIHpl/Tu1QfvHcnsTnmFXehBJCAR6
         +Y3qOnFIWrZQgA1UM98950aei2Nj/qAYx8q/sVxVL+ZnBgaLQ1YgWwQCqXzzLRaiLTX3
         WeTz8xHPT8+yw3bDeictGNJ6ZxXJZQfFLtGu6vKbkmQWBBpDcFM9b4aWODmcFGV3LdBT
         e1BG14pf+TS2qDulfMJRaDB53cnrw6PJ0rUSlxOcCetmzbES4Impl136jEpDgQGVd/Ei
         eoYNCEIwjIUjWyfyMhc86VZZw4mte3uq+LAVNEeDHNvhyKgD8lAMQWV4CJSbj9C6Wl/K
         6nlA==
X-Gm-Message-State: AOUpUlFhaWcLTA3PBIkPaEzB6vDOvufyP8rYbcPUuqwgZ20M+ezhFc9p
        BLSO8NcpFtzI8aFavGcpFsWeNC+t
X-Google-Smtp-Source: AAOMgpfrHz7auw5MdQ04GZ40aofQ4SSpiUjZlNGWCSUitQHrOtXVLZOUtl8aSPukRv68ars6JgG/Tg==
X-Received: by 2002:a62:571b:: with SMTP id l27-v6mr1967101pfb.29.1533259302442;
        Thu, 02 Aug 2018 18:21:42 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c1-v6sm7922740pfg.25.2018.08.02.18.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 18:21:41 -0700 (PDT)
Subject: Re: [PATCH 4.14 000/246] 4.14.60-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180801165011.700991984@linuxfoundation.org>
 <20180802154325.GB5137@roeck-us.net> <20180802182517.GA24531@roeck-us.net>
 <20180802190946.GA25832@roeck-us.net> <20180802194135.GA13901@kroah.com>
 <20180802194536.GA22671@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <387e5d1c-431f-869e-43b2-c33e60bcbfdb@roeck-us.net>
Date:   Thu, 2 Aug 2018 18:21:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802194536.GA22671@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 12:45 PM, Greg Kroah-Hartman wrote:
[ ... ]
> 
> I've pushed out -rc2 releases for all of these with that patch removed.
> 

Boot tests with updated images passed for all three releases.

Guenter
