Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC3CC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 23:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B1E217BD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 23:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LrnLQJIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B1E217BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbeHEBqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 21:46:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34150 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbeHEBqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 21:46:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id h1-v6so3446341eds.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 16:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r4NHSoA9QeKw4Vhs7zLRceN2nC7R7wcgrUStp7Xinwk=;
        b=LrnLQJItLLp33jPKprAuYsukOctS+mDWzmGijSr+ivIvrJBtppcfpN5hkponbos81o
         Boq/x9M6qiloCc1pHNw4r7N1y0MSHxeQSaKqg/SJYfiWepa8k+G4Ci9aAcoyeS6m3hZQ
         WUiuBAbEZb85UiBYzfnySfsCB4ZOGbWhXYpEgHmTRT3Umo3uBKvy/j8ZCdPckXJ+Q3RP
         zZqVV1Rsa3Gm1lZlZJO64cCX+uBqATDBq7ONu4ngj1m7XL1+wRTeqs+ZLO23htbaBHgj
         SqpQobeurapawsgbIFpyjGyxZsLYvr7BbC7SCORMITMY5zMEI6i8WTVrb1G15SIZVMBs
         vLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r4NHSoA9QeKw4Vhs7zLRceN2nC7R7wcgrUStp7Xinwk=;
        b=Djr9R3rtaU8kYCmeDeZI73ubDdB2pmgJnqw75FVRpbWn2KFLKlswqP7wj0NJwkOmr+
         KQY0IhbiYAtWxIvKq6uAM7kS3Ir+9PGiAgBK0WhOKNckXzskZ5eRsJO9umbvcwX/aF5H
         76qUsQ3m6aGFn8BSYbViyFttn2LPoyfTfr7L0iYCxUX1Tt1Ae5ex1dblbf717EgBB5pU
         Id0v36Su/2neZMmDBbWMLwvx8G+fmZ6PjMg9mxCs5R2HZpkP0wDxSeoxPGNiB975cwYv
         3Y67fKau3jpbHQXGsOlPEQHzdaN9x++0x0CNcByRx15C8/cZatDpnw+x0lGMAyxp7wBp
         H37Q==
X-Gm-Message-State: AOUpUlEnNF4at5PlGUutffL7LZrtgZ55nE4loKW6LelRQY41nK5GStRV
        guT0KQ7KdJKxar1WAz5NKVCDdw==
X-Google-Smtp-Source: AAOMgpeVIIddtjEnheAZ9yj2MS9mj3FsfI23l2jtQ5wJmL1kqHYLGs6ksFxQ15EZqCx5G+jPNAc/ZQ==
X-Received: by 2002:a50:b8c5:: with SMTP id l63-v6mr12390739ede.80.1533426270293;
        Sat, 04 Aug 2018 16:44:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:5459:5b7e:632c:59fc])
        by smtp.gmail.com with ESMTPSA id d26-v6sm4834776ede.50.2018.08.04.16.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 16:44:29 -0700 (PDT)
Message-ID: <1533426268.2679.152.camel@arista.com>
Subject: Re: [PATCH 4.4 106/124] netlink: Do not subscribe to non-existent
 groups
From:   Dmitry Safonov <dima@arista.com>
To:     David Miller <davem@davemloft.net>
Cc:     natechancellor@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        herbert@gondor.apana.org.au, steffen.klassert@secunet.com,
        netdev@vger.kernel.org
Date:   Sun, 05 Aug 2018 00:44:28 +0100
In-Reply-To: <20180804.163348.896647113172060665.davem@davemloft.net>
References: <1533424322.2679.144.camel@arista.com>
         <20180804232102.GA3982@flashbox> <1533425198.2679.148.camel@arista.com>
         <20180804.163348.896647113172060665.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-08-04 at 16:33 -0700, David Miller wrote:
> From: Dmitry Safonov <dima@arista.com>
> Date: Sun, 05 Aug 2018 00:26:38 +0100
> 
> > Thanks for the testing, sorry again for the breakage.
> > Will send the patch shortly (with sizeof(unsigned long long)
> instead of
> > hard-coded 64). Hopefully, not too late.
> 
> 'groups' is "long unsigned int" not "unsigned long long"
> 
>         long unsigned int groups = nladdr->nl_groups;
> 
> And nladdr->nl_groups is specified as "__u32"
> 
> So the size of the relevant bits is actually strictly 32-bit.
> 
> This makes also the "ULL" in your constant specification incorrect as
> well.
> 
> So much crazy stuff going on here :-/

Right, I misslooked that..
How does this work on Android then?
I doubt they changed uabi.
