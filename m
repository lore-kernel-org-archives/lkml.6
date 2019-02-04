Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA99BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77ED720821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6k9gw/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfBDWsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:48:19 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39689 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfBDWsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:48:19 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so617967pld.6;
        Mon, 04 Feb 2019 14:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yc5fCYM/TkKV5TfK+5HzeOwnXfXgH6K3XWc6z9cSr68=;
        b=F6k9gw/cZ6sNOdKVs8vpse7F+NsMBdCFijH7iSwf3ncQGmA+ndMSS4LHZWkeDdP4JH
         LH/rvkF2qSsLB8zrf/NVJ3+JFqlE3vPLptmVR7IUVKvDMES7oxL9/ha0batKlyo1OfPs
         P5K+PTeI3Qw3tNsO/A3rsQxwZV4b6NGLV2tnlOPaYFXmLpBQ8mYGIgkKazeDnvOZJUxS
         6txi6mClYuxwcEycx6sCN/cHs5jxM8xbnVVc1f05Z6aE2WM7/jVFpRT/ZPUHXjfLpTHB
         w/NCC+b278gPyROJU1hZVC7BB5pV4/OJIDd4jhc5t63RbV66cn/vftkABIegTfANFkIa
         /Jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yc5fCYM/TkKV5TfK+5HzeOwnXfXgH6K3XWc6z9cSr68=;
        b=ReECrv1rEHMqwox38VPAQkHn4HvdXiDAm8OddJXq3tnQvHVl8XfnT2R0dF6A0v5jON
         eUZ/TrewjO3mWFREz205Ri7EH8t9C4q3WaudAxds9CtzUiMWCB5eg+CChBgiPxYq1Bjz
         kL+EaN8FHeB6ejj+J9sFdo1fEIHXIWGKOmFgoJkZlKSbCywtd4PYgFIWoY9U830W9mep
         rwI0g/orB7xNtP+oXysMAfOGm4Ch1WGzsNimGCN4e1OMXF4UmvuSlRFllHUqZJiaEoWN
         fpmbW46Chl+jCkMRa5eKt8J7sW1VtAVS/xbkB7ciBLKknHiUSLJRhO3Jz2SiSVjUzcr2
         XQMA==
X-Gm-Message-State: AHQUAuarsNZr94W6+LUm5NuDmVoO1URbdgDp4IhlST8cS/XdNZTybyWS
        nTUWvO+e5qqjTIM6H3maZ3A=
X-Google-Smtp-Source: AHgI3IZu800gEiaUco+PDQ0cpL9BhrixBUo27l6sF+HdGOmHWH3+uCu6DBOuAn7r4CKz4Q9h4n78bQ==
X-Received: by 2002:a17:902:f091:: with SMTP id go17mr1814607plb.235.1549320498871;
        Mon, 04 Feb 2019 14:48:18 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z9sm2849158pfd.99.2019.02.04.14.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 14:48:18 -0800 (PST)
Date:   Mon, 4 Feb 2019 14:48:17 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/65] 4.4.173-stable review
Message-ID: <20190204224817.GA12968@roeck-us.net>
References: <20190204103610.583715954@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 11:35:53AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.173 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb  6 10:35:30 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 291 pass: 291 fail: 0 (*)

Guenter

---
(*) I had to revert to gcc 5.3.0 for sh4 boot tests.
    With gcc 8.2.0, most tests stall early in boot.
    I didn't try to track down the root cause.
