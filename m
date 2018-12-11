Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2636C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675E62081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544538473;
	bh=uWKbXWDybGHa7TqlCpRzSWsYEsMiSEDWD1y1DOSD/Ds=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WMHya2zsZj5RTa9J/cz9tXrVUmBV+53TQvuUkLQdbFUDC7DBGZcrAU02PPNkp0JsE
	 nmDZLXN8RPuHWSvGX8VEq3HOrd1PN35Yb/YQrbJaBXdc9nC5lePqwFmxocEWBlhI2m
	 Wvl1CnD2WZcy3sI+Na1iDWDnIbNxE2aX1R3EVTsY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675E62081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbeLKO1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:27:52 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43188 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeLKO1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:27:51 -0500
Received: by mail-ed1-f66.google.com with SMTP id f9so12665377eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 06:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uWKbXWDybGHa7TqlCpRzSWsYEsMiSEDWD1y1DOSD/Ds=;
        b=OrlyIDP/YGohHgAKKWLWv7q4mJQrZwZwQA/l7GwESkQlOUX54gHhRSth5ouBawUVJy
         7nBMakgpc5MV64+liOE1uSOXaDfqZXIrpbQ/WeIFYWto2qTUJyTge2ik4h5Zulxs5sW8
         c3k3D6wF6dqwseq00C+jHi/wdIrmfvyafuBs2dLOyXEakc3Ul77E+L46OjJ72KO/7URp
         BFM34JlbVFJ7mCXekROnL3xJiPG0W6X26b+yRZgeV9J2tRh0ntf14Wy6KWhuSmic3feO
         Myh+n86Qq7fpnJ+kqgaRdseqY9GkEJ8OWLK4JnQFMN6tAwhLuCdjvZPJ9CEs9+DkVVBX
         L6/A==
X-Gm-Message-State: AA+aEWYBv6xRzyX3ZedHOWDSTvMDdfF9g1oNrT6kXpO1UZ/z17/WBxw9
        3nSs5GzjK6XUn0HDlRJzmn8=
X-Google-Smtp-Source: AFSGD/UFU/xd/EaZjqIX24eiawbdn2SJMpbYUZuA9K6q2D341p52PrJjxp3lRDQr2jz1wItoRmKjSw==
X-Received: by 2002:a17:906:4944:: with SMTP id f4-v6mr12849696ejt.72.1544538469884;
        Tue, 11 Dec 2018 06:27:49 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id g31sm4073975eda.96.2018.12.11.06.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 06:27:48 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 0/3] few memory offlining enhancements
Date:   Tue, 11 Dec 2018 15:27:38 +0100
Message-Id: <20181211142741.2607-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has been posted as an RFC [1]. There was a general agreement for
these patches. I hope I have addressed all the review feedback.

Original cover:
I have been chasing memory offlining not making progress recently. On
the way I have noticed few weird decisions in the code. The migration
itself is restricted without a reasonable justification and the retry
loop around the migration is quite messy. This is addressed by patch 1
and patch 2.

Patch 3 is targeting on the faultaround code which has been a hot
candidate for the initial issue reported upstream [2] and that I am
debugging internally. It turned out to be not the main contributor
in the end but I believe we should address it regardless. See the patch
description for more details.

[1] http://lkml.kernel.org/r/20181120134323.13007-1-mhocko@kernel.org
[2] http://lkml.kernel.org/r/20181114070909.GB2653@MiWiFi-R3L-srv


