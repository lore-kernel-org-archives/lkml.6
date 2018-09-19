Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C351FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FC72150D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FC72150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbeISPpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:45:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34383 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbeISPpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:45:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id j25-v6so9072378wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 03:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/RrOOYn9/i5abI8jQPJ0P3dbfJeu7mgxvohT+QHErjI=;
        b=H7S4Z0mRBTa9o6O+EdZYg3XxuY5v/E1OS/26JoCg/6mZaI43Rj4V9LXurMbFfDdYtK
         j1Isy/QECYmDuT+aJpnznZUrYqkNI5k5tiNNVtu1dguekSSI8b7Uo6YANzgXiwwsgaET
         xkTokDnQKF4drR49AtWtM/3OATLgTYgXhEUCQ0Weyqaq8ZXqTZ4wQ4JCmr5LUEtca9oG
         3jQY+EzJcNR21MdkyU9UlfxYe6eKau0Ekk1cz/Jw0l+hoJeyhyCyIXM2ZxP+J82wM545
         Ludcclitu1o7sQXBuMNvu3BCRnnP/6knCbn9TJ9IoEqaDoon52v/1+/Y0Jw7Ui/KxmRm
         jWMg==
X-Gm-Message-State: APzg51A2elGI9jKHRTME4suDYdW3BIV9yFVXBP8gEpuLEwQsF1yfIopM
        MSP7X8k//+2TB8Xe4h9Moao=
X-Google-Smtp-Source: ANB0VdYIIP2/SqUr3iuQp8wP7YHC3y/FrjzF55lVh4KkGFw61Fb+t51/ZCfEUMtO2MpP9pCqi0RzXA==
X-Received: by 2002:a1c:dd05:: with SMTP id u5-v6mr19916494wmg.107.1537351718758;
        Wed, 19 Sep 2018 03:08:38 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id x16-v6sm21265497wrm.69.2018.09.19.03.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 03:08:38 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 6C020125379;
        Wed, 19 Sep 2018 12:08:37 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, david@redhat.com,
        Pavel.Tatashin@microsoft.com, Jonathan.Cameron@huawei.com,
        yasu.isimatu@gmail.com, malat@debian.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 0/5] Refactor node_states_check_changes_online/offline
Date:   Wed, 19 Sep 2018 12:08:14 +0200
Message-Id: <20180919100819.25518-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

This patchset refactors/clean ups node_states_check_changes_online/offline
functions together with node_states_set/clear_node.

The main reason behind this patchset is that currently, these
functions are suboptimal and confusing.

For example, they contain wrong statements like:

if (N_MEMORY == N_NORMAL_MEMORY)
if (N_MEMORY =! N_NORMAL_MEMORY)
if (N_MEMORY != N_HIGH_MEMORY)
if (N_MEMORY == N_HIGH_MEMORY)

These comparasions are wrong, as N_MEMORY will never be equal
to either N_NORMAL_MEMORY or N_HIGH_MEMORY.
Although the statements do not "affect" the flow because in the way
they are placed, they are completely wrong and confusing.

I caught another misuse of this in [1].

Another thing that this patchset addresses is the fact that
some functions get called twice, or even unconditionally, without
any need.

Examples of this are:

- node_states_set_node()->node_set_state(node, N_MEMORY)

* node_states_set_node() gets called whenever we online pages,
  so we end up calling node_set_state(node, N_MEMORY) everytime.
  To avoid this, we should check if the node is already in
  node_state[N_MEMORY].

- node_states_set_node()->node_set_state(node, N_HIGH_MEMORY)

* On !CONFIG_HIGH_MEMORY, N_HIGH_MEMORY == N_NORMAL_MEMORY,
  but the current code sets:
  status_change_nid_high = status_change_nid_normal
  This means that we will call node_set_state(node, N_NORMAL_MEMORY) twice.
  The fix here is to set status_change_nid_normal = -1 on such systems,
  so we skip the second call.

[1] https://patchwork.kernel.org/patch/10579155/

Oscar Salvador (5):
  mm/memory_hotplug: Spare unnecessary calls to node_set_state
  mm/memory_hotplug: Avoid node_set/clear_state(N_HIGH_MEMORY) when
    !CONFIG_HIGHMEM
  mm/memory_hotplug: Tidy up node_states_clear_node
  mm/memory_hotplug: Simplify node_states_check_changes_online
  mm/memory_hotplug: Clean up node_states_check_changes_offline

 mm/memory_hotplug.c | 153 +++++++++++++++++++++-------------------------------
 1 file changed, 60 insertions(+), 93 deletions(-)

-- 
2.13.6

