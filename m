Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB9FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A114E206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LHaqXnBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A114E206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390250AbeKVJRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:17:53 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:45506 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387465AbeKVJRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:17:53 -0500
Received: by mail-ed1-f50.google.com with SMTP id d39so6139705edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 14:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=iyu+r1qU4x4WLB9qIma9AHESoTIw5m2Vat5BZdT61Oo=;
        b=LHaqXnBP/y8+l+vQOkAC9X0L09mU85qyc+TDzjjunQCm2KJVcyB4Gw5eTF2LN9Muuj
         KtghmKz5NGhop25VwimTWbRsuiwEi0K62jCj1AmkY0bnEzRS9/7O1vol0jE1g2ReoT/8
         bIyqy9cEP6PGZ5DgOujno5xQaO2/sxjF/zmAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iyu+r1qU4x4WLB9qIma9AHESoTIw5m2Vat5BZdT61Oo=;
        b=Qd3e9bgKe914pntXVNfvBAtPC8GA42gZKuN7HvyDk+Q9k3FGBdb5vQpPaubyugDfYc
         FdQ0Zp5cfM3fJMnXVshIZA5E8MbupLEvMcjGE/UuWrS75QWk3Ax+xxsSocoqAyQV7RdO
         NkKBmXz/KgJtbSt0nWoZIqKxNJIBGduKPYq9+DYnRncuZBmHJTkYWDRK4yW5H7vuSeHk
         DjIBNhWO4En3u5Y9EVnBBHBwRZRE6x1xNb6z6mtyRr6x8iHxpNQL1JSbXELZm85vzyYR
         Qs+wN2A1eIEGzZddmhW5Xy8ohqo+6pvxBnmuI1X2cVrUG4y2eO+1vtgGG/Hwe81k2LPN
         H5pA==
X-Gm-Message-State: AA+aEWZWkvKwXFjJn2t/dC12VN6QZbr14OmAxT59ViMF+4RJdTH9k97A
        9Rzb3ZdlSd88ew4ZSMau6OCmEA==
X-Google-Smtp-Source: AFSGD/Ww0EH1zrGj/4fAFvcSJL/Q810COOxA8wVf4lVD6mpU/+OXbvA24r1gdssPQ73DAheG8HhBsg==
X-Received: by 2002:a50:ad97:: with SMTP id a23mr6814441edd.128.1542840087676;
        Wed, 21 Nov 2018 14:41:27 -0800 (PST)
Received: from andrea (dynamic-2a00-1028-8386-da8a-eacb-c188-78b9-634c.ipv6.broadband.iol.cz. [2a00:1028:8386:da8a:eacb:c188:78b9:634c])
        by smtp.gmail.com with ESMTPSA id a22-v6sm2917461ejv.17.2018.11.21.14.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 14:41:27 -0800 (PST)
Date:   Wed, 21 Nov 2018 23:41:24 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [Question] smp_wmb() in prepare_uprobe()
Message-ID: <20181121224124.GB4016@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The comment for the smp_wmb() in prepare_uprobe() says:

  "pairs with rmb() in find_active_uprobe()"

but I see no (smp_)rmb() in find_active_uprobe(); I see the smp_rmb() in
handle_swbp(): is this the intended pairing barrier?

Which memory accesses do you want to "order" with this pairing?

Thanks,
  Andrea
