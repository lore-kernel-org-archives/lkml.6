Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbeBXCqq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 21:46:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58966 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753002AbeBXCqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 21:46:45 -0500
Date: Fri, 23 Feb 2018 18:46:41 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Chris Mi <chrism@mellanox.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Fwd: Re: Kernel panic with 4.16-rc1 (and 4.16-rc2) running
 selftest
Message-ID: <20180224024641.GB15231@bombadil.infradead.org>
References: <7995f335-ccac-bfdc-bb37-46d0f887c647@oracle.com>
 <b926a569-c05e-dd49-a25d-555e88e9ff8e@infradead.org>
 <CAM_iQpUveA5T6-y7bguaPUok-LphJrLYxw6kNgaMorsxm4z9NA@mail.gmail.com>
 <CAM_iQpWSRe0t1Dr=7o+1ejULV=F+_Wx1v7yyw=NRBUTYttMxog@mail.gmail.com>
 <96bf4941-17c0-0796-292c-b66087f5f52e@infradead.org>
 <CAFhKne9Dyx1uvRz_9rvCq7mewAbLA5T77P21oBQfOR7JzP_1aQ@mail.gmail.com>
 <20180224011528.GA15231@bombadil.infradead.org>
 <VI1PR0501MB2143077CA6E5A728B8F581BAABC30@VI1PR0501MB2143.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0501MB2143077CA6E5A728B8F581BAABC30@VI1PR0501MB2143.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 01:49:35AM +0000, Chris Mi wrote:
> To verify this patch, the following is a sanity test case:
> 
> # tc qdisc delete dev $link ingress > /dev/null 2>&1;
> # tc qdisc add dev $link ingress;
> # tc filter add dev $link prio 1 protocol ip handle 0x80000001 parent ffff: flower skip_hw src_mac e4:11:0:0:0:2 dst_mac e4:12:0:0:0:2 action drop;
> # tc filter show dev $link parent ffff:
> 
> filter pref 1 flower chain 0
> filter pref 1 flower chain 0 handle 0x80000001

I added these tests to my local tree for now.

diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index 44ef9eba5a7a..28d99325a32d 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -178,6 +178,29 @@ void idr_get_next_test(int base)
 	idr_destroy(&idr);
 }
 
+void idr_u32_test(struct idr *idr, int base)
+{
+	assert(idr_is_empty(idr));
+	idr_init_base(idr, base);
+	u32 handle = 10;
+	idr_alloc_u32(idr, NULL, &handle, handle, GFP_KERNEL);
+	BUG_ON(handle != 10);
+	idr_remove(idr, handle);
+	assert(idr_is_empty(idr));
+
+	handle = 0x80000001;
+	idr_alloc_u32(idr, NULL, &handle, handle, GFP_KERNEL);
+	BUG_ON(handle != 0x80000001);
+	idr_remove(idr, handle);
+	assert(idr_is_empty(idr));
+
+	handle = 0xffe00000;
+	idr_alloc_u32(idr, NULL, &handle, handle, GFP_KERNEL);
+	BUG_ON(handle != 0xffe00000);
+	idr_remove(idr, handle);
+	assert(idr_is_empty(idr));
+}
+
 void idr_checks(void)
 {
 	unsigned long i;
@@ -248,6 +271,9 @@ void idr_checks(void)
 	idr_get_next_test(0);
 	idr_get_next_test(1);
 	idr_get_next_test(4);
+	idr_u32_test(&idr, 0);
+	idr_u32_test(&idr, 1);
+	idr_u32_test(&idr, 4);
 }
 
 /*
