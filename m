Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3690BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECED921924
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733155AbeLUQEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:04:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729789AbeLUQEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:04:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6133E99D29;
        Fri, 21 Dec 2018 16:04:53 +0000 (UTC)
Received: from [10.36.116.27] (ovpn-116-27.ams2.redhat.com [10.36.116.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4748B177E0;
        Fri, 21 Dec 2018 16:04:51 +0000 (UTC)
Subject: Re: [PATCH v3] mm, page_alloc: Fix has_unmovable_pages for HugePages
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pavel.tatashin@microsoft.com,
        rppt@linux.vnet.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181221062809.31771-1-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <a9be72d5-d87b-3165-6275-d50d6611b533@redhat.com>
Date:   Fri, 21 Dec 2018 17:04:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181221062809.31771-1-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 21 Dec 2018 16:04:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.12.18 07:28, Oscar Salvador wrote:
> v3 -> v2: Get rid of the round_up()
> v2 -> v1: Adjust skip pages logic per Michal
> 
> From 8c057ff497a078f28e293af8c0bd089893a57753 Mon Sep 17 00:00:00 2001
> From: Oscar Salvador <osalvador@suse.de>
> Date: Wed, 19 Dec 2018 00:04:18 +0000
> Subject: [PATCH] mm, page_alloc: fix has_unmovable_pages for HugePages
> 
> While playing with gigantic hugepages and memory_hotplug, I triggered the
> following #PF when "cat memoryX/removable":
> 
> <---
> kernel: BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> kernel: #PF error: [normal kernel read fault]
> kernel: PGD 0 P4D 0
> kernel: Oops: 0000 [#1] SMP PTI
> kernel: CPU: 1 PID: 1481 Comm: cat Tainted: G            E     4.20.0-rc6-mm1-1-default+ #18
> kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
> kernel: RIP: 0010:has_unmovable_pages+0x154/0x210
> kernel: Code: 1b ff ff ff eb 32 48 8b 45 00 bf 00 10 00 00 a9 00 00 01 00 74 07 0f b6 4d 51 48 d3 e7 e8 c4 81 05 00 48 85 c0 49 89 c1 75 7e <41> 8b 41 08 83 f8 09 74 41 83 f8 1b 74 3c 4d 2b 64 24 58 49 81 ec
> kernel: RSP: 0018:ffffc90000a1fd30 EFLAGS: 00010246
> kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000009
> kernel: RDX: ffffffff82aed4f0 RSI: 0000000000001000 RDI: 0000000000001000
> kernel: RBP: ffffea0001800000 R08: 0000000000200000 R09: 0000000000000000
> kernel: R10: 0000000000001000 R11: 0000000000000003 R12: ffff88813ffd45c0
> kernel: R13: 0000000000060000 R14: 0000000000000001 R15: ffffea0000000000
> kernel: FS:  00007fd71d9b3500(0000) GS:ffff88813bb00000(0000) knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 0000000000000008 CR3: 00000001371c2002 CR4: 00000000003606e0
> kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> kernel: Call Trace:
> kernel:  is_mem_section_removable+0x7d/0x100
> kernel:  removable_show+0x90/0xb0
> kernel:  dev_attr_show+0x1c/0x50
> kernel:  sysfs_kf_seq_show+0xca/0x1b0
> kernel:  seq_read+0x133/0x380
> kernel:  __vfs_read+0x26/0x180
> kernel:  vfs_read+0x89/0x140
> kernel:  ksys_read+0x42/0x90
> kernel:  do_syscall_64+0x5b/0x180
> kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> kernel: RIP: 0033:0x7fd71d4c8b41
> kernel: Code: fe ff ff 48 8d 3d 27 9e 09 00 48 83 ec 08 e8 96 02 02 00 66 0f 1f 44 00 00 8b 05 ea fc 2c 00 48 63 ff 85 c0 75 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 f3 c3 0f 1f 44 00 00 55 53 48 89 d5 48 89
> kernel: RSP: 002b:00007ffeab5f6448 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> kernel: RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007fd71d4c8b41
> kernel: RDX: 0000000000020000 RSI: 00007fd71d809000 RDI: 0000000000000003
> kernel: RBP: 0000000000020000 R08: ffffffffffffffff R09: 0000000000000000
> kernel: R10: 000000000000038b R11: 0000000000000246 R12: 00007fd71d809000
> kernel: R13: 0000000000000003 R14: 00007fd71d80900f R15: 0000000000020000
> kernel: Modules linked in: af_packet(E) xt_tcpudp(E) ipt_REJECT(E) xt_conntrack(E) nf_conntrack(E) nf_defrag_ipv4(E) ip_set(E) nfnetlink(E) ebtable_nat(E) ebtable_broute(E) bridge(E) stp(E) llc(E) iptable_mangle(E) iptable_raw(E) iptable_security(E) ebtable_filter(E) ebtables(E) iptable_filter(E) ip_tables(E) x_tables(E) kvm_intel(E) kvm(E) irqbypass(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) bochs_drm(E) ttm(E) drm_kms_helper(E) drm(E) aesni_intel(E) virtio_net(E) syscopyarea(E) net_failover(E) sysfillrect(E) failover(E) aes_x86_64(E) crypto_simd(E) sysimgblt(E) cryptd(E) pcspkr(E) glue_helper(E) parport_pc(E) fb_sys_fops(E) i2c_piix4(E) parport(E) button(E) btrfs(E) libcrc32c(E) xor(E) zstd_decompress(E) zstd_compress(E) raid6_pq(E) sd_mod(E) ata_generic(E) ata_piix(E) ahci(E) libahci(E) serio_raw(E) crc32c_intel(E) virtio_pci(E) virtio_ring(E) virtio(E) libata(E) sg(E) scsi_mod(E) autofs4(E)
> kernel: CR2: 0000000000000008
> kernel: ---[ end trace 49cade81474e40e7 ]---
> kernel: RIP: 0010:has_unmovable_pages+0x154/0x210
> kernel: Code: 1b ff ff ff eb 32 48 8b 45 00 bf 00 10 00 00 a9 00 00 01 00 74 07 0f b6 4d 51 48 d3 e7 e8 c4 81 05 00 48 85 c0 49 89 c1 75 7e <41> 8b 41 08 83 f8 09 74 41 83 f8 1b 74 3c 4d 2b 64 24 58 49 81 ec
> kernel: RSP: 0018:ffffc90000a1fd30 EFLAGS: 00010246
> kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000009
> kernel: RDX: ffffffff82aed4f0 RSI: 0000000000001000 RDI: 0000000000001000
> kernel: RBP: ffffea0001800000 R08: 0000000000200000 R09: 0000000000000000
> kernel: R10: 0000000000001000 R11: 0000000000000003 R12: ffff88813ffd45c0
> kernel: R13: 0000000000060000 R14: 0000000000000001 R15: ffffea0000000000
> kernel: FS:  00007fd71d9b3500(0000) GS:ffff88813bb00000(0000) knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 0000000000000008 CR3: 00000001371c2002 CR4: 00000000003606e0
> kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> --->
> 
> The reason is we do not pass the Head to page_hstate(), and so, the call
> to compound_order() in page_hstate() returns 0, so we end up checking all
> hstates's size to match PAGE_SIZE.
> 
> Obviously, we do not find any hstate matching that size, and we return
> NULL.  Then, we dereference that NULL pointer in
> hugepage_migration_supported() and we got the #PF from above.
> 
> Fix that by getting the head page before calling page_hstate().
> 
> Also, since gigantic pages span several pageblocks, re-adjust the logic
> for skipping pages.
> While are it, we can also get rid of the round_up().
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/page_alloc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2ec9cc407216..995d1079f958 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7802,11 +7802,14 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  		 * handle each tail page individually in migration.
>  		 */
>  		if (PageHuge(page)) {
> +			struct page *head = compound_head(page);
> +			unsigned int skip_pages;
>  
> -			if (!hugepage_migration_supported(page_hstate(page)))
> +			if (!hugepage_migration_supported(page_hstate(head)))
>  				goto unmovable;
>  
> -			iter = round_up(iter + 1, 1<<compound_order(page)) - 1;
> +			skip_pages = (1 << compound_order(head)) - (page - head);
> +			iter += skip_pages - 1;
>  			continue;
>  		}
>  
> 

Makes sense to me

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
