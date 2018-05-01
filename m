Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754867AbeEANgg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 09:36:36 -0400
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:2667 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeEANgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 09:36:35 -0400
Message-ID: <1525181758.23227.65.camel@petrovitsch.priv.at>
Subject: Re: Suggested new user link command
From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
To: Tony Wallace <tony@tony.gen.nz>,
        Richard Weinberger <richard.weinberger@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Tue, 01 May 2018 15:35:58 +0200
In-Reply-To: <388f79ad-4ed0-ec39-f649-5c120ee9dc2f@tony.gen.nz>
References: <decdbe00-2292-3012-d7ae-6bfa382fc74a@tony.gen.nz>
         <1525165387.23227.44.camel@petrovitsch.priv.at>
         <a91ef2fb-09ed-51ae-5dfa-8f71ec81f20c@tony.gen.nz>
         <CAFLxGvxpe78WhrEKcKRt5XRBMtT-mZUe9Bm=sQsn8-f1TnX0eQ@mail.gmail.com>
         <388f79ad-4ed0-ec39-f649-5c120ee9dc2f@tony.gen.nz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-DCC-debian-Metrics: esgaroth.tuxoid.at 1169; Body=3 Fuz1=3 Fuz2=3
X-Spam-Report: *  0.0 UNPARSEABLE_RELAY Informational: message has unparseable relay lines
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

Top-quoting is evil BTW.

On Wed, 2018-05-02 at 00:17 +1200, Tony Wallace wrote:
> Two issues here:
> 1) Use case (which I have)
> 2) Permissions
> 
> 1) Use case
> 
> I am trying to build a backup system.  To avoid duplication of files
> over multiple backups I take an Md5 check sum of file contents.  Files
> with the same sum are hardlinked together.   Files are linked in to a
> standard directory structure a new link for each backup that the file is
> part of.  When all backups pointing to a file are deleted the reference
> count drops to zero and the file is deleted.  We can keep a database of
> checksums and there related inode numbers for linking purposes.  So why

a) You can store one of the filenames instead of the inode number.
b) You can keep an extra directory with a hardlink named as the inode 
   number (and delete the entries there if the link count drops to 1).

> not have some reference copy to link against it would take no extra
> space.  Well it doesn't, but it keeps at least one copy of the file on

You have a (disk) space problems on an backup system?
I don't think so, Tim;-)

> disk forever and the reference count never drops to zero.  Using one of
> the backup copies to link to (as stored as the reference copy in the
> database) will not work as it could be deleted at any time.
> 
> I have seen on stack overflow others wanting to do this also.

"Do. Or do not. There is no try." - Yoda
SCNR .....

> 2) Permissions
> 
> To maintain security there are two requirements: 
> 2.1) The effective user must have rights to the inode, that is they must
> either own it or be root
> 2.2) The effective user must have rights file creation rights to the
> directory where it is being linked

Obviously (und useful). And on a backup system, there is no problem
about that (because the backup software probably runs as root anyways
because otherwise 2.1) below will limit the deduplication severely).

But for a (to be mainlined/accepted) new syscall, one should think
about all situations/use cases and not just one.

Additionally to the 2 items above, one needs also x-permissions on
*all* directories from / to one existing hardlink in the traditional
case and such a syscall bypasses that.
Think about it: Everyone can write a progrm to try link all inodes from
 0 to ~0 to a directory entry and gets all files with restrictions 2.1)
and 2.2) from below.
ATM it is enough to `chmod o= ~` to keep all others from all files in
my $HOME. Afterwards it's no longer that easy.

> If you say no, that is fine, but I do think this idea has merit and can
> be done without compromising the system.

I'm no one to say no (or yes;-) here to anything;-) I'm just thinking
about the implications.

And you can always implement a patch and if it's ignored/not accepted,
you can use it locally anyways - no one can stop that:-)

One more - more constructive - thing: Perhaps it is more
acceptable/useful if there is a mount option which must be activated on
the backup filesystems and that is not activated anywhere else.

MfG,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at
