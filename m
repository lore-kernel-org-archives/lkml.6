Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeEBCSt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 22:18:49 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42923 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeEBCSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 22:18:47 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1524862838-8247-1-git-send-email-longman@redhat.com>
Date: Tue, 01 May 2018 21:18:17 -0500
In-Reply-To: <1524862838-8247-1-git-send-email-longman@redhat.com> (Waiman
        Long's message of "Fri, 27 Apr 2018 17:00:30 -0400")
Message-ID: <87po2ex0k6.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fDhLa-0007Dr-Th;;;mid=<87po2ex0k6.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX194fR8D97k8KGopeMkPAD/2gD+zliWQSiU=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4519]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Waiman Long <longman@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 719 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.0 (0.4%), b_tie_ro: 2.00 (0.3%), parse: 1.14 (0.2%),
        extract_message_metadata: 3.9 (0.5%), get_uri_detail_list: 1.51 (0.2%),
        tests_pri_-1000: 5 (0.7%), tests_pri_-950: 2.0 (0.3%), tests_pri_-900: 1.67
        (0.2%), tests_pri_-400: 26 (3.6%), check_bayes: 24 (3.3%), b_tokenize: 10
        (1.3%), b_tok_get_all: 6 (0.9%), b_comp_prob: 3.4 (0.5%), b_tok_touch_all:
        1.91 (0.3%), b_finish: 0.78 (0.1%), tests_pri_0: 649 (90.2%),
        check_dkim_signature: 0.81 (0.1%), check_dkim_adsp: 319 (44.4%),
        tests_pri_500: 6 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v6 0/8] ipc: Clamp *mni to the real IPCMNI limit & increase that limit
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> The sysctl parameters msgmni, shmmni and semmni have an inherent limit
> of IPC_MNI (32k). However, users may not be aware of that because they
> can write a value much higher than that without getting any error or
> notification. Reading the parameters back will show the newly written
> values which are not real.
>
> Enforcing the limit by failing sysctl parameter write, however, may
> cause regressions if existing user setup scripts set those parameters
> above 32k as those scripts will now fail in this case.

I have a serious problem with this approach.  Have you made any effort
to identify any code that sets these values above 32k?  Have you looked
to see if these applications actually care if you return an error when
a value is set too large?

Right now this seems like a lot of work to avoid breaking applications
and or users that may or may not exist.  If you can find something that
will care sure.  We need to avoid breaking userspace and causing
regressions.  However as this stands it looks you are making maintenance
of the kernel more difficult to avoid having to look to see if there are
monsters under the bed.



Eric
