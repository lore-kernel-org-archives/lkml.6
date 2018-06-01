Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753256AbeFASTf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:19:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45813 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753150AbeFASTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:19:32 -0400
X-ME-Proxy: <xmx:NI4RW8uwvP_rJ4elRwK-sCN87oJR7PnuDtprD3d-YXPB_wfgobDaXw>
X-ME-Proxy: <xmx:NI4RW5qemqMPRBRBM1a8FhQyqmAoy0s3qVyyIM5-cgNwLJBQd9VVrA>
X-ME-Proxy: <xmx:NI4RW5ksJn2OvmK4efus4Vn1GJhgXGJxrs2iU5EdB6vLeamEpsQc4A>
X-ME-Proxy: <xmx:NI4RW9zwJErFqYZUVYW6yn9OcWXP8NaKle9NOyr9Zh8pjZ5YbVqmxA>
X-ME-Proxy: <xmx:NI4RWxkhiDJBPLd6G6Z--lxw3jmfpaAaqWA712rXJVAJqoEdbUoWug>
X-ME-Proxy: <xmx:NI4RW3rtFNiJ1qNLAtSnayutgUG-AAwOfx6NlnA5W4C-6Z9ZbPpdSg>
X-ME-Sender: <xms:NI4RW4a4kjgRhxZHKrDDGWevcn_t7k6Uf-bhhDS8hEMctjg81W68XA>
Date: Fri, 1 Jun 2018 21:19:29 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Tom Herbert <tom@herbertland.com>, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH net] ipv6: omit traffic class when calculating flow hash
Message-ID: <20180601181929.GA16452@splinter>
References: <20180601112948.93BE7A0C48@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601112948.93BE7A0C48@unicorn.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 12:34:41PM +0200, Michal Kubecek wrote:
> Some of the code paths calculating flow hash for IPv6 use flowlabel member
> of struct flowi6 which, despite its name, encodes both flow label and
> traffic class. If traffic class changes within a TCP connection (as e.g.
> ssh does), ECMP route can switch between path. It's also incosistent with
> other code paths where ip6_flowlabel() (returning only flow label) is used
> to feed the key.
> 
> Use only flow label everywhere, including one place where hash key is set
> using ip6_flowinfo().
> 
> Fixes: 51ebd3181572 ("ipv6: add support of equal cost multipath (ECMP)")
> Fixes: f70ea018da06 ("net: Add functions to get skb->hash based on flow structures")
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Hi Michal,

Please consider adding a test case to
tools/testing/selftests/net/fib_tests.sh

Personally, I tested the patch by looping over different values of 'tos'
for 'ip route get' and confirmed that the same nexthop is selected.

Thanks!
