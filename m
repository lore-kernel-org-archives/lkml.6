Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E17DC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0119C20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0119C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbeLKWlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:41:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbeLKWlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:41:19 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6EFA307DAA4;
        Tue, 11 Dec 2018 22:41:18 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CBA15D736;
        Tue, 11 Dec 2018 22:41:10 +0000 (UTC)
Date:   Tue, 11 Dec 2018 17:41:07 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Eric Paris <eparis@redhat.com>, viro@zeniv.linux.org.uk,
        sgrubb@redhat.com
Subject: Re: [PATCH ghak59 V3 0/4] audit: config_change normalizations and
 event record gathering
Message-ID: <20181211224107.vdeksnc5bd5bb7mb@madcap2.tricolour.ca>
References: <cover.1544477629.git.rgb@redhat.com>
 <CAHC9VhRqMt2k+pL7YF0MaZQfXZzttyHAXBJhHH56Mvswii4EKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRqMt2k+pL7YF0MaZQfXZzttyHAXBJhHH56Mvswii4EKg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 11 Dec 2018 22:41:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-11 17:31, Paul Moore wrote:
> On Mon, Dec 10, 2018 at 5:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > Make a number of changes to normalize CONFIG_CHANGE records by adding
> > missing op= fields, providing more information in existing op fields
> > (optional last patch) and connecting all records to existing audit
> > events.  The user record needs special-casing since its content isn't
> > directly related to the call that logs it.
> >
> > Since tree purge records are processed after the EOE record is produced,
> > the order of operation of the EOE record and the purge will have to be
> > reversed so that the purge records can be included in the event.
> >
> > The last patch is included for completeness understanding it may be more
> > information than necessary.
> >
> > For reference, here are the calling methods and function tree for all
> > CONFIG_CHANGE events with fields:
> > - audit_log_config_change()
> >         - add "op=set" to fields: "[op] <param-name> old auid ses subj res"
> >         - AUDIT_SET:AUDIT_STATUS_PID
> >         - AUDIT_SET:AUDIT_STATUS_LOST
> >         - audit_do_config_change()
> >                 - AUDIT_SET:AUDIT_STATUS_FAILURE
> >                 - AUDIT_SET:AUDIT_STATUS_ENABLED
> >                 - AUDIT_SET:AUDIT_STATUS_RATE_LIMIT
> >                 - AUDIT_SET:AUDIT_STATUS_BACKLOG_LIMIT
> >                 - AUDIT_SET:AUDIT_STATUS_BACKLOG_WAIT_TIME
> > - audit_log_rule_change()
> >         - fields: "auid ses subj op key list res"
> >         - AUDIT_ADD_RULE -F dir=...
> >         - AUDIT_DEL_RULE -F dir=...
> > - audit_log_common_recv_msg()
> >         - fields: "pid uid auid ses subj ..."
> >         - AUDIT_*USER* events (not CONFIG_CHANGE like all the rest)
> >         - AUDIT_LOCKED add "op={add,remove}_rule" to "[op] audit_enabled res"
> >         - AUDIT_TRIM "op=trim res"
> >         - AUDIT_MAKE_EQUIV: "op=make_equiv old new res"
> >         - AUDIT_TTY_SET: "op=tty_set old-enabled new-enabled old-log_passwd new-log_passwd res"
> > - audit_mark_log_rule_change()
> >         - add ":mark" to op in fields: "uid ses op=autoremove_rule[] path key list res"
> >         - audit_autoremove_mark_rule()
> >                 - audit_mark_handle_event()
> >                         - audit_mark_fsnotify_ops.handle_event
> > - audit_tree_log_remove_rule() called from kill_rules()
> >         - add to op ":tree:%s" to fields: "op=remove_rule[] dir key list res"
> >         - from trim_marked()
> >                 - AUDIT_TRIM: audit_trim_trees() "trim"
> >                 - audit_add_tree_rule() iterate_mounts err "add"
> >                         - audit_add_rule()
> >                                 - audit_rule_change()
> >                                         - AUDIT_ADD_RULE -F dir=...
> >                 - AUDIT_MAKE_EQUIV: audit_tag_tree() iterate_mounts err "equiv"
> >         - from audit_kill_trees()
> >                 - __audit_free() "free"
> >                         - do_exit()
> >                         - copy_process() err
> >                 - __audit_syscall_exit() "exit"
> >         - from evict_chunk() "evict"
> >                 - audit_tree_freeing_mark()
> >                         - audit_tree_ops.freeing_mark
> > - audit_watch_log_rule_change()
> >         add to op ":watch:%s" to fields "auid ses op={updated,remove}_rule[] path key list res"
> >         - audit_update_watch() "updated_rules:watch:inval" : "updated_rules:watch:set"
> >                 - audit_watch_handle_event() FS_CREATE|FS_MOVED_TO, FS_DELETE|FS_MOVED_FROM
> >                         - audit_watch_fsnotify_ops.handle_event
> >         - audit_remove_parent_watches() "remove_rule:watch:parent"
> >                 - audit_watch_handle_event() FS_DELETE_SELF|FS_UNMOUNT|FS_MOVE_SELF
> >                         - audit_watch_fsnotify_ops.handle_event
> > - audit_seccomp_actions_logged()
> >         - fields: "op actions old-actions res"
> >
> >
> > See: https://github.com/linux-audit/audit-kernel/issues/50
> > See: https://github.com/linux-audit/audit-kernel/issues/59
> >
> > Sources of AUDIT_CONFIG_CHANGE records and their current and proposed
> > fields are listed here
> >         https://github.com/linux-audit/audit-kernel/issues/59#issuecomment-445055154
> >
> > Changelog:
> > v3:
> > - un-clever %s_rule to not break up op values
> > - create audit_log_user_recv_msg() and squash into record connection
> > - squash kill_trees context handling with kill-trees before EOE
> > - rebase on audit/next (v4.20-rc1) with 2a1fe215e730 ("audit: use current whenever possible")
> > - remove parens in extended format
> >
> > v2:
> > - re-order audit_log_exit() and audit_kill_trees()
> > - drop EOE reordering patch
> > - rebase on 4.18-rc1 (audit/next)
> >
> > Richard Guy Briggs (4):
> >   audit: give a clue what CONFIG_CHANGE op was involved
> >   audit: add syscall information to CONFIG_CHANGE records
> >   audit: hand taken context to audit_kill_trees for syscall logging
> >   audit: extend config_change mark/watch/tree rule changes
> >
> >  kernel/audit.c          | 33 +++++++++++++++++++++++----------
> >  kernel/audit.h          |  4 ++--
> >  kernel/audit_fsnotify.c |  4 ++--
> >  kernel/audit_tree.c     | 28 +++++++++++++++-------------
> >  kernel/audit_watch.c    |  8 +++++---
> >  kernel/auditfilter.c    |  2 +-
> >  kernel/auditsc.c        | 12 ++++++------
> >  7 files changed, 54 insertions(+), 37 deletions(-)
> 
> In order to make sure expectations are set appropriately, as we are at
> -rc6 right now this is not something that would go into audit/next now
> (assuming everything looks okay on review), it would go into
> audit/next *after* the upcoming merge window.

I agree it is a bit late for this.  I wasn't expecting it to go in this
one.  I'm filling the queue since I'm blocked on other review for
ghak81(5.5wks), ghak90(5.5wks), ghak100(3.5wks).  ghak90 missed another
merge window.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
