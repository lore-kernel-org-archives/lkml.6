Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbeDHGnU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 02:43:20 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:47417 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751126AbeDHGnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 02:43:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=zoucao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0T-qAGpS_1523169795;
From: zoucao@linux.alibaba.com
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] free e820 reserved memory in bootargs memmap
Date: Sun,  8 Apr 2018 14:41:33 +0800
Message-Id: <20180408064134.77385-1-zoucao@linux.alibaba.com>
X-Mailer: git-send-email 2.14.1.40.g8e62ba1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add a new chareater "-" in bootargs memmap, you can use this chareater to free
e820 reserved memory, for example:

reserved iomem:
	cat /proc/iomem:
	......
	00100000-6aefefff : System RAM
	  01000000-0165537a : Kernel code
	  0165537b-01a8873f : Kernel data
	  01c31000-01f4efff : Kernel bss
	  28000000-320fffff : Crash kernel
	6aeff000-6effffff : reserved       --> it is e820 reserved memory
	6f000000-78240fff : System RAM
	......


add bootargs memmap=0x4101000-0x6aeff000, to free memory region: 6aeff000-6effffff
then 6aeff000-6effffff will be merged into 00100000-78240fff.

new iomem:  
	cat /proc/iomem:
	......
	00100000-78240fff : System RAM
	  01000000-0165537a : Kernel code
	  0165537b-01a8873f : Kernel data
	  01c31000-01f4efff : Kernel bss
	......
