Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C07C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7785420821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I54IRyGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7785420821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeLJUgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:36:15 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47074 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbeLJUgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:36:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so5489318pgp.13;
        Mon, 10 Dec 2018 12:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JORjAZbRn7zRYyCYKv9bu4UjvfIRFZK7OjCFytWdjgk=;
        b=I54IRyGorAjQfA2YERuZp3FdOLKygcPwBHtWTCmedDRVyblfXAOUc1jhMVPea9C/Li
         IleU7/yCjQ4xw34BrCcE7zuuvxHX6V5iIWpCAwehhr27Bp3aPfITEGbIUh1N5hmN44LN
         CFNWWiJdDMbekWJkk35HZzT6QkG4lISOnnNygk05ig3C0bfx7Sf81eMnQt5GW+49Aq1N
         hb7NAeU8Z7uYc6oFZTiWCNla5EFKHfTZeDkNDSXsP7CzpIue1MB7CjxOxUJXeOD7Yj6S
         tWh110+YnnGwhtqs4tCctGJwoJq5UzUH4dlxrUrqzJ5v+a9RjiQ9/Qx5TEe/EXywXvPb
         yU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JORjAZbRn7zRYyCYKv9bu4UjvfIRFZK7OjCFytWdjgk=;
        b=SDqxv/qXMDSqCaIh6iNkbhXhUbbmqWgLRUThu3VgGTHp2Git7z6CV+eANx+XybTnT9
         E5E8deX2cp3kmjlJLfVHiRcSnolL7lZXTsAnRqn5owk9CBDem95LrqDrvKLapnUnAHSu
         Py0VsVUudPZ0WA4emR8TPaCukRF0o/9DK035YvTJkX3SddQyBx/X4A6ZXu2FhTB2yz2j
         l3XpbzvssQz23S3NILjfAvWote+jc+qa+ezBnXqAoSV65OAuEf4xYsii7mqTF6AxVTkg
         sa2/6agtqNUbHCZx8OUafXT87LrwRHELX+O5rxppjidNfs/VXjw94klyHh1n5Wlk7XcI
         L65Q==
X-Gm-Message-State: AA+aEWY8MNr8aJq25bswASpAWhbBOhANti8RmjMIO/qsN06HuQ0aIu+8
        0ajFg/1Ce/uZm7qL83b5x+lwYVV+
X-Google-Smtp-Source: AFSGD/UH1yz+qoDjKAW1aH8DwvIZVSgvJx94sXt00VTLB+qaKmK/YFdC6asD/Th64ySS40ZpZocF2g==
X-Received: by 2002:a62:109b:: with SMTP id 27mr13399291pfq.227.1544474174288;
        Mon, 10 Dec 2018 12:36:14 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m76sm17634981pfi.102.2018.12.10.12.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 12:36:13 -0800 (PST)
Date:   Mon, 10 Dec 2018 12:36:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH 3.16 000/328] 3.16.62-rc1 review
Message-ID: <20181210203611.GA15708@roeck-us.net>
References: <lsq.1544392232.713909046@decadent.org.uk>
 <20181210165414.GA25566@roeck-us.net>
 <d17c45bcaf44c02fa716c2dc862119278e0262ca.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d17c45bcaf44c02fa716c2dc862119278e0262ca.camel@decadent.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 07:06:41PM +0000, Ben Hutchings wrote:
> On Mon, 2018-12-10 at 08:54 -0800, Guenter Roeck wrote:
> > On Sun, Dec 09, 2018 at 09:50:32PM +0000, Ben Hutchings wrote:
> > > This is the start of the stable review cycle for the 3.16.62 release.
> > > There are 328 patches in this series, which will be posted as responses
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Fri Dec 14 18:00:00 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > 
> > Build results:
> > 	total: 136 pass: 135 fail: 1
> 
> This is the i386 perf build which never succeeded yet, right?
> 

Correct. Should I disable the test ?

> > Failed builds: 
> > 	i386:tools/perf 
> > Qemu test results:
> > 	total: 219 pass: 219 fail: 0
> > 
> > Details are available at https://kerneltests.org/builders/.
> 
> Thanks for checking.
> 
My pleasure.

Thanks,
Guenter
