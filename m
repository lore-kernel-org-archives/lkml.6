Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5299FC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0144021486
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R02GwzJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0144021486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeHVTmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 15:42:19 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:39457 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbeHVTmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 15:42:19 -0400
Received: by mail-wm0-f45.google.com with SMTP id q8-v6so2787783wmq.4;
        Wed, 22 Aug 2018 09:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BSgNjFue3yX1zJii+M050p91Ol/lhrwPaAJ/mgXBTZM=;
        b=R02GwzJsRIA1xUmoQ3tvLW0tMuM+gIE0pCSpRoyjsRXzf63N/zOG7D+09WOfX7LDYG
         DXZyXg7LXga0UUJl4Vbew5He9rJ/zAMH5jXMHdWgUOadVNA+nRs3NAlKnWxdxVoHc3mq
         DNSq/hGdiyTfZ36eoeeaTHyYIhIyujScDLXi/LiVb0sS4xZcmsBAODm/HuZ6oBi3FyVl
         +eS1YpAR2n0GOLCNKVT2vgtVz0lLbGXJx4iKRS+1q0tg2t/5dIckHB8sjxoAjfXbPWHO
         aZbw0KRcX3i0CwuCc7HJGaIrZ28j3m/JauGAqbSeUMkpQjMzcbXNJgx6NZy3Yo7lCoao
         Bgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BSgNjFue3yX1zJii+M050p91Ol/lhrwPaAJ/mgXBTZM=;
        b=FQQ0xCXiXH8gJ7cRPwpZ1XjWxIzitFUJrIN23o2YPKAClQCV8oi4S1euHCNL4O7IPh
         nXtVX1+Qo+OSFvlOBEAYEcpF8wRpUaVSvvnPLiW0Y19OOFEGeJbA2XA7RDw9sUH9YWfG
         tMXNg1LIwxmOK3i6/qJUa5GXA7lTMQGouutSmcU1VG1327F676MiPaqR/ppjtfWkI9s0
         bjbsWwBO1AM4z7UsUJf5AFPHM/0L26e8z0SljAamqQ8yRVuuSwHubXhQA2kNdhJnaTQo
         i5ppBUb8nUmDoxDUa66T3t+FYR9y4Z617NfSCYsTxxcWHgQR7h9Vd+n1NoR2YYPCy/z0
         bm/A==
X-Gm-Message-State: APzg51BlelVAceRc4eAtqWVC7D7C5S3TP4d3BDb3SMDeXsOW5JihzV0B
        tMruiOuCwiPC9bDcCkgJnlPoUfNi
X-Google-Smtp-Source: ANB0VdYs8t6ft0wf+GGCAobkJbwV/wrRejRfKwB64hU6YRFR5ChytxecaY/7kjwCauANDzCQFhKBiw==
X-Received: by 2002:a1c:c147:: with SMTP id r68-v6mr2834465wmf.161.1534954606139;
        Wed, 22 Aug 2018 09:16:46 -0700 (PDT)
Received: from dell.be.48ers.dk (d528f5fe4.static.telenet.be. [82.143.95.228])
        by smtp.gmail.com with ESMTPSA id x23-v6sm1546907wmh.26.2018.08.22.09.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 09:16:45 -0700 (PDT)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peter@korsgaard.com>)
        id 1fsVoK-0006Sd-MJ; Wed, 22 Aug 2018 18:16:44 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: i2c:ocores: fixes and polling mechanism
References: <20180625161303.7991-1-federico.vaga@cern.ch>
        <5011687.103nMUzm2u@harkonnen> <20180812153400.GA1010@kunai>
Date:   Wed, 22 Aug 2018 18:16:44 +0200
In-Reply-To: <20180812153400.GA1010@kunai> (Wolfram Sang's message of "Sun, 12
        Aug 2018 17:34:00 +0200")
Message-ID: <8760022x77.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Wolfram" == Wolfram Sang <wsa@the-dreams.de> writes:

 >> sorry to disturb you all but after one month and a half I never received 
 >> any comment about this patch set and I fear it ended up in a forgotten 
 >> corner. I would like to know if someone is considering it or not.

 > Adding Peter to CC using his latest EMail address.

Thanks! I'll take a look at the patches now.

> Peter, you said you wanted to update MAINTAINERs with the new address?

Sorry, I forgot about it when I left on holidays. Will send now.

-- 
Bye, Peter Korsgaard
