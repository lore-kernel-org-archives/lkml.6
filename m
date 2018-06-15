Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FF5C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7305E208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7305E208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756344AbeFOSRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:17:18 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:45346 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753686AbeFOSRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:17:17 -0400
Received: from mipsdag03.mipstec.com (mail3.mips.com [12.201.5.33]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Fri, 15 Jun 2018 11:16:54 -0700
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag03.mipstec.com
 (10.20.40.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Fri, 15
 Jun 2018 11:17:06 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Fri, 15 Jun
 2018 11:17:06 -0700
Date:   Fri, 15 Jun 2018 11:16:54 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     James Hogan <jhogan@kernel.org>
CC:     <linux-mips@linux-mips.org>, Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 4/4] rseq/selftests: Implement MIPS support
Message-ID: <20180615181654.wmaadjgqgq7wksc5@pburton-laptop>
References: <20180614235211.31357-1-paul.burton@mips.com>
 <20180614235211.31357-5-paul.burton@mips.com>
 <20180615105809.GB7603@jamesdev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180615105809.GB7603@jamesdev>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1529086614-321457-25883-48-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.33
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194091
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: jhogan@kernel.org,linux-mips@linux-mips.org,peterz@infradead.org,linux-kernel@vger.kernel.org,mathieu.desnoyers@efficios.com,boqun.feng@gmail.com,paulmck@linux.vnet.ibm.com,ralf@linux-mips.org
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 11:58:10AM +0100, James Hogan wrote:
> On Thu, Jun 14, 2018 at 04:52:10PM -0700, Paul Burton wrote:
> > +#define __RSEQ_ASM_DEFINE_TABLE(version, flags,	start_ip,			\
> 
> Nit: technically all these \'s are on 81st column...

True... I'll replace the runs of tabs with a single space.

> > +#define __RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown,			\
> > +				abort_label, version, flags,			\
> > +				start_ip, post_commit_offset, abort_ip)		\
> > +		".balign 32\n\t"						\
> 
> ARM doesn't do this for DEFINE_ABORT. Is it intentional that we do for
> MIPS?

We need to align this structure at least in the MIPS64 case because the
.dword directive seems to lead to extra padding if we don't, and that
messes up the offsets of the fields.

For example here's an extract from basic_percpu_ops_test built for
MIPS64r6el without the .balign directive, starting from the
RSEQ_ASM_STORE_RSEQ_CS macro in rseq_cmpeqv_storev():

   120001298:   df848068        ld      a0,-32664(gp)
   12000129c:   fc640008        sd      a0,8(v1)
   1200012a0:   8c640004        lw      a0,4(v1)
   1200012a4:   14820011        bne     a0,v0,1200012ec <.L4^B1>
   1200012a8:   00000000        nop
   1200012ac:   dca40000        ld      a0,0(a1)
   1200012b0:   14870015        bne     a0,a3,120001308 <.L5>
   1200012b4:   00000000        nop
   1200012b8:   fca60000        sd      a2,0(a1)
   1200012bc:   1000000d        b       1200012f4 <.L5^B1>
   1200012c0:   00000000        nop
   1200012c4:   00000000        nop
   1200012c8:   00000000        nop
   1200012cc:   00000000        nop
   1200012d0:   200012a0        bovc    zero,zero,120005d54 <__FRAME_END__+0x3e28>
   1200012d4:   00000001        0x1
   1200012d8:   0000001c        0x1c
   1200012dc:   00000000        nop
   1200012e0:   200012ec        bovc    zero,zero,120005e94 <__FRAME_END__+0x3f68>
   1200012e4:   00000001        0x1
   1200012e8:   53053053        0x53053053

...

   120012118:   200012c4        bovc    zero,zero,120016c2c <_end+0x49bc>
   12001211c:   00000001        0x1

And _gp, which the gp register contains the address of:

   $ nm tools/testing/selftests/rseq/basic_percpu_ops_test | grep gp
   000000012001a0b0 d _gp

The ld instruction @120001298 is what the "dla $4, 3f" expanded to, so
it's loading the address of the table which we're going to write to
rseq_cs. It loads from gp-32664, ie. 0x12001a0b0-32664, ie. 0x120012118,
so the table address loaded is 0x1200012c4.

If we take that as the start of the struct rseq_cs then we get:

   1200012c4: __u32 version = 0x0
   1200012c8: __u32 flags = 0x0
   1200012cc: __u64 start_ip = 200012a000000000

Where start_ip is both not naturally aligned, so might be slow to access
or involve T&E, and more importantly doesn't have the intended value.
What happened is that gas inserted 4 bytes of padding at 1200012cc to
naturally align the .dword directive for start_ip, and that throws us
off.

Using the .balign directive avoids this, and I went with 32 bytes
because that's what struct rseq_cs is declared with in linux/rseq.h.

The ARM code has probably gotten away with it because it's 32 bit only,
so isn't emitting any 64 bit values (though if it did I don't know what
an ARM64 assembler would do with regards to alignment & padding anyway).

> Otherwise this whole series looks reasonable to me, so feel free to add
> my rb on the whole series if you do apply youself:
> 
> Reviewed-by: James Hogan <jhogan@kernel.org>

Thanks James :)

Paul
