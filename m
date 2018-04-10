Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbeDJOoY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:44:24 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44831 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753097AbeDJOoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:44:21 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+9369930ca44f29e60e2d@syzkaller.appspotmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, <linux-security-module@vger.kernel.org>
References: <0000000000008d2e0d05697a693d@google.com>
        <9d192497-8b1e-ca8d-0ed8-b3324ee1e361@I-love.SAKURA.ne.jp>
Date: Tue, 10 Apr 2018 09:42:50 -0500
In-Reply-To: <9d192497-8b1e-ca8d-0ed8-b3324ee1e361@I-love.SAKURA.ne.jp>
        (Tetsuo Handa's message of "Tue, 10 Apr 2018 19:13:23 +0900")
Message-ID: <87o9irw2ad.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f5uVA-0004hd-0l;;;mid=<87o9irw2ad.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.140.30;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18O51KZq88/188jzEqp6jNNUMsjtwSaEAk=
X-SA-Exim-Connect-IP: 97.119.140.30
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
        *  1.0 T_XMDrugObfuBody_04 obfuscated drug references
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15035 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.3 (0.0%), b_tie_ro: 1.59 (0.0%), parse: 0.75 (0.0%),
        extract_message_metadata: 21 (0.1%), get_uri_detail_list: 1.84 (0.0%),
        tests_pri_-1000: 2.9 (0.0%), tests_pri_-950: 1.18 (0.0%), tests_pri_-900:
        1.00 (0.0%), tests_pri_-400: 22 (0.1%), check_bayes: 21 (0.1%), b_tokenize: 7
        (0.0%), b_tok_get_all: 7 (0.0%), b_comp_prob: 2.0 (0.0%), b_tok_touch_all:
        3.0 (0.0%), b_finish: 0.55 (0.0%), tests_pri_0: 263 (1.7%),
        check_dkim_signature: 0.47 (0.0%), check_dkim_adsp: 2.6 (0.0%),
        tests_pri_500: 14719 (97.9%), poll_dns_idle: 14702 (97.8%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: KASAN: null-ptr-deref Read in xattr_getsecurity
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:

> From 904d07a6eb014f3df0c5a1ebfcfd4323276a9a76 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Tue, 10 Apr 2018 15:15:16 +0900
> Subject: [PATCH] commoncap: Handle memory allocation failure.
>
> syzbot is reporting NULL pointer dereference at xattr_getsecurity() [1],
> for cap_inode_getsecurity() is returning sizeof(struct vfs_cap_data) when
> memory allocation failed. Return -ENOMEM if memory allocation failed.
>
> [1] https://syzkaller.appspot.com/bug?id=a55ba438506fe68649a5f50d2d82d56b365e0107

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Tetsuo I can pick this up, or do you have preferred path for getting
this change merged?

Serge does this fix look ok to you?  I am a bit worried that
might be a bit brittler but I don't see any issues with this change.

Eric


> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: 8db6c34f1dbc8e06 ("Introduce v3 namespaced file capabilities")
> Reported-by: syzbot <syzbot+9369930ca44f29e60e2d@syzkaller.appspotmail.com>
> Cc: stable <stable@vger.kernel.org> # 4.14+
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  security/commoncap.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 48620c9..1ce701f 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -449,6 +449,8 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
>  				magic |= VFS_CAP_FLAGS_EFFECTIVE;
>  			memcpy(&cap->data, &nscap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
>  			cap->magic_etc = cpu_to_le32(magic);
> +		} else {
> +			size = -ENOMEM;
>  		}
>  	}
>  	kfree(tmpbuf);
> --
> 1.8.3.1
