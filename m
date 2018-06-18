Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788F6C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2182B2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2182B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755449AbeFRVeY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:34:24 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44930 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754519AbeFRVeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:34:22 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fV1ms-0000If-Q2; Mon, 18 Jun 2018 15:34:10 -0600
Received: from 97-119-124-205.omah.qwest.net ([97.119.124.205] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fV1md-0008PF-1z; Mon, 18 Jun 2018 15:34:10 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
References: <87in6kptqt.fsf@xmission.com>
        <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
        <3949.1529353850@warthog.procyon.org.uk>
Date:   Mon, 18 Jun 2018 16:33:41 -0500
In-Reply-To: <3949.1529353850@warthog.procyon.org.uk> (David Howells's message
        of "Mon, 18 Jun 2018 21:30:50 +0100")
Message-ID: <8736xjdbka.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fV1md-0008PF-1z;;;mid=<8736xjdbka.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/pUF+iYP0sv4GNN4ctl07iB8w1S3znR98=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 00/32] VFS: Introduce filesystem context [ver #8]
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>> I have read through these patches and I noticed a significant issue.
>> 
>> Today in mount_bdev we do something that looks like:
>> 
>> mount_bdev(...)
>> {
>> 	s = sget(..., bdev);
>> 	if (s->s_root) {
>>         	/* Noop */
>>         } else {
>>         	err = fill_super(s, ...);
>>                 if (err) {
>>                 	deactivate_locked_super(s);
>>                         return ERR_PTR(err);
>>                 }
>>                 s->s_flags |= SB_ATTIVE;
>>                 bdev->bd_super = s;
>>         }
>>         return dget(s->s_root);
>> }
>> 
>> The key point is that we don't process the mount options at all if
>> a super block already exists in the kernel.  Similar to what
>> your fscontext changes are doing (after parsing the options).
>
> Actually, no, that's not the case.
>
> The fscontext code *requires* you to parse the parameters *before* any attempt
> to access the superblock is made.  Note that this will actually be a problem
> for, say, ext4 which passes a text string stored in the superblock through the
> parser *before* parsing the mount syscall data.  Fun.
>
> I'm intending to deal with that particular case by having ext4 create multiple
> private contexts, one filled in from the user data, and then a second one
> filled in from the superblock string.  These can then be validated one against
> the other before the super_block struct is published.
>
> And if the super_block struct already exists, the user's specified parameters
> can be validated against that.

I did not say parse.  I said process.   My meaning is that today
on a second mount of a filesystem like ext2.  But really most of them we
ignore those options.  

>> Your fscontext changes do not improve upon this area of the mount api at
>> all and that concerns me.  This is an area where people can and already
>> do shoot themselves in their feet.
>
> This *will* be dealt with, but I wanted to get the core changes upstream
> before tackling all the filesystems.  The legacy wrapper is just that and
> should be got rid of when all the filesystems have been converted.

This is an area where you are making things explicit, where before
there was no way to talk about this.   For filesystems that are in
legacy mode I realize we might miss this corner case, but we should
still think about it and handle it.  The proc filesystem has the same
behavior and it is one you are converting.

>> ...
>>
>> Creating a new mount and finding an old mount are the same operation in
>> the kernel today.  This is fundamentally confusing.  In the new api
>> could we please separate these two operations?
>>
>> Perhaps someting like:
>> x create
>> x find
>> 
>> With the "x create" case failing if the filesystem already exists,
>> still allowing "x find"?  And with the "x find" case failing if
>> the superblock is not already created in the kernel.
>
> No.  What you're suggesting introduces a userspace-userspace and a
> userspace-kernel race - unless you're willing to let userspace lock against
> superblock creation by other parties.
>
> Further, some filesystems *have* to be parameterised before you can do the
> check for the superblock.  Network filesystems, for example, where you have to
> set the network parameters upfront and the key to the superblock might not be
> known until you've queried the server.

I am not talking about skipping the parameterization.  I am talking
about actually acting on those options.  Parsing and validating them
ahead of time is not my concern.  When we make the super block
honor those options is my concern.

Further I am not suggesting something that has a meaningful race.
I am suggesting some that is the equivalent of the O_EXCL logic.
I am proposing that "x create" fail if the superblock already exists
in the kernel.  I am proposing that "x find" will fail if the
superblock does not already exist.

In the worst case you have to iterate a time or two when another
user is racing with you to create the super block.  But this
gives you very valuable information.  Knowledge of if the superblock
is honoring all of your specified mount options or not.

It removes an existing nasty race today where people think they mount a
filesystem like "proc" with one set of options and those options are
ignored because an internal kernel mount already exists.

This is at the level of the fscontext API.

I don't care what filesystems that have not been updated to fscontext
do. I just want to avoid the nasty nasty confusion that is possible
with the existing API.

My motivation is I am in the middle of closing a regression in option
parsing in proc that caused a security option to get ignored.

I would be happy even with a result value of "x create" that told
reported if the superbloc "created" or "found".  Instead of having two
different options.

But I want to be able to say to userspace very clearly.  If this
superblock already exists.  You need to go through the
remount/reconfigure code path to change it's options.


>> That should make it clear to a userspace program what is going on
>> and give it a chance to mount a filesystem anyway.
>
> That said, I'm willing to provide a "fail if already extant" option if we
> think that's actually likely to be of use.  However, you'd still have to
> provide parameters before the check can be made.

Yes that is what I am asking for, though very much not optionally.  It
is a rare case and it succeeds in the wrong way today.  Letting people
think they have set a mount option when they have not.

>> In a similar vein could we please clarify the rules for changing mount
>> options for an existing superblock are in the new api?
>
> You mean remount/reconfigure?  Note that we have to provide backward
> compatibility with every single filesystem.

Yes.  I am thinking explicitly of reconfigure.  The old remount
can do whatever is backwards compatible.

>> Today mount assumes that it has to provide all of the existing options to
>> reconfigure a mount.  What people want to do and what most filesystems
>> support is just specifying the options that need to be changed.  Can we
>> please make this the rule of how this are expected to work for fscontext?
>> That only changing mount options need to be specified before: "x
>> reconfigure"
>
> Fine by me - but it must *also* support every option being specified if that
> is what mount currently does.

Yes.  That is what ext4 and xfs support today.

I just want it clear that at least if you use the new reconfigure
interface that you can expect options you have not specified to remain
the same instead of reverting to a default state.

> I don't really want to supply extra parsers if I can avoid it.  Miklós, for
> example wanted a different, incompatible interface, so you'd do:
>
> 	write(fd, "o +foo");
> 	write(fd, "o -bar");
> 	write(fd, "x reconfig");
>
> sort of thing to enable or disable options... but this assumes that options
> are binary and requires a separate parser to the one that does the initial
> configuration - and you still have to support the old remount data parse.
>
> I'm okay with specifying that you should just specify the options you want to
> change and that the normal way to 'disable' something is to prefix it with
> "no".

Yes.  That is what I am asking for.  Just so we don't need to specify
the options that are staying the same.

> I guess I could pass a flag through to indicate that this came from
> sys_mount(MS_REMOUNT) rather than the new method.

I don't think that would be needed.  As some of the most common
filesystems implement this semantic already for sys_mount(MS_REMOUNT).

What I think we might need is to cache the option string during the
transition for unconverted filesystems so that we can give then a full
set of options.  So that if we have an unconverted filesystem like
devpts that assumes a missing option should be set to it's default value
we won't break it.

Eric

