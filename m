Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2791C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28392183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546871983;
	bh=5tRaWG9w/bpcFZS51x2blm7DQSPjMkRHfXBKvSfmEO4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AhC+hGGXC3+Xu8ridIH5xgLo+lwQzAqwmjRNMYUSHnDjCWoVvoLkDkzA40b/TPE8i
	 OoEgV675X2iuZaTtb3LuVpNEza7K22GCeL9KFz8Kvoz22kf28rino2NamucbQU57Oa
	 cCJ7bo3l9baxIL9FHjP0eoYWOA6No/he5kVyXYd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfAGOjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:39:42 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35934 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfAGOjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:39:42 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so1104322edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 06:39:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5tRaWG9w/bpcFZS51x2blm7DQSPjMkRHfXBKvSfmEO4=;
        b=IFCI8f3QN2rThd9X0gUByS29nwp2d0hAwCGthZVh25DLWpzfJQW0WecA/omv8vOdBD
         cN2EwaSfxR/Q52gsDzEW6+dKfspwQtlBbiaSQo/grpCSfDNTZgDdbGpOitKHYHM5aa8m
         04+BhijltYzrKcW2zS0MzZPwvrqchMEeV4J/vgYH5J8sSQdHOzOznix/QxRcU/CJKyeg
         lRCu2z8ei5tDR3x5dqE09k2GeAfSQl2oDfrZH0K9QF4bICx3wc58wat6t1XORQQCIafA
         CrpoAC5kuDutI+EBwlaS1UJ0ndKapocJY24PG/ZgmWLbmHun152KHXJyegh9GoV3Xr+p
         49kg==
X-Gm-Message-State: AA+aEWaaEzsnTR4I2P0a67dm3PjrvDyXx+wapWEUHsj6NgjlXEQlzzOW
        Ze3gu5ThyuD2lNVej27/PJI=
X-Google-Smtp-Source: AFSGD/UbqBj8Yo+QEtRTxDtV5oQIeDDOS6Geta9x8qi72hOl59hF37p6FNT0/XlUN0k1SwWTttTePw==
X-Received: by 2002:a50:a5b8:: with SMTP id a53mr57562641edc.199.1546871980381;
        Mon, 07 Jan 2019 06:39:40 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id l18sm29285813edq.87.2019.01.07.06.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 06:39:39 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] oom, memcg: do not report racy no-eligible OOM
Date:   Mon,  7 Jan 2019 15:38:00 +0100
Message-Id: <20190107143802.16847-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have posted this as an RFC previously [1]. Tetsuo has pointed out some
issues with the patch 1 which I have fixed hopefully. Other than that
this is just a rebase on top of Linus tree.

The original cover:
this is a follow up for [2] which has been nacked mostly because Tetsuo
was able to find a simple workload which can trigger a race where
no-eligible task is reported without a good reason. I believe the patch2
addresses that issue and we do not have to play dirty games with
throttling just because of the race. I still believe that patch proposed
in [2] is a useful one but this can be addressed later.

This series comprises 2 patch. The first one is something I meant to do
loooong time ago, I just never have time to do that. We need it here to
handle CLONE_VM without CLONE_SIGHAND cases. The second patch closes the
race.

Feedback is appreciated of course.

[1] http://lkml.kernel.org/r/20181022071323.9550-1-mhocko@kernel.org
[2] http://lkml.kernel.org/r/20181010151135.25766-1-mhocko@kernel.org


