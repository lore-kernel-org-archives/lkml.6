Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932257AbeCOT2T (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:28:19 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:50832 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbeCOT2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:28:17 -0400
Date: Thu, 15 Mar 2018 15:28:15 -0400 (EDT)
Message-Id: <20180315.152815.1012910593389921933.davem@davemloft.net>
To: nitin.m.gupta@oracle.com
CC: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: sparc64 MM regression...
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


So I bisected a userspace corruption regression down to commit:

commit a8e654f01cb725d0bfd741ebca1bf4c9337969cc                                                                                    
Author: Nitin Gupta <nitin.m.gupta@oracle.com>                                                                                     
Date:   Wed Jan 31 16:18:09 2018 -0800                                                                                             
                                                                                                                                   
    sparc64: update pmdp_invalidate() to return old pmd value                                                                      

The transformation is basically from a set_pte_at() call into
an atomic cmpxchg64() loop to set the pmd.

The problem is that set_pmd_at() does more than just assign
the pmd entry.

It also does some accounting and also queues up a batch TLB
flush entry.

So the side effect of this change is that the TLB is never
flushed for these changed PMDs, and thus the userland memory
corruption I was seeing.
