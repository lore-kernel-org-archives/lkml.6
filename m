Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeEOTId (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 15:08:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52168 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752386AbeEOTIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 15:08:31 -0400
X-Google-Smtp-Source: AB8JxZqFGYO4SHqvZ18Ms5FQThRIMTHf8sa4w6n8RJrAO0ikqaJGKrmG/eN7w7ogi3iH5ivMi+x5rQ==
Date: Tue, 15 May 2018 22:08:26 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: hch@lst.de, dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] proc: Add a way to make network proc files writable
Message-ID: <20180515190826.GA4788@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Tue, May 01, 2018 at 12:20:33AM +0100, David Howells wrote:
> > Provide two extra functions, proc_create_net_data_write() and
> > proc_create_net_single_write() that act like their non-write versions but
> > also set a write method in the proc_dir_entry struct.
> > 
> > An internal simple write function is provided that will copy its buffer and
> > hand it to the pde->write() method if available (or give an error if not).
> > The buffer may be modified by the write method.
> 
> I thought of doing something like this, aѕ it would remove tons of
> boilerplat code from a lot of procfs instances.  But I'd also like to
> hear what Al and Alexey think of it.  We also should offer this for
> non-net proc users as well.

For the record I hate both series. This is kmalloc disease with its
dozens of signatures to do the same thing slightly differently.
It is just runtime .text reduction is hard to argue against.

Function names become longer and signatures themselves become longer and
now you're arguing about indentation and character limit.

I remember reading about abusing C99 intializers to emulate optional
parameters somewhere. If it can be used (with bloat-o-meter in mind)
it will be very much appreciated.

Currently there are

	->proc_fops
	simple seq_file
	custom seq_file with start and stop
	optional write hook
	->data pointer

which is already way too much.
