Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx49G1b7+CrLy9+BzsHiWLmixGE5D+3iDGRgX72qwo0sbxo8fiWpSJ8OsquRnHOIiJ8bGEmeL
ARC-Seal: i=1; a=rsa-sha256; t=1523483719; cv=none;
        d=google.com; s=arc-20160816;
        b=tuVPVALmeUzTtyTKQzfHzNWD4HxUgPLsXa3Go6HILCi9LKvPoGHNqU6d89a5ldxM24
         0isNQb7FgKmwlkYFi67mTGZ7qt3hsK69FQ9ZlsJPn/0W5CONM+P/Hft5Ifvlnnn9RDZQ
         56BSkcnK4AeYQa4LgsEsJ0Tk0nQssUUeAtpAlMW/b1P1P2rt5uRcqwaqpNfitZ3IUcjB
         WHUm+/xVhhtdNTnBdHNfmwqY+azC6k8WPNiI3Szi+D4TjGMy+2co3Dy5HE0cZgL58StV
         eBwehfM2BS4GbpSxMXEdBA1VO+PoPN+lDVTRmN/MygP4fGuEaxOZIrhQepTSAsabYmlk
         7tpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:message-id:cc
         :subject:date:to:from:arc-authentication-results;
        bh=7pUPzpglaWC1Ms2bz411lj2TL4oggXX5Vo9BZr3PAbc=;
        b=jhy1Wt3KQlAalWplCRvw/tNb5uVaI24eXVSNU6o72LXdXuZPjvMFiaowUVSG0ZrEbp
         H/PBs5n2Q5lXz5UFXLJLvHv8IGLKJzJiUbE5t7Cr1nVxolFKK/AiEjomzelBL0pUHMKH
         CmkQm3GYmHTw2pcOJay8QCeuJv3gi2wyEDvrl/JsV/AObdgUbcNDC6nUBSCozdv3WQBu
         0N2Nqek0INJLm8OLZIWjvQq02Mk/H2xCu+0wXIyOgooO7e1qt8PZLHarzpYmMk7vQEQv
         gsHqMMMIjEOuKnWKy17ezV+vL7oIO9ckFuAkaZYC+U0uTPgeYMH4YgIjUufOPR2Q+c7T
         Wgag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Thu, 12 Apr 2018 07:54:48 +1000
Subject: [PATCH 00/20] staging: lustre: convert to rhashtable
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152348312863.12394.11915752362061083241.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597488463998050383?=
X-GMAIL-MSGID: =?utf-8?q?1597488463998050383?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

libcfs in lustre has a resizeable hashtable.
Linux already has a resizeable hashtable, rhashtable, which is better
is most metrics. See https://lwn.net/Articles/751374/ in a few days
for an introduction to rhashtable.

This series converts lustre to use rhashtable.  This affects several
different tables, and each is different is various ways.

There are two outstanding issues.  One is that a bug in rhashtable
means that we cannot enable auto-shrinking in one of the tables.  That
is documented as appropriate and should be fixed soon.

The other is that rhashtable has an atomic_t which counts the elements
in a hash table.  At least one table in lustre went to some trouble to
avoid any table-wide atomics, so that could lead to a regression.
I'm hoping that rhashtable can be enhanced with the option of a
per-cpu counter, or similar.


I have enabled automatic shrinking on all tables where it makes sense
and doesn't trigger the bug.  I have also removed all hints concerning
min/max size - I cannot see how these could be useful.

The dump_pgcache debugfs file provided some interesting challenges.  I
think I have cleaned it up enough so that it all makes sense.  An
extra pair of eyes examining that code in particular would be
appreciated.

This series passes all the same tests that pass before the patches are
applied.

Thanks,
NeilBrown


---

NeilBrown (20):
      staging: lustre: ptlrpc: convert conn_hash to rhashtable
      staging: lustre: convert lov_pool to use rhashtable
      staging: lustre: convert obd uuid hash to rhashtable
      staging: lustre: convert osc_quota hash to rhashtable
      staging: lustre: separate buckets from ldlm hash table
      staging: lustre: ldlm: add a counter to the per-namespace data
      staging: lustre: ldlm: store name directly in namespace.
      staging: lustre: simplify ldlm_ns_hash_defs[]
      staging: lustre: convert ldlm_resource hash to rhashtable.
      staging: lustre: make struct lu_site_bkt_data private
      staging: lustre: lu_object: discard extra lru count.
      staging: lustre: lu_object: factor out extra per-bucket data
      staging: lustre: lu_object: move retry logic inside htable_lookup
      staging: lustre: fold lu_object_new() into lu_object_find_at()
      staging: lustre: llite: use more private data in dump_pgcache
      staging: lustre: llite: remove redundant lookup in dump_pgcache
      staging: lustre: use call_rcu() to free lu_object_headers
      staging: lustre: change how "dump_page_cache" walks a hash table
      staging: lustre: convert lu_object cache to rhashtable
      staging: lustre: remove cfs_hash resizeable hashtable implementation.


 .../staging/lustre/include/linux/libcfs/libcfs.h   |    1 
 .../lustre/include/linux/libcfs/libcfs_hash.h      |  866 --------
 drivers/staging/lustre/lnet/libcfs/Makefile        |    2 
 drivers/staging/lustre/lnet/libcfs/hash.c          | 2064 --------------------
 drivers/staging/lustre/lnet/libcfs/module.c        |   12 
 drivers/staging/lustre/lustre/include/lu_object.h  |   55 -
 drivers/staging/lustre/lustre/include/lustre_dlm.h |   19 
 .../staging/lustre/lustre/include/lustre_export.h  |    2 
 drivers/staging/lustre/lustre/include/lustre_net.h |    4 
 drivers/staging/lustre/lustre/include/obd.h        |   11 
 .../staging/lustre/lustre/include/obd_support.h    |    9 
 drivers/staging/lustre/lustre/ldlm/ldlm_request.c  |   31 
 drivers/staging/lustre/lustre/ldlm/ldlm_resource.c |  370 +---
 drivers/staging/lustre/lustre/llite/lcommon_cl.c   |    8 
 drivers/staging/lustre/lustre/llite/vvp_dev.c      |  332 +--
 drivers/staging/lustre/lustre/llite/vvp_object.c   |    9 
 drivers/staging/lustre/lustre/lov/lov_internal.h   |   11 
 drivers/staging/lustre/lustre/lov/lov_obd.c        |   12 
 drivers/staging/lustre/lustre/lov/lov_object.c     |    8 
 drivers/staging/lustre/lustre/lov/lov_pool.c       |  159 +-
 drivers/staging/lustre/lustre/lov/lovsub_object.c  |    9 
 drivers/staging/lustre/lustre/obdclass/genops.c    |   34 
 drivers/staging/lustre/lustre/obdclass/lu_object.c |  564 ++---
 .../staging/lustre/lustre/obdclass/obd_config.c    |  161 +-
 .../staging/lustre/lustre/obdecho/echo_client.c    |    8 
 drivers/staging/lustre/lustre/osc/osc_internal.h   |    5 
 drivers/staging/lustre/lustre/osc/osc_quota.c      |  136 -
 drivers/staging/lustre/lustre/osc/osc_request.c    |   12 
 drivers/staging/lustre/lustre/ptlrpc/connection.c  |  164 +-
 29 files changed, 870 insertions(+), 4208 deletions(-)
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/libcfs_hash.h
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/hash.c

--
Signature
