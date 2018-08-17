Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E491AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C5A218DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="xaA3IK+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C5A218DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prjkt.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeHQRDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:03:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45175 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeHQRDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:03:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so3551091pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 06:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:disposition-notification-to:return-receipt-to:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :subject:to:cc:from:message-id;
        bh=MqmQQftCsfTP9NTI693S5qR/U4721ALjfnvaRGZrKJA=;
        b=xaA3IK+2szEyXttPJ08YwQdP/DNllpqEuegdxPEdGe/sPuAAJPU77skdx7hf+d2OtL
         zZzmigonjZE2kRUcRtO5IfAowf7xxtDRSZxC0II2BxjzuUWZ06ZtI7tr0B3MkDa5A4ax
         7Paby97Mv9enRsAkVvJgDiein5ChHVHRdALFkA63astmaJT0qAiwdEMQdYtYrZrrDD8t
         0fe/7oLXoaAcdyBl4KocyAQ+9KQBqpp+rOxkuTeVrPohKKfpDYuP8jl2CJ6+GcBnR1YH
         k2M0LEmnEQ9DiECNJ36ofpPuMp9E4S7FhUJV/JjF18fc3B2KshSaUiU7YA7ycgQry6YW
         +mSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:disposition-notification-to
         :return-receipt-to:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=MqmQQftCsfTP9NTI693S5qR/U4721ALjfnvaRGZrKJA=;
        b=JfXs5lStuYuKojpmF56f0bNNLo1nEaLMmdVgbnOxC5Wimhe+jRCyZmnpPMSY4ah6u0
         kT4kubHh1xS4/H3vdh9B65y/OjST0SbG5ebedVJkRsnbuQAFn4deKFGhsFRr3NImLjQf
         x52D6QAUoc/+NoF4jFCDkr1tgrzA1FPb6rJU4n7VzaQDdXsV55A9IbWGGLqVsi/Fgj1P
         22/QpIJUdF/Mpv/nrBQMqCgPLCGsEAdv0uE2X9gbUvhnjrGhEs7UySnJ7KDt4Zkey1cM
         5oyrytbFwxSaVSrliYe2wyhtMqLEaPU/pVTUG13Bt3Kn/nur0mkQ5c24FfwzjxaxkGdc
         xY0Q==
X-Gm-Message-State: AOUpUlGHRo5aMbW38O1LWcf7Ee2n3lljpRavgnasexjMiUs9KBbKlc8S
        Ny2G+0KKevzWy6u6b+kva7rqDg==
X-Google-Smtp-Source: AA+uWPxagykt9welELQR9eU734gmFz/c68plo7y0RJsG8Ig4ARvqPcaMUn7csQKbpbi34c7Ln8e/Eg==
X-Received: by 2002:a62:dec1:: with SMTP id h184-v6mr36733611pfg.197.1534514371392;
        Fri, 17 Aug 2018 06:59:31 -0700 (PDT)
Received: from [192.168.0.101] ([103.87.59.77])
        by smtp.gmail.com with ESMTPSA id 1-v6sm5152573pfm.145.2018.08.17.06.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 06:59:30 -0700 (PDT)
Date:   Fri, 17 Aug 2018 19:29:25 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20180816171633.546734046@linuxfoundation.org>
References: <20180816171633.546734046@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3.18 00/15] 3.18.119-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh 'Shandilya <harsh@prjkt.io>
Message-ID: <07416EB6-AEB8-4709-9E5C-F6319687D487@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 August 2018 12:11:37 AM IST, Greg Kroah-Hartman <gregkh@linuxfoundati=
on=2Eorg> wrote:
>This is the start of the stable review cycle for the 3=2E18=2E119 release=
=2E
>There are 15 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Sat Aug 18 17:16:20 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v3=2Ex/stable-review/patch-3=
=2E18=2E119-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-3=2E18=2Ey
>and the diffstat can be found below=2E
Merged cleanly and compiled with -Werror, All good on the OnePlus 3T=2E Th=
anks for the update!
--=20
Harsh Shandilya, PRJKT Development LLC
