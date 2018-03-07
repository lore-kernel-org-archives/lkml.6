Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934348AbeCGWuq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:50:46 -0500
Received: from imap.thunk.org ([74.207.234.97]:40624 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933743AbeCGWup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:50:45 -0500
Date: Wed, 7 Mar 2018 17:50:43 -0500
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: ext4 ignoring rootfs default mount options
Message-ID: <20180307225043.GA15217@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180306190315.puocf5bu3bfz6yct@csclub.uwaterloo.ca>
 <20180307040608.GA2462@thunk.org>
 <20180307151427.i6vbeq6kqo55cdgs@csclub.uwaterloo.ca>
 <20180307160856.GD7507@thunk.org>
 <20180307191324.qtloesy4zdlkfnwv@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307191324.qtloesy4zdlkfnwv@csclub.uwaterloo.ca>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 02:13:24PM -0500, Lennart Sorensen wrote:
> 
> Trying to use tune2fs -E mount_opts to set some default options, and
> can't figure out how to enter two options at once.
>
> ...
>
> Sure in this case I can set one with -o and the other with -E, but in
> general there seems to be a small problem here, probably only in user
> space though.  Seems tune2fs needs some change in how it deals with
> extended options that contain commas.

Yes, this is a shortcoming in tune2fs.  You can set extended mount
options using debugfs:

    debugfs -w -R "set_super_value mount_opts foo,bar" /dev/sda1

... but there ought to be some way to support some kind of quoting
mechanism so that tune2fs can understand when a comma is part of an
extended option value, as opposed to separating extended options.

Extended options haven't been used much, so it's not been something
that has gotten a lot of polish.  Backing up for a bit, is there a
reason why you need so many mount options when mounting the root file
sytsem?  Specifically, why do you want to turn off dellayed allocation?

	 	       	      	       	  - Ted
