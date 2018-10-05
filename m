Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CE6C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B011020875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B011020875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJEMKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 08:10:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36660 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbeJEMKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 08:10:31 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g8I0x-0000kr-7l; Fri, 05 Oct 2018 04:46:59 +0000
Date:   Fri, 5 Oct 2018 05:46:59 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>, daniel@iogearbox.net,
        luto@amacapital.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/6] bpf: introduce BPF_PROG_TYPE_FILE_FILTER
Message-ID: <20181005044659.GU32577@ZenIV.linux.org.uk>
References: <20181004025750.498303-1-ast@kernel.org>
 <20181004025750.498303-2-ast@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004025750.498303-2-ast@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 07:57:45PM -0700, Alexei Starovoitov wrote:
 
> @@ -15,6 +15,7 @@
>  #include <linux/bpf.h>
>  #include <linux/bpf-cgroup.h>
>  #include <net/sock.h>
> +#include <../fs/mount.h>

No.

> +	struct file *file = NULL;
> +	struct inode *inode;
> +	struct super_block *sb;
> +	struct mount *mnt;

Fuck, no.

> +	case offsetof(struct bpf_file_info, mnt_id):
> +		/* dst = real_mount(file->f_path.mnt)->mnt_id */
> +		mnt = real_mount(LD_1(file->f_path.mnt));
> +		LD_n(mnt->mnt_id);

NAK.  Anything in struct mount is private to just a couple of
files in fs/*.c.  Don't do that.  And keep in mind that internal
details can and will be changed at zero notice, so be careful
with adding such stuff.

Another problem is your direct poking in ->i_ino.  It's not
something directly exposed to userland at the moment and it should
not become such.  Filesystem has every right to have ->getattr()
set ->ino (== ->st_ino value) in whichever way it likes; the same
goes for ->dev.
