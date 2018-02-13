Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933470AbeBMGth (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 01:49:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933406AbeBMGte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 01:49:34 -0500
Subject: Re: ppc elf_map breakage with MAP_FIXED_NOREPLACE
To: Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <5acba3c2-754d-e449-24ff-a72a0ad0d895@linux.vnet.ibm.com>
 <20180126140415.GD5027@dhcp22.suse.cz>
 <15da8c87-e6db-13aa-01c8-a913656bfdb6@linux.vnet.ibm.com>
 <6db9b33d-fd46-c529-b357-3397926f0733@linux.vnet.ibm.com>
 <20180129132235.GE21609@dhcp22.suse.cz>
 <87k1w081e7.fsf@concordia.ellerman.id.au>
 <20180130094205.GS21609@dhcp22.suse.cz>
 <5eccdc1b-6a10-b48a-c63f-295f69473d97@linux.vnet.ibm.com>
 <20180131131937.GA6740@dhcp22.suse.cz>
 <bfecda5e-ae8b-df91-0add-df6322b42a70@linux.vnet.ibm.com>
 <20180201134829.GL21609@dhcp22.suse.cz>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au, broonie@kernel.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 13 Feb 2018 12:19:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180201134829.GL21609@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18021306-0040-0000-0000-0000042F2C27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021306-0041-0000-0000-000020D2EE39
Message-Id: <b0a751c4-9552-87b4-c768-3e1b02c18b5c@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802130085
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2018 07:18 PM, Michal Hocko wrote:
> On Thu 01-02-18 08:43:34, Anshuman Khandual wrote:
> [...]
>> $dmesg | grep elf_brk
>> [    9.571192] elf_brk 10030328 elf_bss 10030000
>>
>> static int load_elf_binary(struct linux_binprm *bprm)
>> ---------------------
>>
>> 	if (unlikely (elf_brk > elf_bss)) {
>> 			unsigned long nbyte;
>> 	            
>> 			/* There was a PT_LOAD segment with p_memsz > p_filesz
>> 			   before this one. Map anonymous pages, if needed,
>> 			   and clear the area.  */
>> 			retval = set_brk(elf_bss + load_bias,
>> 					 elf_brk + load_bias,
>> 					 bss_prot);
>>
>>
>> ---------------------
> 
> Just a blind shot... Does the following make any difference?
> ---
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 021fe78998ea..04b24d00c911 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -895,7 +895,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	   the correct location in memory. */
>  	for(i = 0, elf_ppnt = elf_phdata;
>  	    i < loc->elf_ex.e_phnum; i++, elf_ppnt++) {
> -		int elf_prot = 0, elf_flags;
> +		int elf_prot = 0, elf_flags, elf_fixed = MAP_FIXED_NOREPLACE;
>  		unsigned long k, vaddr;
>  		unsigned long total_size = 0;
>  
> @@ -927,6 +927,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  					 */
>  				}
>  			}
> +			elf_fixed = MAP_FIXED;
>  		}
>  
>  		if (elf_ppnt->p_flags & PF_R)
> @@ -944,7 +945,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		 * the ET_DYN load_addr calculations, proceed normally.
>  		 */
>  		if (loc->elf_ex.e_type == ET_EXEC || load_addr_set) {
> -			elf_flags |= MAP_FIXED_NOREPLACE;
> +			elf_flags |= elf_fixed;
>  		} else if (loc->elf_ex.e_type == ET_DYN) {
>  			/*
>  			 * This logic is run once for the first LOAD Program
> @@ -980,7 +981,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  				load_bias = ELF_ET_DYN_BASE;
>  				if (current->flags & PF_RANDOMIZE)
>  					load_bias += arch_mmap_rnd();
> -				elf_flags |= MAP_FIXED_NOREPLACE;
> +				elf_flags |= elf_fixed;
>  			} else
>  				load_bias = 0;
>  
> 

Yeah, it does solve the problem on mmotm-2018-01-25-16-20.
