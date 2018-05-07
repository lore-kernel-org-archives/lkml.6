Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeEGGUp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 02:20:45 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:49574 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751892AbeEGGUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 02:20:42 -0400
Date: Mon, 7 May 2018 08:20:37 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Dmitry Safonov <dima@arista.com>
CC: <linux-kernel@vger.kernel.org>, <0x7f454c46@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Masahide NAKAMURA <nakam@linux-ipv6.org>,
        YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCHv2] net/xfrm: Revert "[XFRM]: Do not add a state whose SPI
 is zero to the SPI hash."
Message-ID: <20180507062037.kxuh2yqfu4z5rkgd@gauss3.secunet.de>
References: <20180504012009.643-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180504012009.643-1-dima@arista.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 6C0E9F6A-719B-4F01-875B-91B44F9D2810
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 02:20:09AM +0100, Dmitry Safonov wrote:
> This reverts commit 7b4dc3600e48 ("[XFRM]: Do not add a state whose SPI
> is zero to the SPI hash.").
> 
> Zero SPI is legal and defined for IPcomp.
> We shouldn't omit adding the state to SPI hash because it'll not be
> possible to delete or lookup for it afterward:
> __xfrm_state_insert() obviously doesn't add hash for zero
> SPI in xfrm.state_byspi, and xfrm_user_state_lookup() will fail as
> xfrm_state_lookup() does lookups by hash.
> 
> It also isn't possible to workaround from userspace as
> xfrm_id_proto_match() will be always true for ah/esp/comp protos.
> 
> v1 link: https://lkml.kernel.org/r/<20180502020220.2027-1-dima@arista.com>
> 
> Cc: Masahide NAKAMURA <nakam@linux-ipv6.org>
> Cc: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Dmitry Safonov <dima@arista.com>

This patch does much more than reverting the commit you mentioned.
It removes all the logic that is needed to handle larval SAs.

The result is a disaster, all connections that are negotiated
by an IKE deamon stop working.

On traffic triggered connections the IKE deamon inserts a new SA
for each packet that matches a policy.
