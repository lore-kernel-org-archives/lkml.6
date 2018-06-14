Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 70B07C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207EB208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207EB208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755323AbeFNUXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:23:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754695AbeFNUXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:23:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CBF2B738E9;
        Thu, 14 Jun 2018 20:23:09 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-45.rdu2.redhat.com [10.10.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49164111762F;
        Thu, 14 Jun 2018 20:23:03 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <aviro@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH ghak59 V1 0/6] audit: config_change normalizations and event record gathering
Date:   Thu, 14 Jun 2018 16:21:10 -0400
Message-Id: <cover.1529003588.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 14 Jun 2018 20:23:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 14 Jun 2018 20:23:09 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make a number of changes to normalize CONFIG_CHANGE records by adding
missing op= fields, providing more information in existing op fields and
connecting all records to existing audit events.

The user record patch is included but is *optional* since there is doubt
that we want to disconnect the records from a single event.

Since tree purge records are processed after the EOE record is produced,
the order of operation of the EOE record and the purge will have to be
reversed so that the purge records can be included in the event.

Could I get some feedback on the format of the op field values
themselves?  They shouldn't cause any text processing headaches but
there may be a better way of expressing them.

For reference, here are the calling methods and function tree for all
CONFIG_CHANGE events:
- audit_log_config_change() "op=set"
        - AUDIT_SET:AUDIT_STATUS_PID
        - AUDIT_SET:AUDIT_STATUS_LOST
        - audit_do_config_change()
                - AUDIT_SET:AUDIT_STATUS_FAILURE
                - AUDIT_SET:AUDIT_STATUS_ENABLED
                - AUDIT_SET:AUDIT_STATUS_RATE_LIMIT
                - AUDIT_SET:AUDIT_STATUS_BACKLOG_LIMIT
                - AUDIT_SET:AUDIT_STATUS_BACKLOG_WAIT_TIME
- audit_log_common_recv_msg()
        - AUDIT_*USER* events (not CONFIG_CHANGE like all the rest)
        - AUDIT_LOCKED "op=%s_rule"(add/remove)
        - AUDIT_TRIM "op=trim"
        - AUDIT_MAKE_EQUIV: "op=make_equiv"
        - AUDIT_TTY_SET: "op=tty_set"
- audit_log_rule_change()
        - AUDIT_ADD_RULE -F dir=:
        - AUDIT_DEL_RULE -F dir=:
- audit_mark_log_rule_change()
        - audit_autoremove_mark_rule() "op=autoremove_rule(mark)"
                - audit_mark_handle_event()
                        - audit_mark_fsnotify_ops.handle_event
- audit_tree_log_remove_rule() "op=remove_rule(tree:%s)" from kill_rules()
        - from trim_marked()
                - AUDIT_TRIM: audit_trim_trees() "trim"
                - audit_add_tree_rule() iterate_mounts err "add"
                        - audit_add_rule()
                                - audit_rule_change()
                                        - AUDIT_ADD_RULE -F dir=:
                - AUDIT_MAKE_EQUIV: audit_tag_tree() iterate_mounts err "equiv"
        - from audit_kill_trees()
                - __audit_free() "free"
                        - do_exit()
                        - copy_process() err
                - __audit_syscall_exit() "exit"
        - from evict_chunk() "evict"
                - audit_tree_freeing_mark()
                        - audit_tree_ops.freeing_mark
- audit_watch_log_rule_change()
        - audit_update_watch() "updated_rules(watch:inval)" : "updated_rules(watch:set)"
                - audit_watch_handle_event() FS_CREATE|FS_MOVED_TO, FS_DELETE|FS_MOVED_FROM
                        - audit_watch_fsnotify_ops.handle_event
        - audit_remove_parent_watches() "remove_rule(watch:parent)"
                - audit_watch_handle_event() FS_DELETE_SELF|FS_UNMOUNT|FS_MOVE_SELF
                        - audit_watch_fsnotify_ops.handle_event

See: https://github.com/linux-audit/audit-kernel/issues/50
See: https://github.com/linux-audit/audit-kernel/issues/59

Richard Guy Briggs (6):
  audit: give a clue what CONFIG_CHANGE op was involved
  audit: add syscall information to CONFIG_CHANGE records
  audit: exclude user records from syscall context
  audit: hand taken context to audit_kill_trees for syscall logging
  audit: move EOE record after kill_trees for exit/free
  audit: extend config_change mark/watch/tree rule changes

 kernel/audit.c          | 20 ++++++++++++++------
 kernel/audit.h          |  4 ++--
 kernel/audit_fsnotify.c |  4 ++--
 kernel/audit_tree.c     | 28 +++++++++++++++-------------
 kernel/audit_watch.c    |  8 +++++---
 kernel/auditfilter.c    |  2 +-
 kernel/auditsc.c        | 26 ++++++++++++++++++--------
 7 files changed, 57 insertions(+), 35 deletions(-)

-- 
1.8.3.1

