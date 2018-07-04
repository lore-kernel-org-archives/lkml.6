Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21DEC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11A822526
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HntODKFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11A822526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeGDPOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:14:40 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33861 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752193AbeGDPNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:13:22 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so11356539ois.1;
        Wed, 04 Jul 2018 08:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=443fSwYZ9H8AddF/cp4SIl/5HftCEObh4vfDLn1TR+g=;
        b=HntODKFfgyT0X0ImANRgx2HYYvaqKsHoR8anIyhkk96rLjUi4OuuZItVMQDvjH9Fz7
         X7C/naEAEYv8sEl6fgLTWN3LtzD93sjlbg/Sgkwse4yMOA/sI2Q+302EKo0NysgnA8vQ
         s6tRLIFHErWol9z8w6aK979y+qUJp4lAPl1eTez2UfGqratAWcmvY6hbUvw40EHee8Ka
         UHA8pI02oSWQF8Gn6eJFOyycLdR8OsIh8ZOxucQQavYZNyyOo+eQP3R7k9fNHIkK+ifv
         J+OAkbqwIT5yiJQvLlBbqktYwCJBlMc7PjfPHEJkR1mOOWkk5eXyaoRY9fQSfcX4exXB
         Ahlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=443fSwYZ9H8AddF/cp4SIl/5HftCEObh4vfDLn1TR+g=;
        b=O7oBOf6N3GfNXRCV8fHOqHrwgRA/SxCIkN0+iNiZRj17eo6dflY0UabUsjpF/lKV1/
         7x918PvdpItn3GQzgr868oIaK9mwQ+jwm7JYUfexIvJGySX7GzkW7KZvCIN3oY4zXG7+
         MsBLa1n4wbmuAC8+il660CTvAzaBYcchOjoqgv0yZ0sa7Fd6DXOiu17JXAe0MEjejmdw
         CLOPw5lJJfyA8dIwI2nGBsQsEr86RoaDhUU1jjbwl1aYvrJX9x6gH5p4Y/63M+Az58cQ
         wVLiP6OImyje3L5TRJ4sUPWmRo+wJfru0q2a+EY19oHpkCVRflCclHodZsRKBgQZQv1M
         d9aw==
X-Gm-Message-State: APt69E38xwps5dsHM9mR+L5rrZpcKa2xveV74EgUN0zomsch9lh8ktIm
        g+YUTufaj/Ln8Fi5aHQyatc=
X-Google-Smtp-Source: AAOMgpePypWk2s+vcdg/PjLA1OLei7Q8HD50LBFzyOXWW125vM/LMVoHdfBij1xtE/Fsw7cGD3VXbQ==
X-Received: by 2002:aca:f516:: with SMTP id t22-v6mr2865330oih.56.1530717201994;
        Wed, 04 Jul 2018 08:13:21 -0700 (PDT)
Received: from [192.168.1.107] (cpe-24-31-253-228.kc.res.rr.com. [24.31.253.228])
        by smtp.gmail.com with ESMTPSA id 97-v6sm1807071oth.15.2018.07.04.08.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 08:13:21 -0700 (PDT)
Subject: Re: [BUG] staging: r8822be: RTL8822be can't find any wireless AP
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        devel@driverdev.osuosl.org, Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Colin Ian King <colin.king@canonical.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <CAPpJ_ed1oFQW_xmBtetP-ztoL7Z14T6akOSgKJ_8jxogdf3FWg@mail.gmail.com>
 <f3bf0687-76fb-9411-6fa2-e8ef312efb58@lwfinger.net>
 <20180704140933.3dk2ylbntltz6jqd@mwanda>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <7e95bd6a-97bc-b030-26ce-83da66e5f279@lwfinger.net>
Date:   Wed, 4 Jul 2018 10:13:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180704140933.3dk2ylbntltz6jqd@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2018 09:09 AM, Dan Carpenter wrote:
> On Wed, Jul 04, 2018 at 08:55:00AM -0500, Larry Finger wrote:
>> I do not think this is a bug.
> 
> It's obviously a bug.  The driver should just work by default.
> 
> As a last resort, we would do something like add quirk or something.  I
> haven't looked at how quirks would be handled for this driver but grep
> for quirk to see how other drivers do it.

We will have to agree to disagree.

I have no idea what the vendors are doing that cause some motherboards to need a 
different aspm value. What I do know is that we have had to live with the idiocy 
of some vendors saving a few pennies by only including a single antenna, rather 
than two, and then making a problem by miscoding the EFUSE bit that indicates 
which connector is actually in use. As we have no means that I know about to 
detect which boxes have the problem, a module parameter was created, just as in 
this case.

I agree that drivers should work "out of the box", but finite resources and lack 
of vendor cooperation make this a goal that may not be attainable.

Larry
