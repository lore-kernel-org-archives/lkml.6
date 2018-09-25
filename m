Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2093EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF7E20838
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF7E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeIYSK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:10:56 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:35096 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeIYSK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:10:56 -0400
Received: by mail-pg1-f169.google.com with SMTP id v133-v6so3861669pgb.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 05:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VYEW7ht00VUcAk5YZHzmqxXiRl5qowM6sR3VDqHDTYs=;
        b=ewGCDSa/y1RYrp7oNnO/7DzKTs/3kVC8z6EM8rTYZBw/HFECnbHy9m3RqpB5ZHi6sA
         PwtR+JHUVqM5brYsXy+uOEG1+/5l94hlHlAT5ZfDgZtlv/giuArUpaW4zDCzCMrn3uX5
         s3EMFOu9ErPbEb4B6rX+CUn+QZ+mVZSnGp17eFcauJgIt3vlhSlB6Haj0N2TKbab5qCQ
         EnDguXTEzYfNtZeLbpP1a1px1bR8lrkh54cIvAGb/zL266srTBppJB7/yMMwVYPljqPY
         wDGnJUOyk25crlp6mv74G3zr5RFVL89Ct00faC8dwv9TNsIMo6rExXGG3rJx+RBDZHIR
         PPpQ==
X-Gm-Message-State: ABuFfohF/VwsDJMom/EzJxZj2GinwOaqkXguZ2l5RBeQzy6hgpTxilFy
        tMuDNULsOlZkpYFLDppKIQ4=
X-Google-Smtp-Source: ACcGV60hDR6AU3IycpSip7JKoqXdedt2CcxEYIlOI32wfBLSxTw52qW8zZKH1DYioiMlJ/TUiJ3agQ==
X-Received: by 2002:a63:e116:: with SMTP id z22-v6mr755481pgh.89.1537877022928;
        Tue, 25 Sep 2018 05:03:42 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id h132-v6sm3657449pfc.100.2018.09.25.05.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 05:03:42 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] thp nodereclaim fixes
Date:   Tue, 25 Sep 2018 14:03:24 +0200
Message-Id: <20180925120326.24392-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this has been brought up by Andrea [1] and he proposed two different
fixes for the regression. I have proposed an alternative fix [2]. I have
changed my mind in the end because whatever fix we end up with it should
be backported to the stable trees so going with a minimalistic one is
preferred so I have got back to the Andrea's second proposed solution
[3] in the end. I have just reworded the changelog to reflect other bug
report with the stall information.

My primary concern about [3] was that the __GFP_THISNODE logic should be
placed in alloc_hugepage_direct_gfpmask which I've done on top of the
fix as a cleanup (patch 2) and it doesn't need to be backported to the
stable tree.

I am still not happy that the David's workload will regress as a result
but we should really focus on the default behavior and come with a more
robust solution for specialized one for those who have more restrictive
NUMA preferences. I am thinking about a new numa policy that would mimic
node reclaim behavior and I am willing to work on that but we really
have to fix the regression first and that is the patch 1.

Thoughts, alternative patches?

[1] http://lkml.kernel.org/r/20180820032204.9591-1-aarcange@redhat.com
[2] http://lkml.kernel.org/r/20180830064732.GA2656@dhcp22.suse.cz
[3] http://lkml.kernel.org/r/20180820032640.9896-2-aarcange@redhat.com


