Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932277AbeCLTfe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 15:35:34 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:52204 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751313AbeCLTfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 15:35:32 -0400
X-Google-Smtp-Source: AG47ELtHyYXyNnogWwlIr8fEV0zecVOeEFgk8YW3F6q+r+GIRAvDohtUySmujIOvMyoIjDtHLNmgIw==
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
From: valdis.kletnieks@vt.edu
To: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org
Subject: linux-next 20180307 - UBSAN whine in lib/radix-tree.c
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1520883323_3561P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Mar 2018 15:35:23 -0400
Message-ID: <22378.1520883323@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1520883323_3561P
Content-Type: text/plain; charset=us-ascii

Seen in the dmesg:

[    0.000000] ================================================================================
[    0.000000] UBSAN: Undefined behaviour in lib/radix-tree.c:123:14
[    0.000000] member access within null pointer of type 'const struct radix_tree_node'
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G                T 4.16.0-rc4-next-20180307-dirty #559
[    0.000000] Hardware name: Dell Inc. Latitude E6530/07Y85M, BIOS A20 05/08/2017
[    0.000000] Call Trace:
[    0.000000]  dump_stack+0x83/0xca
[    0.000000]  ubsan_epilogue+0xd/0x3a
[    0.000000]  handle_null_ptr_deref+0x85/0x90
[    0.000000]  __ubsan_handle_type_mismatch_v1+0x5e/0x70
[    0.000000]  __radix_tree_replace+0x1e4/0x1f0
[    0.000000]  radix_tree_iter_replace+0x25/0x50
[    0.000000]  idr_alloc_u32+0x166/0x1f0
[    0.000000]  idr_alloc+0x7e/0xd0
[    0.000000]  worker_pool_assign_id+0x61/0xd0
[    0.000000]  ? mutex_lock_nested+0x1b/0x20
[    0.000000]  workqueue_init_early+0x58a/0xc3f
[    0.000000]  start_kernel+0x4f7/0x809
[    0.000000]  x86_64_start_reservations+0x40/0x61
[    0.000000]  x86_64_start_kernel+0x7b/0x9e
[    0.000000]  secondary_startup_64+0xa5/0xb0
[    0.000000] ================================================================================

not sure why a null 'parent' value got passed to get_slot_offset() in the first place, but it sounds
like something is missing an 'if (NULL)' test...

--==_Exmh_1520883323_3561P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWqbWe40DS38y7CIcAQIKVAgApf8tgcWmqWY2ryW9qObWSS7xUbj4YsVW
gYnnLTdGWaqSJIy/ko+XQuzn5UUrykPULez9Nxrbmguiz+DLTFdEFQlzYbPramPk
0xK8rKyBe9GzCZCzULz4iFp0tWteqi228RhO9Yr3LtDkl6qE3i2vSWxSiqemjvn3
msK+zMnjjgbuJW5rRdmuZ3D7W0rOaz7HNtR23AfewPMQCk83tlVw8m+HU9TrNKii
8jF5PR5zdlY1HsP8Cln/YIvnZlYNvWfDHTDDHb/psfHRUWgKqOVti/Ahdr1ro9hO
xe89gNS9PISA0HI9E3JkjDkPvv2HEtVoCtMkkNaVOM2EZ/oG5UtcNg==
=ObxP
-----END PGP SIGNATURE-----

--==_Exmh_1520883323_3561P--
