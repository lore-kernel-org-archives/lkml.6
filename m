Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dQCZKQKCGlvtWwAAmS7hNA
	; Fri, 08 Jun 2018 13:17:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DFD82608BA; Fri,  8 Jun 2018 13:17:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6E67F606FA;
	Fri,  8 Jun 2018 13:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E67F606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbeFHNRz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:17:55 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:53132 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbeFHNRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:17:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fRHH4-0007GB-Fz; Fri, 08 Jun 2018 14:17:50 +0100
Message-ID: <1528463869.2289.92.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 017/268] do d_instantiate/unlock_new_inode
 combinations safely
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: stable@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 14:17:49 +0100
In-Reply-To: <20180528100203.994843437@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
         <20180528100203.994843437@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-28 at 11:59 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> commit 1e2e547a93a00ebc21582c06ca3c6cfea2a309ee upstream.
> 
> For anything NFS-exported we do _not_ want to unlock new inode
> before it has grown an alias; original set of fixes got the
> ordering right, but missed the nasty complication in case of
> lockdep being enabled - unlock_new_inode() does
> 	lockdep_annotate_inode_mutex_key(inode)
> which can only be done before anyone gets a chance to touch
> ->i_mutex.  Unfortunately, flipping the order and doing
> unlock_new_inode() before d_instantiate() opens a window when
> mkdir can race with open-by-fhandle on a guessed fhandle, leading
> to multiple aliases for a directory inode and all the breakage
> that follows from that.
> 
> 	Correct solution: a new primitive (d_instantiate_new())
> combining these two in the right order - lockdep annotate, then
> d_instantiate(), then the rest of unlock_new_inode().  All
> combinations of d_instantiate() with unlock_new_inode() should
> be converted to that.
[...]

I think you missed xfs, which has a wrapper around unlock_new_inode()
called xfs_finish_inode_setup().  It looks like xfs_generic_create()
and xfs_vn_symlink() still need this conversion.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
