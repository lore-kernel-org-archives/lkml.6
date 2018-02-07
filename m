Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754520AbeBGPUu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:20:50 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:59179 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754417AbeBGPUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:20:48 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@canonical.com>
Cc: Jiri Benc <jbenc@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        netdev@vger.kernel.org, ktkhai@virtuozzo.com,
        stephen@networkplumber.org, w.bumiller@proxmox.com,
        nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, davem@davemloft.net
References: <20180206131902.31937-1-christian.brauner@ubuntu.com>
        <20180206131902.31937-2-christian.brauner@ubuntu.com>
        <20180207121925.5fa1e534@redhat.com>
        <20180207115050.GA29047@gmail.com>
Date: Wed, 07 Feb 2018 09:20:32 -0600
In-Reply-To: <20180207115050.GA29047@gmail.com> (Christian Brauner's message
        of "Wed, 7 Feb 2018 12:50:51 +0100")
Message-ID: <878tc4g727.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ejRWf-0003dV-2N;;;mid=<878tc4g727.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/GGGNE6/nDe7l2CEUsEXuvcTWt31pMeqs=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4989]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@canonical.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 550 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 2.9 (0.5%), b_tie_ro: 1.91 (0.3%), parse: 1.17 (0.2%),
        extract_message_metadata: 24 (4.5%), get_uri_detail_list: 1.89 (0.3%),
        tests_pri_-1000: 9 (1.6%), tests_pri_-950: 2.2 (0.4%), tests_pri_-900: 1.77
        (0.3%), tests_pri_-400: 29 (5.4%), check_bayes: 27 (5.0%), b_tokenize: 10
        (1.8%), b_tok_get_all: 7 (1.2%), b_comp_prob: 4.3 (0.8%), b_tok_touch_all:
        2.8 (0.5%), b_finish: 0.98 (0.2%), tests_pri_0: 466 (84.8%),
        check_dkim_signature: 0.86 (0.2%), check_dkim_adsp: 4.8 (0.9%),
        tests_pri_500: 8 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net 1/1 v3] rtnetlink: require unique netns identifier
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@canonical.com> writes:

> On Wed, Feb 07, 2018 at 12:19:25PM +0100, Jiri Benc wrote:
>> On Tue,  6 Feb 2018 14:19:02 +0100, Christian Brauner wrote:
>> > +/* Verify that rtnetlink requests supporting network namespace ids
>> > + * do not pass additional properties potentially referring to different
>> > + * network namespaces.
>> > + */
>> > +static int rtnl_ensure_unique_netns(struct nlattr *tb[],
>> > +				    struct netlink_ext_ack *extack)
>> > +{
>> > +	/* Requests without network namespace ids have been able to specify
>> > +	 * multiple properties referring to different network namespaces so
>> > +	 * don't regress them.
>> > +	 */
>> > +	if (!tb[IFLA_IF_NETNSID])
>> > +		return 0;
>> 
>> I agree with Eric that we should enforce this also for the existing
>> pid/fd attributes.
>
> Yes, I would prefer this too but in the Linux spirit of never regressing
> userspace I was afraid that there might already be userspace
> applications that stick a pid and an fd at the same time into an
> rtnetlink request. If we are ok with potentially breaking them then we
> should just go for it. It is definitely the cleaner solution.

Odds are low that anything does anything so silly.  If we accidentally
cause a regression then we fix it.  Unless you have reason to suspect
someone actually does something silly we should be good.

Eric
