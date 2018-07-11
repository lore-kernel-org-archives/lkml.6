Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB598C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9404E20870
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9404E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbeGKSb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:31:27 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:39572 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387823AbeGKSb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:31:27 -0400
Received: by mail-pf0-f170.google.com with SMTP id s21-v6so18962596pfm.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 11:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dNWOPijWMoJAn8cAcDislrnTD3/Xbfg4rJqcIbdOx8U=;
        b=b9MP/WMQBSzihdhj271I9GRUm+PuYIzIPMBhAKsVyAWXt+ieSdORS+t3M4chOUdfdZ
         I9ZueQn20+MDeSP6N3pMjkgaUwW88DBnFkspm31ub8gBj76OByris6tTaPmnOXinmHld
         i1i+VB1w3MNd4pd/q7y9XhBtKIPE8wnX0A6oMeVZSvFK9knzDP3yKvpazWDe+DGkrgjr
         CkMA2a3t2hnTnSv9nGfsfxKWB8tSMy4THkwhWdKzsWshwDLtuU/i92oB9kxouRtqHjwT
         rzz2ovy0zdLF2/RSxE108K01CEXGd6DdcjtikAiuor0vcbwpFO+r6O63lbbpV5SzQsrQ
         pwKw==
X-Gm-Message-State: APt69E1LfRKreLIWLMKyQMh7ivD7fHpc9kKFGTKKaLhLdy1ti2emsCfZ
        7tk2P8WeCJ3PE23Cc8ksvXHHvQ==
X-Google-Smtp-Source: AAOMgpdgZUNzDk6QX30OdrrOX3JkzKxncqamNSaBn3zYAoiLh0R9B30vZ3uR3ZRFKBILecDvT+kGSQ==
X-Received: by 2002:a62:b40c:: with SMTP id h12-v6mr18352828pfn.18.1531333554751;
        Wed, 11 Jul 2018 11:25:54 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id 64-v6sm7977331pfe.151.2018.07.11.11.25.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 11:25:54 -0700 (PDT)
Date:   Wed, 11 Jul 2018 11:25:53 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Alan Tull <atull@kernel.org>
Cc:     federico.vaga@cern.ch, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: fpga: fpga_mgr_free usage
Message-ID: <20180711182553.GA5356@archbook>
References: <5553262.evi6GU8epL@pcbe13614>
 <CANk1AXRewvAAxRi=kmCNL3CEki9ODk7LvLS6q8Hd64JRanyfew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXRewvAAxRi=kmCNL3CEki9ODk7LvLS6q8Hd64JRanyfew@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Wed, Jul 11, 2018 at 10:59:01AM -0500, Alan Tull wrote:
> On Wed, Jul 11, 2018 at 7:38 AM, Federico Vaga <federico.vaga@cern.ch> wrote:

[..]
> > This makes the usage consistent: the user creates and destroy its own
> > objects. This is also consistent with our other discussion where we
> > said, among the other things, that the module that uses the FPGA
> > manager can the owner of the fpga_manager data structure.
> 
> You're not the first to complain about this.  I think I'll err on the
> side of consistency and implement your option 2 here.

I agree, that seems like a good approach.

Cheers,

Moritz
