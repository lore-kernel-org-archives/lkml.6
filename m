Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C741C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C2A20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="c3p7PKqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C2A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934438AbeFRLuz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:50:55 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37493 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933631AbeFRLun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:50:43 -0400
Received: by mail-wr0-f196.google.com with SMTP id d8-v6so16517522wro.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 04:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CEPIyf9S6aoVD3Y5s5I5t9IjCYaj3rchBcC/w8gEdy4=;
        b=c3p7PKqdNSDPrtCd6N+8nEgZGsP5fJfdts/RoJQSfeb/movRJtwonOlyLiWRG+F4Sk
         3wcbH3IxJVuFC8k/7DLaYet0JuUA8GJ/OVEvpCnVOmI3Q1tU989eqdsX6uirY3lEmCsA
         CPrSBhMSbYStJssbU9aXSMzw8fDbfqha6HMGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CEPIyf9S6aoVD3Y5s5I5t9IjCYaj3rchBcC/w8gEdy4=;
        b=dmeq6uSPaeUVBno6Loq3Iy57FMsKuNUx4bQMA6+YoMk7NOOeN6N49VM48tpdZc8N9k
         Petaz+wb6V3Yc01a9jEQ+VyX90C/0DJLMpdlB7PXmdMRGPSlUlBP7Uv9QpOyG8W4Pw2u
         xtuOPl+XrRcZFQmVtzezx/7Uya53oj5m9NRkLRRhI+1sxESn3ZwTcfMzRf+0IyIpZCiw
         Ia4jjUBcl6ffqDOvyl3MtJXFtxJC7kXgTj2Ylm7+z/yn0XU7daDXVenQPIxx8MjUekG9
         aK7XchmuoNyuvN9FhuwiHPLd+1kuXutfkuG//tqcBx7fZzQnersJ6SGo4G2cjd8HoCfu
         XaLA==
X-Gm-Message-State: APt69E0rXt3tbiRacyFFuH3J3qSh3wkxrdXuxs9YdfGfYEmmd4Zj/2Xo
        Fvpc/cyKm15PtCSNJQ8FDOgtdQ==
X-Google-Smtp-Source: ADUXVKJENtChpk6Wug8eN3Vn687TwskHyi4BUG4o3sFO7HJLYgfzDqq5qbwdOf+DARn3GM7KkWmmKg==
X-Received: by 2002:adf:b92d:: with SMTP id k42-v6mr10182336wrf.116.1529322642357;
        Mon, 18 Jun 2018 04:50:42 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-176-63-54-97.catv.broadband.hu. [176.63.54.97])
        by smtp.gmail.com with ESMTPSA id e188-v6sm21727685wmf.21.2018.06.18.04.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 04:50:41 -0700 (PDT)
Date:   Mon, 18 Jun 2018 13:50:38 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 14/39] ovl: stack file ops
Message-ID: <20180618115038.GK23785@veci.piliscsaba.redhat.com>
References: <20180529144339.16538-15-mszeredi@redhat.com>
 <20180610041243.GJ30522@ZenIV.linux.org.uk>
 <CAJfpegtEGuBqmJ+6Kzd0456o0xyebe3LBk66xWQcuzsenqKVeg@mail.gmail.com>
 <20180612022926.GY30522@ZenIV.linux.org.uk>
 <20180612024029.GZ30522@ZenIV.linux.org.uk>
 <CAJfpegvUkcUw0GXxFesT6V2f27EXW7jkvBpvnG4XB49BPdvjjA@mail.gmail.com>
 <20180612182423.GA30522@ZenIV.linux.org.uk>
 <20180612183123.GB30522@ZenIV.linux.org.uk>
 <CAJfpegsnvxUNCaE4c1_UDKq169i8WBTMuWzyvyo8UvenqZCUXg@mail.gmail.com>
 <20180615054717.GC30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615054717.GC30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 06:47:17AM +0100, Al Viro wrote:
> On Wed, Jun 13, 2018 at 11:21:30AM +0200, Miklos Szeredi wrote:

> > Looked at some other options...  What coda mmap does looks very
> > dubious.  It only sets f_mapping, not vm_file.  That's going to get
> > into all sorts of trouble when underlying fs tries to look at
> > file_inode() or worse, ->private_data.  Looks like that should be
> > converted to what overlayfs does, to have a remote chance of actually
> > not crashing on most filesystems.  Does anybody actually use coda
> > still?
> 
> Keep in mind that coda is using the local fs only as cache; IOW, its needs
> are much more limited than those of overlayfs - local r/w filesystem,
> disk-backed or tmpfs, used pretty much as a scratch space.

Look:

coda_file_mmap(struct file *coda_file, struct vm_area_struct *vma)
{
[...]
	coda_file->f_mapping = host_file->f_mapping;
[...]
	return call_mmap(host_file, vma);
}

So that'll end up with vma->vm_file pointing to coda file, coda_file->f_mapping
pointing to host mapping.  Hence vm_ops and a_ops are going to come from host
file, but they'll be getting a "foreign" file with ->private_data and ->f_inode
pointing to coda structures.

For example:

int ext4_filemap_fault(struct vm_fault *vmf)
{
	struct inode *inode = file_inode(vmf->vma->vm_file)
	int err;

	down_read(&EXT4_I(inode)->i_mmap_sem);
[...]

There you have it: coda inode being interpreted as ext4 inode.  How is that
supposed to work?  How is it not blowing up?  What am I missing?

Thanks,
Miklos
