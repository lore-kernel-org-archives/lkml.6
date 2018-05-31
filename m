Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932585AbeEaAv0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 20:51:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41666 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932451AbeEaAvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 20:51:25 -0400
Subject: Re: [PATCH 2/2] fs, elf: drop MAP_FIXED usage from elf_map
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, libhugetlbfs@googlegroups.com
References: <20171129144219.22867-1-mhocko@kernel.org>
 <20171129144219.22867-3-mhocko@kernel.org>
 <93ce964b-e352-1905-c2b6-deedf2ea06f8@oracle.com>
 <c0e447b3-4ba7-239e-6550-64de7721ad28@oracle.com>
 <20180530080212.GA27180@dhcp22.suse.cz>
 <e7705544-04fe-c382-f6d0-48d0680b46f2@oracle.com>
 <20180530162501.GB15278@dhcp22.suse.cz>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1f6be96b-12ac-9a03-df90-386dab02369d@oracle.com>
Date: Wed, 30 May 2018 17:51:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180530162501.GB15278@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8909 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1805310007
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30/2018 09:25 AM, Michal Hocko wrote:
> Could you add a debugging data to dump the VMA which overlaps the
> requested adress and who requested that? E.g. hook into do_mmap and dump
> all requests from the linker.

Here you go.  I added a bunch of stuff as I clearly do not understand
how elf loading works.  To me, the 'sections' parsed by the kernel code
do not seem to directly align with those produced by objdump.

[   38.899260] load_elf_binary: attempting to load file ./tests/obj32/xB.linkhuge_nofd
[   38.902340]     dumping section headers
[   38.903534]     index 0 p_offset = 34
[   38.904683]     index 0 p_vaddr  = 8048034
[   38.905680]     index 0 p_paddr  = 8048034
[   38.906442]     index 0 p_filesz = 120
[   38.907110]     index 0 p_memsz  = 120
[   38.907764] 
[   38.908019]     index 1 p_offset = 154
[   38.908521]     index 1 p_vaddr  = 8048154
[   38.909081]     index 1 p_paddr  = 8048154
[   38.909496]     index 1 p_filesz = 13
[   38.909855]     index 1 p_memsz  = 13
[   38.910453] 
[   38.910731]     index 2 p_offset = 0
[   38.911317]     index 2 p_vaddr  = 8048000
[   38.911997]     index 2 p_paddr  = 8048000
[   38.912590]     index 2 p_filesz = 169c
[   38.913141]     index 2 p_memsz  = 169c
[   38.913713] 
[   38.913987]     index 3 p_offset = 169c
[   38.914518]     index 3 p_vaddr  = 804969c
[   38.915101]     index 3 p_paddr  = 804969c
[   38.915718]     index 3 p_filesz = 1878
[   38.916266]     index 3 p_memsz  = 1878
[   38.916799] 
[   38.917032]     index 4 p_offset = 3000
[   38.917537]     index 4 p_vaddr  = 9000000
[   38.918119]     index 4 p_paddr  = 9000000
[   38.918709]     index 4 p_filesz = 0
[   38.919525]     index 4 p_memsz  = 10
[   38.919993] 
[   38.920275]     index 5 p_offset = 2d88
[   38.920791]     index 5 p_vaddr  = 804ad88
[   38.921307]     index 5 p_paddr  = 804ad88
[   38.921800]     index 5 p_filesz = 18c
[   38.922288]     index 5 p_memsz  = 18c
[   38.922739] 
[   38.922973]     index 6 p_offset = 168
[   38.923431]     index 6 p_vaddr  = 8048168
[   38.923946]     index 6 p_paddr  = 8048168
[   38.924457]     index 6 p_filesz = 44
[   38.924931]     index 6 p_memsz  = 44
[   38.925414] 
[   38.925593]     index 7 p_offset = 0
[   38.926031]     index 7 p_vaddr  = 0
[   38.926510]     index 7 p_paddr  = 0
[   38.926957]     index 7 p_filesz = 0
[   38.927443]     index 7 p_memsz  = 0
[   38.927879] 
[   38.928115]     index 8 p_offset = 169c
[   38.928594]     index 8 p_vaddr  = 804969c
[   38.929091]     index 8 p_paddr  = 804969c
[   38.929646]     index 8 p_filesz = 8c
[   38.930177]     index 8 p_memsz  = 8c
[   38.930710] 
[   38.931497] load_elf_binary: skipping index 0 p_vaddr = 8048034
[   38.932321] load_elf_binary: skipping index 1 p_vaddr = 8048154
[   38.933165] load_elf_binary: calling elf_map() index 2 bias 0 vaddr 8048000
[   38.934087]     map_addr ELF_PAGESTART(addr) 8048000 total_size 0 ELF_PAGEALIGN(size) 2000
[   38.935101]     eppnt->p_offset = 0
[   38.935561]     eppnt->p_vaddr  = 8048000
[   38.936073]     eppnt->p_paddr  = 8048000
[   38.936897]     eppnt->p_filesz = 169c
[   38.937493]     eppnt->p_memsz  = 169c
[   38.938042] load_elf_binary: calling elf_map() index 3 bias 0 vaddr 804969c
[   38.939002]     map_addr ELF_PAGESTART(addr) 8049000 total_size 0 ELF_PAGEALIGN(size) 2000
[   38.939959]     eppnt->p_offset = 169c
[   38.940410]     eppnt->p_vaddr  = 804969c
[   38.940897]     eppnt->p_paddr  = 804969c
[   38.941507]     eppnt->p_filesz = 1878
[   38.942019]     eppnt->p_memsz  = 1878
[   38.942516] 1123 (xB.linkhuge_nof): Uhuuh, elf segment at 8049000 requested but the memory is mapped already

It is pretty easy to see the mmap conflict.  I'm still trying to determine if
the executable file is 'valid'.  It did not throw an error previously as
MAP_FIXED unmapped the overlapping page.  However, this does not seem right.
-- 
Mike Kravetz
