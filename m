Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26727C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FC8240E4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FC8240E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936298AbeF2MQe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:16:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754720AbeF2MQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:16:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 218287263E;
        Fri, 29 Jun 2018 12:16:32 +0000 (UTC)
Received: from localhost (unknown [10.36.118.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2B261C739;
        Fri, 29 Jun 2018 12:16:31 +0000 (UTC)
Date:   Fri, 29 Jun 2018 14:16:30 +0200
From:   Niels de Vos <ndevos@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Marcin Sulikowski <marcin.k.sulikowski@gmail.com>
Subject: Re: [PATCH v2] fuse: add support for copy_file_range()
Message-ID: <20180629121630.GS2345@ndevos-x270>
References: <20180627074534.7307-1-ndevos@redhat.com>
 <20180627084648.16892-1-ndevos@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180627084648.16892-1-ndevos@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 29 Jun 2018 12:16:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 29 Jun 2018 12:16:32 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ndevos@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 10:46:48AM +0200, Niels de Vos wrote:
> There are several FUSE filesystems that can implement server-side copy
> or other efficient copy/duplication/clone methods. The copy_file_range()
> syscall is the standard interface that users have access to while not
> depending on external libraries that bypass FUSE.
> 
> Signed-off-by: Niels de Vos <ndevos@redhat.com>

NACK on this by myself, see reason further below.

> 
> ---
> v2: return ssize_t instead of long
> ---
>  fs/fuse/file.c            |  65 +++++++++++++++++++++++
>  fs/fuse/fuse_i.h          |   3 ++
>  include/uapi/linux/fuse.h | 106 ++++++++++++++++++++++----------------
>  3 files changed, 130 insertions(+), 44 deletions(-)
...
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 92fa24c24c92..77330fa510f1 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
...
> @@ -792,4 +796,18 @@ struct fuse_lseek_out {
>  	uint64_t	offset;
>  };
>  
> +struct fuse_copy_file_range_in {
> +	uint64_t	fh_in;
> +	uint64_t	off_in;

It seems that libfuse has the expectation of having access to the nodeid
when a file-descriptor is passed to userspace.

From Marcin Sulikowski in https://github.com/libfuse/libfuse/pull/259:

> There is a caveat though – the kernel module change proposed in
> https://lkml.org/lkml/2018/6/27/114 provides only ino_in argument
> because that is passed in the request's header (args.in.h.nodeid =
> ff_in->nodeid; in fs/fuse/fuse.c in the kernel) whereas ino_out is not
> given by the kernel to the userspace implementation. Isn't this an
> oversight in the kernel module? The lack of the inode number would
> make it impossible to create high-level interface which follows the
> libfuse's convention where the high-level callbacks are given paths to
> files which are to be modified.

So, the next version of this patch will add nodeid_out to the struct.

Niels


> +	uint64_t	fh_out;
> +	uint64_t	off_out;
> +	uint64_t	len;
> +	uint32_t	flags;
> +};
> +
> +struct fuse_copy_file_range_out {
> +	uint32_t	size;
> +	uint32_t	padding;
> +};
> +
>  #endif /* _LINUX_FUSE_H */
> -- 
> 2.17.1
> 
