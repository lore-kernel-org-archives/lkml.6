Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751723AbeFEFwP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 01:52:15 -0400
Received: from mgwym04.jp.fujitsu.com ([211.128.242.43]:10430 "EHLO
        mgwym04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeFEFwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 01:52:14 -0400
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
To: "'Eric W. Biederman'" <ebiederm@xmission.com>
CC: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        "'tj@kernel.org'" <tj@kernel.org>,
        "Okajima, Toshiyuki" <toshi.okajima@jp.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'ebiederm@aristanetworks.com'" <ebiederm@aristanetworks.com>
Subject: RE: [CFT][PATCH] kernfs: Correct kernfs directory seeks.
Thread-Topic: [CFT][PATCH] kernfs: Correct kernfs directory seeks.
Thread-Index: AQHT/HFLI3mQ17S8REWGMo+9PpY1yqRRKDIA
Date: Tue, 5 Jun 2018 05:52:05 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E21B66BAFB@G01JPEXMBYT03>
References: <33710E6CAA200E4583255F4FB666C4E21B63D491@G01JPEXMBYT03>
        <87wovhqex2.fsf@xmission.com> <87po17r9ek.fsf_-_@xmission.com>
        <33710E6CAA200E4583255F4FB666C4E21B65E04E@G01JPEXMBYT03>
        <87sh62k3vk.fsf@xmission.com> <87h8mihtx5.fsf@xmission.com>
In-Reply-To: <87h8mihtx5.fsf@xmission.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217-enc
x-shieldmailcheckermailid: 164f185dab124feda3e3f0bace252a03
x-originating-ip: [10.124.89.120]
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Eric W. Biederman [mailto:ebiederm@xmission.com]
> Sent: Tuesday, June 5, 2018 11:03 AM
> To: Hatayama, Daisuke <d.hatayama@jp.fujitsu.com>
> Cc: 'gregkh@linuxfoundation.org' <gregkh@linuxfoundation.org>;
> 'tj@kernel.org' <tj@kernel.org>; Okajima, Toshiyuki 
> <toshi.okajima@jp.fujitsu.com>; linux-kernel@vger.kernel.org;
> 'ebiederm@aristanetworks.com' <ebiederm@aristanetworks.com>
> Subject: Re: [CFT][PATCH] kernfs: Correct kernfs directory seeks.
> 
> ebiederm@xmission.com (Eric W. Biederman) writes:
> 
> > "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com> writes:
> >
> >>> Can you test this and please verify it fixes your issue?
> >>
> >> I tried this patch on top of v4.17 but the system fails to boot
> >> without detecting root disks by dracut like this:
> [snip]
> 
> >> OTOH, there's no issue on the pure v4.17 kernel.
> >>
> >> As above, ls /sys/module looks apparently good. But I guess any part of
> >> behavior of getdentries() on sysfs must have changed, affecting the disk
> >> detection...
> >
> > I haven't been able to reproduce this yet.  My test system boots fine.
> > Which fedora are you testing on?
> 
> I reproduced something similar and fedora 28.  So I think I have found
> and fixed the issue.  I believe I simply reversed the test at the end of
> kernfs_dir_pos. AKA "<" instead of ">".

Though too late, I used fedora 28 and RHEL7.5.

I applied this fix to your patch and the system boot was successfully done.

I'll start testing your patch from now on.

> 
> I am going to see if I can test my changes more throughly on this side
> and then repost.
> 
> 
> 
> >>>  fs/kernfs/dir.c | 109
> >>> ++++++++++++++++++++++++++++++++++----------------------
> >>>  1 file changed, 67 insertions(+), 42 deletions(-)
> >>>
> >>> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> >>> index 89d1dc19340b..8148b5fec48d 100644
> >>> --- a/fs/kernfs/dir.c
> >>> +++ b/fs/kernfs/dir.c
> >>> @@ -1584,53 +1584,75 @@ static int kernfs_dir_fop_release(struct inode
> *inode,
> >>> struct file *filp)
> >>>  	return 0;
> >>>  }
> >>>
> >>> +static struct kernfs_node *kernfs_dir_next(struct kernfs_node *pos)
> >>> +{
> >>> +	struct rb_node *node = rb_next(&pos->rb);
> >>> +	return node ? rb_to_kn(node) : NULL;
> >>> +}
> >>> +
> >>>  static struct kernfs_node *kernfs_dir_pos(const void *ns,
> >>> -	struct kernfs_node *parent, loff_t hash, struct kernfs_node *pos)
> >>> +	struct kernfs_node *parent, loff_t off, struct kernfs_node *saved)
> >>>  {
> >>> -	if (pos) {
> >>> -		int valid = kernfs_active(pos) &&
> >>> -			pos->parent == parent && hash == pos->hash;
> >>> -		kernfs_put(pos);
> >>> -		if (!valid)
> >>> -			pos = NULL;
> >>> -	}
> >>> -	if (!pos && (hash > 1) && (hash < INT_MAX)) {
> >>> -		struct rb_node *node = parent->dir.children.rb_node;
> >>> -		while (node) {
> >>> -			pos = rb_to_kn(node);
> >>> -
> >>> -			if (hash < pos->hash)
> >>> -				node = node->rb_left;
> >>> -			else if (hash > pos->hash)
> >>> -				node = node->rb_right;
> >>> -			else
> >>> -				break;
> >>> +	struct kernfs_node *pos;
> >>> +	struct rb_node *node;
> >>> +	unsigned int hash;
> >>> +	const char *name = "";
> >>> +
> >>> +	/* Is off a valid name hash? */
> >>> +	if ((off < 2) || (off >= INT_MAX))
> >>> +		return NULL;
> >>> +	hash = off;
> >>> +
> >>> +	/* Is the saved position usable? */
> >>> +	if (saved) {
> >>> +		/* Proper parent and hash? */
> >>> +		if ((parent != saved->parent) || (saved->hash != hash)) {
> >>> +			saved = NULL;
> >>
> >> name is uninitialized in this path.
> >
> > It is.  name is initialized to "" see above.
> >
> >>> +		} else {
> >>> +			if (kernfs_active(saved))
> >>> +				return saved;
> >>> +			name = saved->name;
> >>>  		}
> >>>  	}
> >>> -	/* Skip over entries which are dying/dead or in the wrong namespace
> >>> */
> >>> -	while (pos && (!kernfs_active(pos) || pos->ns != ns)) {
> >>> -		struct rb_node *node = rb_next(&pos->rb);
> >>> -		if (!node)
> >>> -			pos = NULL;
> >>> +
> >>> +	/* Find the closest pos to the hash we are looking for */
> >>> +	pos = NULL;
> >>> +	node = parent->dir.children.rb_node;
> >>> +	while (node) {
> >>> +		int result;
> >>> +
> >>> +		pos = rb_to_kn(node);
> >>> +		result = kernfs_name_compare(hash, name, ns, pos);
> >>> +		if (result < 0)
> >>> +			node = node->rb_left;
> >>> +		else if (result > 0)
> >>> +			node = node->rb_right;
> >>>  		else
> >>> -			pos = rb_to_kn(node);
> >>> +			break;
> >>>  	}
> >>> +
> >>> +	/* Ensure pos is at or beyond the target position */
> >>> +	if (pos && (kernfs_name_compare(hash, name, ns, pos) < 0))
>                                                     ^^^^^^^^^^^^^^^^
>                                           should be > 0
> >>> +		pos = kernfs_dir_next(pos);
> >>> +
> 
> Eric
> 
