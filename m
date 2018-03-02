Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932387AbeCBVug (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 16:50:36 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:48920 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932131AbeCBVue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 16:50:34 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <87po4rz4ui.fsf_-_@xmission.com>
        <20180226235302.12708-5-ebiederm@xmission.com>
        <CAOssrKeWvYpgj4_cgsRBL_kTOHyRS-9_mfO9JHP-JahgqFnfHQ@mail.gmail.com>
Date: Fri, 02 Mar 2018 15:49:56 -0600
In-Reply-To: <CAOssrKeWvYpgj4_cgsRBL_kTOHyRS-9_mfO9JHP-JahgqFnfHQ@mail.gmail.com>
        (Miklos Szeredi's message of "Tue, 27 Feb 2018 10:00:25 +0100")
Message-ID: <87fu5i9mgr.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ersZU-00067Y-6n;;;mid=<87fu5i9mgr.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18M8r3PpH9aWfkmmNgc6Uai8WKA3qn5Ehg=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4782]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 190 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.9 (1.5%), b_tie_ro: 1.86 (1.0%), parse: 0.75 (0.4%),
        extract_message_metadata: 9 (4.9%), get_uri_detail_list: 1.22 (0.6%),
        tests_pri_-1000: 5 (2.8%), tests_pri_-950: 1.11 (0.6%), tests_pri_-900: 0.99
        (0.5%), tests_pri_-400: 18 (9.7%), check_bayes: 17 (9.2%), b_tokenize: 6
        (3.0%), b_tok_get_all: 6 (3.1%), b_comp_prob: 1.88 (1.0%), b_tok_touch_all:
        2.4 (1.3%), b_finish: 0.54 (0.3%), tests_pri_0: 145 (76.2%),
        check_dkim_signature: 0.47 (0.2%), check_dkim_adsp: 2.4 (1.3%),
        tests_pri_500: 4.0 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v7 5/7] fuse: Simplfiy the posix acl handling logic.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> writes:

> On Tue, Feb 27, 2018 at 12:53 AM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Rename the fuse connection flag posix_acl to cached_posix_acl as that
>> is what it actually means.  That fuse will cache and operate on the
>> cached value of the posix acl.
>>
>> When fc->cached_posix_acl is not set, set ACL_DONT_CACHE on the inode
>> so that get_acl and friends won't cache the acl values even if they
>> are called.
>>
>> Replace forget_all_cached_acls with fuse_forget_cached_acls.  This
>> wrapper only takes effect when cached_posix_acl is true to prevent
>> losing the nocache or noxattr status in when posix acls are not
>> cached.
>
> Shouldn't forget_cached_acl() be taught about ACL_DONT_CACHE?  I think
> it makes sense to generally not clear ACL_DONT_CACHE, since it's not
> an actual acl value that needs forgetting.

After stopping to make certain I understand the issues, I don't think
it makes sense to teach forget_cached_acl about ACL_DONT_CACHE.

If you are fogetting a cached attribute ACL_DONT_CACHE simply doesn't
make sense.

Further it makes sense to cache a negative result for fuse when
!fc->no_getxattr.  Even if you would ordinarily not cache posix acls.

So I think the better plan is to teach the posix acl code how to not
cache results on a case by case basis.  As I did in my rfc patch I
posted a little earlier today.  That works with forget_cached_acl and it
supports local reasoning.  Further while the performance might not be as
good as ACL_DONT_CACHE I don't think that matters as always going to the
fuse server to get acls is almost certainly going to dominate the acl
costs.

Eric
