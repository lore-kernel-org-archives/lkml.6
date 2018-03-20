Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeCTQpa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:45:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45016 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeCTQpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:45:24 -0400
Message-ID: <5AB13A86.9010607@ORACLE.COM>
Date: Tue, 20 Mar 2018 18:44:54 +0200
From: Liran Alon <LIRAN.ALON@ORACLE.COM>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: shmulik.ladkani@gmail.com, netdev@vger.kernel.org, mrv@mojatatu.com,
        daniel@iogearbox.net, davem@davemloft.net,
        linux-kernel@vger.kernel.org, yuval.shaia@ORACLE.COM,
        idan.brown@ORACLE.COM
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info
 only when crossing netns
References: <0d84d286-9965-45cb-93c8-379ca1b2441e@default> <87tvta67gl.fsf@xmission.com>
In-Reply-To: <87tvta67gl.fsf@xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8838 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/03/18 18:24, ebiederm@xmission.com wrote:
>
> I don't believe the current behavior is a bug.
>
> I looked through the history.  Basically skb_scrub_packet
> started out as the scrubbing needed for crossing network
> namespaces.
>
> Then tunnels which needed 90% of the functionality started
> calling it, with the xnet flag added.  Because the tunnels
> needed to preserve their historic behavior.
>
> Then dev_forward_skb started calling skb_scrub_packet.
>
> A veth pair is supposed to give the same behavior as a cross-over
> cable plugged into two local nics.  A cross over cable won't
> preserve things like the skb mark.  So I don't see why anyone would
> expect a veth pair to preserve the mark.

I disagree with this argument.

I think that a skb crossing netns is what simulates a real packet 
crossing physical computers. Following your argument, why would 
skb->mark should be preserved when crossing netdevs on same netns via 
routing? But this does today preserve skb->mark.

Therefore, I do think that skb->mark should conceptually only be 
scrubbed when crossing netns. Regardless of the netdev used to cross it.

>
> Right now I don't see the point of handling packets that don't cross
> network namespace boundaries specially, other than to preserve backwards
> compatibility.
>
> Eric
>
