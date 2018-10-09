Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720BCC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D232085B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIcZVLGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D232085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeJJEXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:23:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36650 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeJJEXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:23:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id y11-v6so1419468plt.3;
        Tue, 09 Oct 2018 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mw04dfVKZTSpXjmODtB4LdALdoN2e61Sdt/hZEaF79g=;
        b=DIcZVLGrjLZ2rNcaKG1vYugvTD7Gb7wK+Dpjka/9QgPH38QVxN1Rc0n/rC/BHJBVA/
         0mO2JQ5ki1ZCXR4YxlvbVVclt7fFvF33SdW3B3EBlFmvWXfh8KQC2X+gXiHa8R7AvuyW
         aoyfW3YZiHvuhMNOGLInhQXyIkJBT2TTBHx56FlpqAbR04rEdO81HnFzxP0lDyR1KGB9
         6249lBEEqgPVgDawaeg80hevn48ymS71HhLtX0Qrp2RJGZXGBUMUDwfrYfj4p6dzwp10
         eLgTStORwEpINUPFEJMqCqCo5Hb+7kO9S+VF5cx5jS5AxS1vsIY5LY14tjN9KfEtkUqB
         Pdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mw04dfVKZTSpXjmODtB4LdALdoN2e61Sdt/hZEaF79g=;
        b=msT4N+9x2vmramqGbHDpjKH/e0I/taBcdUMLbutenydNbBGv7teQ+SkUXdWKVZa0vK
         8qd3H3v3De/Xnm+F5lLNn4H7jNZm6vFWdH0OsxruuvHRQs2YXI97fzdRyWXv0A1JlBRe
         3pEPbbhjOT9rosPmKXZI10Il4OFkyAbHsDTEZf1EKZFB2C/RJvAyA1Q8jAK+FvRMuExR
         OZZT4ODSiQeimbr3AHPvnFHa7fWYO2imiUi52bqFTzePnIM6sXu9pkBT+VR1mWxB3LQf
         Aui3cKQrj07BBnCvRqM4KUIav7294X5H25ZQciCBjTI2w1Kl7mnboEFgIbu3xz6/YnG0
         7sXg==
X-Gm-Message-State: ABuFfogH1QFo/75Jt0gc+w/19lyHPKY9/4HY+YgQnJbQxR18+DBHXwr/
        Flt6aLaFzVLYWGaEpa+jJyUWFTA3
X-Google-Smtp-Source: ACcGV61bU8SBYL3t57T0kylBmYAxJkkrwpvrGZZ99QsrvR3jp9aXb8Q1hFUR0ZfmVmCjwcJ6i+dePQ==
X-Received: by 2002:a17:902:b213:: with SMTP id t19-v6mr30804277plr.51.1539119103528;
        Tue, 09 Oct 2018 14:05:03 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h88-v6sm49784756pfa.184.2018.10.09.14.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 14:05:02 -0700 (PDT)
Date:   Tue, 9 Oct 2018 14:05:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/113] 4.4.160-stable review
Message-ID: <20181009210501.GA12203@roeck-us.net>
References: <20181008175530.864641368@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 08:30:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.160 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Oct 10 17:55:13 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 286 pass: 286 fail: 0

The previously reported failure of
powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs
is no longer reported because CONFIG_OF_UNITTEST is now disabled.
This applies to all reports.

Thanks,
Guenter
