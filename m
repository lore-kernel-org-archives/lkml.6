Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933112AbeEHQex (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:34:53 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:40573 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932080AbeEHQev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:34:51 -0400
X-Google-Smtp-Source: AB8JxZoAaiu/fsfhxPPZSS33LR+ig5k5SzIfItjtzsVitXaF+vRFpQEp7J1GrMEsoapYWkJmSPk/3Q==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: general protection fault in encode_rpcb_string
From: Chuck Lever <chucklever@gmail.com>
In-Reply-To: <20180508161529.GD6151@fieldses.org>
Date: Tue, 8 May 2018 12:34:48 -0400
Cc: Trond Myklebust <trondmy@hammer.space>,
        "syzbot+4b98281f2401ab849f4b@syzkaller.appspotmail.com"
        <syzbot+4b98281f2401ab849f4b@syzkaller.appspotmail.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-Id: <4B24FAE4-C7E8-4D01-9808-B8F4E9E59D64@gmail.com>
References: <f4f5e80803d08f47b9056a0366dd@google.com>
 <20180417213308.GC18217@fieldses.org> <1524002074.63751.5.camel@hammer.space>
 <20180508161529.GD6151@fieldses.org>
To: Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w48GYvki027088



> On May 8, 2018, at 12:15 PM, bfields@fieldses.org wrote:
> 
> On Tue, Apr 17, 2018 at 09:54:36PM +0000, Trond Myklebust wrote:
>> Yes, and we can probably convert it, and the other GFP_ATOMIC
>> allocations in the rpcbind client to use GFP_NOFS in order to improve
>> reliability.
> 
> Chuck, I think the GFP_ATOMIC is unnecessary here as well?
> 
> --b.
> 
> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
> index e8adad33d0bb..de90c6c90cde 100644
> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
> @@ -228,7 +228,7 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, struct xdr_buf *xdrbuf,
> 			/* XXX: Certain upper layer operations do
> 			 *	not provide receive buffer pages.
> 			 */
> -			*ppages = alloc_page(GFP_ATOMIC);
> +			*ppages = alloc_page(GFP_NOFS);
> 			if (!*ppages)
> 				return -EAGAIN;
> 		}

This code can't sleep, as I understand it. Caller is holding
the transport write lock. This logic was copied from
xdr_partial_copy_from_skb, which uses GFP_ATOMIC.

Recall that this is here because of GETACL. As I've stated in
the past, the correct solution is to ensure that these pages
are provided in every case by the upper layer, making this
alloc_page call site unnecessary.


--
Chuck Lever
chucklever@gmail.com
