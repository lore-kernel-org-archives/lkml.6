Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbeDKP6q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:58:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42202 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeDKP6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:58:44 -0400
Date: Wed, 11 Apr 2018 18:58:12 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: David Howells <dhowells@redhat.com>
Cc: Colin Ian King <colin.king@canonical.com>,
        linux-afs@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] afs: fix integer overflow when shifting 1 more
 than 32 places
Message-ID: <20180411155811.2qznymjhi6zlzgbb@mwanda>
References: <62e9abc2-b639-419c-afa7-e89054f7dce9@canonical.com>
 <20180411132613.18974-1-colin.king@canonical.com>
 <23535.1523453966@warthog.procyon.org.uk>
 <24493.1523455816@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24493.1523455816@warthog.procyon.org.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8860 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=709
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804110148
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 03:10:16PM +0100, David Howells wrote:
> Colin Ian King <colin.king@canonical.com> wrote:
> 
> > >> -	mask = (1 << nr_slots) - 1;
> > >> +	mask = (1ULL << nr_slots) - 1;
> > > 
> > > nr_slots cannot be larger than 9, so what I wrote is actually fine and is
> > > more efficient on a 32-bit machine.
> > 
> > ok, sorry about the noise.
> 
> It would be possible to cast the value to u64 before assigning it, I suppose.
> Would that help?  E.g.:
> 
> 	mask = (u64)((1 << nr_slots) - 1);
> 
> It looks a bit odd, though, since the cast is made implicitly anyway.

My feeling is that makes it worse.  It would introduce a secret,
unpublished static checker warning on my build and it doesn't help me as
a reviewer.

Ideally static analyzers should know that nr_slots is 0-9, but right now
that seems pretty tricky to figure out...

regards,
dan carpenter
