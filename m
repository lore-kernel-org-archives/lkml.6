Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeCWRqu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:46:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:25876 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751790AbeCWRqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:46:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,351,1517904000";
   d="scan'208";a="41609357"
Subject: [PATCH 00/11] Use global pages with PTI
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        aarcange@redhat.com, luto@kernel.org, torvalds@linux-foundation.org,
        keescook@google.com, hughd@google.com, jgross@suse.com, x86@kernel.org,
        namit@vmware.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 23 Mar 2018 10:44:47 -0700
Message-Id: <20180323174447.55F35636@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The later verions of the KAISER pathces (pre-PTI) allowed the user/kernel
shared areas to be GLOBAL.  The thought was that this would reduce the
TLB overhead of keeping two copies of these mappings.

During the switch over to PTI, we seem to have lost our ability to have
GLOBAL mappings.  This adds them back.

This adds one major change from the last version of the patch set
(present in the last patch).  It makes all kernel text global for non-
PCID systems.  This keeps kernel data protected always, but means that
it will be easier to find kernel gadgets via meltdown on old systems
without PCIDs.  This heuristic is, I think, a reasonable one and it
keeps us from having to create any new pti=foo options

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@google.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: x86@kernel.org
Cc: Nadav Amit <namit@vmware.com>
