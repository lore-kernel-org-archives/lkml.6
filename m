Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753610AbeBGJh0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:37:26 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:56011 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753314AbeBGJhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:37:22 -0500
X-Google-Smtp-Source: AH8x227v30vOzd/xJH+YJpAXqHhpqb+p3mnCOrpkmSMp7jXGn6ZunVyZ0kAX20KER9NPMaG+R9osuw==
Date: Wed, 7 Feb 2018 10:37:19 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: UDF driver is not able to read UDF filesystem without
 Terminating Descriptor
Message-ID: <20180207093719.d2rgv5afrhffsdqr@pali>
References: <20180121120856.eoepjk4qnrr7dtwa@pali>
 <20180125163838.ep4ne4sfvgmhwzul@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180125163838.ep4ne4sfvgmhwzul@quack2.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 January 2018 17:38:38 Jan Kara wrote:
> Hi!
> 
> [added linux-fsdevel@vger.kernel.org to CC since that's more appropriate
> than LKML]
> 
> On Sun 21-01-18 13:08:56, Pali Rohár wrote:
> > Hi! In attachment you can find two minimalistic UDF filesystem images.
> > Strictly speaking they are not compliant to Ecma-167 which requires to
> > have at least 258 blocks for filesystem, but Linux kernel has no problem
> > to read also such small UDF filesystems. First one is "udf_with_td", has
> > 89 blocks and udf.ko reads it without problem. Second one is
> > "udf_without_td", has 88 blocks and udf.ko reject it with error message:
> > 
> > UDF-fs: linux/fs/udf/misc.c:223:udf_read_tagged: location mismatch block 1, tag 0 != 1
> > UDF-fs: warning (device loop1): udf_fill_super: No fileset found
> > 
> > The only difference between these two images is presence/absence of
> > Terminating Descriptor (TD).
> > 
> > Looking at the code in function udf_process_sequence(), I found out that
> > udf.ko does not read Partition Descriptor when filesystem does not
> > contain Terminating Descriptor. This is of course wrong as without
> > reading Partition Descriptor it is not possible to locale root directory
> > of the UDF filesystem.
> > 
> > In that function is following code:
> > 
> > 	if (vds[VDS_POS_PARTITION_DESC].block) {
> > 		/*
> > 		 * We rescan the whole descriptor sequence to find
> > 		 * partition descriptor blocks and process them.
> > 		 */
> > 		for (block = vds[VDS_POS_PARTITION_DESC].block;
> > 		     block < vds[VDS_POS_TERMINATING_DESC].block;
> > 		     block++) {
> > 			ret = udf_load_partdesc(sb, block);
> > 			if (ret < 0)
> > 				return ret;
> > 		}
> > 	}
> > 
> > Array vds is initialized to zeros, so when Partition Descriptor is not
> > present then vds[VDS_POS_TERMINATING_DESC].block is zero and so above
> > for loop is immediately stopped.
> > 
> > As a quick fix I applied following patch:
> > 
> > --- a/fs/udf/super.c
> > +++ b/fs/udf/super.c
> > @@ -1620,6 +1620,7 @@ static noinline int udf_process_sequence(
> >  	unsigned int indirections = 0;
> >  
> >  	memset(vds, 0, sizeof(struct udf_vds_record) * VDS_POS_LENGTH);
> > +	vds[VDS_POS_TERMINATING_DESC].block = lastblock;
> >  
> >  	/*
> >  	 * Read the main descriptor sequence and find which descriptors
> > 
> > which forces above loop to call udf_load_partdesc() also when TD is not
> > available.
> 
> Yes, but this will not do the right thing in case there's VDP (volume
> descriptor pointer) descriptor. More on this below.
> 
> > Note that this problem happen also with large enough UDF filesystems
> > without Terminating Descriptor, not only for those small.
> > 
> > And I have not found any restrictions in UDF or ECMA-167 specification
> > that Terminating Descriptor is required.
> 
> You are right that TD does not seem to be required and thus the code is
> buggy.
> 
> > ==========
> > 
> > But I'm not sure if above for loop is correct at all.
> > 
> > In function udf_process_sequence() is code for handling TAG_IDENT_VDP,
> > which allow to scanning nested Volume Descriptor Sequences. And each
> > identifier descriptor handles (increasing) volDescSeqNum except
> > TAG_IDENT_PD which is for Partition Descriptor. Partition Descriptor is
> > always used one which was processed first:
> > 
> > 		case TAG_IDENT_PD: /* ISO 13346 3/10.5 */
> > 			curr = &vds[VDS_POS_PARTITION_DESC];
> > 			if (!curr->block)
> > 				curr->block = block;
> > 			break;
> > 
> > But only the last processed Terminating Descriptor is used:
> > 
> > 		case TAG_IDENT_TD: /* ISO 13346 3/10.9 */
> > ...
> > 			vds[VDS_POS_TERMINATING_DESC].block = block;
> > ...
> > 			break;
> > 
> > And if nested Volume Descriptor Sequences "jumps" to block with smaller
> > number and in that nested sequence is Terminating Descriptor, it would
> > have smaller block number as Partition Descriptor block number (read
> > before nested jump) and so loop for calling udf_load_partdesc() would be
> > stopped at beginning too.
> 
> Yeah, strictly speaking this is possible but that would have to be really
> evil udf image creator ;) But yes, we ought to handle that.

mkudffs in special cases generate such filesystem. I find out it in
code, therefore I generated such image and tested what would kernel
do...

> > Also question is, which Partition Descriptor should be loaded? First
> > processed? Last processed? One with smallest or biggest Sequence Number?
> > Or all which are found, including all in nested sequence?
> 
> So partition descriptors are "special". You can have multiple partition
> descriptiors in the descriptor sequence. "Prevailing descriptors" (this is
> the term from ECMA 167 specification - it means descriptors that should be
> taken into account) are those with highest sequence number found for a
> partition with a particular partition number. So prevailing descriptor for
> partition 0 can have different sequence number than prevailing descriptor
> for partition 1. But still you are correct that processing of PD
> descriptors is hosed both wrt descriptor sequence numbers, VPD descriptor,
> and missing TD descriptors. I'll fix that up (but probably get to it only
> after my vacation next week). Thanks for spotting this!

Ok, so after you are back and would have a proper fix for this, let me know.

-- 
Pali Rohár
pali.rohar@gmail.com
