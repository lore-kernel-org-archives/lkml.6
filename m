Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4C1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D6D2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQ/uqDju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfAVTY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:24:28 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34754 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfAVTY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:24:27 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so11961658plz.1;
        Tue, 22 Jan 2019 11:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CYoPfVUaYOVeGlZzNLpRMOk55RsIHsvW5d3Mbhz/Nxc=;
        b=nQ/uqDjuX7gK/5rffN3L5T51OVcluBH/u26HP0yHTpbGDwTx2pudahsSLV1xjCP0xw
         TdMI1WjBDZ0CAGqY74ZZfBp3Kz5bcKMXuc4MihgbaR4tl/EdLyS5vzUuFvECXYN23PpA
         AmG0PWbTkwlrcAuiYea3npBHfEfr6hF+b1RrdlTAueel7nijizJj2/tch4JanJJUBKoH
         qDUxvvG5U9XVVuC/rpk5epX043TcqBvb7TGn5wNPpEPAN1QRGfDpAr84/u9O3+jfHMum
         R/IwJAAOx+7jI4QT19RDH6eDL3N7k1cSgTVukBb+t3H4PVU/h7aDQjXQBheLb/PXuR0L
         u+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CYoPfVUaYOVeGlZzNLpRMOk55RsIHsvW5d3Mbhz/Nxc=;
        b=JUkEJXfO9JhLFrwyxCtWncR7+oiWwMA3I2Ii2BA5yYjV519TKnmK46NEHfNQH0EgA2
         ebSw7kwefvmKYb4nSJLIWOwtVhFoYXwj1qEodzl2WSDskeGaVNh72X95sj/J9fPDUeK6
         m5jNl5jqUf4G77Dgy+4QizG641iMW4xPsyL5QotZyg21MhVfG1WsDT4igzjj1b8vF7SN
         If16aki8Zj8yAtLxg9QV65qYa3/cIEKveqY4/JID/zwTtgSByonbJOtDoVy15ZPFdcva
         FZOWyZnKRSJEUVd0l+efR3dsYGdZ/WSmLY64s9XNSyVwrW17hQFd+DGngC5NXqMWhGF/
         NWlg==
X-Gm-Message-State: AJcUukfcYsdQvDc22EnuuRcYmN7I6WoF5muFsLXFNT2G3tjluviMoxDS
        R0EcvyD4m4claHkpmhPaXWE=
X-Google-Smtp-Source: ALg8bN4K8EeA0WSPatK77Wafq9eRAv4K2zjavtuID2bHeoDOPTJe3vCDZgrZQ2X8T/3lvYMQmhjhyQ==
X-Received: by 2002:a17:902:4601:: with SMTP id o1mr35568764pld.243.1548185066814;
        Tue, 22 Jan 2019 11:24:26 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q1sm22325078pfb.96.2019.01.22.11.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 11:24:26 -0800 (PST)
Date:   Tue, 22 Jan 2019 11:24:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/111] 4.20.4-stable review
Message-ID: <20190122192425.GC2224@roeck-us.net>
References: <20190121122455.819406896@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 02:41:54PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.4 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan 23 12:23:56 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter
