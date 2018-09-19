Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2367DECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF38C206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA7LHjnd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF38C206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbeISKvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 06:51:44 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:44322 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730760AbeISKvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 06:51:43 -0400
Received: by mail-ed1-f44.google.com with SMTP id s10-v6so3757642edb.11;
        Tue, 18 Sep 2018 22:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/cD/twJRprP935+eWBvMcRV7JP4eAdUWXlDVjQTuj7s=;
        b=HA7LHjndvWcYIXtobWtrxznKlZGOILss0znUb3vD7bDte0jwCz5J1nGG+N3mVwNyjM
         bMeR1bR+UX8IqwXGu/A6gFo8YCexYbrvboqZQNLwdsFxoHvmxcDHSdHBl/kC38DM+TX2
         tORU+90NchEziPZc9sSWlJ4eVZTt9rZWxHPwU7gL3PaePevkIhhCA2T1ncMe7BI3WMIa
         n/tWL7vJAmIkJ477f6xOBYA5CYyTwPa9l+WwwaCfs/89C7zXE47k+9Vbw1jcFeNmw3po
         ufuJel6KnEC6oIcxw1cB5kUTKTjjz1qIyPuF6dabKcXgzMULW2DPrEL1StV+38E3yspG
         M6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/cD/twJRprP935+eWBvMcRV7JP4eAdUWXlDVjQTuj7s=;
        b=MKKmv7tFWKtiIrcn9VJaSaMWtkQjjUWhakJIcbK6E2tHiV9rIwBUw5na6ENeuWN9cN
         PqCswOImZDU6mavHizo9ySMioxm4E9Jlu8q1+R//kisNs/2yxGjiIymb7DlYuW5xbcS/
         HQka4D/tDPDhJhYo56xFXyEHJYH8VlWcussPMOzWIh/W3u2efZ42uUxv5UbqPvZL5z7t
         TRNiZElvv82nTuF9rUsKM6/VKjPfWwDVoXA9z8/tGNojv+KXl0WpA61SWv5cAP7iUL3p
         4dgu5jjlvnYiS09F5HH5i7cZ5DlIjzVDNFqCOiP5oNGAUVgmeSLy5q0ANol4g95RMd0L
         pTiw==
X-Gm-Message-State: APzg51AXQF8OO9PmLAcRz2O1sSp3XS91TUkAoLOXa0Smi4dBk65Pm8dl
        kcbrBMo8THAWbqI0ZFXFn6E=
X-Google-Smtp-Source: ANB0VdbbUjItVVDQbf/IQFzo95xCMy4h/vdzv01clh3eoX1QeClubPBf2Kiq9Ca4yJLJimKL992zUA==
X-Received: by 2002:a50:9e85:: with SMTP id a5-v6mr56375128edf.92.1537334131699;
        Tue, 18 Sep 2018 22:15:31 -0700 (PDT)
Received: from dell.be.48ers.dk ([178.157.251.200])
        by smtp.gmail.com with ESMTPSA id f7-v6sm2136700edd.6.2018.09.18.22.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 22:15:30 -0700 (PDT)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peter@korsgaard.com>)
        id 1g2Upl-00021A-3k; Wed, 19 Sep 2018 07:15:29 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: i2c:ocores: fixes and polling mechanism
References: <20180625161303.7991-1-federico.vaga@cern.ch>
        <5011687.103nMUzm2u@harkonnen> <20180812153400.GA1010@kunai>
        <8760022x77.fsf@dell.be.48ers.dk> <20180917164235.GB1082@kunai>
Date:   Wed, 19 Sep 2018 07:15:29 +0200
In-Reply-To: <20180917164235.GB1082@kunai> (Wolfram Sang's message of "Mon, 17
        Sep 2018 18:42:35 +0200")
Message-ID: <87sh26oyoe.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Wolfram" == Wolfram Sang <wsa@the-dreams.de> writes:

 >> Thanks! I'll take a look at the patches now.

 > Ping :)

I'm terribly sorry. I didn't manage to review before leaving on
travel. I'm back next week and then I'll review, OK?

-- 
Bye, Peter Korsgaard
