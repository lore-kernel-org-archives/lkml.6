Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A105C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC67205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC67205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeK2FyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:54:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:27022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbeK2FyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:54:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A55A308A941;
        Wed, 28 Nov 2018 18:51:48 +0000 (UTC)
Received: from dhcp-25.97.bos.redhat.com (unknown [10.18.25.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B5FA7B605;
        Wed, 28 Nov 2018 18:51:44 +0000 (UTC)
From:   Aaron Conole <aconole@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Brouer <brouer@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Gospodarek <andy@greyhouse.net>,
        Rony Efraim <ronye@mellanox.com>,
        Simon Horman <horms@verge.net.au>,
        Marcelo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [RFC -next v0 1/3] bpf: modular maps
References: <20181125180919.13996-1-aconole@bytheb.org>
        <20181125180919.13996-2-aconole@bytheb.org>
        <20181127020608.4vucwmhrtu2cxrwu@ast-mbp.dhcp.thefacebook.com>
        <f7tftvmd2ey.fsf@dhcp-25.97.bos.redhat.com>
        <20181128051001.wcsgqx3d6c2aszp6@ast-mbp.dhcp.thefacebook.com>
Date:   Wed, 28 Nov 2018 13:51:42 -0500
Message-ID: <f7to9a99gsh.fsf@dhcp-25.97.bos.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 28 Nov 2018 18:51:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Nov 27, 2018 at 09:24:05AM -0500, Aaron Conole wrote:
>> 
>>   1. Introduce flowmap again, this time, basically having it close to a
>>      copy of the hashmap.  Introduce a few function calls that allow an
>>      external module to easily manipulate all maps of that type to insert
>>      / remove / update entries.  This makes it similar to, for example,
>>      devmap.
>
> what is a flowmap?
> How is this flowmap different from existing hash, lpm and lru maps?

The biggest difference is how relationship works.  Normal map would
have single key and single value.  Flow map needs to have two keys
"single-value," because there are two sets of flow tuples to track
(forward and reverse direction).  That means that when updating the k-v
pairs, we need to ensure that the data is always consistent and up to
date.  Probably we could do that with the existing maps if we had some
kind of allocation mechanism, too (so, keep a pointer to data from two
keys - not sure if there's a way to do that in ebpf)?

Still I need a way to get the conntrack information from netfilter (or
really any other entity that will provide it) into the bpf map, whatever
map type it takes.

> 'close to a copy of hashmap'... why hashmap is not enough for your purpose?

It might be (see the item 2. in that list).  I'm trying to allow
netfilter conntrack to update the bpf map so that the flow offload data
is available, and make sure that when I look up a 5-tuple from the
bpf program in the map, I get the appropriate flow-offload data (ie:
forward direction addresses could be different from reverse direction so
just swapping addresses / ports will not match).  Like I wrote in the
cover letter (but probably poorly, sorry for that), I want to forward
packets into the stack until a connection is added to the table, and
then push the packets directly to the places they need to go, doing the
nat etc.  That lets us use xdp as a fast forwarding path for
connections, getting all of the advantage of helper modules to do the
control / parsing, and all the advantage of xdp for packet movement.

Maybe I don't see a better solution, though - or possibly there's a more
generic approach that works better.
