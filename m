Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021DAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16CB2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qPFEVpj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16CB2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeKUNxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 08:53:07 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38284 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbeKUNxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 08:53:07 -0500
Received: by mail-it1-f195.google.com with SMTP id h65so6908538ith.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 19:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIPzqofjs6yZ6OIwxBHyvs/wydE9D2NgOy4LYNGRIMY=;
        b=qPFEVpj5vIyEQkjAGB6GOEzHx5rz3O6zkJ/+pKvtl+kysiklzTrysCGcOBEWC8v/dE
         BNFnv8cUhbq8WUZ+lMRen9SiO4yBbwJFJDItDcf3ZXqJReEvINUVOLAC0XXoKY0fz/qq
         wLi1QCohPJg9ruH/dPtDjGWRpxUDkaE9S8dKAfBMK402bXNcQQjWgvjGjqoz0vGruzVD
         OjdTQeyohaSCsgDS1/3pRylbmmnGFu+EO5UcJ7stfZwx1lqdCstNDHM8Rado50RhUh9r
         KXA9buu0Gl+IyC7eoJCY8RacN4f1VmajayijFK0UU9s2IyF+/S8z5TMcq4LQr2KKimac
         Fa/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIPzqofjs6yZ6OIwxBHyvs/wydE9D2NgOy4LYNGRIMY=;
        b=aUdBJMcssC93TTVoITR6C0L4rRPv8ipc67BlNobW2RaVip7FkXBHiBnj6H96kdyHBV
         1XtGrNt7vI68uYIT9C94MocbvWd1ZqqT+vWeUqVcTsRXWh66viGpFIQaUUS1jn6Qt2HJ
         iqwJ8PItNhaqqQMVr9Wj3z2jA3ncLjhe5aEz81U2QIoyo/tUerVn/77SVBATAvqLh3J8
         9sgznT7WqgE0TR0gNqeox9s1dJqmE4fReYdo/XNsqjYs0WMEixEXVfsOgydxRzGAMQC9
         sD3b9XSxJhCF9bg6fmhacqYzj9orpSeMOWjvbVpRI/P9k7uYoOyB7Z9Jx0WsqteukBec
         AIgg==
X-Gm-Message-State: AA+aEWaR1liztUe3P0BDVXh4laFShoJ6wxgE/xm6rOAz7EjPdrzurtYK
        tRve4tbiCd4Uz+UZlgPomNz8MCSFxz+PXy62csMgRw==
X-Google-Smtp-Source: AFSGD/UJYSc0OyQV94+f+B93B/UzkvfGr3AHmpjbLg1ybnQlwg9hw4W5ttAWfXLj/FswxGnP84BoLXugckKobO6FHqM=
X-Received: by 2002:a02:8527:: with SMTP id g36mr3826297jai.135.1542770436516;
 Tue, 20 Nov 2018 19:20:36 -0800 (PST)
MIME-Version: 1.0
References: <20181004195906.201895-1-schuffelen@google.com> <8736tjgumd.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <8736tjgumd.fsf@kamboji.qca.qualcomm.com>
From:   Cody Schuffelen <schuffelen@google.com>
Date:   Tue, 20 Nov 2018 19:20:25 -0800
Message-ID: <CAAELVAE0QqON_6-m09CE4D-zypWmNxWaMRHi_AT-NOEDHaMPHw@mail.gmail.com>
Subject: Re: [PATCH net-next v3] wireless-drivers: rtnetlink wifi simulation device
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I already said in v2 that you should not mark this for net-next as this
> goes to mac80211-next (if it gets accepted), now you are just
> unnecessarily confusing people.

My fault, I misunderstood. The next version will be named correctly.

The new version is uploaded here: https://lkml.org/lkml/2018/11/21/251
