Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbeBTVS4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 16:18:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:30793 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750799AbeBTVSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 16:18:54 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="202527153"
Date: Tue, 20 Feb 2018 13:18:50 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joe Konno <joe.konno@linux.intel.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        matthew.garrett@nebula.com, jk@ozlabs.org, ak@linux.intel.com,
        mjg59@google.com, pjones@redhat.com, Andy Lutomirski <luto@kernel.org>,
        james.bottomley@hansenpartnership.com
Subject: Re: [PATCH 1/2] fs/efivarfs: restrict inode permissions
Message-ID: <20180220211849.fqjb6rdmypl6opir@agluck-desk>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <20180215182208.35003-2-joe.konno@linux.intel.com>
 <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 11:18:57AM -0800, Andy Lutomirski wrote:
> On 02/15/2018 10:22 AM, Joe Konno wrote:
> > From: Joe Konno <joe.konno@intel.com>
> > 
> > Efivarfs nodes are created with group and world readable permissions.
> > Reading certain EFI variables trigger SMIs. So, this is a potential DoS
> > surface.
> > 
> > Make permissions more restrictive-- only the owner may read or write to
> > created inodes.
...
> The discussion in this thread has gone on too long, so:
> 
> Acked-by: Andy Lutomirski <luto@kernel.org>
> 
> And yes, this patch will break a couple of minor usecases, but IMO those
> usecases deserve to break.
...
> > -	inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0644, 0,
> > +	inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0600, 0,
> >   				   is_removable);

Linus,

Does this rate an exception to the "don't break userspace" for a security issue?

What breaks:
User can't run efibootmgr(8) to see things like BootOrder. Also
"fwupdate", "dbxtool", "mokutil", and "tpmtotp" have some modes
where ordinary users need read access to some EFI variables.

We looked at some other options.

1) When mounting efivarfs have it read all the variables and
   cache the values. Then user can read without making an EFI
   call because we just copyout the cached copy.
   Rejected as there can be a lot of variables (70 on Peter Jones
   system) and EFI dropped the 1KB per variable limit. So this
   pins a bunch of memory for a few obscure use cases.

2) Rate limit EFI calls for non-root
   This solution still has some cheer-leaders. Obviously a bit
   more code than just changing the permissions. But would also
   preemptively fix any other places where an ordinary user can
   trigger an EFI call.

-Tony
