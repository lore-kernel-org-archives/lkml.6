Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933523AbeCMP4F (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:56:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:39859 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932400AbeCMP4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:56:03 -0400
From: Petr Mladek <pmladek@suse.com>
To: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc: Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Nicolai Stange <nstange@suse.de>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/2] livepatch: Allocate and free shadow variables more safely
Date: Tue, 13 Mar 2018 16:54:46 +0100
Message-Id: <20180313155448.1998-1-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nikolai started to use shadow variables and found that list_head
is not initialized correctly using the existing API.

The problem is that LIST_HEAD_INIT() set pointers to itself.
klp_shadow_alloc() then copies these pointers to another location.

It would be possible to solve this by a late initialization. But
this does not work well with klp_shadow_get_or_alloc(). Also this
behavior is error prone. Note that list_head might be hidden in
another structure, for example mutex.

I suggest to change the API and allow to initialize the shadow
variables using a custom callback. I think that we have already
talked about this but we decided to go the easier way. It seems
that it was a bad decision.

I send also patch that add a symmetric callback to the klp_shadow_free()
functions. It might be handy especially for klp_shadow_free_all().


The patchset is against the current Linus' tree.

Petr Mladek (2):
  livepatch: Initialize shadow variables by init function safely
  livepatch: Allow to unregister or free shadow data using a custom
    function

 Documentation/livepatch/shadow-vars.txt   | 42 ++++++++++++-----
 include/linux/livepatch.h                 | 23 +++++++---
 kernel/livepatch/shadow.c                 | 75 +++++++++++++++++++++----------
 samples/livepatch/livepatch-shadow-fix1.c | 44 +++++++++++++-----
 samples/livepatch/livepatch-shadow-fix2.c | 33 +++++++-------
 5 files changed, 150 insertions(+), 67 deletions(-)

-- 
2.13.6
