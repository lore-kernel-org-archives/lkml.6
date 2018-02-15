Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946104AbeBORnP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:43:15 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35215 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946084AbeBORnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:43:10 -0500
X-Google-Smtp-Source: AH8x224mZlQkgCLVSqpDdH5Ks7UmSwgH4K9VTAoKYmRVEXgJWSt1nnkNS6EtxM84pO/YjId4j6AP+w==
Message-ID: <1518716586.3715.205.camel@gmail.com>
Subject: Re: v4.16-rc1 misaligned atomics in skb__clone / __napi_alloc_skb
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc: netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>
Date: Thu, 15 Feb 2018 09:43:06 -0800
In-Reply-To: <CANn89iLvNjvUsjsqVN=3ZTPQvp6xChqYEu+cUASFXtTSQnA1aA@mail.gmail.com>
References: <20180215170432.e4wue4osyv3vmdla@lakrids.cambridge.arm.com>
         <CANn89iK-7v=sR3oD3uwkC6qac=GrSDUfMGmvKo=DS6tQ6C1ZJQ@mail.gmail.com>
         <CANn89iLvNjvUsjsqVN=3ZTPQvp6xChqYEu+cUASFXtTSQnA1aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-15 at 09:24 -0800, Eric Dumazet wrote:
> 
> I will send something more suited to original intent of these commits :
> 
> 90e33d45940793def6f773b2d528e9f3c84ffdc7 tun: enable napi_gro_frags()
> for TUN/TAP driver
> 943170998b200190f99d3fe7e771437e2c51f319 tun: enable NAPI for TUN/TAP driver

Can you try this patch ?

Thanks !

 drivers/net/tun.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 81e6cc951e7fc7c983919365c34842c34bcaedcf..b52258c327d2e1d7c7476de345e49f082909c246 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1489,27 +1489,23 @@ static struct sk_buff *tun_napi_alloc_frags(struct tun_file *tfile,
 	skb->truesize += skb->data_len;
 
 	for (i = 1; i < it->nr_segs; i++) {
+		struct page_frag *pfrag = &current->task_frag;
 		size_t fragsz = it->iov[i].iov_len;
-		unsigned long offset;
-		struct page *page;
-		void *data;
 
 		if (fragsz == 0 || fragsz > PAGE_SIZE) {
 			err = -EINVAL;
 			goto free;
 		}
 
-		local_bh_disable();
-		data = napi_alloc_frag(fragsz);
-		local_bh_enable();
-		if (!data) {
+		if (!skb_page_frag_refill(fragsz, pfrag, GFP_KERNEL)) {
 			err = -ENOMEM;
 			goto free;
 		}
 
-		page = virt_to_head_page(data);
-		offset = data - page_address(page);
-		skb_fill_page_desc(skb, i - 1, page, offset, fragsz);
+		skb_fill_page_desc(skb, i - 1, pfrag->page,
+				   pfrag->offset, fragsz);
+		page_ref_inc(pfrag->page);
+		pfrag->offset += fragsz;
 	}
 
 	return skb;
