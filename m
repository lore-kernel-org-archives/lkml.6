Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751589AbeCTS26 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 14:28:58 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:54862 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbeCTS2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 14:28:53 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <cover.1512741134.git.dongsu@kinvolk.io>
        <878tbmf5vl.fsf@xmission.com> <87po4rz4ui.fsf_-_@xmission.com>
        <87r2p287i8.fsf_-_@xmission.com> <87ina6ntx0.fsf_-_@xmission.com>
        <CAOssrKebhX-nm06RAwep8HUUV4QpsAa=ZOgxdRyP=WF9p-=4Tw@mail.gmail.com>
Date: Tue, 20 Mar 2018 13:27:57 -0500
In-Reply-To: <CAOssrKebhX-nm06RAwep8HUUV4QpsAa=ZOgxdRyP=WF9p-=4Tw@mail.gmail.com>
        (Miklos Szeredi's message of "Tue, 20 Mar 2018 17:25:06 +0100")
Message-ID: <87tvta38lu.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eyM0A-0000lM-5k;;;mid=<87tvta38lu.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX185e7+SB4+sONbq6A8ZkqrCUUKliE+vL7k=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 820 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.1 (0.4%), b_tie_ro: 2.0 (0.2%), parse: 1.34 (0.2%),
        extract_message_metadata: 28 (3.4%), get_uri_detail_list: 5 (0.6%),
        tests_pri_-1000: 10 (1.3%), tests_pri_-950: 2.1 (0.3%), tests_pri_-900: 1.71
        (0.2%), tests_pri_-400: 49 (5.9%), check_bayes: 46 (5.6%), b_tokenize: 16
        (1.9%), b_tok_get_all: 11 (1.3%), b_comp_prob: 6 (0.7%), b_tok_touch_all: 7
        (0.8%), b_finish: 0.89 (0.1%), tests_pri_0: 711 (86.7%),
        check_dkim_signature: 0.92 (0.1%), check_dkim_adsp: 6 (0.7%), tests_pri_500:
        8 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v9 0/4] fuse: mounts from non-init user namespaces
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> writes:

> On Thu, Mar 8, 2018 at 10:23 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> This patchset builds on the work by Donsu Park and Seth Forshee and is
>> reduced to the set of patches that just affect fuse.  The non-fuse
>> vfs patches are far enough along we can ignore them except possibly for the
>> question of when does FS_USERNS_MOUNT get set in fuse_fs_type.
>>
>> Fuse with a block device has been left as an exercise for a later time.
>>
>> Since v5 I changed the core of this patchset around as the previous
>> patches were showing signs of bitrot.  Some important explanations were
>> missing, some important functionality was missing, and xattr handling
>> was completely absent.
>>
>> Since v6 I have:
>> - Removed the failure case from fuse_get_req_nofail_nopages that I
>>   added.
>> - Updated fuse to always to use posix_acl_access_xattr_handler, and
>>   posix_acl_default_xattr_handler, by teaching fuse to set
>>   ACL_DONT_CACHE when FUSE_POSIX_ACL is not set.
>>
>> Since v7 I have:
>> - Rethought and reworked how I am unifying the cached and the non-cached
>>   posix acl case so the code is cleaner and simpler.
>>   - I have dropped enhancements to caching negative acls when
>>     fc->no_getxattr is set.
>>   - Removed the need to wrap forget_all_cached_acls in fuse.
>> - Reorder the patches so the posix acl work comes first
>>
>> Since v8 I have:
>> - Dropped and postponed the unification of the uncached and the cached
>>   posix acls case.  The code is not hard but tricky enough it needs
>>   to be considered on it's own on it's own merits.
>>
>> Miklos can you take a look and see what you think?
>>
>> Miklos if you could pick these up I would appreciate it.  If not I can
>> merge these through the userns tree.
>
> Thank you Eric for moving this along.  Patches pushed to:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
>
> I did just one modification to "fuse: Fail all requests with invalid
> uids or gids": instead of zeroing out the context for the nofail case,
> continue to use the "_munged" variants. I don't think this hurts and
> is better for backward compatibility (I guess the only relevant use
> would be for debugging output, but we don't want to regress even for
> that if not necessary)

Hmm...

The thing is the failure doesn't come in the difference between the
_munged and the normal variants.  The difference between
munged and non-munged variants is how they handled failure ((uid16_t)-2)
aka 0xfffe for munged and -1 for the non-munged case.

The failures are introduced by changing &init_user_ns to fc->user_ns.

The operations in question are iop->flush and fuse_force_forget (on an
error).   I don't know what value having ids on those paths will do
they are operations that must succeed, and they should not change the
on-disk ids.  I was thinking saying the most privileged id was asking
for the oepration would seem to make sense.

With the munged variants we will get (uid16_t)-2 aka 0xfffe aka
nobody asking for the operation if things don't map.  In practice
the don't map case is new.

Since the id's should not be looked at anyway I don't see it makes
much difference which ids we use so the munged case seems at least
plausible.

It might be better to use the non-munghed variant and do:
	if (req->in.h.uid == (uid_t)-1)
		req.in.h.uid = 0;
	if (req->in.h.gid == (gid_t)-1)
        	req.in.h.gid = 0;

That might be less surprising to userspace.  As I don't think the
unmapped case has ever occurred in practice yet.  The vfs will work hard
to keep the unmapped case from happening but only in the context of
i_uid and i_gid not current_fsuid and current_fsgid.

Eric
