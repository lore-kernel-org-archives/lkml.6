Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbeCTQZY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:25:24 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:34448 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751669AbeCTQZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:25:22 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Liran Alon <liran.alon@oracle.com>
Cc: <shmulik.ladkani@gmail.com>, <netdev@vger.kernel.org>,
        <mrv@mojatatu.com>, <daniel@iogearbox.net>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <yuval.shaia@oracle.com>,
        <idan.brown@oracle.com>
References: <0d84d286-9965-45cb-93c8-379ca1b2441e@default>
Date: Tue, 20 Mar 2018 11:24:26 -0500
In-Reply-To: <0d84d286-9965-45cb-93c8-379ca1b2441e@default> (Liran Alon's
        message of "Thu, 15 Mar 2018 10:14:01 -0700 (PDT)")
Message-ID: <87tvta67gl.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eyK4d-0006Qb-AJ;;;mid=<87tvta67gl.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Zk1fy+w7/kylh6lH8TcjYR58ZGwHXKlw=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1728]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Liran Alon <liran.alon@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 686 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.1 (0.5%), b_tie_ro: 2.2 (0.3%), parse: 1.30 (0.2%),
        extract_message_metadata: 27 (3.9%), get_uri_detail_list: 3.8 (0.5%),
        tests_pri_-1000: 9 (1.2%), tests_pri_-950: 2.1 (0.3%), tests_pri_-900: 1.62
        (0.2%), tests_pri_-400: 37 (5.4%), check_bayes: 35 (5.1%), b_tokenize: 13
        (1.9%), b_tok_get_all: 9 (1.3%), b_comp_prob: 5 (0.7%), b_tok_touch_all: 3.1
        (0.5%), b_finish: 1.85 (0.3%), tests_pri_0: 592 (86.3%),
        check_dkim_signature: 0.93 (0.1%), check_dkim_adsp: 4.6 (0.7%),
        tests_pri_500: 8 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info only when crossing netns
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liran Alon <liran.alon@oracle.com> writes:

> ----- shmulik.ladkani@gmail.com wrote:
>
>> On Thu, 15 Mar 2018 09:35:51 -0700 (PDT) Liran Alon
>> <liran.alon@oracle.com> wrote:
>> > ----- shmulik.ladkani@gmail.com wrote:
>> > 
>> > > On Thu, 15 Mar 2018 08:01:03 -0700 (PDT) Liran Alon
>> > > <liran.alon@oracle.com> wrote:  
>> > > > 
>> > > > I still think that default behavior should be to zero skb->mark
>> only  
>> > > when skb  
>> > > > cross netdevs in different netns.  
>> > > 
>> > > But the previous default was scrub the mark in *both* xnet and
>> > > non-xnet
>> > > situations.
>> > > 
>> > > Therefore, there might be users which RELY on this (strange)
>> default
>> > > behavior in their same-netns-veth-pair setups.
>> > > Meaning, changing the default behavior might break their apps
>> relying
>> > > on
>> > > the former default behavior.
>> > > 
>> > > This is why the "disable mark scrubbing in non-xnet case" should
>> be
>> > > opt-in.  
>> > 
>> > We think the same.
>> > The only difference is that I think this for now should be
>> controllable
>> > by a global /proc/sys/net/core file instead of giving a flexible
>> per-netdev
>> > control.
>> > Because that is a larger change that could be done later.
>> 
>> A flags attribute to veth newlink is a very scoped change.
>> User controls this per veth creation.
>> This is way more neat than /proc/sys/net and provides the desired
>> granular
>> control.
>> 
>> Also, scoping this to veth has the advantage of not affecting the many
>> other
>> dev_forward_skb callers.
>
> Agreed. But isn't this an issue also for the
> many others (& future) callers of dev_forward_skb()?
> This seems problematic to me.
>
> This will kinda leave a kernel interface with broken default behavior
> for backwards comparability.
>
> A flag to netdev or /proc/sys/net/core to "fix" default behavior
> will avoid this.

I don't believe the current behavior is a bug.

I looked through the history.  Basically skb_scrub_packet
started out as the scrubbing needed for crossing network
namespaces.

Then tunnels which needed 90% of the functionality started
calling it, with the xnet flag added.  Because the tunnels
needed to preserve their historic behavior.

Then dev_forward_skb started calling skb_scrub_packet.

A veth pair is supposed to give the same behavior as a cross-over
cable plugged into two local nics.  A cross over cable won't
preserve things like the skb mark.  So I don't see why anyone would
expect a veth pair to preserve the mark.

Right now I don't see the point of handling packets that don't cross
network namespace boundaries specially, other than to preserve backwards
compatibility.

Eric
