Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753604AbeEONnz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 09:43:55 -0400
Received: from verein.lst.de ([213.95.11.211]:42000 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752154AbeEONnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 09:43:53 -0400
Date: Tue, 15 May 2018 15:48:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Cc: hch@lst.de, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] proc: Add a way to make network proc files writable
Message-ID: <20180515134811.GB31066@lst.de>
References: <152513042072.13808.9692322366778075206.stgit@warthog.procyon.org.uk> <152513043358.13808.4250608064312146536.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <152513043358.13808.4250608064312146536.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 12:20:33AM +0100, David Howells wrote:
> Provide two extra functions, proc_create_net_data_write() and
> proc_create_net_single_write() that act like their non-write versions but
> also set a write method in the proc_dir_entry struct.
> 
> An internal simple write function is provided that will copy its buffer and
> hand it to the pde->write() method if available (or give an error if not).
> The buffer may be modified by the write method.

I thought of doing something like this, aѕ it would remove tons of
boilerplat code from a lot of procfs instances.  But I'd also like to
hear what Al and Alexey think of it.  We also should offer this for
non-net proc users as well.

> +struct proc_dir_entry *proc_create_net_data_write(const char *name, umode_t mode,
> +						  struct proc_dir_entry *parent,
> +						  const struct seq_operations *ops,
> +						  proc_write_t write,
> +						  unsigned int state_size, void *data)
> +{

The other option I though about would be to hide a write callback
in struct seq_operations, as that way all the existing helpers would
just work.

Btw one of the lines above is over 80 chars.  By using normal two
tab indents for the continuations this would become a lot more readable:

struct proc_dir_entry *proc_create_net_data_write(const char *name,
		umode_t mode, struct proc_dir_entry *parent,
		const struct seq_operations *ops, proc_write_t write,
		unsigned int state_size, void *data)
