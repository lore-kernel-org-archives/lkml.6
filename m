Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750903AbeCMEDn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 00:03:43 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44829 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbeCMEDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 00:03:42 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CA+55aFyP9JtyzUzA_S2sdKCK+8CZtNoA3UkXg5X4J0Hf2_ekjg@mail.gmail.com>
        <20180224002248.GH30522@ZenIV.linux.org.uk>
        <20180225073950.GI30522@ZenIV.linux.org.uk>
        <87bmgbnhar.fsf_-_@linutronix.de>
        <20180312191351.GN30522@ZenIV.linux.org.uk>
        <877eqhcab3.fsf@xmission.com>
        <20180312203916.GQ30522@ZenIV.linux.org.uk>
        <87woygan6p.fsf@xmission.com> <87tvtk97i8.fsf@xmission.com>
        <20180313003751.GT30522@ZenIV.linux.org.uk>
        <20180313005010.GV30522@ZenIV.linux.org.uk>
Date: Mon, 12 Mar 2018 23:02:32 -0500
In-Reply-To: <20180313005010.GV30522@ZenIV.linux.org.uk> (Al Viro's message of
        "Tue, 13 Mar 2018 00:50:11 +0000")
Message-ID: <87po484o87.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1evb9h-0001fi-Uw;;;mid=<87po484o87.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/UZG+F24xbe2z/+I36WGKNedzTRizErmw=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@ZenIV.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15025 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.9 (0.0%), b_tie_ro: 2.0 (0.0%), parse: 1.20 (0.0%),
        extract_message_metadata: 13 (0.1%), get_uri_detail_list: 3.1 (0.0%),
        tests_pri_-1000: 2.9 (0.0%), tests_pri_-950: 1.14 (0.0%), tests_pri_-900:
        0.95 (0.0%), tests_pri_-400: 27 (0.2%), check_bayes: 26 (0.2%), b_tokenize: 9
        (0.1%), b_tok_get_all: 9 (0.1%), b_comp_prob: 2.6 (0.0%), b_tok_touch_all:
        3.6 (0.0%), b_finish: 0.60 (0.0%), tests_pri_0: 224 (1.5%),
        check_dkim_signature: 0.48 (0.0%), check_dkim_adsp: 3.8 (0.0%),
        tests_pri_500: 14748 (98.2%), poll_dns_idle: 14740 (98.1%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: dcache: remove trylock loops (was Re: [BUG] lock_parent() breakage when used from shrink_dentry_list())
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> writes:

> On Tue, Mar 13, 2018 at 12:37:51AM +0000, Al Viro wrote:
>> On Mon, Mar 12, 2018 at 06:52:31PM -0500, Eric W. Biederman wrote:
>> 
>> > Ah.  I see now there is now the s_roots list that handles
>> > that bit of strangeness.
>> > 
>> > So one path is to simply remove the heuristic from
>> > path_connected.
>> > 
>> > Another path is to have nfsv2 and nfsv3 not set s_root at all.
>> > Leaving the heuristic working for the rest of the filesystems,
>> > and generally simplifying the code.
>> > 
>> > Something like the diff below I should think.
>> 
>> > +	/* Leave nfsv2 and nfsv3 s_root == NULL */
>> 
>> Now, grep fs/super.c for s_root.  Or try to boot it, for that
>> matter...
>
> BTW, if rename happens on server and we step into directory
> we'd already seen in one subtree while doing a lookup in
> another, we will get it moved around.  Without having the
> subtrees ever connected in dcache on client.  So adding
> && IS_ROOT(sb->s_root) to the test also won't work.

Nope.  We fundamentally need to call is_subdir in the nfs case
to ensure we don't have crazy problems.

I believe below is the obviously correct fix (that still preserves some
caching).  I need to look at nilfs as it also calls d_obtain_root.  I am
also wondering if some of the other network filesystems might be
susceptible to problems caused by renames on the server.

It is tempting to be more clever and not consider NFS_MOUNT_UNSHARED
mounts or mounts without mulitple s_roots but there can be renames
on the server that should trip up even those cases.  At least if
anything figures out how to trigger the dentries in the path to ever get
revalidated.

Eric

diff --git a/fs/namei.c b/fs/namei.c
index 921ae32dbc80..cafa365eeb70 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -559,9 +559,10 @@ static int __nd_alloc_stack(struct nameidata *nd)
 static bool path_connected(const struct path *path)
 {
 	struct vfsmount *mnt = path->mnt;
+	struct super_block *sb = mnt->mnt_sb;
 
-	/* Only bind mounts can have disconnected paths */
-	if (mnt->mnt_root == mnt->mnt_sb->s_root)
+	/* Bind mounts and multi-root filesystems can have disconnected paths */
+	if (!(sb->s_iflags & SB_I_MULTIROOT) && (mnt->mnt_root == sb->s_root))
 		return true;
 
 	return is_subdir(path->dentry, mnt->mnt_root);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 29bacdc56f6a..64129a72f312 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2631,6 +2631,7 @@ struct dentry *nfs_fs_mount_common(struct nfs_server *server,
 		/* initial superblock/root creation */
 		mount_info->fill_super(s, mount_info);
 		nfs_get_cache_cookie(s, mount_info->parsed, mount_info->cloned);
+		s->s_iflags |= SB_I_MULTIROOT;
 	}
 
 	mntroot = nfs_get_root(s, mount_info->mntfh, dev_name);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2a815560fda0..0430e03febaa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1317,6 +1317,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_CGROUPWB	0x00000001	/* cgroup-aware writeback enabled */
 #define SB_I_NOEXEC	0x00000002	/* Ignore executables on this fs */
 #define SB_I_NODEV	0x00000004	/* Ignore devices on this fs */
+#define SB_I_MULTIROOT	0x00000008	/* Multiple roots to the dentry tree */
 
 /* sb->s_iflags to limit user namespace mounts */
 #define SB_I_USERNS_VISIBLE		0x00000010 /* fstype already mounted */
