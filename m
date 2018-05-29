Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934571AbeE2Nol (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:44:41 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:45660 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934183AbeE2Noj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:44:39 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian@brauner.io>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@kernel.org, james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com
References: <20180528215355.16119-1-christian@brauner.io>
        <20180528215355.16119-5-christian@brauner.io>
        <87r2lusl8l.fsf@xmission.com> <20180529124159.GB11221@mailbox.org>
Date: Tue, 29 May 2018 08:44:22 -0500
In-Reply-To: <20180529124159.GB11221@mailbox.org> (Christian Brauner's message
        of "Tue, 29 May 2018 14:41:59 +0200")
Message-ID: <87fu2apoeh.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fNevU-0003Ol-AV;;;mid=<87fu2apoeh.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/aPs6JEd5ipzP93vR70RmFaBLr9ahXwsw=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian@brauner.io>
X-Spam-Relay-Country: 
X-Spam-Timing: total 237 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.5 (1.5%), b_tie_ro: 2.4 (1.0%), parse: 1.42 (0.6%),
        extract_message_metadata: 17 (7.0%), get_uri_detail_list: 2.3 (1.0%),
        tests_pri_-1000: 7 (3.0%), tests_pri_-950: 1.71 (0.7%), tests_pri_-900: 1.38
        (0.6%), tests_pri_-400: 25 (10.6%), check_bayes: 24 (10.0%), b_tokenize: 9
        (3.8%), b_tok_get_all: 7 (2.9%), b_comp_prob: 2.9 (1.2%), b_tok_touch_all:
        3.0 (1.2%), b_finish: 0.62 (0.3%), tests_pri_0: 171 (72.2%),
        check_dkim_signature: 0.59 (0.2%), check_dkim_adsp: 3.2 (1.4%),
        tests_pri_500: 4.5 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v1 04/20] signal: add copy_pending() helper
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:

> On Tue, May 29, 2018 at 07:24:26AM -0500, Eric W. Biederman wrote:
>> Christian Brauner <christian@brauner.io> writes:
>> 
>> > Instead of using a goto for this let's add a simple helper copy_pending()
>> > which can be called in both places.
>> 
>> Ick no.  As far as I can see this just confuses the logic of the
>> collect_signal function.
>> 
>> Instead of having two cases with an optional
>> "sigdelset(&list->signal, sig)" if the signal is no longer in the queue,
>> you are moving the core work of collect_signal into another function.
>> 
>> At the very least this is going to make maintenance more difficult
>> as now the work of this function is split into two functions.
>
> I do disagree here tbh. The goto jump into it the if part of an if-else
> seems pretty nasty.
> I also don't know why this should be confusing the logic. There's a
> single function that is called in two places and it is declared directly
> atop it's only caller. Additionally, recognizing a single name of a
> function as being the same in two places is way easier then recognizing
> that a multi-line pattern is the same in two places.

But there are not two places.  There is only one place.
The logic might be cleaned up reorganizing the tests a little bit.
Something like this perhaps.

	/*
	 * Collect the siginfo appropriate to this signal.  Check if
	 * there is another siginfo for the same signal.
	*/
	list_for_each_entry(q, &list->list, list) {
		if (q->info.si_signo == sig) {
			if (first)
                        	break;
			first = q;
		}
	}

	/* Not still pending? */
	if (!first || (&q->list != &list->list))
        	sigdelset(&list->signal, sig);
	if (first) {
		...


The logic at a high level is:
	Is there another instance of this signal pending?
             yes?  Then don't "sigdelset"
        Do we have siginfo?
           yes? return it.
           no?  dummy up a siginfo.

Making that logic clearer would be nice.  Obscuring it with
an extra function just obstructs maintenance.

Eric
