Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53361ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134EF2150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134EF2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390097AbeIUTPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:15:34 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:45095 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeIUTPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:15:34 -0400
Received: by mail-wr1-f50.google.com with SMTP id 20-v6so12854605wrb.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1uKCZtawr6sx1VF67pqvvb8M6Rauyp4CSph0imxJ5Ao=;
        b=jYXQ8VGvFfkKCmOwm3UpDrMMpnwU7qZ0MSfdpPFlQ2EjpWQdenjGCpUrHSQ+9j9kqK
         /WxFRSTpHGS1aiWygeK0yZWHWtYEEW8LTAw7WbQlDiManHEPJWEV7EHBy0NUWEPbTXHt
         Z3p5SE5DkZ5jJjrdVVznWNQ4hkSmx7aYhIFecSUoLpgv7wPpoy6m/Rbe13QpeHrVmK6L
         NN7jfVTMkQ8TI2ggM7bUuJJ0zkH9s+bZFdGM7gJHY+bmWW5sDnPHslung+aRHmgop5s/
         XQbJf6sWl2eGFFgwCEwNYA/6Q6NNAl33A92JqSZZAalVM8HCtqi4zby+tXlNf0rAkL4R
         mKiQ==
X-Gm-Message-State: APzg51CmXCSWHbE6PqLAedISgCVnZKjF7rgBpblqpSCTG/ihU5+8WoXP
        VetlCpKxc8hA0Qlu3F4Z0rE=
X-Google-Smtp-Source: ANB0VdaVJa74kMPkh47W1eZR1xPt5lfIMMNXIpuzjoLxYy9WyfaycvtUv6Q/YzZmUC1I80AWBOSLUg==
X-Received: by 2002:adf:e44e:: with SMTP id t14-v6mr37268082wrm.96.1537536401315;
        Fri, 21 Sep 2018 06:26:41 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id y5-v6sm30937834wrd.5.2018.09.21.06.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:26:40 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id C3A0D1252A7;
        Fri, 21 Sep 2018 15:26:39 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, david@redhat.com,
        Pavel.Tatashin@microsoft.com, Jonathan.Cameron@huawei.com,
        yasu.isimatu@gmail.com, malat@debian.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 0/4] Refactor node_states_check_changes_online/offline
Date:   Fri, 21 Sep 2018 15:26:30 +0200
Message-Id: <20180921132634.10103-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

v1 -> v2:
        - Address feedback from Pavel
        - Re-write patch4 his way, as it is better
        - Add Reviewed-by from Pavel

---

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
  To avoid this, we should check if the node is already in node_state[N_MEMORY].

- node_states_set_node()->node_set_state(node, N_HIGH_MEMORY)

* On !CONFIG_HIGH_MEMORY, N_HIGH_MEMORY == N_NORMAL_MEMORY,
  but the current code sets:
  status_change_nid_high = status_change_nid_normal
  This means that we will call node_set_state(node, N_NORMAL_MEMORY) twice.
  The fix here is to set status_change_nid_normal = -1 on such systems,
  so we skip the second call.

[1] https://patchwork.kernel.org/patch/10579155/

Oscar Salvador (4):
  mm/memory_hotplug: Spare unnecessary calls to node_set_state
  mm/memory_hotplug: Tidy up node_states_clear_node
  mm/memory_hotplug: Simplify node_states_check_changes_online
  mm/memory_hotplug: Clean up node_states_check_changes_offline

 mm/memory_hotplug.c | 146 ++++++++++++++--------------------------------------
 1 file changed, 40 insertions(+), 106 deletions(-)

-- 
2.13.6

