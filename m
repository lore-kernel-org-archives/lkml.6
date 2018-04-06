Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeDFOLV convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:11:21 -0400
Received: from prv-mh.provo.novell.com ([137.65.248.74]:53608 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756367AbeDFOLU (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:1:1>);
        Fri, 6 Apr 2018 10:11:20 -0400
Message-Id: <5AC747C1020000A7001FA82C@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Fri, 06 Apr 2018 08:11:13 -0600
From: "Tom Abraham" <tabraham@suse.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] swap: divide-by-zero when zero length swap file on ssd
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

                                                                                
Calling swapon() on a zero length swap file on SSD can lead to a                
divide-by-zero.                                                                 
                                                                                
Although creating such files isn't possible with mkswap and they woud be        
considered invalid, it would be better for the swapon code to be more robust    
and handle this condition gracefully (return -EINVAL). Especially since the fix 
is small and straight-forward.                                                  
                                                                                
To help with wear leveling on SSD, the swapon syscall calculates a random       
position in the swap file using modulo p->highest_bit, which is set to          
maxpages - 1 in read_swap_header.                                               
                                                                                
If the swap file is zero length, read_swap_header sets maxpages=1 and           
last_page=0, resulting in p->highest_bit=0 and we divide-by-zero when we modulo 
p->highest_bit in swapon syscall.                                               
                                                                                
This can be prevented by having read_swap_header return zero if last_page is    
zero.                                                                           
                                                                                
diff --git a/mm/swapfile.c b/mm/swapfile.c                                      
index c7a33717d079..d6b7bd9f365d 100644                                         
--- a/mm/swapfile.c                                                             
+++ b/mm/swapfile.c                                                             
@@ -2961,6 +2961,10 @@ static unsigned long read_swap_header(struct swap_info_struct *p,
        maxpages = swp_offset(pte_to_swp_entry(                                 
                        swp_entry_to_pte(swp_entry(0, ~0UL)))) + 1;             
        last_page = swap_header->info.last_page;                                
+       if(!last_page) {                                                        
+               pr_warn("Empty swap-file\n");                                   
+               return 0;                                                       
+       }                                                                       
        if (last_page > maxpages) {                                             
                pr_warn("Truncating oversized swap area, only using %luk out of %luk\n",
                        maxpages << (PAGE_SHIFT - 10),
