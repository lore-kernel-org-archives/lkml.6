Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbeCTSgA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 14:36:00 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42274 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeCTSf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 14:35:57 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Ben Greear <greearb@candelatech.com>
Cc: Liran Alon <LIRAN.ALON@ORACLE.COM>, shmulik.ladkani@gmail.com,
        netdev@vger.kernel.org, mrv@mojatatu.com, daniel@iogearbox.net,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        yuval.shaia@ORACLE.COM, idan.brown@ORACLE.COM
References: <0d84d286-9965-45cb-93c8-379ca1b2441e@default>
        <87tvta67gl.fsf@xmission.com> <5AB13A86.9010607@ORACLE.COM>
        <d031d870-27c0-3fde-7ab8-bf65f6c9d910@candelatech.com>
Date: Tue, 20 Mar 2018 13:35:00 -0500
In-Reply-To: <d031d870-27c0-3fde-7ab8-bf65f6c9d910@candelatech.com> (Ben
        Greear's message of "Tue, 20 Mar 2018 10:07:47 -0700")
Message-ID: <87lgem38a3.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eyM6z-00085x-Gj;;;mid=<87lgem38a3.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+emzsOfcleYedGI/zYIzRn9dwpCmA/pFU=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4439]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Ben Greear <greearb@candelatech.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 615 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 2.9 (0.5%), b_tie_ro: 1.99 (0.3%), parse: 1.31 (0.2%),
        extract_message_metadata: 30 (4.9%), get_uri_detail_list: 2.8 (0.5%),
        tests_pri_-1000: 14 (2.3%), tests_pri_-950: 2.7 (0.4%), tests_pri_-900: 1.87
        (0.3%), tests_pri_-400: 36 (5.9%), check_bayes: 34 (5.6%), b_tokenize: 12
        (1.9%), b_tok_get_all: 8 (1.2%), b_comp_prob: 4.5 (0.7%), b_tok_touch_all: 7
        (1.1%), b_finish: 0.76 (0.1%), tests_pri_0: 512 (83.2%),
        check_dkim_signature: 0.83 (0.1%), check_dkim_adsp: 6 (1.0%), tests_pri_500:
        8 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info only when crossing netns
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:

> On 03/20/2018 09:44 AM, Liran Alon wrote:
>>
>>
>> On 20/03/18 18:24, ebiederm@xmission.com wrote:
>>>
>>> I don't believe the current behavior is a bug.
>>>
>>> I looked through the history.  Basically skb_scrub_packet
>>> started out as the scrubbing needed for crossing network
>>> namespaces.
>>>
>>> Then tunnels which needed 90% of the functionality started
>>> calling it, with the xnet flag added.  Because the tunnels
>>> needed to preserve their historic behavior.
>>>
>>> Then dev_forward_skb started calling skb_scrub_packet.
>>>
>>> A veth pair is supposed to give the same behavior as a cross-over
>>> cable plugged into two local nics.  A cross over cable won't
>>> preserve things like the skb mark.  So I don't see why anyone would
>>> expect a veth pair to preserve the mark.
>>
>> I disagree with this argument.
>>
>> I think that a skb crossing netns is what simulates a real packet
>> crossing physical computers. Following your argument, why would
>> skb->mark should be preserved when crossing netdevs on same netns via
>> routing? But this does today preserve skb->mark.
>>
>> Therefore, I do think that skb->mark should conceptually only be
>> scrubbed when crossing netns. Regardless of the netdev used to cross
>> it.
>
> It should be scrubbed in VETH as well.  That is one way to make virtual routers.  Possibly
> the newer VRF features will give another better way to do it, but you should not break
> things that used to work.
>
> Now, if you want to add a new feature that allows one to configure the kernel (or VETH) for
> a new behavior, then that might be something to consider.
>
>>> Right now I don't see the point of handling packets that don't cross
>>> network namespace boundaries specially, other than to preserve backwards
>>> compatibility.
>
> Well, backwards compat is a big deal all by itself!

Absolutely agreed.

Eric
