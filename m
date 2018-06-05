Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeFEPmP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:42:15 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:41870 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbeFEPmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:42:14 -0400
X-Google-Smtp-Source: ADUXVKLBLnmEVUFHvP66kkh9sJVZhMkeusG/JwLllft9auu0NnsEPPM6NPX0D0RmzOlrov/64I5lXQ==
Date: Tue, 5 Jun 2018 08:42:10 -0700
From: "'tj@kernel.org'" <tj@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>,
        "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        "Okajima, Toshiyuki" <toshi.okajima@jp.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'ebiederm@aristanetworks.com'" <ebiederm@aristanetworks.com>
Subject: Re: [CFT][PATCH] kernfs: Correct kernfs directory seeks.
Message-ID: <20180605154210.GD1351649@devbig577.frc2.facebook.com>
References: <33710E6CAA200E4583255F4FB666C4E21B63D491@G01JPEXMBYT03>
 <87wovhqex2.fsf@xmission.com>
 <87po17r9ek.fsf_-_@xmission.com>
 <33710E6CAA200E4583255F4FB666C4E21B65E04E@G01JPEXMBYT03>
 <87sh62k3vk.fsf@xmission.com>
 <33710E6CAA200E4583255F4FB666C4E21B66BAC8@G01JPEXMBYT03>
 <87h8mhgsh3.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8mhgsh3.fsf@xmission.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jun 05, 2018 at 10:31:36AM -0500, Eric W. Biederman wrote:
> What I have above is not the clearest, and in fact the logic could be
> better.
> 
> The fundamental challenge is because hash collisions are possible a file
> offset does not hold complete position information in a directory.
> 
> So the kernfs node that is to be read/displayed next is saved in the
> struct file.  The it is tested if the saved kernfs node is usable
> for finding the location in the directory.  Several things may have
> gone wrong.
> 
> - Someone may have called seekdir.
> - The saved kernfs node may have been renamed.
> - The saved kernfs node may have been moved to a different directory in
>   kernfs.
> - the saved kernfs node may have been deleted.
> 
> If any of those are true the code needs to do the rbtree lookup.

So, given that the whole thing is protected by a mutex which protects
modifications, it could be an option to simply keep track of who's
iterating what and shift them on removals.  IOW, always keep cursor
pointing to the next thing to visit and if that gets removed shift the
cursor to the next one.

Thanks.

-- 
tejun
