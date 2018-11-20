Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC94C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90E82087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90E82087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbeKTVD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:03:58 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38409 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbeKTVD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:03:58 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so1463608ede.5;
        Tue, 20 Nov 2018 02:35:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cZ6VZMIljRfGjZ5SmAgXfmbGgE7sRwEooFqEb0nTS0I=;
        b=jvqbFZiPQ41R1sX0aaDQ4MujZ1JyJ5c1hRNS/1nW7OnfT3j1nauKTvV/+q8zFgwrVK
         9mutI6e7IOq05akYIzeHndBzggbungc9OBtjSOa++0YwQWhOoNvwwTLPcGUe2bG2xUMB
         /FHk3B1W5KgoZ9gCgVeYipjhlYmxpcK/I37oYGZv6sR/KgDBtYTCfF39i4xriycnSqPZ
         yK+ldslXC5vyhRAebvP+oqcr0k1SPcuFIFKteN7Ig9pAjuXRfOX9kllOdFSI0j42lRP6
         AIZOAoAVokq3an3pHDOQA/Cs1XtCQ0osCHhgLplfuOzaeoszRi/sHQssjWha5fUyjWpF
         3tEw==
X-Gm-Message-State: AA+aEWZGilvT4UAjblMpMqVbDjwwqBgOcEsMLjeAuxc2FVA0GNGeUpF/
        icetRbJEoc9dfrvUY3Bd/Q2n5LtU
X-Google-Smtp-Source: AFSGD/XWfFLT5IQ8zuKu614Nyn0CNrwYEyBt2W5cBjtUGfvdTtrzmfqh/8Fb0kGp9tl5nIQLugWrNQ==
X-Received: by 2002:a50:a7c1:: with SMTP id i59-v6mr1797998edc.37.1542710129568;
        Tue, 20 Nov 2018 02:35:29 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id a15-v6sm5967233ejj.5.2018.11.20.02.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 02:35:28 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     linux-api@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 0/3] THP eligibility reporting via proc
Date:   Tue, 20 Nov 2018 11:35:12 +0100
Message-Id: <20181120103515.25280-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this series of three patches aims at making THP eligibility reporting
much more robust and long term sustainable. The trigger for the change
is a regression report [1] and the long follow up discussion. In short
the specific application didn't have good API to query whether a particular
mapping can be backed by THP so it has used VMA flags to workaround that.
These flags represent a deep internal state of VMAs and as such they should
be used by userspace with a great deal of caution.

A similar has happened for [2] when users complained that VM_MIXEDMAP is
no longer set on DAX mappings. Again a lack of a proper API led to an
abuse.

The first patch in the series tries to emphasise that that the semantic
of flags might change and any application consuming those should be really
careful.

The remaining two patches provide a more suitable interface to address [1]
and provide a consistent API to query the THP status both for each VMA
and process wide as well.

[1] http://lkml.kernel.org/r/http://lkml.kernel.org/r/alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com
[2] http://lkml.kernel.org/r/20181002100531.GC4135@quack2.suse.cz


