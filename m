Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbeBADNs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 22:13:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751448AbeBADNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 22:13:47 -0500
Subject: Re: ppc elf_map breakage with MAP_FIXED_NOREPLACE
To: Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <2a05eaf2-20fd-57a8-d4bd-5a1fbf57686c@linux.vnet.ibm.com>
 <20180124090539.GH1526@dhcp22.suse.cz>
 <5acba3c2-754d-e449-24ff-a72a0ad0d895@linux.vnet.ibm.com>
 <20180126140415.GD5027@dhcp22.suse.cz>
 <15da8c87-e6db-13aa-01c8-a913656bfdb6@linux.vnet.ibm.com>
 <6db9b33d-fd46-c529-b357-3397926f0733@linux.vnet.ibm.com>
 <20180129132235.GE21609@dhcp22.suse.cz>
 <87k1w081e7.fsf@concordia.ellerman.id.au>
 <20180130094205.GS21609@dhcp22.suse.cz>
 <5eccdc1b-6a10-b48a-c63f-295f69473d97@linux.vnet.ibm.com>
 <20180131131937.GA6740@dhcp22.suse.cz>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au, broonie@kernel.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 1 Feb 2018 08:43:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180131131937.GA6740@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18020103-0012-0000-0000-000005AA1FA3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020103-0013-0000-0000-00001925C2BD
Message-Id: <bfecda5e-ae8b-df91-0add-df6322b42a70@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-31_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802010036
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/31/2018 06:49 PM, Michal Hocko wrote:
> On Wed 31-01-18 10:35:38, Anshuman Khandual wrote:
>> On 01/30/2018 03:12 PM, Michal Hocko wrote:
> [...]
>>> Anshuman, could you try to run
>>> sed 's@^@@' /proc/self/smaps
>>> on a system with MAP_FIXED_NOREPLACE reverted?
>>>
>> After reverting the following commits from mmotm-2018-01-25-16-20 tag.
>>
>> 67caea694ba5965a52a61fdad495d847f03c4025 ("mm-introduce-map_fixed_safe-fix")
>> 64da2e0c134ecf3936a4c36b949bcf2cdc98977e ("fs-elf-drop-map_fixed-usage-from-elf_map-fix-fix")
>> 645983ab6ca7fd644f52b4c55462b91940012595 ("mm: don't use the same value for MAP_FIXED_NOREPLACE and MAP_SYNC")
>> d77bab291ac435aab91fa214b85efa74a26c9c22 ("fs-elf-drop-map_fixed-usage-from-elf_map-checkpatch-fixes")
>> a75c5f92d9ecb21d3299cc7db48e401cbf335c34 ("fs, elf: drop MAP_FIXED usage from elf_map")
>> 00906d029ffe515221e3939b222c237026af2903 ("mm: introduce MAP_FIXED_NOREPLACE")
>>
>> $sed 's@^@@' /proc/self/smaps
> Interesting
> 
>> -------------------------------------------
>> 10000000-10020000 r-xp 00000000 fd:00 10558                              /usr/bin/sed
>> 10020000-10030000 r--p 00010000 fd:00 10558                              /usr/bin/sed
>> 10030000-10040000 rw-p 00020000 fd:00 10558                              /usr/bin/sed
>> 2cbb0000-2cbe0000 rw-p 00000000 00:00 0                                  [heap]
> We still have a brk and at a different offset. Could you confirm that we
> still try to map previous brk at the clashing address 0x10030000?

yes.

[    9.295990] vma c000001fc8137c80 start 0000000010030000 end 0000000010040000
next c000001fc81378c0 prev c000001fc8137680 mm c000001fc8108200
prot 8000000000000104 anon_vma           (null) vm_ops           (null)
pgoff 1003 file           (null) private_data           (null)
flags: 0x100073(read|write|mayread|maywrite|mayexec|account)
[    9.296351] CPU: 47 PID: 7537 Comm: sed Not tainted 4.14.0-00006-g4bd92fe-dirty #162
[    9.296450] Call Trace:
[    9.296482] [c000001fc70db9b0] [c000000000b180e0] dump_stack+0xb0/0xf0 (unreliable)
[    9.296588] [c000001fc70db9f0] [c0000000002db0b8] do_brk_flags+0x2d8/0x440
[    9.296674] [c000001fc70dbac0] [c0000000002db4d0] vm_brk_flags+0x80/0x130
[    9.296751] [c000001fc70dbb20] [c0000000003d2998] set_brk+0x80/0xe8
[    9.296824] [c000001fc70dbb60] [c0000000003d2518] load_elf_binary+0x12f8/0x1580
[    9.296910] [c000001fc70dbc80] [c00000000035d9e0] search_binary_handler+0xd0/0x270
[    9.296999] [c000001fc70dbd10] [c00000000035f938] do_execveat_common.isra.31+0x658/0x890
[    9.297089] [c000001fc70dbdf0] [c00000000035ff80] SyS_execve+0x40/0x50
[    9.297162] [c000001fc70dbe30] [c00000000000b220] system_call+0x58/0x6c

But coming back to when it failed with MAP_FIXED_NOREPLACE, looking into ELF
section details (readelf -aW /usr/bin/sed), there was a PT_LOAD segment with
p_memsz > p_filesz which might be causing set_brk() to be called.


  Type           Offset   VirtAddr           PhysAddr           FileSiz  MemSiz   Flg Align
  ...
  LOAD           0x020328 0x0000000010030328 0x0000000010030328 0x000384 0x0094a0 RW  0x10000

which can be confirmed by just dumping elf_brk/elf_bss for this particular
instance. (elf_brk > elf_bss)

$dmesg | grep elf_brk
[    9.571192] elf_brk 10030328 elf_bss 10030000

static int load_elf_binary(struct linux_binprm *bprm)
---------------------

	if (unlikely (elf_brk > elf_bss)) {
			unsigned long nbyte;
	            
			/* There was a PT_LOAD segment with p_memsz > p_filesz
			   before this one. Map anonymous pages, if needed,
			   and clear the area.  */
			retval = set_brk(elf_bss + load_bias,
					 elf_brk + load_bias,
					 bss_prot);


---------------------
So is not there a chance that subsequent file mapping might be overlapping
with these anon mappings ? I mean may be thats how ELF loading might be
happening right now.
