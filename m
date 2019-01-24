Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0C6C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652E0218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfAXAvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 19:51:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:37536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726235AbfAXAvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 19:51:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8AEBFAFCB;
        Thu, 24 Jan 2019 00:51:41 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>
Subject: [PATCH 0/6] Fix issues with Python3 scripting
Date:   Wed, 23 Jan 2019 16:52:23 -0800
Message-Id: <20190124005229.16146-1-tonyj@suse.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seeteena posted, earlier this week, some patches to add Python3 support
to scripts/python/*.py.  Unfortunately there were some issues with these
patches (such as: https://lkml.org/lkml/2019/1/17/351)

Since I already had a tested set of patches in openSUSE:Factory and 
SLE15-SP1 and was about to submit them, Seeteena and I that agreed I 
should post my patches not involving scripts/python/*.py and Seeteena 
will later resubmit the patches for scripts/python/*.py incorporating 
my review feedback under a joint signed-off-by.

It should be noted that the use of "from __future__ import print_function" 
(see: https://lkml.org/lkml/2019/1/16/641) and "except as" (see change to:
tests/attr.py) implies Python2 >= 2.6 as the necessary support has not 
been backported to prior versions.  I am not sure if it's worth detecting 
<2.6 at build time or whether it's sufficiently old as to be a non-issue?

The shebang changes were driven mostly by our build process as it scans
all files within an rpm and the shebangs would result in a rpm requires
on the python2 binary when BuildRequires was python3-devel. I think they 
make sense to apply upstream but understand totally if it's prefered we 
keep them local.

These changes have been tested with PYTHON=python2 (v2.7) and 
PYTHON=python3 (v3.6) on latest openSUSE Tumbleweed.  I did notice that 
test #18 "'import perf' in python" is failing on my system without these 
changes. I'll look at it further but didn't want to hold up Seeteena's 
resubmit.

Tony Jones (6):
  perf script python: Add trace_context extension module to sys,modules
  perf script python: Use PyBytes for attr in trace-event-python
  perf script python: remove explicit shebang from setup.py
  perf script python: remove explicit shebang from tests/attr.c
  perf script python: remove explicit shebang from Python scripts
  perf script python: add Python3 support to tests/attr.py

 tools/perf/Makefile.perf                      |  4 +--
 .../scripts/python/exported-sql-viewer.py     |  1 -
 tools/perf/scripts/python/sched-migration.py  |  2 --
 tools/perf/scripts/python/stat-cpi.py         |  1 -
 tools/perf/tests/attr.py                      | 33 +++++++++++--------
 .../scripting-engines/trace-event-python.c    |  9 ++---
 tools/perf/util/setup.py                      |  2 --
 7 files changed, 26 insertions(+), 26 deletions(-)

-- 
2.20.1

