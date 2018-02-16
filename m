Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967079AbeBPPP5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:15:57 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:38616 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752192AbeBPPPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:15:55 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 88D1A2F8C77
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: "David S. Miller" <davem@davemloft.net>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>, Van Jacobson <vanj@google.com>,
        Jerry Chu <hkchu@google.com>
Subject: Re: TCP and BBR: reproducibly low cwnd and bandwidth
Date: Fri, 16 Feb 2018 16:15:51 +0100
Message-ID: <2189487.nPhU5NAnbi@natalenko.name>
In-Reply-To: <1697118.nv5eASg0nx@natalenko.name>
References: <1697118.nv5eASg0nx@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1518794152;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
        bh=aXWm3PoC35jSDJ09cLzbO9l3BqzGTa1DSwhNF6GUhAg=;
        b=0RelFhp9kE7M95tpPwQY5GI+QajuLqhFbFKkEt5sWD9Y2pvlRacZFoKhnwVOWNjxOP7B/W
        v3N7/xhltV3ziZuRQ/xOruUmFqdfGFwuXAxCVAhHAWO6OHxZoOYQ7/Ga6gzAOePdYWYLjC
        ZwIfpvnb10MwxNHApFS+Mtemfmo2Xk0=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1518794152; a=rsa-sha256;
        cv=none;
        b=bEw5NvLEQUqGv8Jci7Q0LwgEm2Jw1NL9CSxkPHRTvDVYF8iQA3Groyy7ToeimUWdkHa+YtiJsU60wIsipdnGijbiTVThCvw7HF9DNc8xBW2gGcLn0XGYMakkeu9/7mLCXA7+nS794RSPIPmlz6danj2FMze9ZHXQHeD5nqNYtbc=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name
        smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1GFG1Oi002304

Hi, David, Eric, Neal et al.

On čtvrtek 15. února 2018 21:42:26 CET Oleksandr Natalenko wrote:
> I've faced an issue with a limited TCP bandwidth between my laptop and a
> server in my 1 Gbps LAN while using BBR as a congestion control mechanism.
> To verify my observations, I've set up 2 KVM VMs with the following
> parameters:
> 
> 1) Linux v4.15.3
> 2) virtio NICs
> 3) 128 MiB of RAM
> 4) 2 vCPUs
> 5) tested on both non-PREEMPT/100 Hz and PREEMPT/1000 Hz
> 
> The VMs are interconnected via host bridge (-netdev bridge). I was running
> iperf3 in the default and reverse mode. Here are the results:
> 
> 1) BBR on both VMs
> 
> upload: 3.42 Gbits/sec, cwnd ~ 320 KBytes
> download: 3.39 Gbits/sec, cwnd ~ 320 KBytes
> 
> 2) Reno on both VMs
> 
> upload: 5.50 Gbits/sec, cwnd = 976 KBytes (constant)
> download: 5.22 Gbits/sec, cwnd = 1.20 MBytes (constant)
> 
> 3) Reno on client, BBR on server
> 
> upload: 5.29 Gbits/sec, cwnd = 952 KBytes (constant)
> download: 3.45 Gbits/sec, cwnd ~ 320 KBytes
> 
> 4) BBR on client, Reno on server
> 
> upload: 3.36 Gbits/sec, cwnd ~ 370 KBytes
> download: 5.21 Gbits/sec, cwnd = 887 KBytes (constant)
> 
> So, as you may see, when BBR is in use, upload rate is bad and cwnd is low.
> If using real HW (1 Gbps LAN, laptop and server), BBR limits the throughput
> to ~100 Mbps (verifiable not only by iperf3, but also by scp while
> transferring some files between hosts).
> 
> Also, I've tried to use YeAH instead of Reno, and it gives me the same
> results as Reno (IOW, YeAH works fine too).
> 
> Questions:
> 
> 1) is this expected?
> 2) or am I missing some extra BBR tuneable?
> 3) if it is not a regression (I don't have any previous data to compare
> with), how can I fix this?
> 4) if it is a bug in BBR, what else should I provide or check for a proper
> investigation?

I've played with BBR a little bit more and managed to narrow the issue down to 
the changes between v4.12 and v4.13. Here are my observations:

v4.12 + BBR + fq_codel == OK
v4.12 + BBR + fq       == OK
v4.13 + BBR + fq_codel == Not OK
v4.13 + BBR + fq       == OK

I think this has something to do with an internal TCP implementation for 
pacing, that was introduced in v4.13 (commit 218af599fa63) specifically to 
allow using BBR together with non-fq qdiscs. Once BBR relies on fq, the 
throughput is high and saturates the link, but if another qdisc is in use, for 
instance, fq_codel, the throughput drops. Just to be sure, I've also tried 
pfifo_fast instead of fq_codel with the same outcome resulting in the low 
throughput.

Unfortunately, I do not know if this is something expected or should be 
considered as a regression. Thus, asking for an advice.

Ideas?

Thanks.

Regards,
  Oleksandr
