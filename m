Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF53C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F69820823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F69820823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbeKSXQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:16:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:39956 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728818AbeKSXQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:16:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04FB2AFB6;
        Mon, 19 Nov 2018 12:52:30 +0000 (UTC)
Date:   Mon, 19 Nov 2018 13:52:28 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
cc:     David Herrmann <dh.herrmann@googlemail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or
 elevated privileges
In-Reply-To: <20181114215509.163600-1-ebiggers@kernel.org>
Message-ID: <nycvar.YFH.7.76.1811191351020.21108@cbobk.fhfr.pm>
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com> <20181114215509.163600-1-ebiggers@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ David added to CC ]

On Wed, 14 Nov 2018, Eric Biggers wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> When a UHID_CREATE command is written to the uhid char device, a
> copy_from_user() is done from a user pointer embedded in the command.
> When the address limit is KERNEL_DS, e.g. as is the case during
> sys_sendfile(), this can read from kernel memory.  Alternatively,
> information can be leaked from a setuid binary that is tricked to write
> to the file descriptor.  Therefore, forbid UHID_CREATE in these cases.
> 
> No other commands in uhid_char_write() are affected by this bug and
> UHID_CREATE is marked as "obsolete", so apply the restriction to
> UHID_CREATE only rather than to uhid_char_write() entirely.
> 
> Thanks to Dmitry Vyukov for adding uhid definitions to syzkaller and to
> Jann Horn for commit 9da3f2b740544 ("x86/fault: BUG() when uaccess
> helpers fault on kernel addresses"), allowing this bug to be found.
> 
> Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
> Fixes: d365c6cfd337 ("HID: uhid: add UHID_CREATE and UHID_DESTROY events")
> Cc: <stable@vger.kernel.org> # v3.6+
> Cc: Jann Horn <jannh@google.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks for the patch. I however believe the fix below is more generic, and 
would prefer taking that one in case noone sees any major flaw in that 
I've overlooked. Thanks.



From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] HID: uhid: prevent splice(2)

The kernel has a default implementation of splice(2) for writing from a
pipe into an arbitrary file. This behavior can be overriden by
providing an f_op.splice_write() callback.

Unfortunately, the default implementation of splice_write() takes page
by page from the source pipe, calls kmap() and passes the mapped page
as kernel-address to f_op.write(). Thus, it uses standard write(2) to
implement splice(2). However, since the page is kernel-mapped, they
have to `set_fs(get_ds())`. This is mostly fine, but UHID takes
command-streams through write(2), and thus it might interpret the data
taken as pointers. If called with KERNEL_DS, you can trick UHID to
allow kernel-space pointers as well.

As a simple fix, prevent splice(2) on UHID. It is unsecure, but it is
also non-functional. We need a linear mapping of the input in UHID, so
chunked input from splice(2) makes no sense, anyway.

Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/uhid.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 3c5507313606..fefedc0b4dc6 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -753,6 +753,15 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
 	return ret ? ret : count;
 }
 
+static ssize_t uhid_char_splice_write(struct pipe_inode_info *pipe,
+				      struct file *out,
+				      loff_t *ppos,
+				      size_t len,
+				      unsigned int flags)
+{
+	return -EOPNOTSUPP;
+}
+
 static __poll_t uhid_char_poll(struct file *file, poll_table *wait)
 {
 	struct uhid_device *uhid = file->private_data;
@@ -771,6 +780,7 @@ static const struct file_operations uhid_fops = {
 	.release	= uhid_char_release,
 	.read		= uhid_char_read,
 	.write		= uhid_char_write,
+	.splice_write	= uhid_char_splice_write,
 	.poll		= uhid_char_poll,
 	.llseek		= no_llseek,
 };

-- 
Jiri Kosina
SUSE Labs

