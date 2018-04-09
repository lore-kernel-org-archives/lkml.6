Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeDIJ7c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 05:59:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41293 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeDIJ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 05:59:30 -0400
Date: Mon, 9 Apr 2018 11:59:12 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: David Gstir <david@sigma-star.at>
Cc: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [RFC] UBIFS authentication
Message-ID: <20180409095912.f7d35y7yjdnj2ffz@pengutronix.de>
References: <E6D3BD02-AF3A-4B75-92FD-A8A07B4C9C51@sigma-star.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E6D3BD02-AF3A-4B75-92FD-A8A07B4C9C51@sigma-star.at>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:47:33 up 108 days, 18:06, 88 users,  load average: 0.05, 0.12,
 0.15
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Wed, Jan 17, 2018 at 04:19:14PM +0100, David Gstir wrote:
> Hi everybody!
> 
> ### Index Authentication
> 
> Through UBIFS' concept of a wandering tree, it already takes care of only
> updating and persisting changed parts from leaf node up to the root node
> of the full B+ tree. This enables us to augment the index nodes of the tree
> with a hash over each node's child nodes. As a result, the index basically also
> a Merkle tree. Since the leaf nodes of the index contain the actual filesystem
> data, the hashes of their parent index nodes thus cover all the file contents
> and file metadata. When a file changes, the UBIFS index is updated accordingly
> from the leaf nodes up to the root node including the master node. This process
> can be hooked to recompute the hash only for each changed node at the same time.
> Whenever a file is read, UBIFS can verify the hashes from each leaf node up to
> the root node to ensure the node's integrity.
> 
> To ensure the authenticity of the whole index, the UBIFS master node stores a
> keyed hash (HMAC) over its own contents (which includes the location of the root
> node) and the root node of the index tree. As mentioned above, the master node
> is always written to the flash whenever the index is persisted (ie. on index
> commit).
> 
> Using this approach only UBIFS index nodes and the master node are changed to
> include a hash. All other types of nodes will remain unchanged. This reduces
> the storage overhead which is precious for users of UBIFS (ie. embedded
> devices).
> 
> 
>                                             HMAC Master Node
>                                                  |
>                       ' ' ' ' ' ' ' ' ' ' ' ' ' '|' '
>                       '     +---------------+    o  '
>                       '     |  Master Node  |       '
>                       '     +---------------+       '       Hash Index Node #1
>                       '             |               '                |
>        . . . . . . . .'. . . . . .  v . . . . . . . . . . . . . . . .|. . . . .
>        .              '      +---------------+      '                o        .
>        .              '      | Index Node #1 |      '                         .
>        .              '      +---------------+      '                         .
>        .              '        |    ...   |  (fanout: 8)                      .
>        .              ' ' ' '  | ' ' ' '  | ' ' ' ' '                         .
>        .               +-------+          +------+                            .
>        .               |                         |                            .
>        .     ' ' ' ' ' v ' ' ' ' '  ' ' ' ' ' '  v  ' ' ' ' ' ' ' ' ' ' '     .
>        .     ' +---------------+ '  '     +---------------+             '     .
>        .     ' | Index Node #2 | '  '     | Index Node #3 |             '     .
>        .     ' +---------------+ '  '     +---------------+             '     .
>        .     '   |   ...         '  '        |   ...   |                '     .
>        . . . ' . v . . . . . . . '. ' . . .  v . . . . v . . . . . . . .' . . .
>              ' +-----------+     '  '+----------+  +-----------+        '
>              ' | Data Node |     '  '| INO Node |  | DENT Node |        '
>              ' +-----------+     '  '+----------+  +-----------+        '
>              '  o                '  '                                o  '
>              ' '|' ' ' ' ' ' ' ' '  ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' '|' '
>                 |                                                    |
>           Hash Index Node #2                                Hash Index Node #3

When a hash covers an index node and also its children then of course
this is really space efficient, but this also means that in order to
read a node we always have to read all of its children. Also adding a
new leaf node means rehashing all siblings. Is it really worth paying
this price to save a few bytes for more hashes?
I would rather suggest to add a hash per child to each index node.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
