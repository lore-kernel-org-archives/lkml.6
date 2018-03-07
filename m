Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933798AbeCGTbg convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 14:31:36 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:40481 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933626AbeCGTbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:31:34 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@canonical.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
References: <20180307161744.GA17562@gmail.com>
Date: Wed, 07 Mar 2018 13:30:52 -0600
In-Reply-To: <20180307161744.GA17562@gmail.com> (Christian Brauner's message
        of "Wed, 7 Mar 2018 17:17:45 +0100")
Message-ID: <878tb3u1hv.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1etemj-0005Ta-7m;;;mid=<878tb3u1hv.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+bNxoEIFNZFMHA7jb312RGNXdQw0XGXqA=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@canonical.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 335 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.4 (0.7%), b_tie_ro: 1.65 (0.5%), parse: 0.96 (0.3%),
        extract_message_metadata: 15 (4.5%), get_uri_detail_list: 3.2 (1.0%),
        tests_pri_-1000: 7 (2.0%), tests_pri_-950: 1.19 (0.4%), tests_pri_-900: 0.93
        (0.3%), tests_pri_-400: 29 (8.5%), check_bayes: 28 (8.2%), b_tokenize: 10
        (3.0%), b_tok_get_all: 9 (2.7%), b_comp_prob: 3.1 (0.9%), b_tok_touch_all:
        2.9 (0.9%), b_finish: 0.65 (0.2%), tests_pri_0: 267 (79.7%),
        check_dkim_signature: 0.61 (0.2%), check_dkim_adsp: 3.2 (0.9%),
        tests_pri_500: 10 (2.9%), poll_dns_idle: 0.93 (0.3%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: Invalid /proc/<pid>/fd/{0,1,2} symlinks with TIOCGPTPEER
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@canonical.com> writes:

> Hey,
>
> We discovered a potential bug in the devpts implementation via
> TIOCGPTPEER ioctl()s today. We've tackled a similar problem already in:
>
> commit 311fc65c9fb9c966bca8e6f3ff8132ce57344ab9
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Thu Aug 24 15:13:29 2017 -0500
>
>     pty: Repair TIOCGPTPEER
>
> Most libcs will *still* look at /dev/ptmx when opening the master fd of
> pty device. Usually, /dev/ptmx will nowadays be either a symlink to
> /dev/pts/ptmx or it will be a second device node with permissions 666
> whereas /dev/pts/ptmx will usually have permissions 000. Afaik, we've
> also always supported making /dev/ptmx a bind-mount to /dev/pts/ptmx or
> at least I haven't observed any issues with this so far and it's
> something fairly common in containers. So in short, it should be legal
> to do:
>
> mount --bind /dev/pts/ptmx /dev/ptmx
> chmod 666 /dev/ptmx
>
> However, for any libc implementation or program that uses TIOCGPTPEER
> the /proc/<pid>/fd/{0,1,2} symlinks are broken (currently affects at
> least glibc 2.27) with bind-mounts of /dev/pts/ptmx to /dev/ptmx. A
> quick reproducer is:
>
> unshare --mount
> mount --bind /dev/pts/ptmx /dev/ptmx
> chmod 666 /dev/ptmx
> script
> ls -al /proc/self/fd/0
>
> Let's assume the slave device index I received was 5 then I would expect to
> see:
>
> ls -al /proc/self/fd/0
> lrwx------ 1 chb chb 64 Mar  7 16:41 /proc/self/fd/0 -> /dev/pts/5
>
> But what I actually see is:
>
> ls -al /proc/self/fd/0
> lrwx------ 1 chb chb 64 Mar  7 16:41 /proc/self/fd/0 -> /
>
> I think the explanation for this is fairly straightforward. When
> userspace does:
>
> master = open("/dev/ptmx", O_RDWR | O_NOCTTY);
> slave = ioctl(master, TIOCGPTPEER, O_RDWR | O_NOCTTY);
>
> and /dev/ptmx is a bind-mount of /dev/pts/ptmx looking up the root mount
> of the dentry for the slave it appears to the kernel as if the dentry is
> escaping it's bind-mount:
>
> ├─/dev        udev          devtmpfs   rw,nosuid,relatime,size=4001260k,nr_inodes=1000315,mode=755
> │ ├─/dev/pts  devpts        devpts     rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000
> │ └─/dev/ptmx devpts[/ptmx] devpts     rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000
>
> since the root mount of the dentry is /dev/pts but the root mount of
> /dev/ptmx is /dev if I'm correct so similar to what Linus pointed out in
> a previous discussion (see [1]) before. So we still record the "wrong"
> vfsmount when /dev/ptmx is a bind-mount and then hit the problem when we
> call devpts_mntget() in drivers/tty/pty.c.

I think your analysis of why we return / is correct. If the root of the
mount is a file (aka /dev/pts/ptmx).  Then any other file will on that
mount will not be under the root of the mount, and will be displayed
as '/'.  Because we have in fact escaped the root of the mount.

I think this is more of a quality of implementation issue more than a
bug per se.

> So I thought about this and - in case my analysis is correct - the
> solution didn't seem obvious to me as a bind-mount has no concept of
> what it's "parent" is (Which in this case should be the devpts mount at
> /dev/pts.).

We might be able to improve the quality of the implementation, by
noticing this case early (sb->s_root != mnt->mnt_root) and using the
same tricks on /dev/pts/ptmx as we do on /dev/ptmx.  That is looking
in ../pts and see if the filesystem we want is there.

It would be a wee bit tricky but doable.  The practical question becomes
what breaks and what makes it worth maintaining such a mechanism.

I don't remember how important it is to have a valid path in proc.  So
I won't comment on how important it is to improve the quality of
the implementation.

The code can be improved by doing something like:

static int devpts_ptmx_pts_path(struct path *path)
{
	struct super_block *sb;
	int err;

	/* Is a devpts filesystem at "pts" in the same directory? */
	err = path_pts(path);
	if (err)
		return err;

	/* Is the path the root of a devpts filesystem? */
	sb = path->mnt->mnt_sb;
	if ((sb->s_magic != DEVPTS_SUPER_MAGIC) ||
	    (path->mnt->mnt_root != sb->s_root))
		return -ENODEV;

	return 0;
}

....
	if ((DEVPTS_SB(path.mnt->mnt_sb) == fsi) &&
	    (path.mnt->mnt_root == fsi->ptmx_dentry)) {
		/* While the start point is a bind mount of single file
                 * walk upwards.
                 */
            	while ((path.mnt->mnt_root == path.dentry) && follow_up(&path))
			;
		if (devpts_ptmx_pts_path(&path) == 0) {
                	dput(path.dentry);
                   	return path.mnt;     
                }
                /* No luck fall through to the old code */
                path_put(path);
                path = filp->f_path;
                path_get(&path);
        }

The fall through vs fail would be a judgement on how important it is to
have a useable path in proc for TIOCPTPEER.

Eric
