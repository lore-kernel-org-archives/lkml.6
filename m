Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF2EC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C2220645
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C2220645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbeJSFA7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 01:00:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbeJSFA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 01:00:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2ED3F88319;
        Thu, 18 Oct 2018 20:58:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 884AB60150;
        Thu, 18 Oct 2018 20:58:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <7833.1539893347@warthog.procyon.org.uk>
References: <7833.1539893347@warthog.procyon.org.uk> <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com> <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk> <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk> <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com>
Cc:     dhowells@redhat.com,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE [ver #12]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12080.1539896287.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Thu, 18 Oct 2018 21:58:07 +0100
Message-ID: <12081.1539896287@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 18 Oct 2018 20:58:10 +0000 (UTC)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> but this fails on your modified test-fsmount with:
>
> 	shell-init: error retrieving current directory: getcwd: cannot access
> 	parent directories: No such file or directory

Actually, it doesn't fail at this point, and I do see a splat later in
fsnotify_first_mark().

	static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_connector **connp)
	{
		struct fsnotify_mark_connector *conn;
		struct hlist_node *node = NULL;

		conn = srcu_dereference(*connp, &fsnotify_mark_srcu);

conn here is 6b6b6b6b6b6b6b6b.

	RIP: 0010:fsnotify_first_mark+0x5f/0xbb

	Call Trace:
	 fsnotify+0x115/0x344
	 ? __fput+0xac/0x1c1
	 __fput+0xac/0x1c1
	 task_work_run+0x78/0x9f
	 do_exit+0x525/0xa05
	 do_group_exit+0xb2/0xb2
	 __x64_sys_exit_group+0x14/0x14
	 do_syscall_64+0x7d/0x1a0
	 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The line in fsnotify is:

			fsnotify_first_mark(&mnt->mnt_fsnotify_marks);

and fsnotify() is called from fsnotify_close().

David
