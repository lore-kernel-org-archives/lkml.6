Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934320AbeCENya (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:54:30 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:57403 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933628AbeCENy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:54:27 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <87r2p287i8.fsf_-_@xmission.com>
        <20180302215919.27207-1-ebiederm@xmission.com>
        <CAOssrKf0cuxx1YLiwFJHSnzMOOoejjWWibs98Mb5KSXVSSXfOg@mail.gmail.com>
Date: Mon, 05 Mar 2018 07:53:46 -0600
In-Reply-To: <CAOssrKf0cuxx1YLiwFJHSnzMOOoejjWWibs98Mb5KSXVSSXfOg@mail.gmail.com>
        (Miklos Szeredi's message of "Mon, 5 Mar 2018 10:53:41 +0100")
Message-ID: <87lgf639xx.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1esqZM-00020R-GN;;;mid=<87lgf639xx.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18nRcsOklM1J+HbkvUi4JXH9mj1G09Xvd8=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.0 XMSlimDrugH Weight loss drug headers
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 201 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 5.0 (2.5%), b_tie_ro: 4.0 (2.0%), parse: 1.20 (0.6%),
        extract_message_metadata: 13 (6.4%), get_uri_detail_list: 1.95 (1.0%),
        tests_pri_-1000: 8 (3.9%), tests_pri_-950: 1.63 (0.8%), tests_pri_-900: 1.45
        (0.7%), tests_pri_-400: 23 (11.5%), check_bayes: 22 (10.9%), b_tokenize: 8
        (3.9%), b_tok_get_all: 8 (3.7%), b_comp_prob: 1.60 (0.8%), b_tok_touch_all:
        2.4 (1.2%), b_finish: 0.61 (0.3%), tests_pri_0: 140 (69.8%),
        check_dkim_signature: 0.43 (0.2%), check_dkim_adsp: 2.4 (1.2%),
        tests_pri_500: 3.7 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v8 1/6] fs/posix_acl: Update the comments and support lightweight cache skipping
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> writes:

> On Fri, Mar 2, 2018 at 10:59 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> The code has been missing a way for a ->get_acl method to not cache
>> a return value without risking invalidating a cached value
>> that was set while get_acl() was returning.
>>
>> Add that support by implementing to_uncachable_acl, to_cachable_acl,
>> is_uncacheable_acl, and dealing with uncachable acls in get_acl().
>
> I don't like the pointer magic here.  Can't the uncachable bit just be
> added to struct posix_acl?
>
>  AFAICS that can be done even without increasing the size of that
> struct (e.g. by unioning it with the rcu_head).

Except that would:
- add a possible cache line miss.
- make it unusable for overlayfs.

I am after very light-weight semantics that say don't cache this return
value but don't have any effects elsewhere.

We are already playing pointer magic games in this code.  This just uses
those games for the last piece of information to keep the logic clean.

I see two possible implementation alternatives:
- Make get_acl return a struct that returns the acl and cachability flag
- Add a helper that does"cmpxchg(p, sentinel, ACL_NOT_CACHED)".
  Such a heleper function seems like a waste, it does side effect magic
  which is never particularly pleasant, and it is more code to execute
  in practice.  Though honestly it is my second choice.

  void dont_cache_my_return_acl(struct inode *inode, int type)
  {
    	/* Valid only inside ->get_acl implementations */
        struct posix_acl **p = get_acl_type(inode, type);
        struct posix_acl *sentinel = uncached_acl_sentinel(current);
        cmpxchg(p, sentinel, ACL_NOT_CACHED);
  }
  EXPORT_SYMBOL(dont_cache_my_return_acl);

  It is just a few instructions more so I guess it isn't that bad.
  Especially for something that is not a common case.

Do you think you could live with dont_cache_my_return_acl?

Otherwise I think I will respin this patch set without the acl
unification.  There is plenty of evidence what it will look like
now.  We can deal with the rest of the patches.  Then we can come back
to exactly what acl unification in fuse should look like.

Eric
