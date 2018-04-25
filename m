Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755573AbeDYRDJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:03:09 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:52312 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754585AbeDYRDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:03:06 -0400
Date: Wed, 25 Apr 2018 13:03:04 -0400 (EDT)
Message-Id: <20180425.130304.1605881647944477071.davem@davemloft.net>
To: amsalam20@gmail.com
Cc: dav.lebrun@gmail.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v3] ipv6: sr: Compute flowlabel for outer IPv6
 header of seg6 encap mode
From: David Miller <davem@davemloft.net>
In-Reply-To: <1524594196-12383-1-git-send-email-amsalam20@gmail.com>
References: <1524594196-12383-1-git-send-email-amsalam20@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmed Abdelsalam <amsalam20@gmail.com>
Date: Tue, 24 Apr 2018 20:23:16 +0200

> ECMP (equal-cost multipath) hashes are typically computed on the packets'
> 5-tuple(src IP, dst IP, src port, dst port, L4 proto).
> 
> For encapsulated packets, the L4 data is not readily available and ECMP
> hashing will often revert to (src IP, dst IP). This will lead to traffic
> polarization on a single ECMP path, causing congestion and waste of network
> capacity.
> 
> In IPv6, the 20-bit flow label field is also used as part of the ECMP hash.
> In the lack of L4 data, the hashing will be on (src IP, dst IP, flow
> label). Having a non-zero flow label is thus important for proper traffic
> load balancing when L4 data is unavailable (i.e., when packets are
> encapsulated).
> 
> Currently, the seg6_do_srh_encap() function extracts the original packet's
> flow label and set it as the outer IPv6 flow label. There are two issues
> with this behaviour:
> 
> a) There is no guarantee that the inner flow label is set by the source.
> b) If the original packet is not IPv6, the flow label will be set to
> zero (e.g., IPv4 or L2 encap).
> 
> This patch adds a function, named seg6_make_flowlabel(), that computes a
> flow label from a given skb. It supports IPv6, IPv4 and L2 payloads, and
> leverages the per namespace 'seg6_flowlabel" sysctl value.
> 
> The currently support behaviours are as follows:
> -1 set flowlabel to zero.
> 0 copy flowlabel from Inner paceket in case of Inner IPv6
> (Set flowlabel to 0 in case IPv4/L2)
> 1 Compute the flowlabel using seg6_make_flowlabel()
> 
> This patch has been tested for IPv6, IPv4, and L2 traffic.
> 
> Signed-off-by: Ahmed Abdelsalam <amsalam20@gmail.com>

Applied.

Please submit a patch which adds appropriate documentation for this new sysctl
to Documentation/networking/ip-sysctl.txt

Thank you.
