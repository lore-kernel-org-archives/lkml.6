Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753053AbeFARHX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 13:07:23 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:45034 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbeFARHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 13:07:19 -0400
X-Google-Smtp-Source: ADUXVKKViu9wyHez61wu1UbtIrD6P8hPoeTlgldWSM16iuTGmeN9Ly92kb7R/HJayLRprG9oI40QNg==
Date: Fri, 1 Jun 2018 10:07:17 -0700
From: "'tj@kernel.org'" <tj@kernel.org>
To: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Cc: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        "Okajima, Toshiyuki" <toshi.okajima@jp.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'ebiederm@aristanetworks.com'" <ebiederm@aristanetworks.com>
Subject: Re: [RESEND PATCH v2] kernfs: fix dentry unexpected skip
Message-ID: <20180601170717.GY1351649@devbig577.frc2.facebook.com>
References: <33710E6CAA200E4583255F4FB666C4E21B63D491@G01JPEXMBYT03>
 <20180529162627.GH1351649@devbig577.frc2.facebook.com>
 <33710E6CAA200E4583255F4FB666C4E21B65779C@G01JPEXMBYT03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E21B65779C@G01JPEXMBYT03>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jun 01, 2018 at 09:25:32AM +0000, Hatayama, Daisuke wrote:
> kernfs_dir_pos() checks if a kernfs_node object given as one of its
> arguments is still active and if so returns it, or returns a
> kernfs_node object that is most equal (possibly smaller and larger) to
> the given object.

Sometimes they're duplicate operations tho, which is exactly the bug
the posted patch is trying to fix.  What I'm suggesting is instead of
leaving both instances and skipping one conditionally, put them in one
place and trigger only when necessary.  The sequence of operations
would be exactly the same.  The only difference is how the code is
organized.

> kernfs_dir_next_pos() returns a kernfs_node object that is next to the
> object given by kernfs_dir_pos().
> 
> Two functions does different things and both need to skip inactive
> nodes. I don't think it natural to remove the skip only from
> kernfs_dir_pos().
> 
> OTOH, throughout getdents(), there is no case that the kernfs_node
> object given to kernfs_dir_pos() is used afterwards in the
> processing. So, is it enough to provide kernfs_dir_next_pos() only?
> Then, the skip code is now not duplicated.
> 
> The patch below is my thought. How do you think?
> 
> But note that this patch has some bug so that system boot get hang
> without detecting root filesystem disk :) I'm debugging this now.

I haven't looked into the code that closely but given that we had
cases where both skippings were fine and not, the condition is likely
gonna be a bit tricker?

Thanks.

-- 
tejun
