Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04BEC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A872098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrnCeOT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A872098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeJCXyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:54:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38311 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeJCXyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:54:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id r77-v6so1851704pgr.5;
        Wed, 03 Oct 2018 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nIy8VN3aC0hVK/rpqOLNZuCzP9jGevjG6bDpsCC2T+U=;
        b=PrnCeOT+odfUd2W5o7DtOLTUaGDeraxNrzF3Rd3ovnJBQLr5GT4o7CGShB8RHrFT/c
         WcNDRFKrl3Ngqi2wFG+F6ytL1ofSN6Mlf5EXcJKqbh4tFlnfYu9ZuZDWTdloDBW30jgc
         YsLFUJST+tDE6ZvXdXSMIh34VXemRfX9gLmZAbE7tE74e749BJEO30Shm/wupDQ41oIa
         R3QgeRIrbf8wtxSgcv3pIdA+hcyz2O52vhWK6bCeziaR6JubMGd47EN37240NUQ/csib
         4AqM3WFtupgXnw0ZJxIiDw6qVsisRnW5hEHAn26hdsd99nSWCGkW0jcCcO+jB9SPLPSY
         EN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nIy8VN3aC0hVK/rpqOLNZuCzP9jGevjG6bDpsCC2T+U=;
        b=A2iqbF02B01q7ddv6oU02bvaLlvcA+f1nbDLr8pT+jUfnrGywsRGtP0Rdu2s+qr+g0
         68Wj0K1nlRq264W/C52z1oHG4liUacpjIVDSWbaA/puYLnRdgT6CD8/jqKYLXyRW7yVp
         hIVRwk4ChCbv4AMbPNQ2fTRi9oZqspO7DDpYXAEvBr63iw4UDKahJr4cu27g05B9qide
         uu4UDJ+q/HD99ctWZ7VM7qNxWP8RAR+5aX6/Mrq0mydxphwSAONZc5erRzmqTHQImOSO
         aCew7hAfUNEeRMkzLUgQ7CRJUdOSCT9TL70v4ADI1VcodnfOWTpEsaSXUZr1VPIsx0hw
         ifzA==
X-Gm-Message-State: ABuFfoi6Vdgzm/gYWSKwvIQG2RMR09Nbpp0tgUc6DhDFDozfTFlNGivI
        obVSjEkCSscRhU8MVha8uC8b8qlx
X-Google-Smtp-Source: ACcGV63NlYlf1y2tiCWQPRmzXnYBjWguWbo2yyRICSuXZsmtVISxVLuk46tXeuFP4kB+900/cS78mg==
X-Received: by 2002:a63:5d03:: with SMTP id r3-v6mr2192525pgb.445.1538586324721;
        Wed, 03 Oct 2018 10:05:24 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:4f27])
        by smtp.gmail.com with ESMTPSA id e134-v6sm3505772pfh.26.2018.10.03.10.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 10:05:23 -0700 (PDT)
Date:   Wed, 3 Oct 2018 10:05:22 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: BPF: RCU use-after-reallocation of hash table elements?
Message-ID: <20181003170520.gc43zeffylshz5k2@ast-mbp.dhcp.thefacebook.com>
References: <CAG48ez0Q3BaFsA_FUs1ZCAMRZtXkq5o_VCbU8CgTEVwa2HRZfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0Q3BaFsA_FUs1ZCAMRZtXkq5o_VCbU8CgTEVwa2HRZfQ@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 06:15:08PM +0200, Jann Horn wrote:
> Hi!
> 
> Note: I haven't tested any of this; feel free to tell me that I've
> completely misunderstood how all this works.
> 
> The BPF manpage, at the moment, states about BPF hash tables:

unfortunately man pages have been obsolete for long time.
the only doc that is mostly up to date is
http://docs.cilium.io/en/latest/bpf/

> Unless a BPF hash table is created with the (undocumented) flag
> BPF_F_NO_PREALLOC, the kernel now actually pre-allocates the hash
> table elements. Hash table elements can be freed and reused for new
> allocations (!) without waiting for an RCU grace period: Freed
> elements are immediately pushed on the percpu freelist, and can be
> immediately reused from there. The most obvious consequence of this is
> that if a BPF program looks up a hash table entry and then reads the
> value, the value can be replaced with a new value in between. A more
> subtle consequence is that BPF map lookups can return false-positive
> results: If the first half of the lookup key matches the old key, and
> the second half of the lookup key matches the new key, then a BPF map
> lookup can return a false-positive result, as far as I can tell.

Correct. That is the case when one cpu deletes the pre-allocated element
and immediately reuses the slot in update_elem while another cpu is still
looking into it.

> If what I'm saying is correct, I'm not sure what the best fix is.
>
> Add a grace period when freeing hash map entries, and add a new -EBUSY
> return value for attempts to create hash map entries when all free
> entries are waiting for the end of an RCU grace period?
> 
> Add a grace period when freeing hash map entries, and use
> rcu_synchronize() when inserting BPF hashmap entries from userspace
> and all free entries are waiting for RCU? But that still leaves the
> bpf_map_update_elem_proto helper that can be called from BPF.
> Deprecate that helper for access to hash maps?
> 
> Document the race, and advise people who use BPF for
> non-performance-tracing purposes (where occasional false positives
> actually matter) to use BPF_F_NO_PREALLOC?

Definitely our fault that it's not documented clearly.
There are subtle issues with kmalloc style as well.
See free_htab_elem():
  atomic_dec(&htab->count);
  l->htab = htab;
  call_rcu(&l->rcu, htab_elem_free_rcu);
which means that for short time the total memory
consumption of the no_prealloc hash map can be higher
than max_entries limit while rcu callbacks are working their way through.
For bpf prog that is invoked million times a second and constantly
doing delete/update the rcu callback latency can be an issue.
Hence the use of no_prealloc needs to be carefully considered as well.

we tried to atomic_dec in rcu callback, but that caused even more
issues, since already written bpf progs expected max_entries limit
to be accurate.

> Add some sort of sequence lock to BPF (yuck)?

why yuck reaction? ;)
Locks are mandatory primitives in concurrent programming and
the lock support is coming to bpf as well.
bpf progs themselves will be able to do lock/unlock of objects
to maintain atomicity of multi field updates.
Right now updating two counters atomically is pretty much impossible.
hash map update can replace the element with a copy, but that's not
usable for counters.
Soon the program will be able to do:
struct value_t {
  u32 var1, var2;
  bpf_lock_t lock;
};
struct value_t * value = bpf_map_lookup_elem(map, &key);
bpf_lock(&value->lock);
value->var1++;
value->var2++;
bpf_unlock(&value->lock);
and verifier will be smart enough to make sure locks don't escape.

Also alloc/free will be available to bpf progs and new program
types won't have to run as one giant rcu_lock+preempt_disable section.
Progs will be able to do rcu_lock/unlock and preempt_enable/disable
from inside the program.

