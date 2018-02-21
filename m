Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeBUVCS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:02:18 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36114 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbeBUU67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:58:59 -0500
X-Google-Smtp-Source: AH8x225ZR8/DqENta698Ia/vRtEvjZXxhH54NxRtzVkLxaQJuoebFOerU3VvBgQelX2kl9e8b+s44w==
Date: Wed, 21 Feb 2018 23:58:55 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, avagin@virtuozzo.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] proc: fix /proc/*/map_files lookup some more
Message-ID: <20180221205855.GA2540@avx2>
References: <20180221184411.GA25924@avx2>
 <20180221185143.GJ30522@ZenIV.linux.org.uk>
 <20180221195340.GA28911@avx2>
 <20180221120403.504b7f1c814618bac39bb78b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221120403.504b7f1c814618bac39bb78b@linux-foundation.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 12:04:03PM -0800, Andrew Morton wrote:
> On Wed, 21 Feb 2018 22:53:40 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > I totally forgot that _parse_integer() accepts arbitrary amount of
> > leading zeroes leading to the following:
> > 
> > 		OK
> > 	# readlink /proc/1/map_files/56427ecba000-56427eddc000
> > 	/lib/systemd/systemd
> > 
> > 		bogus
> > 	# readlink /proc/1/map_files/00000000000056427ecba000-56427eddc000
> > 	/lib/systemd/systemd
> > 	# readlink /proc/1/map_files/56427ecba000-00000000000056427eddc000
> > 	/lib/systemd/systemd
> > 
> > ...
> > 
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -1916,6 +1916,8 @@ static int dname_to_vma_addr(struct dentry *dentry,
> >  	unsigned long long sval, eval;
> >  	unsigned int len;
> >  
> > +	if (str[0] == '0' && str[1])
> > +		return -EINVAL;
> >  	len = _parse_integer(str, 16, &sval);
> >  	if (len & KSTRTOX_OVERFLOW)
> >  		return -EINVAL;
> > @@ -1927,6 +1929,8 @@ static int dname_to_vma_addr(struct dentry *dentry,
> >  		return -EINVAL;
> >  	str++;
> >  
> > +	if (str[0] == '0' && str[1])
> > +		return -EINVAL;
> >  	len = _parse_integer(str, 16, &eval);
> >  	if (len & KSTRTOX_OVERFLOW)
> >  		return -EINVAL;
> 
> I don't know this code and I'm all confused.
> 
> - why is the code designed to accept addresses of "0"?

Now I'm confused.
Code rejects, say ,'07ff...-...' because printing with %lx-%lx would never
produce leading zero.

> - how do we know that the first digit of a VMA address will never be 0?

Except when address is exactly 0 but this case is handled by looking at
the second character.
