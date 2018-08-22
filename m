Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EECAC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362C221480
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362C221480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbeHVM4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:56:38 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:41008 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbeHVM4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:56:38 -0400
Received: by mail-wr1-f42.google.com with SMTP id z96-v6so1037902wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GNke+4p7Lu+SHndIr4sYMwH8plkTnxcGztrvWB/R6gY=;
        b=nGm0fhcv4ga7ysemgsbrNdOQVNejP4L6ek21hKAubKAxBtOnaihVUiC0FPp9DWWMPp
         xGK3g9HqcjkNctkpsPDBGXjSwNE4Xl892ptuQhsCHUZU590uS62Lp9EQW45PqnFxQaIg
         kSHJM6Khmh3W0XzUdrzJSfbZhuyyCW45K8qjI7PznXMcpvpEECDztaENpDssm+EY6LZw
         hL6M+15adorgo6VlJM3D6gbykP4g2NHNCc3kJr9biSd/RyxezJVG74LD5nJX83Oo12kE
         wl0pY17YnQ5b3Kf9O1L4nJkMVCODnSTz7ZWkebf6CiFjehQqNIDe9P9qJodBGNd9kx6x
         MR2Q==
X-Gm-Message-State: APzg51D7ZljfddpAZRNLnwKlmD3Epf/OL7McJEzSddGTUz9l5mNumfhe
        Mwb7IjugXwI26BEfcQyZ7uM=
X-Google-Smtp-Source: ANB0VdbvJSNj1cvv7YHcpuCJmMYc+NxoxnYmiiOhDVLUID3SQ1WZJKQWRmhwNzeRmjPlJ8mytJfuOA==
X-Received: by 2002:a5d:4ac1:: with SMTP id y1-v6mr6047615wrs.248.1534930352021;
        Wed, 22 Aug 2018 02:32:32 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id r30-v6sm1879318wrc.90.2018.08.22.02.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 02:32:31 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id B152F124A08;
        Wed, 22 Aug 2018 11:32:30 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, malat@debian.org,
        david@redhat.com, Pavel.Tatashin@microsoft.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 0/5] Clean up node_states_check_changes_online/offline
Date:   Wed, 22 Aug 2018 11:32:21 +0200
Message-Id: <20180822093226.25987-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

This patchset clean ups node_states_check_changes_online/offline
functions together with node_states_set/clear_node functions.

The main reason behind this patchset is that currently, these
functions are suboptimal and confusing.

For example, they contain wrong statements like:

if (N_MEMORY == N_NORMAL_MEMORY)
if (N_MEMORY =! N_NORMAL_MEMORY)
if (N_MEMORY != N_HIGH_MEMORY)
if (N_MEMORY == N_HIGH_MEMORY)

At least, I could not find anywhere where N_NORMAL_MEMORY gets
assigned to N_MEMORY, or the other way around.
Neither for the N_HIGH_MEMORY case.

My rough guess is that all that was meant to compare
N_NORMAL_MEMORY to N_HIGH_MEMORY, to see if we were on
CONFIG_HIGHMEM systems.

This went unnoticed because the if statements never got triggered,
so they were always silent.
For instance, let us take a look at node_states_clear_node

...
if ((N_MEMORY != N_NORMAL_MEMORY) &&
    (arg->status_change_nid_high >= 0))
        node_clear_state(node, N_HIGH_MEMORY);

if ((N_MEMORY != N_HIGH_MEMORY) &&
    (arg->status_change_nid >= 0))
        node_clear_state(node, N_MEMORY);
...

Since N_MEMORY will never be equal to neither N_HIGH_MEMORY nor
N_NORMAL_MEMORY, this justs proceeds normally.

Another case is node_states_check_changes_offline:

...
zone_last = ZONE_HIGHMEM;
if (N_MEMORY == N_HIGH_MEMORY)
        zone_last = ZONE_MOVABLE;
...

Since N_MEMORY will never be equal to N_HIGH_MEMORY, zone_last will
never be set to ZONE_MOVABLE.
But this is fine as the code works without that.

After I found all this, I tried to re-write the code in a more
understandable way, and I got rid of these confusing parts
on the way.

Another reason for this patchset is that there are some functions that are
called unconditionally when they should only be called under certain
conditions.

That is the case for:

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


I tried it out on x86_64 so far and everything worked.
But I would like to get feedback on this since I could be
missing something.

Oscar Salvador (5):
  mm/memory_hotplug: Spare unnecessary calls to node_set_state
  mm/memory_hotplug: Avoid node_set/clear_state(N_HIGH_MEMORY) when
    !CONFIG_HIGHMEM
  mm/memory_hotplug: Simplify node_states_check_changes_online
  mm/memory_hotplug: Tidy up node_states_clear_node
  mm/memory_hotplug: Simplify node_states_check_changes_offline

 mm/memory_hotplug.c | 146 +++++++++++++++++++++-------------------------------
 1 file changed, 60 insertions(+), 86 deletions(-)

-- 
2.13.6

